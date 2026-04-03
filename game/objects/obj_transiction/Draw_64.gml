
	for(var i = 0; i < lins; i++)
	{
		for(var j = 0; j < cols; j++)	
		{
			//draw_sprite(spr_quad, 8, j * size, i * size);
		
			//if(img > img_num) img = img_num;
		
			var _img = min(max(0, img - j), img_num);
		
			draw_sprite_ext(spr_quad, _img, j * size, i * size, 1, 1, 0, c_black, 1);
		}
	}
