if(number_enemy > 0){
	if (instance_number(obj_enemy_parent) == 0 && created == false)
	{
		created = true;
	    scr_perk_altar(obj_player.x, obj_player.y + 8);
	}
}