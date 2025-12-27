// Inherit the parent event
event_inherited();

if currentState == EnemyState.IDLE return;

switch (currentAttackState) {

    case AttackState.TRIPLE_VERTICAL:
        attack_triple_vertical();
		break;
    case AttackState.HOMING_SINGLE:
        attack_homing_single();
		break;
    case AttackState.TRIPLE_RICOCHET:
        attack_triple_ricochet();
		break;
	case AttackState.OCTOPUS_ATTACK:
		octopus_attack();
		break;
	case AttackState.WAITING:
		choose_next_attack();
		break;
}


function attack_triple_vertical() {
    if (attack_cooldown > 0) {
		speed = 0;	
		if (attack_cooldown % 30 == 0) {
			var inst = instance_create_layer(x, y, "Instances", obj_bullet_vertical);
		}
		attack_cooldown--;
		if (attack_cooldown == 0) {
			_reset_attack();
		}
        return;
    }
	
    attack_cooldown = 90; // 3 tiros no intervalo
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
}

function attack_homing_single() {
   if(_attack_time()) return;
	
    attack_cooldown = 90; // demora mais para atacar
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;

    var b = instance_create_layer(x, y, "Instances", obj_bullet_homing);
    b.follow_time = 45; // 0.75s seguindo o player
}

function attack_triple_ricochet() {
   if(_attack_time()) return;
	
    attack_cooldown = 12; // dispara rápido
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;

    var angles = [-5, 0, 5]; // deslocamento entre cada bala

    for (var i = 0; i < 3; i++) {
        var b = instance_create_layer(x, y + (angles[i]), "Instances", obj_bullet_ricochet);
        b.direction = point_direction(x, y, obj_player.x, obj_player.y);
        b.bounces = 4; // número de ricochetes
		b.displacement = angles[i];
    }
}

function octopus_attack() {
	if(is_attacking == true) {
		if (!instance_exists(obj_octopus)) {
			_reset_attack();
		}
		return;
	}
	
	sprite_index = spr_psicotopus_headless;
	image_index = 0;	
	speed = 0;
	is_invencible = true;
	is_attacking = true;
	currentState = EnemyState.SPECIAL_ATTACK;
	var oct = instance_create_layer(x, y, "Instances", obj_octopus);
}

function choose_next_attack() {
	
	if (change_attack_cooldown > 0) {
		change_attack_cooldown--;
		return;
	}
	
	var next_state = currentAttackState;

	// não repetir o mesmo ataque
	while (next_state == currentAttackState) {
	    next_state = irandom(countAttackStates);
	}

	currentAttackState = next_state;

	change_attack_cooldown = irandom_range(range_time_between_attacks[0], range_time_between_attacks[1])
	attack_cooldown = 0;
}

function _attack_time() {
	if (attack_cooldown > 0) {
        attack_cooldown--;
		speed = 0;
		if (attack_cooldown == 0) {
			_reset_attack()
		}
		return true;
    }
	return false;
}

function _reset_attack() {
	currentAttackState = AttackState.WAITING;
	currentState = EnemyState.CHASING;
	speed = movementSpeed;
	sprite_index = spr_psicotopus;
	is_invencible = false;
	is_attacking = false;
}