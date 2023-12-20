import { App } from "./js/imports.js"
import Bar from "./js/bar/bar.js"
import Notifications from "./js/notifications/list.js"

const windows = () => [
    Bar(0),
    Notifications(0)
]

export default {
    windows: windows().flat(),
    style: App.configDir + "/style.css",
    maxStreamVolume: 1.05,
}
