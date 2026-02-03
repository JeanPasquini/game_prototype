if(count_ricochet >= 2){
	instance_destroy();	
}

x += move_x;
y += move_y;



if (place_meeting(x + lengthdir_x(speed, direction),
                  y + lengthdir_y(speed, direction),
                  obj_wall))
{
	count_ricochet ++;
	move_bounce_solid(0);
}

image_angle = direction;
