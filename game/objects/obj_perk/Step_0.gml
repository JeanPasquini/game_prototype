if (!created && instance_exists(obj_wave_manager) && obj_wave_manager.state == WaveState.COMPLETE)
{
    created = true;
    if (array_length(obj_player.perks_obtained_run) < obj_player.perks_limit_run)
    {
        instance_create_layer(x, y, "controls", obj_perk_selection);
    }
}
