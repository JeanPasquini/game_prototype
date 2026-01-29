event_inherited();

function on_selected()
{
	array_push(obj_player.perks_obtained_run, spr_icon);
    var perk = instance_create_layer(0, 0, "perk_in_run", obj_perk_passive_rage);
}
