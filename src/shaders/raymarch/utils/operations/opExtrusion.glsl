/** The `d` parameter defines the distance returned from a 2D SDF. */
float opExtrusion(in vec3 p, in float d, in float h) {
    vec2 w = vec2(d, abs(p.z) - h);
    return min(max(w.x, w.y), 0.0) + length(max(w, 0.0));
}
