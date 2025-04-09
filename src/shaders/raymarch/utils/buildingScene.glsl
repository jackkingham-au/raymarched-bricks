#include "./operations.glsl"
#include "./sdf.glsl"

Material ground(in vec3 pos) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0, 1, 0);

    return plane;
}

float buildingBaseSDF(in vec3 pos) {
    const float HEIGHT = 3.0;
    const float DEPTH = .2;
    float width = 1.0;

    float b1 = boxSDF(pos, vec3(DEPTH, HEIGHT, width));
    float b2 = boxSDF(pos - vec3(DEPTH, 0, 0), vec3(DEPTH, HEIGHT, width * .8));
    float b3 = boxSDF(pos - vec3(DEPTH * 2.0, 0, 0), vec3(DEPTH, HEIGHT, width * .6));
    float b4 = boxSDF(pos - vec3(DEPTH * 3.0, 0, 0), vec3(DEPTH, HEIGHT, width * .4));

    return min(min(min(b1, b2), b3), b4);
}

float buildingArchSDF(in vec3 pos) {
    pos.xz *= rotate(PI * .5);
    const float HEIGHT = 3.0;

    float arch = archSDF(pos - vec3(0,HEIGHT,0), vec3(.3, HEIGHT, 1.));

    float subHeight = HEIGHT * .98;
    float subDepth = .2;
    float subtraction = archSDF(pos - vec3(0,subHeight - .0001,1),vec3(.2, subHeight, subDepth));

    return max(arch, -subtraction);
}

Material building(in vec3 pos) {
    pos.x = abs(pos.x);
    pos.x += .05;

    Material building = material();
    building.sdf = min(buildingBaseSDF(pos), buildingArchSDF(pos));
    building.color = vec3(1.,0.992,0.816);

    return building;
}

Material scene(in vec3 pos) {
    Material ground = ground(pos);
    Material result = ground;
    result = opUnion(result, building(pos));

    return result;
}