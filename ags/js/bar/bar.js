import Clock from "./widgets/clock.js";
import { App, Widget } from "../imports.js";

import * as battery from "../misc/battery.js";

import SystemIndicators from "./widgets/system_indicators.js";

const Battery = () => Widget.Box({
    class_name: "battery",
    hpack: "end",
    children: [
        battery.Indicator(),
        battery.LevelLabel(),
    ],
});

const Launcher = () => Widget.Button({
    class_name: "launcher",
    on_primary_click: () => App.toggleWindow("applauncher"),
    child: Widget.Box({
        class_name: "launcher__icon",
        vpack: "center",
        hpack: "center",
        hexpand: true,
        vexpand: true,
    }),
});

const Left = () => Widget.Box({
    class_name: "bar__left",
    orientation: "horizontal",
    hpack: "start",
    hexpand: true,
    child: Clock(),
});

const Center = () => Widget.Box({
    class_name: "bar__center",
});

const Right = () => Widget.Box({
    class_name: "bar__right",
    orientation: "horizontal",
    hpack: "end",
    children: [
        SystemIndicators(),
        Battery(),
    ],
});

export default monitor => Widget.Window({
    name: `bar${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    monitor,
    hexpand: true,
    child: Widget.CenterBox({
        class_name: "bar",
        startWidget: Left(),
        centerWidget: Center(),
        endWidget: Right(),
    }),
});
