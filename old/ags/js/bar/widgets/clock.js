import GLib from "gi://GLib";
import { App, Widget } from "../../imports.js";

export default ({
    format = "%a %d %b, %H:%M",
    interval = 1000,
    ...props
} = {}) => Widget.Button({
    cursor: "pointer",
    on_clicked: () => App.toggleWindow("calendar"),
    class_name: "clock",
    ...props,
    connections: [[interval, label =>
        label.label = GLib.DateTime.new_now_local().format(format),
    ]],
});
