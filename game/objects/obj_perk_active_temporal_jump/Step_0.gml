function mark_enemy(enemy_id)
{
    if (!instance_exists(enemy_id)) return;

    for (var i = 0; i < array_length(enemies_marked); i++)
    {
        if (enemies_marked[i].target == enemy_id)
            return;
    }

    array_push(enemies_marked, {
        target: enemy_id,
        offset_x: 6,
        offset_y: -4
    });
}

for (var i = array_length(enemies_marked) - 1; i >= 0; i--)
{
    var enemy = enemies_marked[i].target;

    if (!instance_exists(enemy))
    {
        array_delete(enemies_marked, i, 1);
    }
}

if (fx_active)
{
    fx_frame += fx_speed;

    if (fx_frame >= sprite_get_number(fx_sprite))
    {
        fx_active = false;
        fx_frame = 0;
    }
}


