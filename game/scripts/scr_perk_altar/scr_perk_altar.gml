function scr_perk_altar(_xpos, _ypos)
{
    var _layer = "perk"; 

    var perks_types = 
    [
        obj_perk_altar_temporal_jump,
        obj_perk_altar_space_break,
        obj_perk_altar_black_hole
    ];
    
    var altar_positions = [_xpos - 40, _xpos + 40];

    // ID único do grupo
    var group_id = current_time + irandom(999999);

    // shuffle
    var shuffled_perks = [];
    for (var i = 0; i < array_length(perks_types); i++)
        array_push(shuffled_perks, perks_types[i]);

    for (var i = array_length(shuffled_perks) - 1; i > 0; i--)
    {
        var j = irandom(i);
        var temp = shuffled_perks[i];
        shuffled_perks[i] = shuffled_perks[j];
        shuffled_perks[j] = temp;
    }

    for (var k = 0; k < 2; k++)
    {
        var altar = instance_create_layer(
            altar_positions[k],
            _ypos,
            _layer,
            obj_perk_altar
        );

        altar.image_xscale = 0.8;
        altar.image_yscale = 0.8;
        altar.altar_group_id = group_id;

        var perk = instance_create_layer(
            altar_positions[k],
            _ypos - 30,
            _layer,
            shuffled_perks[k]
        );

        perk.parent_altar = altar;
        perk.altar_group_id = group_id;

        var fx = instance_create_layer(
            altar_positions[k],
            _ypos,
            _layer,
            obj_perk_effect_spawn
        );
        fx.depth = -10000;
        fx.altar_group_id = group_id;
    }
}

function scr_create_single_perk_altar(_perk_object, _xpos, _ypos)
{
    var _layer = "perk";

    var group_id = current_time + irandom(999999);

    var altar = instance_create_layer(
        _xpos,
        _ypos,
        _layer,
        obj_perk_altar
    );

    altar.image_xscale = 0.8;
    altar.image_yscale = 0.8;
    altar.altar_group_id = group_id;

	var perk = instance_create_layer(
	    _xpos,
	    _ypos - 30,
	    _layer,
	    _perk_object
	);

	perk.parent_altar   = altar;
	perk.altar_group_id = group_id;
	perk.depth          = altar.depth - 1;

    var fx = instance_create_layer(
        _xpos,
        _ypos,
        _layer,
        obj_perk_effect_spawn
    );
    fx.depth = -10000;
    fx.altar_group_id = group_id;
}

function spr_to_obj(_spr)
{
    var spr_name = asset_get_name(_spr);
    var obj_name = string_replace(spr_name, "spr_", "obj_");
    return asset_get_index(obj_name);
}

