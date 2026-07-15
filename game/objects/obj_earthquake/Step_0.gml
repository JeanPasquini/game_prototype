var _cam = view_camera[0];
x = camera_get_view_x(_cam) + camera_get_view_width(_cam) / 2;
y = camera_get_view_y(_cam) + camera_get_view_height(_cam) / 2;
audio_emitter_position(emitterAudio, x, y, 0);

if (active) {
    timer -= 1;

    if (timer <= 0) {
        active = false;
        timer = 0;
        fading = true;
        fade_gain = 1;
        fade_duration_frames = max(1, round((600 / 1000) * room_speed)); // 600ms convertido em frames
        fade_step = 1 / fade_duration_frames;
    }
}

if (fading) {
    fade_gain = max(0, fade_gain - fade_step);
    audio_sound_gain(sound_instance, fade_gain, 0); // seta o gain manualmente, frame a frame -> suave garantido

    if (fade_gain <= 0) {
        audio_stop_sound(sound_instance);
        fading = false;
        fade_gain = 1;
    }
}