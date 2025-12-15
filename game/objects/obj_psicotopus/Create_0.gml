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

countAttackStates = 1; // Tem que ser -1 para ignorar WAITING
currentAttackState = AttackState.WAITING;

attack_cooldown = 0;
change_attack_cooldown = 0;

range_time_between_attacks = [180, 240]; // 3 a 4 segundos, o mínimo deve ser 3 para ataques de 3 balas

life = 10;
damage = 1;
