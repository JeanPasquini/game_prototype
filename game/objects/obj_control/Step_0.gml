scr_music_room();

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
