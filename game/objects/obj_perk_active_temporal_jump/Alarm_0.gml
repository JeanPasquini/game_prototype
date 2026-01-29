var len = array_length(enemies_marked);

if (len > 0)
{
	obj_player.invencible = true;
    var last_index = len - 1;
    var enemy = enemies_marked[last_index].target;

    if (instance_exists(enemy))
    {
		fx_active = true;
		fx_x = obj_player.x;
		fx_y = obj_player.y;
		fx_dir = point_direction(obj_player.x, obj_player.y, enemy.x, enemy.y);
		fx_frame = 0;
	
        obj_player.x = enemy.x;
        obj_player.y = enemy.y;
		
		obj_combo_streak.scr_combo_streak();
	
		var dmg = instance_create_layer(enemy.x, enemy.y, "Instances", obj_damage_text);
		dmg.text = "- " + string(damage);
		dmg.color = c_white;
		
		enemy.life -= obj_player.damage;
    }

    array_delete(enemies_marked, last_index, 1);
	alarm[0] = 15;
	
	
}
else{
	fx_active = false;
	alarm[0] = 0;	
	obj_player.alarm[0] = 120;
}
