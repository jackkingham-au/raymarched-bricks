uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uMouseDown;
uniform float uTime;

uniform sampler2D uBrickAlbedo;
uniform sampler2D uBrickDisplacement;
uniform sampler2D uGrassAlbedo;
uniform sampler2D uGrassDisplacement;

const vec3 SKY_COLOR = vec3(0.0, 0.65, 1.0);
const vec3 SUN_COLOR = vec3(1, 1, 0);
const float SUN_BRIGHTNESS = .002;

#define LIGHT_POSITION vec3(-5, 5, -5)
#define CAMERA_ROTATE 1
// #define CAMERA_ORIGIN vec3(7.0, 6, 7.0)

const float PI = 3.14159;

#include "./utils/misc.glsl"
#include "./utils/noise/perlin.glsl"
#include "./utils/textures.glsl"
#include "./utils/displacement.glsl"
#include "./utils/view.glsl"

#include "./utils/raymarch.glsl"
#include "./utils/lighting.glsl"
#include "./utils/render.glsl"

#include "../sun/sun.glsl"

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;
    vec2 mouse = uMouse.xy / uResolution;

    // vec3 origin = vec3(14.0 * cos(4.5 * mouse.x * uMouseDown), 6.0, 14.0 * sin(4.5 * mouse.x * uMouseDown));

    Camera camera = createCamera(uv, CAMERA_LOOKAT, CAMERA_ORIGIN);
    Material material = material();
    vec3 col = render(uv, camera, material);

    if(!material.intersected) {
        col += sun((uv * 6.0) - vec2(0, 2.15));
    }

    col = linear2gamma(col);

    gl_FragColor = vec4(col, 1.);
}