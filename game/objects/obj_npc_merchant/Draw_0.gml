draw_self(); 

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist < range_interaction && obj_player.state != PlayerState.TALKING) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(obj_player.x, obj_player.y - 40, "Press 'E'");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top); 

}