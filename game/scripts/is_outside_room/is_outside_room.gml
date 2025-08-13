/// @function is_outside_room(inst)
/// @description Retorna true se o objeto estiver totalmente fora da room.
/// @param inst: instância a ser verificada
///
/// Uso: if (is_outside_room(id)) { ... }

function is_outside_room(inst) {
    return (
        inst.bbox_right < 0 ||                    // Fora à esquerda
        inst.bbox_left > room_width ||            // Fora à direita
        inst.bbox_bottom < 0 ||                   // Fora acima
        inst.bbox_top > room_height               // Fora abaixo
    );
}