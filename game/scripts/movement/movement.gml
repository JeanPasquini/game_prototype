function movement() {
    // === MOVEMENT ===
    if (tap_timer_left > 0) tap_timer_left--;
    if (tap_timer_right > 0) tap_timer_right--;

    vsp += grv;
    hsp = 0;

	if(state != PlayerState.DOWNED){
	    if (state != PlayerState.LIGHT_ATTACK && state != PlayerState.HEAVY_ATTACK && state != PlayerState.WAIT_ATTACK) {

	        if (keyboard_check_pressed(vk_right)) {
	            if (tap_timer_right > 0) run = true;
	            else { tap_timer_right = double_tap_threshold; run = false; }
	        }

	        if (keyboard_check_pressed(vk_left)) {
	            if (tap_timer_left > 0) run = true;
	            else { tap_timer_left = double_tap_threshold; run = false; }
	        }

	        var current_spd = run ? spd * 2 : spd;

	        if (keyboard_check(vk_right)) { hsp =  current_spd; face = 1; }
	        if (keyboard_check(vk_left))  { hsp = -current_spd; face = -1; }

	        if (!keyboard_check(vk_right) && !keyboard_check(vk_left)) run = false;

	        if (keyboard_check_pressed(vk_up) && ong) {
	            vsp = jmp;
	        }

	        if (!keyboard_check(vk_up) && vsp < 0) {
	            vsp *= 0.5;   
	        }
	    }
	}

    // --- horizontal movement ---
    if (place_meeting(x + hsp, y, obj_wall)){
        while (!place_meeting(x + sign(hsp), y, obj_wall)){
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // --- vertical movement ---
    ong = false;
    if (place_meeting(x, y + vsp, obj_wall)) {
        while (!place_meeting(x, y + sign(vsp), obj_wall)) {
            y += sign(vsp);
        }
        if (vsp > 0) ong = true;
        vsp = 0;
    }
	
	if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {
    var nx = x + knockback_x * 0.5;
	var ny = y + knockback_y * 0.5;

    if (!place_meeting(nx, ny, obj_wall)){
        x = nx;
        y = ny;
    }

    knockback_x *= 0.95;
    knockback_y *= 0.95;
	} else {
	    knockback_x = 0;
	    knockback_y = 0;
	}

    y += vsp;
    image_xscale = face;
}
