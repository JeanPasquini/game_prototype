range_interaction = 75;
talking = false;
started_dialogue = false;
spawn_perk_after_dialogue = false;

price = 2;                  // custo em cristais (obj_player.money)
warning_instance = noone;   // aviso atual (sem cristais / limite de perks)

// persistencia da run: se ja comprou nesta run, o mercador nao vende de novo
has_talked = variable_global_exists("run_pos") && run_state_get(global.run_pos).merchant_used;

/// Mostra um aviso acima do player (mesmo padrão do baú sem chave).
/// Troca o aviso anterior em vez de empilhar se o jogador apertar várias vezes.
merchant_warning = function(_msg) {
	if (instance_exists(warning_instance)) instance_destroy(warning_instance);
	warning_instance = instance_create_layer(obj_player.x, obj_player.y, "controls", obj_warning);
	warning_instance.alarm[0] = 200;
	warning_instance.message_warning = _msg;
};
