#ifndef FOG_FAR
    #define FOG_FAR MAX_DISTANCE * .45
#endif

#ifndef FOG_COLOR
    #define FOG_COLOR vec3(0.922,0.929,0.953)
#endif

#ifndef FOG_NEAR
    #define FOG_NEAR 20.0
#endif

vec3 linearFog(in vec3 col, in float distanceFromOrigin) {
    float factor = clamp((FOG_FAR - distanceFromOrigin) / (FOG_FAR - FOG_NEAR), 0., 1.);
    return mix(FOG_COLOR, col, factor);
}

vec3 linearFog(in vec3 col, in float distanceFromOrigin, in vec3 worldPos) {
    float height = smoothstep(.2, .9, worldPos.y) + smoothstep(.9, .2, worldPos.y);
    float factor = clamp((FOG_FAR - distanceFromOrigin) / (FOG_FAR - FOG_NEAR), .0, 1.);
    float invertFactor = 1.0 - factor;

    vec3 skyFog = SKY_COLOR;
    skyFog.rgb *= 5.0 * height;

    col = mix(skyFog * invertFactor, col, factor);

    float noise = perlin(worldPos) - .5;
    float yPos = worldPos.y + noise;
    yPos += sin(worldPos.x) * .45;

    if (distanceFromOrigin > FOG_NEAR && yPos < 1.) {
        col += linearFog(col, distanceFromOrigin) * .025;    
    }

    return col;
}
