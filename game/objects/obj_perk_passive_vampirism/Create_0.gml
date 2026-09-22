hits_needed = 10;
hit_count = 0;

healed = function(damage){
	
	hit_count++;
	if(hit_count < hits_needed) exit;
	hit_count = 0;
	
	var total_healed = min(1, obj_player.life_max - obj_player.life);
	if(total_healed <= 0) exit;
	
	var heal = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_damage_text);
		heal.text = "+ " + string(total_healed);
		heal.color = c_green;
	
	obj_player.life += total_healed;
}
