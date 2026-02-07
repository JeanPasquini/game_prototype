draw_self();

for (var i = 0; i <= height; i += sprite_get_height(spr_water)) {	
	for (var j = 0; j <= width; j += sprite_get_width(spr_water)) {	
		
		if (i == 0) {
			draw_sprite(spr_water_top, 0, x + j, y + i);	
		} else {
			draw_sprite(spr_water, 0, x + j, y + i);
		}	
		
	}
}
