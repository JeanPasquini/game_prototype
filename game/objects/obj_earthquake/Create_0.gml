active = false;
timer = 0;              // em frames
buffer_time_ms = 50;    // tempo extra em ms
force = 0;
sound_instance = -1;

fading = false;
fade_gain = 1;
fade_duration_frames = 36; // ~600ms a 60fps (recalculado dinamicamente logo abaixo)
fade_step = 0;

x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;
emitterAudio = audio_emitter_create();
audio_emitter_position(emitterAudio, x, y, 0);
audio_falloff_set_model(audio_falloff_linear_distance);
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);

start_earthquake = function(_force, _time_ms) {
    obj_effect_earthquake_dirt.active = true;
    obj_effect_earthquake_stone.active = true;
    scr_camera_shake(_force, _time_ms);

    var _total_ms = _time_ms + buffer_time_ms;
    timer += _total_ms;

    force = _force;
    active = true;

    // cancela fade out em andamento, se tiver
    fading = false;
    fade_gain = 1;

    // só cria o som se ainda não existir ou não estiver tocando
    if (sound_instance == -1 || !audio_is_playing(sound_instance)) {
        sound_instance = audio_play_sound_on(emitterAudio, sde_enemy_psicotopus_ship_movement, true, 10);
    }

    // agora sim, o sound_instance já existe de verdade
    audio_sound_gain(sound_instance, 1, 0);
}