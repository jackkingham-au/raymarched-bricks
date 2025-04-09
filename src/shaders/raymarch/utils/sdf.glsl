/** Assumes a plane at `y = 0 */
float planeSDF(in vec3 pos) {
    return pos.y;
}

float sphereSDF(in vec3 pos, in float radius) {
    return length(pos) - radius;
}

float boxSDF(vec3 pos, vec3 size) {
    vec3 q = abs(pos) - size;
    return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0);
}

float capsuleVerticalSDF(vec3 pos, float height, float radius) {
    pos.y -= clamp(pos.y, 0.0, height);
    return length(pos) - radius;
}

float dot2(vec2 v) {
    return dot(v, v);
}

/** The `wh` parameter defines width and height respectively. */
float tunnelSDF(in vec2 p, in vec2 wh) {
    p.x = abs(p.x);
    p.y = -p.y;
    vec2 q = p - wh;

    float d1 = dot2(vec2(max(q.x, 0.0), q.y));
    q.x = (p.y > 0.0) ? q.x : length(p) - wh.x;
    float d2 = dot2(vec2(q.x, max(q.y, 0.0)));
    float d = sqrt(min(d1, d2));

    return (max(q.x, q.y) < 0.0) ? -d : d;
}

/** The `size` parameter defines width, height, and depth respectively. */
float archSDF(in vec3 pos, in vec3 size) {
    return opExtrusion(pos, tunnelSDF(pos.xy, size.xy), size.z);
}