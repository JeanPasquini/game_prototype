if(other.is_invencible == true) return;

if (!other.poison)
{
    var fx = instance_create_layer(
        other.x,
        other.y,
        "perk_in_run",
        obj_effect_poison
    );

    fx.target = other;
	other.poison = true;
}

obj_perk_passive_elemental_ring.alarm[2] = 200;
other.alarm[3] = 1;
other.alarm[2] = 500;

instance_destroy();
