// Inherit the parent event
event_inherited();

currentState = EnemyState.CHASING;

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
	
	case AttackState.WAITING:
		choose_next_attack();

}


function attack_triple_vertical() {

    if (attack_cooldown > 0) {
		speed = 0;	
		
		if (attack_cooldown % 30 == 0) {
			
			var inst = instance_create_layer(x, y, "Instances", obj_bullet_vertical);
			inst.target_x = obj_player.x;
			inst.target_y = obj_player.y;
		}
		
		attack_cooldown--;
		
		if (attack_cooldown == 0) {
			currentAttackState = AttackState.WAITING;
			speed = movementSpeed;
		}
		
        return;
    }
	
    attack_cooldown = 90; // 3 tiros no intervalo
}

function attack_homing_single() {

   if (attack_cooldown > 0) {
        attack_cooldown--;
		speed = 0;
		
		if (attack_cooldown == 0) {
			currentAttackState = AttackState.WAITING;
			speed = movementSpeed;
		}
		
		return;
    }
	
    attack_cooldown = 90; // demora mais para atacar

    var b = instance_create_layer(x, y, "Instances", obj_bullet_homing);
    b.follow_time = 45; // 0.75s seguindo o player
}

function attack_triple_ricochet() {

    if (attack_cooldown > 0) {
        attack_cooldown--;
		speed = 0;
        return;
    }
	
	speed = movementSpeed

    attack_cooldown = 12; // dispara rápido

    var angles = [-20, 20, -20]; // alternância

    for (var i = 0; i < 3; i++) {
        var b = instance_create_layer(x, y, "Instances", obj_bullet_ricochet);
        b.direction = point_direction(x, y, obj_player.x, obj_player.y) + angles[i];
        b.bounces = 4; // número de ricochetes
    }
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

