function scr_audio_emitter(x, y, _emitter){
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_w = camera_get_view_width(view_camera[0]);
	var cam_center = cam_x + cam_w * 0.5;

	var dist = x - cam_center;

	var pan = dist / (cam_w * 0.5);
	pan = clamp(pan, -1, 1);

	var deadzone = 0.6;

	if (abs(pan) < deadzone) {
	    pan = 0;
	} else {
	    pan = sign(pan) * ((abs(pan) - deadzone) / (1 - deadzone));
	}

	var fake_x = cam_center + pan * (cam_w * 0.5);

	audio_emitter_position(_emitter, fake_x, y, 0);
}