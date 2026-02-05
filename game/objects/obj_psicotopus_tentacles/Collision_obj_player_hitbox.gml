if (type == TentacleType.ALIVE && !scr_already_hit_object(other.hit_enemies, id)) {
	life--;
	ds_list_add(other.hit_enemies, id);
	if (life <= 0) is_destroyed = true;
}