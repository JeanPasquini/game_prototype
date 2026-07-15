if (!instance_exists(obj_followed)) {
    if (emitting) {
        emitting = false;
        part_emitter_destroy(_ps, _em); 
        alarm[0] = particle_life_max;  
    }
    exit; 
}

x = obj_followed.x;
y = obj_followed.y;
part_system_position(_ps, x + x_add, y + y_add);

scr_audio_emitter(x, y, emitterAudio);