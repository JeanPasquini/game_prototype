//draw_self();

if(telegraphX != 0 && telegraphY != 0){
	if (telegraph_timer > 0 && !created) {
		//draw_sprite(spr_telegraph, 0, telegraphX, telegraphY);
		created = true;
		var telegraph = instance_create_layer(telegraphX, telegraphY, "Instances", obj_psicotopus_telegraph);
		telegraph.telegraph = id;
	}
}