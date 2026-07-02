var _W = abs(bbox_right - bbox_left);
var _H = abs(bbox_bottom - bbox_top);
var _bx = min(bbox_left, bbox_right);
var _by = min(bbox_top, bbox_bottom);

var _pixelSize = 3;
var _lowW = ceil(_W / _pixelSize);
var _lowH = ceil(_H / _pixelSize);

if (!surface_exists(wat_surface)
|| surface_get_width(wat_surface)  != _lowW
|| surface_get_height(wat_surface) != _lowH) {
    if (surface_exists(wat_surface)) surface_free(wat_surface);
    wat_surface = surface_create(_lowW, _lowH);
}

surface_set_target(wat_surface);
    draw_clear(make_color_rgb(10, 55, 85));
surface_reset_target();

shader_set(wat_shader);
    shader_set_uniform_f(wat_uTime,  get_timer() * 0.000001);
    shader_set_uniform_f(wat_uCount, wat_springCount);
    shader_set_uniform_f_array(wat_uSpr, wat_springs);
    draw_surface_stretched(wat_surface, _bx, _by, _W, _H);
shader_reset();