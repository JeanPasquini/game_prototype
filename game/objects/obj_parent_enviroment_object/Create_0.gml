base_x = x;
shake = 0;
life = 0;

drops = [
    { item: obj_drop_life,  chance: life_porcentage },
    { item: obj_drop_coin,  chance: money_porcentage  },
    { item: obj_drop_key,   chance: key_porcentage  }
];

/// "Cima" do objeto em graus, respeitando a rotação / espelho vertical colocados
/// no editor (cristal de ponta cabeça no teto = 270, em vez de 90).
env_up_dir = function() {
	return image_angle + ((image_yscale < 0) ? 270 : 90);
};

/// Ponto de onde os drops saem: centro visual do objeto (bbox), ignorando o
/// tremor do hit. Funciona com qualquer rotação, então um cristal pendurado no
/// teto solta o drop NO cristal, e não dentro da parede acima dele.
env_drop_x = function() { return base_x + (bbox_left + bbox_right) * 0.5 - x; };
env_drop_y = function() { return (bbox_top + bbox_bottom) * 0.5; };
