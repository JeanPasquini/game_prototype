if (is_destroyed) {
	tentacles = scr_destroy_tentacles_ds(tentacles);
	instance_destroy();
}


if (telegraph_timer > 0) {
	telegraph_timer--;
} else {
	
	if (tentacles != -1 && ds_exists(tentacles, ds_type_list)) {
		if (ds_list_size(tentacles) >= max_tentacles) {
			var _tent0 = tentacles[| 0];
			if (instance_exists(_tent0)) _tent0.is_destroyed = true;
			ds_list_delete(tentacles, 0);
		}
	} else {
		return;
	}
	
	var _tent =  instance_create_layer(telegraphX, telegraphY-sprite_get_height(spr_tentacles), "Instances", obj_psicotopus_tentacles);
	ds_list_add(tentacles, _tent);
	
	telegraphX = obj_player.x;
	telegraphY = obj_player.y;	
	
	var _height = scr_get_obj_floor_distance(telegraphX, telegraphY);
	
	telegraphY += (_height - sprite_get_height(spr_telegraph));	
	
	telegraph_timer = telegraph_timer_base;
}