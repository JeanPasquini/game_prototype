if (instance_exists(parent_altar))
{

}
else
{
    instance_destroy(); 
}

if (!instance_exists(obj_player)) exit;

var player = obj_player;
var dist = point_distance(x, y, player.x, player.y);

if (dist < range && keyboard_check_pressed(ord("E")))
{
    var _new_perk = name;

    if (player.perk_activatable != noone)
    {
        var altar_x = x;
        var altar_y = y;

        if (instance_exists(parent_altar))
        {
            altar_x = parent_altar.x;
            altar_y = parent_altar.y;
        }

        scr_create_single_perk_altar(
            obj_player.perk_activatable_obj,
            altar_x,
            altar_y
        );
    }

	if (instance_exists(player.perk_activatable_active)) {
		instance_destroy(player.perk_activatable_active);
	}
	
    player.perk_activatable = _new_perk;
	player.perk_activatable_obj = perk_object;
	player.perk_activatable_active = perk_active;
	player.energy = 0;
	player.energy_max = energy;
	
	on_select_perk_altar();

    audio_play_sound(sde_player_get_perk, 1, false);

    if (!instance_exists(obj_effect_perk))
        instance_create_layer(player.x, player.y, "Instances", obj_effect_perk);

    var _gid = altar_group_id;

    with (obj_perk_parent)
        if (altar_group_id == _gid) instance_destroy();

    with (obj_perk_altar)
        if (altar_group_id == _gid) instance_destroy();

    with (obj_perk_effect_spawn)
        if (altar_group_id == _gid) instance_destroy();
}