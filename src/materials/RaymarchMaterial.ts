import * as THREE from "three";

import fragmentShader from "../shaders/raymarch/fragment.glsl";

const TEXTURE_PATHS = [
    "/tiles/tile-albedo.png",
    "/tiles/tile-height.png",

    "/grass/grass-albedo.png",
    "/grass/grass-height.png",
]

const MATERIAL_TEXTURES = TEXTURE_PATHS.map((path) => `/assets/textures${path}`);

export default class RaymarchMaterial {
    uniforms: Record<string, THREE.IUniform>;
    _material: THREE.ShaderMaterial;
    _textures: Record<string, THREE.Texture> = {}

    constructor() {
        this._loadTextures();

        this.uniforms = {
            uResolution: {
                value: new THREE.Vector2(window.innerWidth, window.innerHeight)
            },
            uMouse: {
                value: new THREE.Vector2()
            },
            uMouseDown: {
                value: false
            },
            uTime: {
                value: 0
            },
            uCameraPosition: {
                value: new THREE.Vector3()
            },
            uCameraDirection: {
                value: new THREE.Vector3()
            },
            uSunPosition: {
                value: new THREE.Vector3()
            },
            uSunDirection: {
                value: new THREE.Vector3()
            },
            uBrickAlbedo: {
                value: this._textures[MATERIAL_TEXTURES[0]]
            },
            uBrickDisplacement: {
                value: this._textures[MATERIAL_TEXTURES[1]]
            },
            uGrassAlbedo: {
                value: this._textures[MATERIAL_TEXTURES[2]]
            },
            uGrassDisplacement: {
                value: this._textures[MATERIAL_TEXTURES[3]]
            }
        }

        this._material = new THREE.ShaderMaterial({
            fragmentShader,
            uniforms: this.uniforms,
        });
    }

    _loadTextures = () => {
        const loader = new THREE.TextureLoader();

        MATERIAL_TEXTURES.forEach((path) => {
            const texture = loader.load(path);

            texture.wrapS = THREE.RepeatWrapping
            texture.wrapT = THREE.RepeatWrapping

            this._textures[path] = texture;
        });
    }
}