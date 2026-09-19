// A logo da intro é redesenhada aqui, ancorada no MUNDO: a UI normal fica fixa na tela, então
// desconta o quanto a view desceu (em px de GUI) e a logo sobe e sai da tela junto com a descida.
if (!playing && phase == 1 && logo_snap != undefined) {
    var _cam = view_camera[0];
    var _scale = display_get_gui_height() / camera_get_view_height(_cam);
    var _offset = (camera_get_view_y(_cam) - intro_view_y0) * _scale;

    draw_sprite_ext(logo_snap.spr, logo_snap.img, logo_snap.x, logo_snap.y - _offset,
        logo_snap.xs, logo_snap.ys, 0, c_white, logo_snap.alpha);
}
