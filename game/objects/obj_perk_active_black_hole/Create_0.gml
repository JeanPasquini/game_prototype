damage = 0;
offset = 30;
spawn_x = obj_player.x + (obj_player.image_xscale * offset);


active_perk = function(){

        var inst = instance_create_layer(
            spawn_x, 
            obj_player.y, 
            "perk_in_run", 
            obj_perk_active_black_hole_2
        );
}
