frametime--;
if (frametime <= 0) {
	obj_player.attacked = false;
    instance_destroy();
}