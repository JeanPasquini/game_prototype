if (!has_talked && instance_exists(obj_player))
{
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    // ===== INTERAGIR =====
    if (dist < range_interaction
    && input_interact_pressed()
    && player.state != PlayerState.TALKING
    && !scr_menu_lock_blocks_world())
    {
        // Só trava o player (TALKING) quando a compra realmente acontece: o
        // obj_perk_selection é quem libera o player ao fechar. Sem cristais ou
        // sem espaço de perk, apenas mostra um aviso e o player segue livre.
        if (player.money < price)
        {
            merchant_warning("Not enough crystals!");
        }
        else if (array_length(player.perks_obtained_run) >= player.perks_limit_run)
        {
            merchant_warning("Perk limit reached!");
        }
        else
        {
            player.state = PlayerState.TALKING;
            player.talking = true;

            player.money -= price;
            instance_create_layer(x, y, "controls", obj_perk_selection);
            has_talked = true;
            if (variable_global_exists("run_pos")) run_state_get(global.run_pos).merchant_used = true;
        }
    }
}
