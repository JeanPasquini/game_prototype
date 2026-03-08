// Inherit the parent event
event_inherited();

detectionRadius = 180;
life = 10;
isCharging = false;

throwsProjectile = obj_air_projectile;
idle_movement_script = src_jumping_idle_movement();
chasing_attack_script = src_charging_projectile_attack();
chasing_movement_script = src_limited_flying_movement();

currentAttackDelay = 0;
chargingAttackTimer = 120;
chargingAttackCountDown = chargingAttackTimer;