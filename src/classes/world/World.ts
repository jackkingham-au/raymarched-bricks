
import Application from "../three/Application";
import Environment from "./Environment";

export default class World {
    parent: Application;
    _environment: Environment;

    constructor(parent: Application) {
        this.parent = parent;
        this._environment = new Environment(this);
    }

    update = (elapsedTime: number) => {
        this._environment.update(elapsedTime);
    }
}