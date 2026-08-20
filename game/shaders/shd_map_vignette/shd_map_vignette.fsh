varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_bounds;   // left, top, right, bottom (0..1 uv space)
uniform vec2 u_pad;      // fade distance, in uv space (x, y)

void main() {
    vec4 texel = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    float left   = u_bounds.x;
    float top    = u_bounds.y;
    float right  = u_bounds.z;
    float bottom = u_bounds.w;

    float fade = 1.0;
    fade *= smoothstep(left - u_pad.x, left, v_vTexcoord.x);
    fade *= smoothstep(right + u_pad.x, right, v_vTexcoord.x);
    fade *= smoothstep(top - u_pad.y, top, v_vTexcoord.y);
    fade *= smoothstep(bottom + u_pad.y, bottom, v_vTexcoord.y);

    texel.a *= fade;

    gl_FragColor = texel;
}
