draw_set_font(fnt_ui_menu_boss_introduction_vignette_text);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_center);

if (obj_menu_boss_introduction.boss_introduction) {
    
    image_alpha = lerp(image_alpha, 1, 0.02);
    
    draw_set_alpha(image_alpha);
    draw_text(x, y, obj_menu_boss_introduction.boss_name);
    
    draw_set_alpha(1); // volta ao normal
}
else{
	image_alpha = lerp(image_alpha, 0, 0.1);
    
    draw_set_alpha(image_alpha);
    
    draw_set_alpha(0); // volta ao normal
}