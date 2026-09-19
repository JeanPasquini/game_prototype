/// Entrada da RUN no HUB (substitui a porta): coloque na room, no centro da luz. Não precisa de sprite.
/// Área de ativação = retângulo centrado na instância, com as variáveis da instância trigger_width e
/// trigger_height (padrão 64 x 128, em px do mundo). Ao apertar o botão de interação com o player dentro
/// da área, ele anda até o x deste objeto (centro da luz), pula, cai atrás do chão, toca a animação de
/// morto e só então acontece a cutscene de transição pra próxima sala da run.
/// A sequência em si está em scr_movement (_update_transition).

if (!variable_instance_exists(id, "trigger_width"))  trigger_width  = 64;
if (!variable_instance_exists(id, "trigger_height")) trigger_height = 128;

// mostra no Output por que a entrada não disparou (desligue quando estiver funcionando)
debug_log = true;
log = function(_msg) {
    if (debug_log) show_debug_message("[obj_hub_entry] " + _msg);
};
log("criado em (" + string(x) + ", " + string(y) + ") na sala " + room_get_name(room)
    + " | área " + string(trigger_width) + "x" + string(trigger_height));
