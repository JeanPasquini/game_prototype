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
		if(!open && obj_player.key > 0){
			obj_player.key --;
			audio_play_sound(sde_environment_chest_open, 1, false);
			open = true;
				scr_perk_altar(x, y)
		}
		else if (obj_player.key == 0 && !open){
			var _warning = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_warning);	
			_warning.alarm[0] = 200;
			_warning.message_warning = "No keys!"	
		}
    }
}