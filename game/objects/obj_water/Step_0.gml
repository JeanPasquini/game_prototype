if(!instance_exists(obj_psicotopus)) return

if(obj_psicotopus.currentAttackState == AttackState.FLOOD){
	state = waterState.ATTACK;	
}
else{
	state = waterState.NORMAL;		
}

if (state == waterState.NORMAL) {
    image_yscale = lerp(image_yscale, -5, 0.05);
}
else if (state == waterState.ATTACK) {
    image_yscale = lerp(image_yscale, -6.5, 0.05);
}

for (var i = 0; i < wat_springCount; i++) {
    var _pos = wat_springs[i * 2];
    var _vel = wat_springs[i * 2 + 1];
    var _acc = -wat_tension * _pos - wat_damping * _vel;
    wat_springs[@ i * 2 + 1] = _vel + _acc;
    wat_springs[@ i * 2 + 0] = _pos + wat_springs[i * 2 + 1];
}

for (var pass = 0; pass < 8; pass++) {
    for (var i = 0; i < wat_springCount; i++) {
        if (i > 0) {
            var _d = wat_spread * (wat_springs[i*2] - wat_springs[(i-1)*2]);
            wat_springs[@ (i-1)*2+1] += _d;
        }
        if (i < wat_springCount - 1) {
            var _d = wat_spread * (wat_springs[i*2] - wat_springs[(i+1)*2]);
            wat_springs[@ (i+1)*2+1] += _d;
        }
    }
}