// Inherit the parent event
//event_inherited();

if(freeze){
	shake_x = random_range(-0.3, 0.3);
	shake_y = random_range(-0.3, 0.3);
}
else{
	shake_x = 0;
	shake_y = 0;
}
alpha = lerp(alpha, 0, 0.1);
