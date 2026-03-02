event_inherited();
name = spr_perk_altar_temporal_jump;
perk_active = obj_perk_active_temporal_jump;
prompt_text = "Temporal Jump";
prompt_text_description = "When an enemy is hit by an attack, they are marked for the use of Temporal Leap. After marking one or more enemies, upon activating the perk, the character is instantly teleported between all marked targets, dealing damage to each of them.";
energy = 20;

//Perk Second Variables

//Perk function

function on_select_perk_altar(){
	var perk = instance_create_layer(0, 0, "perk_in_run", obj_perk_active_temporal_jump);
}