enum ShipType {
	STARTING_MOVEMENT,
	FINISHING_MOVEMENT,
	SHOOTING
}

type = ShipType.STARTING_MOVEMENT;

orientation = noone;
image_yscale = 1.5;
movementSpeed = 2;
has_arrived = false;
has_arrived_finishing = false;
shots_fired = 0;
shots_fired_max = 3;

// VISUAL VARIABLES

flag_earthquake = false;

// AUDIO VARIABLES

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);