/*
	Creation code da sala room_challenge_01.

	Para transformar esta sala numa ANOMALIA, defina as globais abaixo antes de
	chamar scr_room_init(). Deixe anomaly_enabled = false para uma sala normal.
	Titulo/descricao ficam aqui para facilitar a escrita e a traducao depois.
*/

global.room_ambient_fx_enabled = false;  // atmosfera de partículas (obj_ambient_fx): desligada nesta sala
global.room_lighting_enabled   = false;  // iluminação: escuridão + luzes (obj_controla_luz): desligada nesta sala
global.room_anomaly_enabled = true;
global.room_anomaly_id      = "2";
global.room_anomaly_title   = "Blank Room 01";
global.room_anomaly_desc    = "Look the MINIMAP";

global.room_wrap_enabled = false;   // wrap de tela (quem sai por uma borda volta pela oposta)

scr_room_init();
