// Inherit and execute the parent Step event logic
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

    //case AttackState.TRIPLE_RICOCHET:
    //    // Executes a triple ricochet projectile attack
    //    attack_triple_ricochet();
	//	break;

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
	_start_attack();
	var fire_count_max = 3;
	var time_milesecond = 120;
	speed = 0;	
	
	function spawn_bullet_offset(_x, _y) {
		var dir = (image_xscale < 0) ? -1 : 1;
	    instance_create_layer(_x, _y, "Instances", obj_psicotopus_sword);
	}
	
	
	
	if (sprite_index == spr_psicotopus_triple_vertical_mid){
		if(alarm[5] <= 0 && attack_mount + 1 <= fire_count_max){
			attack_mount++;
			spawn_bullet_offset(880, + 378);
			alarm[5] = time_milesecond;
		}
	}

    if (attack_mount == fire_count_max && alarm[5] <= 0) {
		attack_mount = 0;
        scr_set_sprite_once(spr_psicotopus_triple_vertical_end, "flag_triple_vertical_end_sprite");
    }
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
	_start_attack();

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
	_start_attack();

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
		} else if (is_destroyed) {
			var oct = instance_find(obj_octopus, 0);
			if instance_exists(oct) oct.is_destroyed = true;
			_reset_attack();
		}
		return;
	}
	
	// Switch sprite and stop movement during the special attack
	sprite_index = spr_psicotopus_headless;
	image_index = 0;	
	speed = 0;
	
	_start_attack();
	
	// Spawn the octopus attack object
	var oct = instance_create_layer(x, y, "Instances", obj_octopus);
	
}

//
function flood_arena_attack() {
	
	if (is_attacking == true) {
		// Centers the object in the room
		scr_center_psicotopus_in_room(movementSpeed*1.2);
		// Decrease attack timer
		attack_cooldown--;		
		// Reset attack state once the sequence is finished
				
		var centerX = 880;
		var centerY = room_height/2;
	    //var is_tent_empty = tentacles == -1 || ( ds_exists(tentacles, ds_type_list) && ds_list_empty(tentacles) );
		
		//if (x == centerX && y == centerY && is_tent_empty) {
		//	var _tent1 = instance_create_layer(centerX - sprite_get_width(spr_tentacles)/2, centerY, "Instances", obj_psicotopus_tentacles);		
		//	var _tent2 = instance_create_layer(centerX + sprite_get_width(spr_tentacles)/2, centerY, "Instances", obj_psicotopus_tentacles);	
		//	_tent1.type = TentacleType.STATIC;
		//	_tent2.type = TentacleType.STATIC;
	
		//	var _height = sprite_get_height(spr_tentacles);	
		//	while (!position_meeting(_tent1.x, _tent1.y + _height, obj_wall)) {
		//		_height++;
		//	}
	
		//	var _sprite_height = sprite_get_height(spr_tentacles);
		//	var scale_y = _height / _sprite_height; 
			
		//	_tent1.scale_target = scale_y;
		//	_tent2.scale_target = scale_y;
	
		//	ds_list_add(tentacles, _tent1);
		//	ds_list_add(tentacles, _tent2);
		//}
		
		// Resets the Attack
		if (!instance_exists(obj_tentacle_telegraph) || is_destroyed) {
			_reset_attack();
			flag_flood_sprite = false;
			
			var _flood = instance_find(obj_water, 0);
			var _tent_tele = instance_find(obj_tentacle_telegraph, 0);
			if instance_exists(_flood) _flood.is_destroyed = true;
			if instance_exists(_tent_tele) _tent_tele.is_destroyed = true;
			
			if (ds_exists(tentacles, ds_type_list)) {
				scr_destroy_tentacles_ds(tentacles);
			}
		}
        return;
   }
	
   attack_cooldown = 240;
   _start_attack();
   tentacles = ds_list_create();
   
   //// Creates the flood "water" object
   //var _flood = instance_create_layer(0, 0, "Instances", obj_water);
   //_flood.width = room_width;
   //_flood.height = room_height - obj_player.y;
   //_flood.image_xscale = _flood.width;
   //_flood.image_yscale = _flood.height;
   //_flood.x = 0
   //_flood.y = obj_player.y;
   //_flood.depth = -100;
   
   obj_water.state = waterState.ATTACK;
   
   
   // Cria o objeto que controla os ataques com tentáculos
   instance_create_layer(0, 0, "Instances", obj_tentacle_telegraph);
   
   
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
	//currentAttackState = AttackState.OCTOPUS_ATTACK;
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
	sprite_index = spr_psicotopus_idle;
	is_invencible = false;
	is_attacking = false;
}

function _start_attack() {
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
	is_invencible = true;
}