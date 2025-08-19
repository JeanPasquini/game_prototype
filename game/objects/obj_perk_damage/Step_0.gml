event_inherited();

var range = 30;

if (instance_exists(obj_player)) {
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < range && keyboard_check_pressed(ord("E"))) {
        obj_player.damage_base += damage;
		layer_destroy_instances("perk");
    }
}
