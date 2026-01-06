function src_show_player_damage_received(damage){
	if(!obj_player.invencible && obj_player.life > 0){
		scr_camera_shake(10,10);
		audio_play_sound(sde_player_receive_damage, 1, false);
		var dmg = instance_create_layer(obj_player.x, obj_player.y, "instances", obj_damage_text);
		dmg.text = "- " + string(damage);
		obj_player.life -= damage;
		obj_player.invencible = true;
		obj_player.alarm[0] = obj_player.invencible_time;
	}
}