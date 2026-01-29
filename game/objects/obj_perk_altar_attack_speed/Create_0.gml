event_inherited();
attack_speed = 0.5;
name = spr_perk_attack_speed;
prompt_text = "Attack Speed Perk";
prompt_text_description = "Attack Speed +" + string(attack_speed);
energy = 10;

//Perk Second Variables


//Perk function

function on_select_perk_altar(){
	if (obj_player.attack_speed + attack_speed >= 2.5)
	    obj_player.attack_speed = 2.5;
	else
	    obj_player.attack_speed += attack_speed;
}