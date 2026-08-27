// Em jogo o marcador é invisível; só aparece o aviso visual durante a contagem.
if (warning_active) {
    var _s = 0.9 + 0.12 * sin(warn_pulse);
    var _a = 0.45 + 0.55 * abs(sin(warn_pulse));
    draw_sprite_ext(spr_warning_enemy_spawn, 0, x, y, _s, _s, 0, c_white, _a);
}
