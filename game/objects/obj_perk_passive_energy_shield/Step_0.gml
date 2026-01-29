if(count_hits >= need_hits){
	if(!instance_exists(obj_perk_passive_energy_shield_2)) instance_create_layer(obj_player.x, obj_player.y, "perk_in_run", obj_perk_passive_energy_shield_2);
	count_hits = 0;
}