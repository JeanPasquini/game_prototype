// "press any button" + descida da câmera rodam só uma vez por execução; ao voltar pro HUB
// (pause > return to hub) vai direto pro menu principal, com o player em INTRODUCTION
var _intro_seen = variable_global_exists("intro_done") && global.intro_done;

layer_name = "ui_menu_main";
button_id = 1; // 1 = Play, 2 = Exit
playing = false;

// fases da abertura: 0 = "press any button" no alto, 1 = câmera descendo até o player, 2 = menu principal
phase = 0;
cam_descend_frames = 480;               // duração da descida (60 fps = 8s); aumente pra ficar mais lenta
cam_descend_t      = 0;                 // progresso 0..1 da descida
cam_descend_from   = obj_cam_follow.y;

// fade do "press any button": só começa quando a logo termina de aparecer
intro_text_alpha       = 0;
intro_text_fade_frames = 60;
logo_snap      = undefined;   // foto da logo (sprite/pos/escala) pra redesenhar ancorada no mundo
intro_view_y0  = 0;           // Y da view no instante em que a descida começa

intro_text_set_alpha = function(_a) {
    with (obj_menu_text) {
        if (description == "Press any button to start") image_alpha = _a;
    }
};
intro_text_set_alpha(0);

scr_menu_lock_try("introduction");

obj_player.state = PlayerState.INTRODUCTION;
obj_player.talking = true;
obj_player.introduction_start = false;

// a câmera começa presa no obj_cam_follow (posicionado no alto da sala) e já nasce nele, sem deslizar
obj_cam.target_ = obj_cam_follow;
obj_cam.zoom_target = 0.7;
obj_cam.x = obj_cam_follow.x;
obj_cam.y = obj_cam_follow.y - obj_cam.base_height_ * obj_cam.zoom_target / 4;

if (_intro_seen) {
    // câmera já no enquadramento do player e menu principal direto
    obj_cam_follow.x = obj_player.x;
    obj_cam_follow.y = obj_player.y;
    obj_cam.x = obj_cam_follow.x;
    obj_cam.y = obj_cam_follow.y - obj_cam.base_height_ * obj_cam.zoom_target / 4;
    phase = 2;
}

layer_set_visible(layer_get_id("ui_introduction"), !_intro_seen);
layer_set_visible(layer_get_id("ui_menu_main"), _intro_seen);
layer_set_visible(layer_get_id("ui_hud_player"), false);
layer_set_visible(layer_get_id("ui_vignette"), false);
