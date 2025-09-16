function src_show_player_damage_received(){
	var dmg = instance_create_layer(obj_player.x, obj_player.y, "instances", obj_damage_text);
	dmg.text = "- " + string(damage);
	obj_player.life -= damage;
}