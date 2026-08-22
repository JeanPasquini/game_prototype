// Trava genérica: só um menu/sequência bloqueante (intro, transição de sala,
// vinheta de boss, pause, mapa, seleção de perk, etc.) por vez.
// global.menu_lock guarda uma tag (string) de quem está segurando a trava,
// ou "noone" quando está livre.

function scr_menu_lock_try(_tag) {
    if (global.menu_lock == noone || global.menu_lock == _tag) {
        global.menu_lock = _tag;
        return true;
    }
    return false;
}

// Assume a trava incondicionalmente, mesmo tomando de quem já segurava
// (ex.: transição de sala precisa sempre vencer "status"/"map", que são leves).
function scr_menu_lock_force(_tag) {
    global.menu_lock = _tag;
}

function scr_menu_lock_release(_tag) {
    if (global.menu_lock == _tag) {
        global.menu_lock = noone;
    }
}

function scr_menu_lock_is_free() {
    return (global.menu_lock == noone);
}

// "status" (TAB) e "map" (M) são overlays de informação: não travam o mundo,
// então portas continuam funcionando com eles abertos. Qualquer outra trava
// (pause, transição, intro, boss, seleção de perk, morte...) bloqueia normalmente.
function scr_menu_lock_blocks_world() {
    return !(global.menu_lock == noone || global.menu_lock == "status" || global.menu_lock == "map");
}
