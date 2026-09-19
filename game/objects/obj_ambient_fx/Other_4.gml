// Room Start: descarta partículas da sala anterior (as coordenadas não valem mais) e pré-aquece de novo
part_particles_clear(ps_far);
part_particles_clear(ps_mid);
part_particles_clear(ps_near);
warm = true;
