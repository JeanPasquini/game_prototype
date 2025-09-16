if (instance_exists(obj_player)){
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < range_interaction && keyboard_check_pressed(ord("E")) && !instance_find(obj_perk_altar, 0) && obj_player.state != PlayerState.TALKING) {
		
		if (!instance_exists(obj_dialogue)) {
            var dlg_instance = instance_create_layer(x, y, "dialogue", obj_dialogue);
			obj_player.state = PlayerState.TALKING;
			if(obj_player.money >= 2)
			{
				obj_player.money = obj_player.money - 2;
				scr_perk_altar(obj_npc_merchant.x + 150, obj_npc_merchant.y + 28);
				dlg_instance.dialogue_lines = scr_load_dialogue(-1, 0, "dialogue_npc_merchant.csv");
			}
            else
		    {
			    dlg_instance.dialogue_lines = scr_load_dialogue(6, 0, "dialogue_npc_merchant.csv");
		    }
        }
    }
}
