// Respeita o hitstop global igual ao resto do jogo (inimigos, player).
if (global.hitstop > 0) exit;

max_life--;

// --- gravidade / arrasto ---
vsp += grv;
hsp *= air_drag;

// --- movimento horizontal com quique lateral em parede ---
if (is_solid(x + hsp, y)) {
    while (abs(hsp) >= 1 && !is_solid(x + sign(hsp), y)) {
        x += sign(hsp);
    }
    hsp = -hsp * bounce;
    if (abs(hsp) < 0.05) hsp = 0;
} else {
    x += hsp;
}

// --- movimento vertical com quique no chao/teto ---
if (is_solid(x, y + vsp)) {
    while (abs(vsp) >= 1 && !is_solid(x, y + sign(vsp))) {
        y += sign(vsp);
    }

    var _was_falling = (vsp > 0);
    vsp = -vsp * bounce;
    hsp *= friction_floor;

    // quique fraco o suficiente => considera pousado
    if (_was_falling && abs(vsp) < 0.55) {
        vsp = 0;
        rest_frames++;
    }
} else {
    y += vsp;
    rest_frames = 0;
}

// --- inicio do fade: ao descansar, ou quando estoura o tempo de vida ---
if (fade_timer < 0 && (rest_frames >= rest_needed || max_life <= 0)) {
    fade_timer = fade_len;
}

if (fade_timer >= 0) {
    fade_timer--;
    image_alpha = fade_timer / fade_len;
    if (fade_timer <= 0) instance_destroy();
}
