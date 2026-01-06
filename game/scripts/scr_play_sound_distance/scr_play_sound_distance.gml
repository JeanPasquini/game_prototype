function scr_play_sound_distance(_sound, _x, _y, _max_dist, _base_vol)
{
    if (!instance_exists(obj_cam)) return -1;

    // posição do listener (câmera)
    var lx = obj_cam.audio_lx;
    var ly = obj_cam.audio_ly;

    // distância
    var dist = point_distance(_x, _y, lx, ly);
    if (dist >= _max_dist) return -1;

    // volume com falloff
    var vol = (1 - (dist / _max_dist)) * _base_vol;
    vol = clamp(vol, 0, 1);

    // toca o som
    var snd = audio_play_sound(_sound, 1, false);

    // ajusta volume
    audio_sound_gain(snd, vol, 0);

    return snd;
}
