part_system_position(_ps, x, y);
if (instance_exists(telegraph)) {
    if (telegraph.is_destroyed) {
		instance_destroy();	
    }
}