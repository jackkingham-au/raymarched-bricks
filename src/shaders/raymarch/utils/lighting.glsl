#ifndef LIGHT_POSITION
    #define LIGHT_POSITION vec3(5, 5, 5)
#endif

float diffuseLight(in vec3 normal, in vec3 lightVector) {
    return clamp(dot(normal, lightVector), 0., 1.);
}

float getShadows(
    in vec3 pos,
    in vec3 normal,
    in vec3 lightVector,
    in vec3 lightPosition
) {
    float distanceToLight = raymarch(pos + normal * MIN_DISTANCE * 2., lightVector);
    return distanceToLight < length(lightPosition - pos) ? .1 : 1.;
}

vec3 ambientLight(in vec3 color, in float intensity) {
    return color * intensity;
}

vec3 getLighting(in Material material) {
    vec3 lightVector = normalize(LIGHT_POSITION - material.worldPos);

    vec3 color = material.color;

    float diffuse = diffuseLight(material.normal, lightVector);
    diffuse *= getShadows(material.worldPos, material.normal, lightVector, LIGHT_POSITION);

    color *= diffuse;
    color += ambientLight(material.color, 0.001);

    return color;
}

vec3 linear2gamma(in vec3 color) {
    return pow(color, vec3(.4545));
}