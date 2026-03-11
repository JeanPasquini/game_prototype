var _life = obj_player.life;
var _life_max = obj_player.life_max;

if (life_id > _life_max) {
    sprite_index = -1;
}
else if (_life >= life_id) {

    playing_losinglife = false;
    sprite_index = spr_ui_player_yeslife;

}
else {

    // se ainda não começou a animação
    if (!playing_losinglife) {
        sprite_index = spr_ui_player_losinglife;
        image_index = 0;
        playing_losinglife = true;
    }

    // quando a animação terminar
    if (playing_losinglife && image_index >= image_number - 1) {
        sprite_index = spr_ui_player_nolife;
    }
}