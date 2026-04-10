spawn_x = obj_player.x + (obj_player.image_xscale * offset);

if (count_attack >= count_attack_need) {

    var inst = instance_create_layer(
        spawn_x,
        obj_player.y - 5,
        "perk_in_run",
        obj_perk_passive_energy_attack_2
    );

    // define lado corretamente
    inst.image_xscale = obj_player.face;

    // define direção em graus
    inst.direction = (obj_player.face == 1) ? 0 : 180;
    inst.speed = speed_attack;

    count_attack = 0;
}
