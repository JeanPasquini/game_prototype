if (shake > 0)
{
    x = base_x + random_range(-shake, shake);
    shake -= 0.5;
}
else
{
    x = base_x;
}

if(life <= 0 ){
	scr_drop_roll(drops, x, y-16, "drop");
	instance_destroy();	
}
