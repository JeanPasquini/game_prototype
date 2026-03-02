poison = false;
with (obj_effect_poison)
{
    if (target == other)
    {
        instance_destroy();
    }
}
alarm[3] = 0;