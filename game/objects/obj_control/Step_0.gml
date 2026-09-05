// ===== INPUT DEBUG SNAPSHOT (F12) =====
// Temporary: pops up a message with keyboard + gamepad raw/mapped state,
// plus what our input_* functions (scr_input.gml) currently read, so it's
// easy to see if a specific button/key isn't registering. Hold the
// button/key you want to test, then press F12.
if (keyboard_check_pressed(vk_f12)) {

    var _report = "";

    // ---- KEYBOARD (raw) ----
    _report += "== KEYBOARD ==\n";
    _report += "Up:" + string(keyboard_check(vk_up))
        + " Down:" + string(keyboard_check(vk_down))
        + " Left:" + string(keyboard_check(vk_left))
        + " Right:" + string(keyboard_check(vk_right)) + "\n";
    _report += "Z(attack):" + string(keyboard_check(ord("Z")))
        + " X(special):" + string(keyboard_check(ord("X")))
        + " C(dash):" + string(keyboard_check(ord("C")))
        + " E(interact):" + string(keyboard_check(ord("E"))) + "\n";
    _report += "Tab(status):" + string(keyboard_check(vk_tab))
        + " M(map):" + string(keyboard_check(ord("M")))
        + " Escape(pause):" + string(keyboard_check(vk_escape))
        + " Enter:" + string(keyboard_check(vk_enter)) + "\n\n";

    // ---- GAMEPAD (raw + mapped) ----
    var _count = gamepad_get_device_count();
    _report += "== GAMEPAD ==\n";
    _report += "device_count: " + string(_count) + "\n";

    for (var i = 0; i < _count; i++) {

        var _connected = gamepad_is_connected(i);
        _report += "slot " + string(i) + " connected: " + string(_connected) + "\n";

        if (!_connected) continue;

        _report += "description: " + gamepad_get_description(i) + "\n";
        _report += "button_count: " + string(gamepad_button_count(i))
            + " axis_count: " + string(gamepad_axis_count(i)) + "\n";

        _report += "MAPPED face1(X):" + string(gamepad_button_check(i, gp_face1))
            + " face2(O):" + string(gamepad_button_check(i, gp_face2))
            + " face3(sq):" + string(gamepad_button_check(i, gp_face3))
            + " face4(tri):" + string(gamepad_button_check(i, gp_face4)) + "\n";

        _report += "MAPPED padu:" + string(gamepad_button_check(i, gp_padu))
            + " padd:" + string(gamepad_button_check(i, gp_padd))
            + " padl:" + string(gamepad_button_check(i, gp_padl))
            + " padr:" + string(gamepad_button_check(i, gp_padr)) + "\n";

        _report += "MAPPED axislh:" + string(gamepad_axis_value(i, gp_axislh))
            + " axislv:" + string(gamepad_axis_value(i, gp_axislv)) + "\n";

        _report += "MAPPED select:" + string(gamepad_button_check(i, gp_select))
            + " start:" + string(gamepad_button_check(i, gp_start))
            + " shoulderl(L1):" + string(gamepad_button_check(i, gp_shoulderl))
            + " shoulderrb(R2):" + string(gamepad_button_check(i, gp_shoulderrb)) + "\n";

        var _raw_buttons = "RAW buttons pressed: ";
        var _raw_count = gamepad_button_count(i);
        for (var b = 0; b < _raw_count; b++) {
            if (gamepad_button_check(i, b)) _raw_buttons += string(b) + " ";
        }
        _report += _raw_buttons + "\n";

        var _raw_axes = "RAW axes: ";
        var _axis_count = gamepad_axis_count(i);
        for (var a = 0; a < _axis_count; a++) {
            _raw_axes += string(a) + "=" + string(gamepad_axis_value(i, a)) + " ";
        }
        _report += _raw_axes + "\n";
    }

    // ---- GAME'S ACTUAL INPUT FUNCTIONS (keyboard OR gamepad combined) ----
    // Only the "held" ones are meaningful in a single-frame snapshot like
    // this - the "_pressed" ones (attack, dash, interact, menu...) are
    // edge-triggered and only true on the exact frame the button was first
    // pressed, so they'd basically always read false here. Use the raw
    // KEYBOARD/GAMEPAD sections above (hold the button, then hit F12) to
    // check those instead.
    _report += "\n== input_* HELD RESULT (scr_input.gml) ==\n";
    _report += "jump_held:" + string(input_jump_held())
        + " move_held_r:" + string(input_move_held(1))
        + " move_held_l:" + string(input_move_held(-1))
        + " status_held:" + string(input_status_held()) + "\n";

    show_message(_report);
}

scr_music_room();

// ===== AVISO DE ANOMALIA (UI) =====
// scr_room_init marca global.anomaly_pending ao entrar numa sala de anomalia.
// A UI e desenhada no evento Draw GUI deste obj_control (persistente, sempre
// renderiza). Fluxo: espera a cutscene de transicao sumir -> fade in -> hold
// -> fade out. So depois disso as hordas sao liberadas.

if (variable_global_exists("anomaly_pending") && global.anomaly_pending) {
    global.anomaly_pending   = false;
    global.anomaly_ui_active = true;
    global.anomaly_ui_title  = global.anomaly_pending_title;
    global.anomaly_ui_desc   = global.anomaly_pending_desc;
    global.anomaly_ui_state  = "wait";
    global.anomaly_ui_t      = 0;
    global.anomaly_ui_a      = 0;
    global.anomaly_ui_yoff   = -24;
    global.anomaly_block_waves = true;
    show_debug_message("[anomaly] UI ativada");
}

if (variable_global_exists("anomaly_ui_active") && global.anomaly_ui_active) {

    var _fade_in  = 16;
    var _hold     = 150;
    var _fade_out = 28;

    global.anomaly_ui_t += 1;
    var _t = global.anomaly_ui_t;

    switch (global.anomaly_ui_state) {
        case "wait":
            global.anomaly_ui_t = 0;
            if (!scr_menu_lock_blocks_world()) global.anomaly_ui_state = "in";
            break;

        case "in":
            global.anomaly_ui_a    = clamp(_t / _fade_in, 0, 1);
            global.anomaly_ui_yoff = lerp(-24, 0, global.anomaly_ui_a);
            if (_t >= _fade_in) {
                global.anomaly_ui_a = 1; global.anomaly_ui_yoff = 0;
                global.anomaly_ui_state = "hold"; global.anomaly_ui_t = 0;
            }
            break;

        case "hold":
            global.anomaly_ui_a = 1;
            if (_t >= _hold) { global.anomaly_ui_state = "out"; global.anomaly_ui_t = 0; }
            break;

        case "out":
            global.anomaly_ui_a    = clamp(1 - (_t / _fade_out), 0, 1);
            global.anomaly_ui_yoff = lerp(0, -18, _t / _fade_out);
            if (_t >= _fade_out) {
                global.anomaly_ui_active   = false;
                global.anomaly_block_waves = false; // libera as hordas
            }
            break;
    }
}

// seguranca: hordas travadas sem nenhuma UI ativa -> destrava
if (variable_global_exists("anomaly_block_waves") && global.anomaly_block_waves
    && !global.anomaly_pending
    && !(variable_global_exists("anomaly_ui_active") && global.anomaly_ui_active)) {
    global.anomaly_block_waves = false;
}
if(layer_get_visible(layer_get_id("ui_menu_main"))){
    layer_set_visible(layer_get_id("ui_pause_layer"), false);
	layer_set_visible(layer_get_id("ui_hud_player"), false);
}
else if (layer_get_visible(layer_get_id("ui_run_finish"))) {
    obj_player.state = PlayerState.TALKING;
    obj_player.talking = true;
	obj_player.invencible = true;
    layer_set_visible(layer_get_id("ui_pause_layer"), false);
	layer_set_visible(layer_get_id("ui_hud_player"), false);
    layer_set_visible(layer_get_id("ui_vignette"), true);
}
else if (scr_menu_lock_blocks_world()) {
    layer_set_visible(layer_get_id("ui_hud_player"), false);
}
else {
    layer_set_visible(layer_get_id("ui_hud_player"), true);
    if (room_get_name(room) != "HUB") {
        time_run += delta_time / 1000000;
    }
    else {
        time_run = 0;   
    }
}

perk_adquired = array_length(obj_player.perks_obtained_run);

var _cam = view_camera[0];

var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);

// centro da câmera
var _center_x = _cam_x + (_cam_w / 2);
var _center_y = _cam_y + (_cam_h / 2);

// aplica nas layers
layer_x("background1", _center_x);
layer_y("background1", _center_y);

layer_x("background2", _center_x * 0.1);
layer_y("background2", _center_y * 0.1);

layer_x("background3", _center_x * 0.125);
layer_y("background3", _center_y * 0.125);

layer_x("background4", _center_x * 0.15);
layer_y("background4", _center_y * 0.15);


if (global.hitstop > 0) {
	global.hitstop--;
	with(all){
		for (var i = 0; i < 12; i++) {
	        if (alarm[i] > 0) alarm[i]++;
	    }
	}
}
	



if (audio_target != audio_current) {

    if (audio_current != noone) {
        audio_stop_sound(audio_current);
    }

    if (audio_target != noone) {
        audio_play_sound(audio_target, 1, true);
    }

    audio_current = audio_target;
}
