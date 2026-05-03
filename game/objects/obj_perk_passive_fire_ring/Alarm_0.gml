image_speed = 1;
image_alpha = 1;
var sfx = [
	sde_perk_fire_ring
];					
scr_audio_play(sfx);
if (ds_exists(hit_enemies, ds_type_list))
{
    ds_list_clear(hit_enemies);
}