//attack_hit_confirmed = false;

event_inherited();

if (!attack_hit_confirmed) exit;

audio_play_sound(sde_enemy_hit, 1, false);

scr_camera_shake(5, 5)

obj_effect_unicle.scr_fx_hit_impact(other.x, other.y);


if (obj_player.energy < obj_player.energy_max && obj_player.perk_activatable != noone)
    obj_player.energy++;
