// Inherit the parent event
event_inherited();

enum AttackState {
	OCTOPUS_ATTACK,
	TRIPLE_VERTICAL,
    HOMING_SINGLE,
    TRIPLE_RICOCHET,
		
	FLOOD,	
	WAITING,
}

countAttackStates = 0; // Tem que ser -1 para ignorar WAITING
currentAttackState = AttackState.WAITING;
is_attacking = false;

attack_cooldown = 0;
change_attack_cooldown = 0;

range_time_between_attacks = [180, 240]; // 3 a 4 segundos

life = 10;
damage = 1;
