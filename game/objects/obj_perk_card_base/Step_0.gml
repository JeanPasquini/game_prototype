if (selected)
{
    select_time += 1;
}
else
{
    select_time = 0;
}

// animação de entrada, igual ease do menu de status do obj_player
spawn_anim_t = clamp(spawn_anim_t + (1 / 12), 0, 1);

// animação de saída ao confirmar a seleção de um perk
if (despawning)
{
    despawn_anim_t = clamp(despawn_anim_t - despawn_speed, 0, 1);

    if (despawn_anim_t <= 0)
    {
        instance_destroy();
    }
}

if (confirm_select)
{
    on_selected();
    confirm_select = false;
}

function on_selected()
{

}

function start_despawn()
{
    despawning = true;
}
