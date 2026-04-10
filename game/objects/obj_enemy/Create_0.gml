// Inherit the parent event
event_inherited();
life = 0;
throwsProjectile = obj_projectile;
chasing_attack_script = src_basic_projectile_attack();
chasing_movement_script = src_limited_flying_movement();
damage = 1;
knockback_strength = 5;