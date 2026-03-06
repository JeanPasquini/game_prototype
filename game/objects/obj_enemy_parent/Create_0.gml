enum EnemyState {
	IDLE,
	CHASING,
	JUMPING,
	ONGROUND,
	FALLING,
	SPECIAL_ATTACK,
	CHARGING_ATTACK
}

drops = [
    { item: noone, chance: 10 },
    { item: obj_drop_coin, chance: 15 },
    { item: obj_drop_key, chance: 5 },
    { item: obj_drop_life, chance: 70 }
];

idle_movement_script = src_basic_idle_movement();
chasing_movement_script = src_basic_idle_movement();
chasing_attack_script = function () {}; // guarantees only damage from contact.
life = 1;
is_destroyed = false;
currentMovement = EnemyState.ONGROUND;
currentState = EnemyState.IDLE;
detectionRadius = 100;
maxRandomMovement = 100;
movementSpeed = 1;
throwsProjectile = noone;
baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;
meleeRange = 10;
jump_direction = 1;
is_invencible = false;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;


speed = movementSpeed;
direction = 0;  // 180 = left, 0 = right

knockback_x = 0;
knockback_y = 0;



damage = 1;

//Effects

freeze = false;
freeze_color = c_aqua;
freeze_alpha = 0;

poison = false;
poison_damage = 1;
