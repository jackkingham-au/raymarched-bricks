vec3 getNormal(in vec3 pos) {
    const float EPSILON = 0.01;

    float distanceToScene = scene(pos).sdf;
    vec2 epsilon = vec2(EPSILON, 0.);

    vec3 normal = distanceToScene - vec3(scene(pos - epsilon.xyy).sdf, scene(pos - epsilon.yxy).sdf, scene(pos - epsilon.yyx).sdf);

    return normalize(normal);
}