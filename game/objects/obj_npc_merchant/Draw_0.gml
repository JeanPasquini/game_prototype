draw_self(); 

var dist = point_distance(x, y, obj_player.x, obj_player.y);

if (dist < range_interaction && obj_player.state != PlayerState.TALKING) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_text(obj_player.x, obj_player.y - 40, "Press 'E'");
}