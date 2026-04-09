if(number_enemy > 0){
	if (instance_number(obj_enemy_parent) == 0 && created == false)
	{
		created = true;
	    //scr_perk_altar(obj_player.x, obj_player.y + 8);
		if (array_length(obj_player.perks_obtained_run) < obj_player.perks_limit_run) instance_create_layer(x, y, "controls", obj_perk_selection);
	}
}