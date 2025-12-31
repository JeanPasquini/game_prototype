// Inherit and execute the parent Step event logic
event_inherited();

// Predict the next position based on current velocity and direction
// The displacement adds a small vertical offset to influence the bounce behavior
var nx = x + lengthdir_x(velocity, direction);
var ny = y + lengthdir_y(velocity, direction) + sign(displacement) * 2;

// If the next position will collide with a wall, decrease the bounce counter
if (place_meeting(nx, ny, obj_wall)) {
    bounces--;
    
    // Destroy the bullet once it has no remaining bounces
    if (bounces <= 0) {
        instance_destroy();
        exit;
    }
}

// Apply the predicted movement
x = nx;
y = ny;

// Handle ricochet behavior by bouncing off solid objects
// The 'true' parameter ensures precise collision handling
move_bounce_solid(true);
