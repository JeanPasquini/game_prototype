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
