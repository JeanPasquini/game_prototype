frametime--;


if (frametime <= 0 || obj_player.is_dashing) {
	obj_player.attacked = false;
    instance_destroy();
}