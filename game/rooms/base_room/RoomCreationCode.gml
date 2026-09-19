/*
	Creation code base, herdado por HUB e demais salas que nao tem creation code
	proprio.

	O antigo global.rooms_map escrito a mao foi substituido pela geracao dinamica
	em scr_generate_run() (chamada por scr_room_init).

	Salas que declaram ANOMALIA (room_challenge_*) tem creation code proprio que
	define global.room_anomaly_* antes de chamar scr_room_init().
*/

// atmosfera de partículas (obj_ambient_fx): ligada por padrão; ponha false no creation code da sala pra desligar
global.room_ambient_fx_enabled = true;
// iluminação (escuridão + luzes): ligada por padrão; ponha false no creation code da sala pra desligar
global.room_lighting_enabled = true;

scr_room_init();
