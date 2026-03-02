/// @func scr_drop_roll(drops, xx, yy, layer)
/// @desc Sorteia um item baseado em chances
/// @param drops   Array [{ item, chance }]
/// @param xx      X do drop
/// @param yy      Y do drop
/// @param layer   Layer onde criar

function scr_drop_roll(_drops, _x, _y, _layer)
{
    var total = 0;

    // soma total das chances
    for (var i = 0; i < array_length(_drops); i++)
    {
        total += _drops[i].chance;
    }

    // nenhum drop válido
    if (total <= 0) return noone;

    var roll = random(total);
    var acumulado = 0;

    for (var i = 0; i < array_length(_drops); i++)
    {
        acumulado += _drops[i].chance;

        if (roll < acumulado)
        {
            if (_drops[i].item != noone)
            {
                instance_create_layer(_x, _y, _layer, _drops[i].item);
            }

            return _drops[i].item;
        }
    }

    return noone;
}
