healed = function(damage){
	
	var total_healed = damage * (10/100)
	
	if(obj_player.life + total_healed <= obj_player.life_max){
		var heal = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_damage_text);
			heal.text = "+ " + string(total_healed);
			heal.color = c_green;
		
		obj_player.life += total_healed;
	}
	else{
		total_healed = obj_player.life_max - obj_player.life;
		var heal = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_damage_text);
			heal.text = "+ " + string(total_healed);
			heal.color = c_green;
			
		obj_player.life += total_healed;
	}
}