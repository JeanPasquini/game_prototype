// Snapshot the menu-lock state at the very start of the frame (Begin Step
// runs for every instance before any instance's regular Step event).
// Movement/combat reads this snapshot instead of the live lock state, so
// that closing a menu with a button also shared with a gameplay action
// (e.g. X = confirm AND jump) can't leak that same press into gameplay on
// the exact frame the menu releases the lock.
global.world_was_blocked = scr_menu_lock_blocks_world();

// atualiza o dispositivo dos icones de prompt (teclado <-> controle)
input_prompt_update();
