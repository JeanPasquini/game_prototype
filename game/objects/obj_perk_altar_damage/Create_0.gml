event_inherited();
name = spr_perk_damage;
perk_active = noone;
prompt_text = "Damage Perk";
prompt_text_description = "Damage +2";
energy = 10;

//Perk Second Variables
damage = 2;

//Perk function

function on_select_perk_altar(){
	obj_player.damage_base += damage;
}
