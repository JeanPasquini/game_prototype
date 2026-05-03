attack_hit_confirmed = false;

if (hit_enemies_bool)
{
    if (ds_exists(hit_enemies, ds_type_list))
    {
        if (ds_list_find_index(hit_enemies, other.id) != -1)
            exit;

        ds_list_add(hit_enemies, other.id);
    }
}

other.life--;
other.shake = 5;

attack_hit_confirmed = true;

var sfx = [
	attack_1,
	attack_2
];						
scr_audio_play(sfx);

obj_effect_unicle.scr_fx_hit_impact(other.x, other.y);
