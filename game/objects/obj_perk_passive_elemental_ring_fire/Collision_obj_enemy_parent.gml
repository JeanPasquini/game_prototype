attack_hit_confirmed = false;
event_inherited();
if (!attack_hit_confirmed) exit;
obj_perk_passive_elemental_ring.alarm[0] = 200;
instance_destroy();
