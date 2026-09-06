// =====================================================================
// PROMPT ICONS: troca automatica teclado <-> controle (PS4)
// =====================================================================
// A ideia: os menus/HUD mostram o icone do ULTIMO dispositivo que o
// jogador usou. Comeca no teclado; a primeira vez que qualquer botao ou
// analogico do controle e usado, todos os prompts viram icone de controle;
// a primeira tecla pressionada volta pro teclado. Se o controle for
// desconectado, cai de volta pro teclado sozinho.
//
// USO:
//   - input_prompt_update()  -> chamar 1x por frame num Begin Step central
//                               (ja e chamado por obj_control).
//   - input_prompt_is_gamepad() -> true se e pra desenhar icones de controle.
//   - scr_prompt_sprite(tag) -> devolve o sprite certo pra aquela acao,
//                               considerando o dispositivo atual.
// =====================================================================

#macro PROMPT_DEVICE_KEYBOARD 0
#macro PROMPT_DEVICE_GAMEPAD  1

// deadzone pra considerar que o analogico/gatilho "foi mexido de proposito"
#macro PROMPT_STICK_DEADZONE 0.4

/// @function input_prompt_update()
/// @description Atualiza global.prompt_device com base no ultimo input.
///              Deve rodar 1x por frame (Begin Step de obj_control).
function input_prompt_update() {

    if (!variable_global_exists("prompt_device")) {
        global.prompt_device = PROMPT_DEVICE_KEYBOARD;
    }

    // ---- atividade de teclado: qualquer tecla recem-pressionada ----
    if (keyboard_check_pressed(vk_anykey)) {
        global.prompt_device = PROMPT_DEVICE_KEYBOARD;
        return;
    }

    // ---- atividade de controle ----
    var _pad = input_gamepad_slot();
    if (_pad == -1) return; // nenhum controle conectado, nada a detectar

    // qualquer botao do controle recem-pressionado
    var _btns = [
        gp_face1, gp_face2, gp_face3, gp_face4,
        gp_padu, gp_padd, gp_padl, gp_padr,
        gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
        gp_start, gp_select, gp_stickl, gp_stickr
    ];
    for (var i = 0; i < array_length(_btns); i++) {
        if (gamepad_button_check_pressed(_pad, _btns[i])) {
            global.prompt_device = PROMPT_DEVICE_GAMEPAD;
            return;
        }
    }

    // analogicos / gatilhos movidos alem da deadzone
    if (abs(gamepad_axis_value(_pad, gp_axislh)) > PROMPT_STICK_DEADZONE
     || abs(gamepad_axis_value(_pad, gp_axislv)) > PROMPT_STICK_DEADZONE
     || abs(gamepad_axis_value(_pad, gp_axisrh)) > PROMPT_STICK_DEADZONE
     || abs(gamepad_axis_value(_pad, gp_axisrv)) > PROMPT_STICK_DEADZONE) {
        global.prompt_device = PROMPT_DEVICE_GAMEPAD;
    }
}

/// @function input_prompt_is_gamepad()
/// @description true = desenhar icones de controle; false = teclado.
function input_prompt_is_gamepad() {

    if (!variable_global_exists("prompt_device")) return false;

    // controle sumiu no meio do caminho: volta pro teclado
    if (global.prompt_device == PROMPT_DEVICE_GAMEPAD && input_gamepad_slot() == -1) {
        global.prompt_device = PROMPT_DEVICE_KEYBOARD;
    }

    return (global.prompt_device == PROMPT_DEVICE_GAMEPAD);
}

/// @function scr_prompt_sprite(tag)
/// @description Recebe o nome logico da acao (as mesmas tags usadas no
///              rich text) e devolve o sprite do dispositivo atual.
///              Devolve noone se a tag nao for reconhecida.
function scr_prompt_sprite(_tag) {

    var _g = input_prompt_is_gamepad();

    switch (_tag) {
        // --- gameplay ---
        case "JUMP_BUTTON":     return _g ? spr_controller_btn__x            : spr_btn_space;
        case "MOVE_BUTTON":     return _g ? spr_controller_btn_left_analogic : spr_btn_move;
        case "ATTACK_BUTTON":   return _g ? spr_controller_btn_square        : spr_btn_z;
        case "DASH_BUTTON":     return _g ? spr_controller_btn_r2            : spr_btn_c;

        // interagir no mundo / confirmar em menu: no teclado e a mesma tecla (E);
        // no controle e o X (Cross), que e o confirm de menu e a interacao util.
        case "INTERACT_BUTTON": return _g ? spr_controller_btn__x            : spr_btn_e;

        // --- HUD ---
        // so o BOTAO a apertar (o icone do mapa e desenhado a parte, ver obj_map)
        case "OPEN_MAP_BUTTON": return _g ? spr_controller_btn_share         : spr_btn_m;
        case "STATUS_BUTTON":   return _g ? spr_controller_btn_l1            : spr_btn_tab;
    }

    return noone;
}
