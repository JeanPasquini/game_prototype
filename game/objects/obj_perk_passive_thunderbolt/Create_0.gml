chance = 10;
damage = obj_player.damage * 5;

scr_perk_thunderbolt = function(_x, _y)
{
    if (irandom(99) < chance)
    {
        instance_create_layer(_x, _y, "perk_in_run", obj_perk_passive_thunderbolt_2);
    }
};
