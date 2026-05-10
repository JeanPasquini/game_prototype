var range = 30;

if (instance_exists(obj_player))
{
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    // PLAYER ENTROU NO RANGE
    if (dist < range)
    {
        // SE NÃO EXISTE AINDA
        if (!instance_exists(warning_instance))
        {
			warning_instance = instance_create_layer(
			    player.x,
			    player.y,
			    "Instances",
			    obj_warning
			);

			warning_instance.message_warning = plate_message;
			warning_instance.persistent_warning = true;
        }
    }
    else
    {
        // SAIU DO RANGE
        if (instance_exists(warning_instance))
        {
            instance_destroy(warning_instance);
        }
    }
}