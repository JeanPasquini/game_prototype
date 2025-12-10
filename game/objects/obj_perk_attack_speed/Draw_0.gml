event_inherited();

draw_self();

var range = 30;

if (instance_exists(obj_player)) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (dist < range) {
        var prompt_text = "Attack Speed +" + string(attack_speed);
        var xx = x;
        var yy = y - 40;

        var w = string_width(prompt_text) + 10;
        var h = 20;

        draw_set_alpha(0.6);
        draw_set_color(c_black);
        draw_rectangle(xx - w/2, yy - h, xx + w/2, yy, false);

        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_text(xx - string_width(prompt_text)/2, yy - h + 2, prompt_text);
    }
}
