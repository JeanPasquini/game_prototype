angle += movementSpeed;
   
var centro_x = room_width / 2;
var centro_y = room_height / 2;
	
x = centro_x + lengthdir_x(radius, angle);
y = centro_y + lengthdir_y(radius, angle);

//image_angle = point_direction(x, y, centro_x, centro_y);
image_angle = angle + 90; // Perpendicular ao Raio