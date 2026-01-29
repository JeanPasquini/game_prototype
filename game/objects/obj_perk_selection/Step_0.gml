if(instance_exists(obj_perk_selection)){
	obj_player.state = PlayerState.TALKING;
	obj_player.talking = true;
}

if (keyboard_check_pressed(vk_left)){  selected_index--; audio_play_sound(sde_perk_selection_change, 1, false);}
if (keyboard_check_pressed(vk_right)){ selected_index++; audio_play_sound(sde_perk_selection_change, 1, false);}

selected_index = clamp(selected_index, 0, array_length(cards) - 1);

// atualiza visual
for (var i = 0; i < array_length(cards); i++)
    cards[i].selected = (i == selected_index);

// confirmar
if (keyboard_check_pressed(ord("E")))
{
	audio_play_sound(sde_perk_selection, 1, false);
	
	if (!instance_exists(obj_effect_perk)) {
		instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_effect_perk);
	}
			
	audio_play_sound(sde_player_get_perk, 1, false);
	
    var card = cards[selected_index];

    if (instance_exists(card))
    {
        card.on_selected(); 
    }

    for (var i = 0; i < array_length(cards); i++)
    {
        if (instance_exists(cards[i]))
            instance_destroy(cards[i]);
    }
	
	obj_player.state = PlayerState.IDLE;
	obj_player.talking = false;

    instance_destroy(); 
}


