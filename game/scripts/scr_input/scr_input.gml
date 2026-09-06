// Centralized input mapping: every action here accepts both keyboard and
// PS4/PS5 controller input. GameMaker's gp_face1..4 map to physical button
// position, not label, so on a PlayStation pad:
// gp_face1 = Cross, gp_face2 = Circle, gp_face3 = Square, gp_face4 = Triangle.
//
// NOTE: on Windows, XInput pads (Xbox) occupy slots 0-3 while DirectInput
// pads (PS4/PS5/etc) show up from slot 4 onward, so the active pad can't be
// assumed to be slot 0 - it has to be found by scanning every slot.

#macro GP_STICK_DEADZONE 0.5

function input_gamepad_slot() {
    static _slot = -1;

    if (_slot != -1 && gamepad_is_connected(_slot)) return _slot;

    var _count = gamepad_get_device_count();
    for (var i = 0; i < _count; i++) {
        if (gamepad_is_connected(i)) {
            _slot = i;
            return _slot;
        }
    }

    _slot = -1;
    return _slot;
}

function input_jump_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(vk_space) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face1));
}

function input_jump_held() {
    var _pad = input_gamepad_slot();
    return keyboard_check(vk_space) || (_pad != -1 && gamepad_button_check(_pad, gp_face1));
}

function input_move_held(_sign) {
    var _pad = input_gamepad_slot();

    if (_sign > 0) {
        var _key = keyboard_check(vk_right);
        var _stick = (_pad != -1) && (gamepad_axis_value(_pad, gp_axislh) > GP_STICK_DEADZONE);
        return _key || _stick;
    }

    var _key = keyboard_check(vk_left);
    var _stick = (_pad != -1) && (gamepad_axis_value(_pad, gp_axislh) < -GP_STICK_DEADZONE);
    return _key || _stick;
}

// Returns 1, -1 or 0 for which horizontal direction was just tapped this
// frame (keyboard or stick). Must be read once per frame - the stick's
// press-edge is detected by comparing against the previous frame's axis
// value, so checking both directions separately (two calls, one per sign)
// would have the first call overwrite that history before the second call
// ever saw it, breaking edge detection for whichever direction was checked
// second.
function input_move_tap_dir() {
    static _prev_axis = 0;

    var _pad = input_gamepad_slot();
    var _axis = (_pad != -1) ? gamepad_axis_value(_pad, gp_axislh) : 0;

    var _dir = 0;
    if (_axis > GP_STICK_DEADZONE && _prev_axis <= GP_STICK_DEADZONE) _dir = 1;
    else if (_axis < -GP_STICK_DEADZONE && _prev_axis >= -GP_STICK_DEADZONE) _dir = -1;

    _prev_axis = _axis;

    if (_dir == 0) {
        if (keyboard_check_pressed(vk_right)) _dir = 1;
        else if (keyboard_check_pressed(vk_left)) _dir = -1;
    }

    return _dir;
}

function input_attack_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("Z")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face3));
}

function input_dash_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("C")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_shoulderrb));
}

function input_special_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("X")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face2));
}

function input_interact_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("E")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padu));
}

function input_status_held() {
    var _pad = input_gamepad_slot();
    return keyboard_check(vk_tab) || (_pad != -1 && gamepad_button_check(_pad, gp_shoulderl));
}

// Circle = back/cancel out of a menu (PlayStation convention). Gamepad-only:
// keyboard already closes the pause menu by pressing Escape again.
function input_menu_back_pressed() {
    var _pad = input_gamepad_slot();
    return (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face2));
}

function input_map_toggle_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("M")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_select));
}

function input_pause_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(vk_escape) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_start));
}

function input_menu_confirm_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(ord("E")) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face1));
}

// Menu navigation accepts keyboard arrows, the D-pad, AND the left analog
// stick. The stick fires a single "press" on the frame it crosses the
// deadzone (edge detection vs the previous frame), so holding it tilted
// doesn't scroll continuously. Each direction keeps its own previous-axis
// history in a static, so the four functions don't clobber each other.
#macro GP_MENU_STICK_DEADZONE 0.5

function input_menu_up_pressed() {
    static _prev = 0;
    var _pad = input_gamepad_slot();
    var _v = (_pad != -1) ? gamepad_axis_value(_pad, gp_axislv) : 0;
    var _stick_edge = (_v < -GP_MENU_STICK_DEADZONE && _prev >= -GP_MENU_STICK_DEADZONE);
    _prev = _v;
    return keyboard_check_pressed(vk_up)
        || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padu))
        || _stick_edge;
}

function input_menu_down_pressed() {
    static _prev = 0;
    var _pad = input_gamepad_slot();
    var _v = (_pad != -1) ? gamepad_axis_value(_pad, gp_axislv) : 0;
    var _stick_edge = (_v > GP_MENU_STICK_DEADZONE && _prev <= GP_MENU_STICK_DEADZONE);
    _prev = _v;
    return keyboard_check_pressed(vk_down)
        || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padd))
        || _stick_edge;
}

function input_menu_left_pressed() {
    static _prev = 0;
    var _pad = input_gamepad_slot();
    var _v = (_pad != -1) ? gamepad_axis_value(_pad, gp_axislh) : 0;
    var _stick_edge = (_v < -GP_MENU_STICK_DEADZONE && _prev >= -GP_MENU_STICK_DEADZONE);
    _prev = _v;
    return keyboard_check_pressed(vk_left)
        || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padl))
        || _stick_edge;
}

function input_menu_right_pressed() {
    static _prev = 0;
    var _pad = input_gamepad_slot();
    var _v = (_pad != -1) ? gamepad_axis_value(_pad, gp_axislh) : 0;
    var _stick_edge = (_v > GP_MENU_STICK_DEADZONE && _prev <= GP_MENU_STICK_DEADZONE);
    _prev = _v;
    return keyboard_check_pressed(vk_right)
        || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padr))
        || _stick_edge;
}

function input_dialogue_advance_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(vk_enter) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_face1));
}

function input_door_transition_pressed() {
    var _pad = input_gamepad_slot();
    return keyboard_check_pressed(vk_enter) || (_pad != -1 && gamepad_button_check_pressed(_pad, gp_padu));
}

// HELD (not edge) "look" direction for the camera to pan up/down while the
// player stands still (Hollow Knight style). -1 = up, 1 = down, 0 = centered.
// Accepts the keyboard arrows (up/down are free now that jump is Space) and
// the left analog stick.
function input_look_dir() {

    if (keyboard_check(vk_up))   return -1;
    if (keyboard_check(vk_down)) return  1;

    var _pad = input_gamepad_slot();
    if (_pad != -1) {
        var _v = gamepad_axis_value(_pad, gp_axislv);
        if (_v < -GP_STICK_DEADZONE) return -1;
        if (_v >  GP_STICK_DEADZONE) return  1;
    }

    return 0;
}
