draw_self(); 

var dist = point_distance(x, y, obj_player.x, obj_player.y);
var xx = obj_player.x;
var yy = obj_player.y - 35;

if (dist < range_interaction && obj_player.state != PlayerState.TALKING) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top); 
	draw_sprite_ext(
    spr_ui_press_e_menu,
    0,
    xx,
    yy,
    1,
    1,
    0,
    c_white,
    1
);

}