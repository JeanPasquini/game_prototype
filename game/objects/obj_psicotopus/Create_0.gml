// Inherit the parent event
event_inherited();

enum AttackState {
	TRIPLE_VERTICAL,
    HOMING_SINGLE,
    TRIPLE_RICOCHET,
	OCTOPUS_ATTACK,
	FLOOD,	
	WAITING,
}

countAttackStates = 2; // Tem que ser -1 para ignorar WAITING
currentAttackState = AttackState.WAITING;

attack_cooldown = 0;
change_attack_cooldown = 0;

range_time_between_attacks = [120, 180]; // 3 a 4 segundos

life = 10;
damage = 1;
