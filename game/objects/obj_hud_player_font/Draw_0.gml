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

if (type_info == 3 && room_get_name(room) != "HUB") {
    draw_text_transformed(x, y, obj_control.time_run, 0.75, 0.75, 0);
}

// HUD de sala de horda: só aparece em salas "challenge_*" com wave manager ativo.
// Fora dessas salas não desenha nem o quadrado nem a contagem.
var _is_challenge_room = (string_pos("challenge", room_get_name(room)) > 0) && instance_exists(obj_wave_manager);

// quantidade de inimigos vivos na room
if (type_info == 4 && _is_challenge_room) {
    draw_sprite_ext(spr_ui_player_hud_info_enemies, 0, x - 30, y - 12, 1.5, 1.5, 0, c_white, 1);
    draw_text(x, y, instance_number(obj_enemy_parent));
}

// horda atual / total de hordas, ex "1/3"
if (type_info == 5 && _is_challenge_room) {
    var _cur = max(obj_wave_manager.current_wave, 1);
    draw_sprite_ext(spr_ui_player_hud_info_hordes, 0, x - 30, y - 12, 1.5, 1.5, 0, c_white, 1);
    draw_text(x, y, string(_cur) + "/" + string(obj_wave_manager.total_waves));
}

// voltar ao padrão
draw_set_halign(fa_left);