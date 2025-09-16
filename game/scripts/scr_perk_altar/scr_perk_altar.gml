function scr_perk_altar(_xpos, _ypos)
{
    var _layer = "perk"; 

    var perks_types = 
	[
	obj_perk_speed, 
	obj_perk_damage, 
	obj_perk_life,
	obj_perk_restoredlife
	];
    
    var altar_positions = [_xpos - 50, _xpos, _xpos + 50];
    
    var shuffled_perks = [];
    for (var i = 0; i < array_length(perks_types); i++)
    {
        array_push(shuffled_perks, perks_types[i]);
    }
    
    for (var i = array_length(shuffled_perks) - 1; i > 0; i--)
    {
        var j = irandom(i);
        var temp = shuffled_perks[i];
        shuffled_perks[i] = shuffled_perks[j];
        shuffled_perks[j] = temp;
    }
    
    for (var k = 0; k < 3; k++)
    {
        var altar = instance_create_layer(altar_positions[k], _ypos, _layer, obj_perk_altar);
        var perk  = instance_create_layer(altar_positions[k], _ypos, _layer, shuffled_perks[k]);
        
        perk.parent_altar = altar;
    }
}

