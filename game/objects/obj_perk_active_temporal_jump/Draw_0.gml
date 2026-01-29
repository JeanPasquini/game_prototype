for (var i = array_length(enemies_marked) - 1; i >= 0; i--)
{
    var enemy = enemies_marked[i].target;

    if (!instance_exists(enemy))
    {
        array_delete(enemies_marked, i, 1);
        continue;
    }

    var draw_x = enemy.x + enemies_marked[i].offset_x;
    var draw_y = enemy.y + enemies_marked[i].offset_y;

    draw_sprite(spr_perk_active_temporal_jump, 0, draw_x, draw_y);
}

if (fx_active)
{
    var num_copies = 5;

    for (var i = 0; i < num_copies; i++)
    {
        var rotation = random(360);

        draw_sprite_ext(
            fx_sprite,
            floor(fx_frame),
            fx_x,
            fx_y,
            1, 1,
            rotation,
            c_white,
            1
        );
    }
}
