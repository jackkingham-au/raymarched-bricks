struct Material {
    vec3 color;
    vec3 normal;
    vec3 worldPos;
    float sdf;
    bool intersected;
    int id;
};

Material material() {
    return Material(
        vec3(0),
        vec3(0),
        vec3(0),
        0.0,
        false,
        -1
    );
}

const int GRASS_MATERIAL_ID = 1;
const int BRICK_MATERIAL_ID = 2;
