event_inherited();
name = spr_perk_altar_black_hole;
perk_active = obj_perk_active_black_hole;
prompt_text = "Black Hole";
prompt_text_description = "Summons a devastating black hole that drags nearby enemies into its crushing core.";
energy = 20;

//Perk Second Variables

//Perk function

function on_select_perk_altar(){
	var perk = instance_create_layer(0, 0, "perk_in_run", obj_perk_active_black_hole);
}