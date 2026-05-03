if (!surface_exists(surf)) {
    surf = surface_create(room_width, room_height);
}

surface_set_target(surf);

// limpa totalmente preta (escuro total)
draw_clear(make_color_rgb(80, 80, 80));

// usa ADD pra desenhar luz (isso é essencial)
gpu_set_blendmode(bm_add);

// luz geral
with (obj_light) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.8, image_yscale * 0.8, image_angle, c_white, 0.5);
}

// player
with (obj_player) {
    draw_sprite_ext(spr_light, 0, x, y, 2, 2, 0, c_white, 1);
}

// torch
with (obj_environment_torch)
{
    var flicker = random_range(0.975, 1);
    var alpha_flicker = random_range(0.8, 1);

    draw_sprite_ext(
        spr_light,
        0,
        x,
        y,
        2 * flicker,
        2 * flicker,
        0,
        make_color_rgb(255, 220, 120),
        alpha_flicker
    );
}

// coin (vermelho)
with (obj_drop_coin) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, c_red, 1);
}

// life (verde)
with (obj_drop_life) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, c_green, 1);
}

// training dummy
with (obj_training_dummy) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(255, 220, 120), 1);
}

// elemental ring fire
with (obj_perk_passive_elemental_ring_fire) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(255, 120, 60), 1);
}

// elemental ring ice
with (obj_perk_passive_elemental_ring_ice) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(120, 220, 255), 1);
}

// elemental ring venomous
with (obj_perk_passive_elemental_ring_venomous) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(120, 255, 80), 1);
}

// volta ao normal
gpu_set_blendmode(bm_normal);

surface_reset_target();

// 🔥 AQUI É O SEGREDO FINAL 🔥
// desenha a surface multiplicando (faz o escuro funcionar)
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_surface(surf, 0, 0);
gpu_set_blendmode(bm_normal);