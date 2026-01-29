ring_frame += ring_anim_speed;

var max_frames = 60; // ou sprite_get_number(spr_ring)

if (ring_frame >= max_frames) {
    ring_frame = 0;
}
