// Inherit the parent event
event_inherited();
life = 10;
maxDetectionRadius = 180;
throwsProjectile = obj_projectile;
idle_movement_script = src_random_flying_idle_movement();
chasing_attack_script = src_lunge_attack();
chasing_movement_script = src_random_flying_chasing_movement();
damage = 1;
knockback_strength = 5;

// --- Controle de voo
fallSpeed = 0;      // velocidade atual com que o peso o puxa pra baixo
thrustCooldown = 0; // contagem até o próximo esforço pra subir
yOffset = 0;        // deslocamento atual
maxOffsetUp   = 16;  // até onde pode subir em relação ao ystart
maxOffsetDown = 16;  // até onde pode "afundar" em relação ao ystart

baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;
retreatTimer = 0;
