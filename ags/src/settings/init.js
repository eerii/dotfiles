import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import options from "../options.js";
import { globals } from "./globals.js";
import { reloadScss, scssWatcher } from "./scss.js";
import Gtk from "gi://Gtk";

export function init() {
    globals();

    scssWatcher();
    reloadScss();

    warnOnLowBattery();
}

function warnOnLowBattery() {
    Battery.connect("notify::percent", () => {
        const low = 15;
        if (
            Battery.percent !== low ||
            Battery.percent !== low / 2 ||
            !Battery.charging
        ) {
            return;
        }

        Utils.execAsync([
            "notify-send",
            `${Battery.percent}% Battery Percentage`,
            "-i",
            icons.battery.warning,
            "-u",
            "critical",
        ]);
    });
}
