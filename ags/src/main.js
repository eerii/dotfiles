import Bar from "./bar/Bar.js";
import Notifications from "./notifications/Notifications.js";
// import Dashboard from "./dashboard/Dashboard.js";
// import QuickSettings from "./quicksettings/QuickSettings.js";
// import AppLauncher from "./applauncher/Applauncher.js";
// import PowerMenu from "./powermenu/PowerMenu.js";
// import Verification from "./powermenu/Verification.js";
// import Desktop from "./desktop/Desktop.js";
import { init } from "./settings/init.js";
import { forMonitors } from "./utils.js";
import options from "./options.js";

App.config({
    onConfigParsed: init,
    windows: () => [
        ...forMonitors(Bar),
        ...forMonitors(Notifications),
    ],
})
