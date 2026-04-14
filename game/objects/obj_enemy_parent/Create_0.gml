enum EnemyState {
	IDLE,
	CHASING,
	JUMPING,
	ONGROUND,
	FALLING,
	RETURNING,
	SPECIAL_ATTACK,
	CHARGING_ATTACK
}

drops = [
    { item: noone, chance: 10 },
    { item: obj_drop_coin, chance: 15 },
    { item: obj_drop_key, chance: 5 },
    { item: obj_drop_life, chance: 70 }
];

// Attack
life = 1;
is_destroyed = false;
currentState = EnemyState.IDLE;
throwsProjectile = noone;
meleeRange = 10;
baseAttackDelay = 1 * 60;
currentAttackDelay = baseAttackDelay;
is_invencible = false;
damage = 1;
hasToCharge = false;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;
direction = 0;  // 180 = left, 0 = right
detectionRadius = 100;
maxRandomMovement = 100;
movementSpeed = 1;
currentMovement = EnemyState.ONGROUND;
knockback_x = 0;
knockback_y = 0;
knockback_strength = 5;
idle_movement_script = src_basic_idle_movement();
chasing_movement_script = src_basic_idle_movement();
chasing_attack_script = function () {}; // guarantees only damage from contact.

// Effects

freeze = false;
freeze_color = c_aqua;
freeze_alpha = 0;

poison = false;
poison_damage = 1;

alpha = 0;
color = c_white;
