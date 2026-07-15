// Inherit and execute the parent Step event logic
// Inherit and execute the parent Step event logic
event_inherited();

// If the enemy is idle, skip all attack processing
if (currentState == EnemyState.APRESENTATION) {
	
    var _speed = 20;
    var _local_x = 800;
    var _target_y = 338;
    
    if (!has_reached_top) {
		obj_effect_unicle.scr_fx_psicotopus_flying(x, y);
        x += lengthdir_x(_speed, point_direction(x, y, _local_x, -32));
        y += lengthdir_y(_speed, point_direction(x, y, _local_x, -32));
        if (point_distance(x, y, _local_x, -32) < _speed) {
            x = 960;
            y = -32;
            has_reached_top = true;
			alarm[6] = 60;
			
        }
    } else if (!has_landed && alarm[6] <= 0) {
        y += _speed;
        if (y >= _target_y) {
            y = _target_y;
            has_landed = true;
        }
    }
	
	if(sprite_index == spr_psicotopus_apresentation_falling && scr_is_last_sprite()){

	}
	
	if(obj_menu_boss_introduction.alarm[0] <= 0){
		obj_cam.point_y = 230;
		currentState = EnemyState.CHASING;	
		has_landed = false;
		has_reached_top = false;
	}
    return;
}

if currentState == EnemyState.IDLE return;

// Execute logic based on the currently selected attack state
switch (currentAttackState) {

    case AttackState.TRIPLE_VERTICAL:
        // Executes the vertical triple-shot attack pattern
        attack_triple_vertical();
		break;

    //case AttackState.HOMING_SINGLE:
    //    // Executes a single homing projectile attack
    //    attack_homing_single();
	//	break;

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
	if(sprite_index != spr_psicotopus_triple_vertical_end){
		_start_attack();
		time_milesecond = 120; // se essa também precisar ser lida em outro lugar, tire o "var" também
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
   //// Handles generic attack timing and early exit
   //if (attack_cooldown > 0) {
	//	// Stop movement while attacking
	//	speed = 0;	
	//	// Decrease attack timer
	//	attack_cooldown--;
		
	//	// Reset attack state once the sequence is finished
	//	if (attack_cooldown == 0) {
	//		_reset_attack();
	//	}
   //     return;
   //}
	
   // // Fast firing attack
   // attack_cooldown = 12;
   if(sprite_index != spr_psicotopus_triple_ricochet_end){
		_start_attack();
		speed = 0;
	
		if (!instance_exists(obj_psicotopus_ship)) {
			var _ship = noone;
		
			if (irandom(1) == 0) {
				_ship = instance_create_layer(1516, 256, "enemy", obj_psicotopus_ship);
				_ship.orientation = -1;
			} else {
				_ship = instance_create_layer(244, 256, "enemy", obj_psicotopus_ship);
				_ship.orientation = 1;
			}
		}
		else {
			// Busca a instância que já existe na sala
			var _existing_ship = instance_find(obj_psicotopus_ship, 0);
		
			if (_existing_ship != noone && _existing_ship.has_arrived_finishing) {
				instance_destroy(_existing_ship.id);
			}
		}
   }

   // // Vertical displacement for each bullet
   // var angles = [-5, 0, 5];

   // for (var i = 0; i < 3; i++) {
   //     var b = instance_create_layer(x, y + (angles[i]), "Instances", obj_bullet_ricochet);
        
   //     // Aim each bullet towards the player
   //     b.direction = point_direction(x, y, obj_player.x, obj_player.y);
        
   //     // Number of allowed ricochets
   //     b.bounces = 4;
		
	//	// Store vertical offset for bounce behavior
	//	b.displacement = angles[i];
   // }
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
	var oct = instance_create_layer(x, y, "enemy", obj_octopus);
	
}

//
function flood_arena_attack() {
	if (is_attacking == true) {
		// Centers the object in the room
		scr_center_psicotopus_in_room(2);
		// Decrease attack timer
		attack_cooldown--;		
		// Reset attack state once the sequence is finished
				
		//var centerX = 880;
		//var centerY = room_height/2;
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
   
   obj_water.state = waterState.ATTACK;

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
	attack_mount = 0;
}

function _start_attack() {
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
	is_invencible = true;
}