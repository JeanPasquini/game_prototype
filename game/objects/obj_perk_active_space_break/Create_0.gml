damage = 1;
number_of_projectiles = 40;

active_perk = function(){
    var qtd = number_of_projectiles;
    var angulo_step = 360 / qtd;

    for (var i = 0; i < qtd; i++) {
        var ang = i * angulo_step;
    
        var inst = instance_create_layer(
            obj_player.x, 
            obj_player.y, 
            "perk_in_run", 
            obj_perk_active_space_break_2
        );
        
		inst.image_angle = ang;
        inst.direction = ang;
        inst.speed = 6;
    }
}
