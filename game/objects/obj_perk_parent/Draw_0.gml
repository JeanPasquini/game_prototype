
draw_self(); 

var range = 30;

if (!variable_global_exists("show_prompt")) {
    global.show_prompt = false;
}

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist < range && !global.show_prompt) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(obj_player.x, obj_player.y - 40, "Press 'E'");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top); 
    
    global.show_prompt = true;
}

if (dist >= range) {
    global.show_prompt = false;
}
