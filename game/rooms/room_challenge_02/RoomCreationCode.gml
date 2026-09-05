/*
	Creation code da sala room_challenge_01.

	Para transformar esta sala numa ANOMALIA, defina as globais abaixo antes de
	chamar scr_room_init(). Deixe anomaly_enabled = false para uma sala normal.
	Titulo/descricao ficam aqui para facilitar a escrita e a traducao depois.
*/

global.room_anomaly_enabled = true;
global.room_anomaly_id      = "1";
global.room_anomaly_title   = "Traps 01";
global.room_anomaly_desc    = "Watch your step!!!";

global.room_wrap_enabled = false;   // wrap de tela (quem sai por uma borda volta pela oposta)

scr_room_init();
