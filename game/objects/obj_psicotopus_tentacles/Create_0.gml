enum TentacleType {
	ORBITAL,
	STATIC,
	ALIVE,
}

type = TentacleType.STATIC;
scale_target = 1.0;
scale_current = 0.0;
grow_smoothness = 0.05;
grow_direction = 1; // 1 up-down, -1 down-up

is_destroyed = false
damage = 1;
life = 3;

angle_rotation = 0;
angle_offset = 0;

radius = 30;
movementSpeed = 2;

// Propriedades para controle de ataque ao player
is_attacking = false;
player_angle_dir = 0;
attack_range = sprite_height; // alcance máximo = altura do sprite
alpha = 0;
color = c_white;