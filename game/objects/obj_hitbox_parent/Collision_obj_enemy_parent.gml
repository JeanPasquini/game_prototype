if(!other.downed){
	var dmg = instance_create_layer(x, y, "Instances", obj_damage_text);
	dmg.text = "- " + string(damage);
	dmg.color = c_white;

	var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);

	other.knockback_x = lengthdir_x(knockback, dir);
	other.life -= damage;
	other.stagger = stagger;
	obj_combo_streak.combo_streak++;
	obj_combo_streak.alarm[0] = 200;

    if(downed){
		other.downed = true;
		other.alarm[0] = downed_time;
		
	}
	instance_destroy();
}