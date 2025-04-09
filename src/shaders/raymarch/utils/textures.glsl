#include "./material.glsl"

/** Apply a texture to an object using triplanar mapping. */
vec3 triplanarMapping(sampler2D tex, vec3 p, vec3 normal) {
    normal = abs(normal);
    normal = pow(normal, vec3(5.0));
    normal /= normal.x + normal.y + normal.z;

    return (texture(tex, p.xy * 0.5 + 0.5) * normal.z +
        texture(tex, p.xz * 0.5 + 0.5) * normal.y +
        texture(tex, p.yz * 0.5 + 0.5) * normal.x).rgb;
}

/** Set material color to match texture, if `material.id` is applicable. */
vec3 getMaterialTexture(Material material) {
    /** Return default color if no texture is applicable. */
    return material.color;
}
