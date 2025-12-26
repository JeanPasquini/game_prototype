if(open){
	image_index = 1;
}
else{
	image_index = 0;
}

var range = 30;

if (instance_exists(obj_player)) {
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < range && keyboard_check_pressed(ord("E"))) {
		if(open){
			audio_play_sound(sde_environment_door_close, 1, false);
			open = false;
		}
		else{
			audio_play_sound(sde_environment_door_open, 1, false);
			open = true;
		}
    }
}