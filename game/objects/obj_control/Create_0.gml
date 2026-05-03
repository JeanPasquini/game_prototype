window_set_fullscreen(false);
gpu_set_texfilter(false);

audio_current = noone;   // guarda o asset, NÃO a voice
audio_target  = noone;
needs_music_update = true;

randomize();
global.hitstop = 0;


layer_set_visible(layer_get_id("ui_vignette"), true);
layer_set_visible(layer_get_id("ui_hud_player"), true);
layer_set_visible(layer_get_id("ui_pause_layer"), false);
