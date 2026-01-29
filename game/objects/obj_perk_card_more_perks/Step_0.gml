event_inherited();

function on_selected()
{
	array_push(obj_player.perks_obtained_run, spr_icon);
    obj_player.perks_limit_run += 3;
}
