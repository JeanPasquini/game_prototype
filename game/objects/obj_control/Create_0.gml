window_set_fullscreen(true);
gpu_set_texfilter(false);

audio_current = noone; 
audio_target  = noone;
needs_music_update = true;
in_run = false;

//controls

time_run = 0;
enemy_killed = 0;
damage_taken = 0;
damage_caused = 0;
perk_adquired = 0; 

randomize();
global.hitstop = 0;
global.force_music = noone;
global.menu_lock = noone;
global.world_was_blocked = false;

// dispositivo dos icones de prompt (teclado/controle) - ver scr_input_prompts
global.prompt_device = PROMPT_DEVICE_KEYBOARD;

layer_set_visible(layer_get_id("ui_vignette"), true);
layer_set_visible(layer_get_id("ui_hud_player"), true);
layer_set_visible(layer_get_id("ui_run_finish"), false);
layer_set_visible(layer_get_id("ui_pause_layer"), false);

// atmosfera de caverna (partículas): persistente, cria só uma vez
if (!instance_exists(obj_ambient_fx)) instance_create_depth(0, 0, 0, obj_ambient_fx);
