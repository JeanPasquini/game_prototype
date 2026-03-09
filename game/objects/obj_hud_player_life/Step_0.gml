var _life = obj_player.life;
var _life_max = obj_player.life_max;

if (life_id > _life_max) {
    sprite_index = -1;
}
else if (_life >= life_id) {
    sprite_index = spr_ui_player_yeslife;
}
else {
    sprite_index = spr_ui_player_nolife;
}