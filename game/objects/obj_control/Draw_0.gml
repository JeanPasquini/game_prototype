if (global.hitstop_timer > 0) {
    draw_set_alpha(0.8);   // escurece levemente a tela
    draw_self();            // desenha o objeto normalmente
    draw_set_alpha(1);      // volta ao normal para o resto do desenho
}