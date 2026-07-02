varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_springCount;
uniform float u_springs[96];

float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

float noise(float x) {
    float i = floor(x);
    float f = fract(x);
    float u = f * f * (3.0 - 2.0 * f);
    return mix(hash(i), hash(i + 1.0), u);
}

void main() {
    float pixelsX = 240.0;
    float pixelsY = 120.0;

    float rawX = v_vTexcoord.x;
    float rawY = v_vTexcoord.y;

    float col     = rawX * u_springCount;
    float idx0    = floor(col);
    float idx1    = min(idx0 + 1.0, u_springCount - 1.0);
    float fr      = fract(col);
    float smo     = fr * fr * (3.0 - 2.0 * fr);
    float d0      = u_springs[int(idx0) * 2];
    float d1      = u_springs[int(idx1) * 2];
    float disp    = mix(d0, d1, smo);

    vec2 uv = vec2(
        floor(rawX * pixelsX) / pixelsX,
        floor(rawY * pixelsY) / pixelsY
    );

    // Ondas base mais visíveis e variadas
    float n1 = noise(rawX * 3.0  + u_time * 0.8);
    float n2 = noise(rawX * 7.0  - u_time * 1.2);
    float n3 = noise(rawX * 13.0 + u_time * 1.8);
    float n4 = noise(rawX * 1.5  - u_time * 0.4);

    float wave = (n1 - 0.5) * 0.035
               + (n2 - 0.5) * 0.020
               + (n3 - 0.5) * 0.012
               + (n4 - 0.5) * 0.040;

    float surface_y = 0.05 + wave + disp * 0.055;
    float depth     = uv.y - surface_y;

    float px1 = 1.0 / pixelsY;
    float px2 = 2.0 / pixelsY;
    float px3 = 3.0 / pixelsY;

    vec3 color;
    float alpha;

    if (depth < 0.0) {
        color = vec3(0.0);
        alpha = 0.0;

    } else if (depth < px1) {
        // Linha de topo branca
        color = vec3(0.88, 0.97, 1.00);
        alpha = 0.70;

    } else if (depth < px2) {
        // Segunda linha azul claro
        color = vec3(0.50, 0.80, 0.95);
        alpha = 0.55;

    } else if (depth < px3) {
        // Terceira linha transição
        color = vec3(0.28, 0.62, 0.82);
        alpha = 0.50;

    } else {
        // Corpo com gradiente suave
        float t = clamp((depth - px3) * 2.5, 0.0, 1.0);
        vec3 shallow = vec3(0.14, 0.44, 0.68);
        vec3 deep    = vec3(0.02, 0.10, 0.22);
        color = mix(shallow, deep, t * t);
        alpha = mix(0.55, 0.45, t);
    }

    gl_FragColor = vec4(color, alpha);
}