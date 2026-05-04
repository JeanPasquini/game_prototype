actived = false;
open = noone;
switch (type) {
    case 1:
        sprite_index = spr_environment_gate_opening;
		open = false;
    break;

    case 2:
        sprite_index = spr_environment_gate_closing;
		open = true;
    break;
}

played_sound = false;

image_speed = 0;

emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance);
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);