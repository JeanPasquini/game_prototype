combo_starter = "";

function combat() {

    //if (combo_timer > 0) {
    //    combo_timer -= 1; 
    //} else {
	//	//state = PlayerState.IDLE;
	//	combo_starter = "";
	//	comboGuide = "";
    //}

    // --- Light attack (Z) ---
    if (keyboard_check_pressed(ord("Z"))) {

        if (combo_stage == 2 && combo_starter == "X"  && !combo_finish) {
            state = PlayerState.LIGHT_ATTACK;
            attack_timer = 10;
            damage = damage_base;
            attack_push = 1;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_4);
            hb.damage = damage;
            hb.direction = face;

			combo_finish = true;
            combo_timer = 30;
			comboGuide += ">Z"

        } else if (combo_stage == 0) {
            state = PlayerState.LIGHT_ATTACK;
            attack_timer = 10;
            damage = damage_base;
            attack_push = 1;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_1);
            hb.damage = damage;
            hb.direction = face;

            combo_stage = 1;
            combo_timer = 60;
			combo_starter = "Z"
			comboGuide += "Z"
        }
		
		else if (combo_stage == 1 && combo_starter == "Z") {
            state = PlayerState.LIGHT_ATTACK;
            attack_timer = 10;
            damage = damage_base;
            attack_push = 1;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_5);
            hb.damage = damage;
            hb.direction = face;

            combo_stage = 2;
            combo_timer = 60;
			comboGuide += ">Z"
        }
		
		alarm[1] = combo_timer;
    }

    // --- Heavy attack (X) ---
    if (keyboard_check_pressed(ord("X"))) {

        if (combo_stage == 0) {
            state = PlayerState.HEAVY_ATTACK;
            attack_timer = 30;
            damage = damage_base * 2;
            attack_push = 2;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_2);
            hb.damage = damage;
            hb.direction = face;

            combo_stage = 1;
            combo_timer = 60;
			combo_starter = "X"
			comboGuide += "X"
        }
        else if (combo_stage == 1 && combo_starter == "X") {
            state = PlayerState.HEAVY_ATTACK;
            attack_timer = 30;
            damage = damage_base * 2;
            attack_push = 2;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_3);
            hb.damage = damage;
            hb.direction = face;

            combo_stage = 2;
            combo_timer = 60;
			comboGuide += ">X"
        }
		else if (combo_stage == 2 && combo_starter == "Z" && !combo_finish) {
            state = PlayerState.HEAVY_ATTACK;
            attack_timer = 25;
            damage = damage_base * 2;
            attack_push = 2;

            var hitbox_x = x + (face * 25);
            var hitbox_y = y - 8;
            var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_6);
            hb.damage = damage;
            hb.direction = face;

			combo_finish = true;
            combo_timer = 30
			comboGuide += ">X"
        }
		
		alarm[1] = combo_timer;
    }
}

function attackSmoothing(){
	if (attack_push > 0) {
	    var dir = (face == 1) ? 0 : 180;

	    var step_size = min(attack_push, 2);
	    var remaining = attack_push;

	    while (remaining > 0) {
	        var move_amt = min(step_size, remaining);
			var blocos = [obj_wall, obj_enemy_parent];

			if (!place_meeting(
			        x + lengthdir_x(move_amt, dir),
			        y + lengthdir_y(move_amt, dir),
			        blocos))
	        {
	            x += lengthdir_x(move_amt, dir);
	            y += lengthdir_y(move_amt, dir);
	        }
	        else break;

	        remaining -= move_amt;
	    }

	    attack_push *= 0.8; 
	    if (attack_push < 0.1) attack_push = 0;
	}	
}
