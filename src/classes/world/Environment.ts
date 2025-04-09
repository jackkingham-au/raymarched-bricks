import * as THREE from "three";
import RaymarchMaterial from "../../materials/RaymarchMaterial";
import World from "./World";

export default class Environment {
    parent: World;

    _renderTarget!: THREE.WebGLRenderTarget;
    _renderTargetScene!: THREE.Scene;
    _renderTargetCamera!: THREE.Camera;

    _quad!: THREE.Mesh;
    _material!: THREE.ShaderMaterial;

    constructor(parent: World) {
        this.parent = parent;
        this._init();
        this.debug();
    }

    _init = () => {
        this._createRenderTarget();
        this._material = new RaymarchMaterial()._material;
        this._quad = this._createQuad(this._material as unknown as THREE.Material);

        this._renderTargetScene.add(this._quad);

        this._setMouseUniforms();
    }

    _createRenderTarget = () => {
        this._renderTarget = new THREE.WebGLRenderTarget(window.innerWidth, window.innerHeight);
        this._renderTargetScene = new THREE.Scene();
        this._renderTargetCamera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0, 1);
    }

    _createQuad = (material: THREE.Material) => {
        return new THREE.Mesh(new THREE.PlaneGeometry(2, 2, 2, 2), material);
    }

    _setMouseUniforms = () => {
        window.addEventListener("mousemove", (event) => {
            this._material.uniforms.uMouse.value = new THREE.Vector2(event.clientX, event.clientY);
        });

        window.addEventListener("mousedown", () => {
            this._material.uniforms.uMouseDown.value = true;
        });

        window.addEventListener("mouseup", () => {
            this._material.uniforms.uMouseDown.value = false;
        });
    }

    _setCameraUniforms = () => {
        const { _camera } = this.parent.parent;

        const position = new THREE.Vector3();
        const direction = new THREE.Vector3();

        _camera.getWorldPosition(position);
        _camera.getWorldDirection(direction);

        this._material.uniforms.uCameraPosition.value = position;
        this._material.uniforms.uCameraDirection.value = direction;
    }   

    _setLightingUniforms = () => {
        const directionalLight = this.parent.parent._lights._getSun();

        const position = new THREE.Vector3();
        const direction = new THREE.Vector3();

        directionalLight.getWorldPosition(position);
        directionalLight.getWorldDirection(direction);

        this._material.uniforms.uSunPosition.value = position;
        this._material.uniforms.uSunDirection.value = direction;
    }

    debug = () => {

    }

    update = (_elapsedTime: number) => {
        this._material.uniforms.uResolution.value = new THREE.Vector2(window.innerWidth, window.innerHeight);
        this._material.uniforms.uTime.value = _elapsedTime;
        
        this._setCameraUniforms();
        this._setLightingUniforms();

        const { _renderer, _scene } = this.parent.parent;

        _renderer.setRenderTarget(this._renderTarget);
        _renderer.render(this._renderTargetScene, this._renderTargetCamera);
        _renderer.setRenderTarget(null);

        _scene.background = this._renderTarget.texture;
    }
}