function src_show_player_damage_received(damage){
	if(!obj_player.invencible){
		var dmg = instance_create_layer(obj_player.x, obj_player.y, "instances", obj_damage_text);
		dmg.text = "- " + string(damage);
		obj_player.life -= damage;
		obj_player.invencible = true;
		obj_player.alarm[0] = obj_player.invencible_time;
	}
}