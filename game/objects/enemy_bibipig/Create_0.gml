// Inherit the parent event
event_inherited();

baseAttackDelay = 90; 
detectionRadius = 120;
hasToCharge = true;
currentChargingDelay = baseAttackDelay;
currentAttackDelay = baseAttackDelay;

knockback_strength = 25;

idle_movement_script = src_grounded_idle_movement();
chasing_movement_script = src_grounded_sprint_chasing_movement();
chasing_attack_script = src_charging_sprint_attack(); // guarantees only damage from contact.