draw_self(); 

var dist = point_distance(x, y, obj_player.x, obj_player.y);
var yy = y - 80;

if (!has_talked)
{
	if (dist < range_interaction && obj_player.state != PlayerState.TALKING) {
	    draw_set_color(c_white);
	    draw_set_alpha(1);
	    draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top); 
		draw_sprite_ext(
	    spr_merchant_trade,
	    0,
	    x,
	    yy,
	    1,
	    1,
	    0,
	    c_white,
	    1
		);
		
		// Texto
		draw_set_font(fnt_player_action);
	    draw_set_halign(fa_center);
	    draw_set_valign(fa_middle);
	    draw_set_color(c_white);

	    draw_text_transformed(
	        x - 24,
	        yy,
	        "2",
	        0.5,
	        0.5,
	        0
	    );
	

	}
}