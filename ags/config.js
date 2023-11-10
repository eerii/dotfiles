import { App } from "./imports.js"
import Bar from "./windows/bar.js"

const windows = () => [
    Bar(0)
]

export default {
    windows: windows().flat(),
    style: App.configDir + "/style.css",
    maxStreamVolume: 1.05,
}
