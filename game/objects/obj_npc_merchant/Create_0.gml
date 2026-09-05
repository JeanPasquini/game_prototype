range_interaction = 75;
talking = false;
started_dialogue = false;
spawn_perk_after_dialogue = false;

// persistencia da run: se ja comprou nesta run, o mercador nao vende de novo
has_talked = variable_global_exists("run_pos") && run_state_get(global.run_pos).merchant_used;
