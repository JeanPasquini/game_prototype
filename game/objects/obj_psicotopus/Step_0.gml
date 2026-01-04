// Inherit and execute the parent Step event logic
event_inherited();

// If the enemy is idle, skip all attack processing
if currentState == EnemyState.IDLE return;

// Execute logic based on the currently selected attack state
switch (currentAttackState) {

    case AttackState.TRIPLE_VERTICAL:
        // Executes the vertical triple-shot attack pattern
        attack_triple_vertical();
		break;

    case AttackState.HOMING_SINGLE:
        // Executes a single homing projectile attack
        attack_homing_single();
		break;

    case AttackState.TRIPLE_RICOCHET:
        // Executes a triple ricochet projectile attack
        attack_triple_ricochet();
		break;

	case AttackState.OCTOPUS_ATTACK:
		// Spawns the octopus special attack entity
		octopus_attack();
		break;
		
	case AttackState.FLOOD:
		flood_arena_attack();
		break;

	case AttackState.WAITING:
		// Chooses the next attack after waiting cooldown
		choose_next_attack();
		break;
}

// Handles a triple vertical bullet attack over a short time window
function attack_triple_vertical() {
    if (attack_cooldown > 0) {
		// Stop movement while attacking
		speed = 0;	
		
		// Fire a bullet every 30 steps
		if (attack_cooldown % 30 == 0) {
			var inst = instance_create_layer(x, y, "Instances", obj_bullet_vertical);
		}
		
		// Decrease attack timer
		attack_cooldown--;
		
		// Reset attack state once the sequence is finished
		if (attack_cooldown == 0) {
			_reset_attack();
		}
        return;
    }
	
    // Initialize attack duration (3 shots over time)
    attack_cooldown = 90;
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
}

// Handles a single homing projectile attack
function attack_homing_single() {
   // Handles generic attack timing and early exit
   if (attack_cooldown > 0) {
		// Stop movement while attacking
		speed = 0;	
		// Decrease attack timer
		attack_cooldown--;
		
		// Reset attack state once the sequence is finished
		if (attack_cooldown == 0) {
			_reset_attack();
		}
        return;
   }
		
	
    // Longer cooldown before the next action
    attack_cooldown = 90;
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;

    // Create a homing bullet that tracks the player for a short duration
    var b = instance_create_layer(x, y, "Instances", obj_bullet_homing);
    b.follow_time = 45; // Follows the player for 0.75 seconds
}

// Handles a triple ricochet bullet attack
function attack_triple_ricochet() {
   // Handles generic attack timing and early exit
   if (attack_cooldown > 0) {
		// Stop movement while attacking
		speed = 0;	
		// Decrease attack timer
		attack_cooldown--;
		
		// Reset attack state once the sequence is finished
		if (attack_cooldown == 0) {
			_reset_attack();
		}
        return;
   }
	
    // Fast firing attack
    attack_cooldown = 12;
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;

    // Vertical displacement for each bullet
    var angles = [-5, 0, 5];

    for (var i = 0; i < 3; i++) {
        var b = instance_create_layer(x, y + (angles[i]), "Instances", obj_bullet_ricochet);
        
        // Aim each bullet towards the player
        b.direction = point_direction(x, y, obj_player.x, obj_player.y);
        
        // Number of allowed ricochets
        b.bounces = 4;
		
		// Store vertical offset for bounce behavior
		b.displacement = angles[i];
    }
}

// Handles the special octopus attack sequence
function octopus_attack() {
	// If already attacking, wait until the octopus instance is gone
	if (is_attacking == true) {
		if (!instance_exists(obj_octopus)) {
			// Reset attack once the octopus entity is destroyed
			_reset_attack();
		}
		return;
	}
	
	// Switch sprite and stop movement during the special attack
	sprite_index = spr_psicotopus_headless;
	image_index = 0;	
	speed = 0;
	
	// Make the enemy temporarily invincible during the attack
	is_invencible = true;
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
	
	// Spawn the octopus attack object
	var oct = instance_create_layer(x, y, "Instances", obj_octopus);
}

//
function flood_arena_attack() {
	
	if (attack_cooldown > 0) {
		// Stop movement while attacking
		speed = 0;	
		// Decrease attack timer
		attack_cooldown--;
		
		// Reset attack state once the sequence is finished
		if (attack_cooldown == 0) {
			_reset_attack();
			instance_destroy(obj_water);
		}
        return;
   }
	
	

      
   attack_cooldown = 90;
   is_attacking = true;
   currentState = EnemyState.SPECIAL_ATTACK;
   
   var _flood = instance_create_layer(0, 0, "Instances", obj_water);
   _flood.width = room_width;
   _flood.height = room_height - obj_player.y;
   _flood.image_xscale = _flood.width;
   _flood.image_yscale = _flood.height;
   _flood.x = 0
   _flood.y = obj_player.y;
}

// Selects a new attack state after the waiting period
function choose_next_attack() {
	
	// Wait until the cooldown for changing attacks is finished
	if (change_attack_cooldown > 0) {
		change_attack_cooldown--;
		return;
	}
	
	var next_state = currentAttackState;

	// Ensure the same attack is not selected twice in a row
	while (next_state == currentAttackState) {
	    next_state = irandom(countAttackStates);
	}

	// Apply the newly chosen attack state
	currentAttackState = next_state;

	// Set a random delay before the next attack sequence
	change_attack_cooldown = irandom_range(
		range_time_between_attacks[0],
		range_time_between_attacks[1]
	);
	
	// Reset attack timer
	attack_cooldown = 0;
}

// Restores default enemy behavior after finishing an attack
function _reset_attack() {
	currentAttackState = AttackState.WAITING;
	currentState = EnemyState.CHASING;
	speed = movementSpeed;
	sprite_index = spr_psicotopus;
	is_invencible = false;
	is_attacking = false;
}
