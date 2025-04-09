import Application from "../three/Application";
import Stats from "stats.js";

const STATS_OPTIONS = ["FPS", "MS", "MB"];

type PerformanceMonitorOptions = typeof STATS_OPTIONS[number];

export default class PerformanceMonitor {
    parent: Application
    _monitor: Stats;

    _show: boolean = false;
    _state: PerformanceMonitorOptions = "FPS";

    constructor(parent: Application) {
        this.parent = parent;
        this._monitor = new Stats();
        
        this._init();
    }

    _init = () => {
        this._monitor.dom.style.display = "none";
        this._monitor.showPanel(0);

        document.body.appendChild(this._monitor.dom);

        this.debug();
    }

    _beginMonitoring = () => {
        this._monitor.begin();
    }

    _endMonitoring = () => {
        this._monitor.end();
    }

    debug = () => {
        const performanceFolder = this.parent._debug.addFolder("Performance Monitor");

        performanceFolder.add(this, "_show")    
            .onChange((show: boolean) => {
                this._monitor.dom.style.display = show ? "block" : "none";
            })
            .name("Show?")

        performanceFolder.add(this, "_state", STATS_OPTIONS)
            .onChange((state: PerformanceMonitorOptions) => {
                this._monitor.showPanel(STATS_OPTIONS.indexOf(state));
            })
            .name("Monitor Type")

        performanceFolder.close();
    }
}