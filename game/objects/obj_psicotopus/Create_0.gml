// Inherit and execute the parent object's Create event logic
event_inherited();

enum AttackState {	
	FLOOD,              // Area-filling or flooding type attack
	OCTOPUS_ATTACK,     // Main octopus attack pattern
	TRIPLE_VERTICAL,    // Fires three bullets vertically
    HOMING_SINGLE,      // Fires a single homing projectile
    TRIPLE_RICOCHET,    // Fires three ricochet bullets
	
	
	WAITING,            // Idle state between attacks
}

// Index or counter used to cycle through attack states
// Must be "count(AttackState)-1" to properly ignore the WAITING state when cycling
countAttackStates = 0;
currentAttackState = AttackState.WAITING;

is_attacking = false;
attack_cooldown = 0;

change_attack_cooldown = 0;

// Randomized time range (in steps) between attacks: 3 to 4 seconds
range_time_between_attacks = [180, 240];

life = 10;    
damage = 1;   

tentacles = -1
