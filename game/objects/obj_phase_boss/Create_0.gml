// Inherit the parent event
event_inherited();

// Isenta o boss dos helpers de colisao novos (unstick / flip por face_scale),
// pra nao quebrar as cutscenes que movem x/y na mao.
is_boss = true;
