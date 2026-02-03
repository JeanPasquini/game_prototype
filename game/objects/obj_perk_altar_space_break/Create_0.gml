event_inherited();
name = spr_perk_altar_space_break;
perk_active = obj_perk_active_space_break;
prompt_text = "Space Break";
prompt_text_description = "Creates shards of fractured spacetime that scatter in all directions, ricocheting off walls.";
energy = 20;

//Perk Second Variables

//Perk function

function on_select_perk_altar(){
	var perk = instance_create_layer(0, 0, "perk_in_run", obj_perk_active_space_break);
}