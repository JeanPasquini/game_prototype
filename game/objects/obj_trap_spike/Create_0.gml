enum TrapSpikeState {
    NOT_DAMAGE,
	DAMAGE
}
state = TrapSpikeState.NOT_DAMAGE;
knockback_strength = 4;
damage = 1;
image_speed = 1;
trap_stopped = false;   // true quando a sala de desafio concluiu (traps_stop_all)
