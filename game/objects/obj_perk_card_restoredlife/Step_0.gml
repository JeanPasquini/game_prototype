event_inherited();

function on_selected()
{
	array_push(obj_player.perks_obtained_run, spr_icon);
    obj_player.life = obj_player.life_max;
}
