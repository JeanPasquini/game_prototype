var damage_amount = damage;
var knockback_strength = 10;

var enemies = [obj_enemy_parent, obj_player];

for (var i = 0; i < array_length(enemies); i++) {
    with (enemies[i]) {
        if (place_meeting(x, y, other)) { 

            var dir_x = x - other.x;
            var dir_y = y - other.y;
            var length = sqrt(sqr(dir_x) + sqr(dir_y));
            if (length != 0) {
                dir_x /= length;
                dir_y /= length;
            }

            knockback_x = dir_x * knockback_strength;

            if (abs(knockback_x) > 0.1) {
                if (place_meeting(x + knockback_x, y, obj_wall) || place_meeting(x + knockback_x, y, obj_player)) {
                    while (!place_meeting(x + sign(knockback_x), y, obj_wall) 
                        && !place_meeting(x + sign(knockback_x), y, obj_player)) {
                        x += sign(knockback_x);
                    }
                    knockback_x = 0;
                } else {
                    x += knockback_x;
                }
                knockback_x *= 0.95; 
            }

            if (!downed) {
                life -= damage_amount;
            }
            stagger = 100;
            downed = true;
            alarm[0] = 100;
        }
    }
}
