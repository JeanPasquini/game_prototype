// Inherit the parent event
event_inherited();

detectionRadius = 180;
life = 10;

throwsProjectile = obj_air_projectile;
chasing_attack_script = src_basic_projectile_attack();
chasing_movement_script = src_limited_flying_movement();

currentAttackDelay = 0;
chargingAttackTimer = 120;
chargingAttackCountDown = chargingAttackTimer;