                                                   /*
	Creation code da sala room_challenge_01.

	Para transformar esta sala numa ANOMALIA, defina as globais abaixo antes de
	chamar scr_room_init(). Deixe anomaly_enabled = false para uma sala normal.
	Titulo/descricao ficam aqui para facilitar a escrita e a traducao depois.
*/

global.room_anomaly_enabled = true;
global.room_anomaly_id      = "3";
global.room_anomaly_title   = "No limits 01";
global.room_anomaly_desc    = "";

global.room_wrap_enabled = true;    // wrap de tela: quem sai por uma borda volta pela oposta

scr_room_init();
