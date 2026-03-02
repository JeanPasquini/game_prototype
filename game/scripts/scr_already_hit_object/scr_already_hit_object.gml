function scr_already_hit_object(_hit_enemies, object){
	if (!ds_exists(_hit_enemies, ds_type_list)) return true;
	return ds_list_find_index(_hit_enemies, object) != -1;
}