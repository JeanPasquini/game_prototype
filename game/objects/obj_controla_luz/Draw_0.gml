if(!surface_exists(surf)){
	surf = surface_create(room_width, room_height);	
}
else{
	surface_set_target(surf);
	
	draw_clear_alpha(c_black, 0.5);
	gpu_set_blendmode(bm_subtract);
			
	with(obj_light){
			
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.8, image_yscale * 0.8, image_angle, c_white, 0.5);	
	}
	
	with (obj_player)
	{		
		draw_sprite_ext(spr_light, 0, x, y, 2, 2, 0, c_white, 1);	
	}
	
	with (obj_environment_torch)
	{		
		draw_sprite_ext(spr_light, 0, x, y, 2, 2, 0, c_white, 1);	
	}
	
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
	
	draw_surface(surf, 0 , 0);
}