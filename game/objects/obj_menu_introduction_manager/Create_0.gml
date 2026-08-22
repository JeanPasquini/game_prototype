layer_name = "ui_menu_main";
button_id = 1; // 1 = Play, 2 = Exit
playing = false;

scr_menu_lock_try("introduction");

var _campfire = instance_exists(obj_environment_campfire) ? obj_environment_campfire : obj_player;

obj_player.state = PlayerState.INTRODUCTION;
obj_player.talking = true;
obj_player.introduction_start = false;

obj_cam.target_ = noone;
obj_cam.fixed_point = true;
obj_cam.point_x = (obj_player.x + _campfire.x) / 2;
obj_cam.point_y = (obj_player.y + _campfire.y) / 2;
obj_cam.zoom_target = 0.7;

layer_set_visible(layer_get_id("ui_menu_main"), true);
layer_set_visible(layer_get_id("ui_hud_player"), false);
layer_set_visible(layer_get_id("ui_vignette"), false);
