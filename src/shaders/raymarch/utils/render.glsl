vec3 render(in vec2 uv, in Camera ray, out Material material) {
    float distanceFromOrigin = raymarch(ray.origin, ray.direction, material);

    vec3 col = vec3(0);

    if(material.intersected) {
        material.color = getMaterialTexture(material);
        col += getLighting(material) * pow(material.color, vec3(4.));
    } else {
        col = SKY_COLOR;
    }

    col = linearFog(col, distanceFromOrigin, material.worldPos);

    return col;
}

vec3 render(in vec2 uv, in Camera camera) {
    Material material = material();
    return render(uv, camera, material);
}
