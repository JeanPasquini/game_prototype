combo_streak = 0;
pulse_scale = 0;     
pulse_decay = 0.15;  
tilt_angle  = 10;    

// function with the objective to count the combo streak and hits about passive perks
// obj_combo_streak.scr_combo_streak
//

scr_combo_streak = function(){
	obj_combo_streak.combo_streak++;
	obj_combo_streak.alarm[0] = 200;
	obj_combo_streak.pulse_scale = 0.35;
	
	if(instance_exists(obj_perk_passive_energy_shield)) obj_perk_passive_energy_shield.count_hits++;
}