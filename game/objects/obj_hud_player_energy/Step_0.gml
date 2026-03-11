// enquanto estiver tocando a animação de usar energia
if (playing_energy_used) {

    if (image_index >= image_number - 1) {
        playing_energy_used = false;
        sprite_index = spr_ui_player_energy;
		image_xscale = obj_player.energy / obj_player.energy_max;
        image_index = 0;
        image_speed = 0;
    }

    exit; // <- MUITO IMPORTANTE
}


// escala da barra
image_xscale = obj_player.energy / obj_player.energy_max;


// lógica normal da energia
if (obj_player.energy < obj_player.energy_max) {

    playing_energy_charged = false;
    sprite_index = spr_ui_player_energy;
    image_speed = 1;

} 
else {

    if (!playing_energy_charged) {
        sprite_index = spr_ui_player_energy_charged;
        image_index = 0;
        image_speed = 1;
        playing_energy_charged = true;
    }

    if (image_index >= image_number - 1) {
        image_index = image_number - 1;
        image_speed = 0;
    }

}