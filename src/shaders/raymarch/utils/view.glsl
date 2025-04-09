#ifndef WORLD_UP
    #define WORLD_UP vec3(0, 1, 0)
#endif

#ifndef CAMERA_ROTATE 
    #define CAMERA_ROTATE 0
#endif

#ifndef CAMERA_ORIGIN
    #if CAMERA_ROTATE == 1
        #define CAMERA_ORIGIN vec3(7.0 * cos(uTime * .1), 4.0, 7.0 * sin(uTime * .1))
    #else
        #define CAMERA_ORIGIN vec3(7.0, 4.0, 7.0)
    #endif
#endif

#ifndef CAMERA_LOOKAT
    #define CAMERA_LOOKAT vec3(0, 2, 0)
#endif

struct Camera {
    vec3 lookAt;
    vec3 origin;
    vec3 direction;
};

Camera createCamera(in vec2 uv, in vec3 lookAt, in vec3 origin) {
    vec3 forward = normalize(lookAt - origin);
    vec3 right = cross(forward, WORLD_UP);
    vec3 up = cross(right, forward);

    vec3 screenCenter = origin + forward;

    /** Where a "ray" will intersect with the screen. */
    vec3 intersectionPoint = screenCenter + uv.x * right + uv.y * up;

    vec3 direction = normalize(intersectionPoint - origin);

    return Camera(lookAt, origin, direction);
}

Camera createCamera(in vec2 uv) {
    return createCamera(uv, CAMERA_LOOKAT, CAMERA_ORIGIN);
}
