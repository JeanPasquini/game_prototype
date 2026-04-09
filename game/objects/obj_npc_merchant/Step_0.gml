if (!has_talked)
{
    if (instance_exists(obj_player) && !has_talked)
{
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    // ===== INICIAR DIÁLOGO =====
    if (dist < range_interaction
    && keyboard_check_pressed(ord("E"))
    && !instance_exists(obj_perk_altar)
    && obj_player.state != PlayerState.TALKING
    && !started_dialogue)
    {
        if (!instance_exists(obj_dialogue))
        {
            var dlg_instance = instance_create_layer(x, y, "controls", obj_dialogue);

            obj_player.state = PlayerState.TALKING;
            obj_player.talking = true;

            started_dialogue = true;
            spawn_perk_after_dialogue = false;

            if (obj_player.money >= 2)
            {
                if (array_length(obj_player.perks_obtained_run) < obj_player.perks_limit_run)
                {
                    obj_player.money -= 2;
                    spawn_perk_after_dialogue = true;

                    dlg_instance.dialogue_lines =
                        scr_load_dialogue(-1, 0, "dialogue_npc_merchant.csv");
                }
                else
                {
                    dlg_instance.dialogue_lines =
                        scr_load_dialogue(6, 0, "dialogue_npc_merchant.csv");
                }
            }
            else
            {
                dlg_instance.dialogue_lines =
                    scr_load_dialogue(6, 0, "dialogue_npc_merchant.csv");
            }
        }
    }

    // ===== DIÁLOGO TERMINOU =====
    if (started_dialogue && !instance_exists(obj_dialogue))
    {
        started_dialogue = false;

        if (spawn_perk_after_dialogue)
        {
            spawn_perk_after_dialogue = false;
            instance_create_layer(x, y, "controls", obj_perk_selection);
        }

        obj_player.state = PlayerState.IDLE;
        obj_player.talking = false;

        // 🔥 DESATIVA O NPC PRA SEMPRE
        has_talked = true;
    }
}

}


