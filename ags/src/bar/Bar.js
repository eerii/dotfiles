import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";

const submenuItems = Variable(1);
SystemTray.connect("changed", () => {
  submenuItems.setValue(SystemTray.items.length + 1);
});

const Start = () =>
    Widget.Box({
        class_name: "start",
        setup: async box => {
            box.children = [
                // await OptionalWorkspaces(),
                // SeparatorDot(),
                // Widget.Box({ hexpand: true }),
                // NotificationIndicator(),
                // SeparatorDot(Notifications, (n) => n.notifications.length > 0 || n.dnd),
            ];
        },
    });

const Center = () =>
    Widget.Box({
        class_name: "center",
        children: [
            // DateButton()
        ],
    });

const End = () =>
    Widget.Box({
        class_name: "end",
        children: [
            // SeparatorDot(Mpris, (m) => m.players.length > 0),
            // MediaIndicator(),
            // Widget.Box({ hexpand: true }),
            //
            // SubMenu({
            //     items: submenuItems,
            //     children: [SysTray(), ColorPicker()],
            // }),
            //
            // SeparatorDot(),
            // ScreenRecord(),
            // SeparatorDot(Recorder, (r) => r.recording),
            // SystemIndicators(),
        ],
    });

/** @param {number} monitor */
export default (monitor) =>
    Widget.Window({
        monitor,
        name: `bar${monitor}`,
        exclusivity: "exclusive",
        anchor: ["top", "right", "left"],
        child: Widget.CenterBox({
            css: "min-height: 16px; background-color: red;",
            start_widget: Start(),
            center_widget: Center(),
            end_widget: End(),
        }),
    });
