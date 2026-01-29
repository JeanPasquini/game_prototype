if(alarm[0] == 1){
	obj_combo_streak.scr_combo_streak();
	other.life -= damage;
	
	var dmg = instance_create_layer(other.x, other.y, "Instances", obj_damage_text);
	dmg.text = "- " + string(damage);
	dmg.color = c_white;

	var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);
}

