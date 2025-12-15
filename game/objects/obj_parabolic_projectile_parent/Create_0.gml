// Inherit the parent event
event_inherited();

mediumPoint = (xStart + xEnd) / 2; // Midpoint between launch and target H
maxHeight = yStart - 50; // Maximum launch height K

// Parabola of the launch with quadratic equation 
division = sqr(xStart - mediumPoint)
if division == 0 division = 0.0001;
a = (yStart - maxHeight) / division;
