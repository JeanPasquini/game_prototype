if (!scr_lighting_enabled()) exit;   // sala com iluminação desligada (global.room_lighting_enabled = false)

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

// feixes de luz colocados na room: igual ao obj_light, mas com a cor escolhida na instância e na MESMA escala
// do desenho visível (com 0.8 o mapa de luz virava um segundo feixe menor dentro do primeiro)
with (obj_light_beam) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, light_color, 0.5);
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

// torch
with (obj_environment_campfire)
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

// cururu enemy
with (obj_enemy_cururu) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(80, 255, 120), 1);
}

// air projectile made by cururu
with (obj_air_projectile) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, make_color_rgb(120, 255, 200), 0.5);
}


// bibipig enemy
with (obj_enemy_bibipig) {
    draw_sprite_ext(spr_light, 0, x, y, 1.5, 1.5, 0, make_color_rgb(200, 100, 255), 0.5);
}

// psicotopus enemy
with (obj_psicotopus) {
    draw_sprite_ext(spr_light, 0, x, y, 5, 5, 0, c_white, 1);
}

with (obj_octopus) {
    draw_sprite_ext(spr_light, 0, x, y, 5, 5, 0, c_white, 1);
}

with (obj_psicotopus_net_ball) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, make_color_rgb(255, 70, 200), 1);
}

with (obj_psicotopus_ship) {
    draw_sprite_ext(spr_light, 0, x, y, 10, 10, 0, make_color_rgb(255, 120, 220), 1);
}

with (obj_psicotopus_sword) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, make_color_rgb(255, 70, 200), 1);
}

with (obj_psicotopus_ball) {
    draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, make_color_rgb(255, 70, 200), 1);
}

// volta ao normal
gpu_set_blendmode(bm_normal);

surface_reset_target();

// ===== tiles da frente (tl_front_*) NUNCA recebem luz =====
// monta uma silhueta dos tiles numa surface auxiliar, pinta ela com a cor ambiente e carimba no mapa de luz:
// onde há tile da frente o mapa fica só com a escuridão base, então nenhuma luz se sobressai por cima dele.
if (!surface_exists(surf_mask)) {
    surf_mask = surface_create(room_width, room_height);
}
surface_set_target(surf_mask);
draw_clear_alpha(c_black, 0);
var _front_layers = scr_front_tile_layers();
for (var _fi = 0; _fi < array_length(_front_layers); _fi++) {
    var _fl = layer_get_id(_front_layers[_fi]);
    if (_fl == -1) continue;
    var _tm = layer_tilemap_get_id(_fl);
    if (_tm == -1) continue;
    draw_tilemap(_tm, tilemap_get_x(_tm), tilemap_get_y(_tm));
}
// cor ambiente por cima, preservando o alpha dos tiles (src * destAlpha)
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
draw_set_color(make_color_rgb(80, 80, 80));
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);
surface_reset_target();

surface_set_target(surf);
draw_surface(surf_mask, 0, 0);
surface_reset_target();

// 🔥 AQUI É O SEGREDO FINAL 🔥
// desenha a surface multiplicando (faz o escuro funcionar)
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_surface(surf, 0, 0);
gpu_set_blendmode(bm_normal);