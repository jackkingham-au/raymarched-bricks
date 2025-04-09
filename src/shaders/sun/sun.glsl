/** Fix the aspect ratio of a space keeping things squared for you  */
vec2 aspect(vec2 st, vec2 s) {
    st.x = st.x * (s.x / s.y);
    return st;
}

vec3 sunCenter(in vec2 uv) {
    /** Apply bloom-like effect for glow. */
    float spread = length(uv);
    float distance = spread * smoothstep(.0, .5, spread);
    vec3 sun = vec3(SUN_BRIGHTNESS / distance);

    /** Reduce light spread of sun. */
    sun *= smoothstep(.7, .0, spread);

    return sun;
}

float rays(in vec2 uv) {
    return max(1. - abs(uv.x * uv.y * 1500.), 0.);
}

vec3 sun(vec2 uv) {
    vec3 color = vec3(0);

    /** Add a subtle rotation to the uv. */
    uv *= rotate(sin(uTime * .2) * .5);

    /** Maximum spread of the color. */
    float spread = length(uv);

    /** Add the rays. */
    color += rays(uv);

    /** Rotate the uv and add more rays. */
    uv *= rotate(PI * .25);
    color += rays(uv);

    /** Apply spread to the final color.*/
    color *= smoothstep(.9, .2, spread);

    /** Color glows. */
    color *= .5 / spread;

    /** Apply central glow like sun. */
    color += (sunCenter(uv) * 1.25) * SUN_COLOR;

    return color;
}