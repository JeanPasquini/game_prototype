draw_self();
var frame = floor(image_index);
if(frame == 4 && sprite_index == spr_octopus_octopus_attack_swiming){
	obj_effect_unicle.scr_fx_psicotopus_bubble_floating(x, y, dir -180);
	audio_special_attack_octopus_attack_bubble();
}

if ((currentState == OctopusState.STARTING_ATTACK || currentState == OctopusState.ENDING_ATTACK) && sprite_index != spr_octopus_octopus_attack_preparing){
	image_angle = dir -90;
}
else{
	image_angle = 0;	
}

