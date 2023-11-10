import { Widget } from "resource:///com/github/Aylur/ags/widget.js"

const Left = () => Widget.Box({
    class_name: 'left',
    children: [
        Widget.Label({ label: "hey" })
    ]
})

const Center = () => Widget.Box({
    class_name: 'center',
    children: [
        Widget.Label({ label: "hi" })
    ]
})

const Right = () => Widget.Box({
    class_name: 'right',
    children: [
        Widget.Box({ hexpand: true }),
        Widget.Label({ label: "hello" })
    ]
})

export default (monitor) => Widget.Window({
    name: `bar${monitor}`,
    exclusive: true,
    monitor,
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
        class_name: 'panel',
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
})
