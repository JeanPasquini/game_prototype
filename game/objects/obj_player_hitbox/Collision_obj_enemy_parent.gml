attack_hit_confirmed = false;
event_inherited();
if (!attack_hit_confirmed) exit;

audio_play_sound(sde_enemy_hit, 1, false);

var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);

other.knockback_x = lengthdir_x(obj_player.attack_knockback, dir);
obj_player.knockback_x = -lengthdir_x(obj_player.attack_recoil, dir);

if (obj_player.energy < obj_player.energy_max && obj_player.perk_activatable != noone)
    obj_player.energy++;
