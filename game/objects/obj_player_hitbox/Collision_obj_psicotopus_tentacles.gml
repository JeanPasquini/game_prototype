attack_hit_confirmed = false;

event_inherited();

if (!attack_hit_confirmed) exit;

audio_play_sound(sde_enemy_hit, 1, false);

if (obj_player.energy < obj_player.energy_max && obj_player.perk_activatable != noone)
    obj_player.energy++;
