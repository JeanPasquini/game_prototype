var _sx = 0;
var _sy = 0;

if (shake_amount > 0) {
    _sx = random_range(-shake_amount, shake_amount);
    _sy = random_range(-shake_amount, shake_amount);
}

draw_sprite_ext(sprite_index, image_index, x + _sx, y + _sy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if(image_speed == 1) audio_hit_shield();