draw_set_font(fnt_ui_menu_perk_selection_title);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_center);

if (type_info == 1) {
    draw_text(x, y, obj_player.money);
}

if (type_info == 2) {
    draw_text(x, y, obj_player.key);
}

// voltar ao padrão
draw_set_halign(fa_left);