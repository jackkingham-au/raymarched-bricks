#include "./operations.glsl"
#include "./sdf.glsl"

Material ground(in vec3 pos) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0, 1, 0);

    return plane;
}

bool isEven(in float num) {
    return mod(num, 2.) == .0;
}

float brickSDF(in vec3 pos) {
    vec3 size = vec3(.48, .15, .15);
    float row = floor(pos.y / .3);

    if(isEven(row)) {
        pos.x += size.x;
    }

    pos.x = fract(pos.x) - .5;

    const float MAX_HEIGHT = 2.5;
    pos.y = max(mod(pos.y, .3) - .125, pos.y - MAX_HEIGHT);

    return boxSDF(pos, size) - 0.008;
}

Material bricks(in vec3 pos) {
    Material bricks = material();
    bricks.color = vec3(0.9,0.412,0.276);
    bricks.sdf = brickSDF(pos);

    return bricks;
}

Material scene(in vec3 pos) {
    Material ground = ground(pos);
    Material result = ground;
    result = opUnion(result, bricks(pos));
    return result;
}