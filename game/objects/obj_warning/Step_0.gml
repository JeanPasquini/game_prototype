if (alarm[0] < 0){

	alpha_warning -= fade_speed;
	alpha_warning = max(alpha_warning, 0);

	if (alpha_warning <= 0) {
	    instance_destroy();
	}
}
