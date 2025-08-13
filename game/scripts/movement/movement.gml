function movement(){
	// === MOVEMENT ===
	if (tap_timer_left > 0) tap_timer_left--;
	if (tap_timer_right > 0) tap_timer_right--;

	vsp += grv;
	hsp = 0;

	if (keyboard_check_pressed(vk_right)) {
	    if (tap_timer_right > 0) {
	        run = true;
	    } else {
	        tap_timer_right = double_tap_threshold;
	        run = false;
	    }
	}

	if (keyboard_check_pressed(vk_left)) {
	    if (tap_timer_left > 0) {
	        run = true;
	    } else {
	        tap_timer_left = double_tap_threshold;
	        run = false;
	    }
	}

	hsp = 0;
	var current_spd = run ? spd * 2 : spd;

	if (keyboard_check(vk_right)) {
	    hsp = current_spd;
	    face = 1;
	}
	if (keyboard_check(vk_left)) {
	    hsp = -current_spd;
	    face = -1;
	}

	if (!keyboard_check(vk_right) && !keyboard_check(vk_left)) {
	    run = false;
	}

	if (keyboard_check_pressed(vk_up) && ong) {
	    vsp = jmp;
	}

	if (place_meeting(x + hsp, y, obj_wall)) {
	    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
	        x += sign(hsp);
	    }
	    hsp = 0;
	}
	x += hsp;

	ong = false;
	if (place_meeting(x, y + vsp, obj_wall)) {
	    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
	        y += sign(vsp);
	    }
	    if (vsp > 0) ong = true;
	    vsp = 0;
	}
	y += vsp;

	image_xscale = face;


}