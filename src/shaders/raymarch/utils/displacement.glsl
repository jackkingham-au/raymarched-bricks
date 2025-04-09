/** Displace a point based on a texture. */
float displacementMap(sampler2D tex, vec3 pos, vec3 normal, float distance, float displacementFactor) {
    float bump = 0.0;

    if(distance < 0.1) {
        normal = normalize(normal);
        bump += displacementFactor * triplanarMapping(tex, pos, normal).r;
    }

    return smoothstep(0.0, 1.0, bump);
}