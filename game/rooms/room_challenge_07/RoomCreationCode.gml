/*
	Creation code da sala room_challenge_01.

	Para transformar esta sala numa ANOMALIA, defina as globais abaixo antes de
	chamar scr_room_init(). Deixe anomaly_enabled = false para uma sala normal.
	Titulo/descricao ficam aqui para facilitar a escrita e a traducao depois.
*/

global.room_ambient_fx_enabled = true;   // atmosfera de partículas (obj_ambient_fx)
global.room_lighting_enabled   = true;   // iluminação: escuridão + luzes (obj_controla_luz)
global.room_anomaly_enabled = true;
global.room_anomaly_id      = "3";
global.room_anomaly_title   = "Traps 02";
global.room_anomaly_desc    = "Watch around!!!";

global.room_wrap_enabled = false;   // wrap de tela (quem sai por uma borda volta pela oposta)

// Camera fixa: a sala inteira (interior 96..672 x 96..384) cabe na view 640x360,
// entao a camera fica parada no centro enquanto nada com prioridade acontece
// (cinematica de porta, trava de dano, intro de boss...). Ver scr_room_init.
global.room_camera_fixed = true;
global.room_camera_x     = 384;
global.room_camera_y     = 240;
global.room_camera_zoom  = 1;

scr_room_init();
