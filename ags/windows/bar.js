import { Widget } from "resource:///com/github/Aylur/ags/widget.js"
import { Audio, Battery, Network, Utils } from "../imports.js"

// Left

const clock = () => Widget.Label({
    class_name: "clock",
    connections: [
        [1000, self => Utils.execAsync(["date", "+%H:%M · %e %b"])
            .then(date => self.label = date).catch(console.error)],
    ],
});

const left = () => Widget.Box({
    class_name: "left",
    children: [
        clock()
    ]
})

// Center

const center = () => Widget.Box({
    class_name: "center",
})

// Right

const volume = Widget.Button({
    on_clicked: () => {
        if (Audio.speaker)
            Audio.speaker.is_muted = !Audio.speaker.is_muted;
    },
    child: Widget.Icon({
        connections: [[Audio, self => {
            if (!Audio.speaker)
                return;

            const vol = Audio.speaker.volume * 100;
            const icon = [
                [101, "overamplified"],
                [67, "high"],
                [34, "medium"],
                [1, "low"],
                [0, "muted"],
            ].find(([threshold]) => Number(threshold) <= vol)?.[1];

            self.icon = `audio-volume-${icon}-symbolic`;
            self.tooltip_text = `Volume ${Math.floor(vol)}%`;
        }, "speaker-changed"]],
    }),
});

const wifi = () => Widget.Button({
    child: Widget.Icon({
        binds: [["icon", Network.wifi, "icon-name"]],
    }),

});

const wired = () => Widget.Button({
    child: Widget.Icon({
        binds: [["icon", Network.wired, "icon-name"]],
    })
});

const network = () => Widget.Stack({
    items: [
        ["wifi", wifi()],
        ["wired", wired()],
    ],
    binds: [["shown", Network, "primary", p => p || "wifi"]],
});

const battery = Widget.Button({
    child: Widget.Icon({
        binds: [["icon", Battery, "icon-name"]],
    }),
    binds: [
        ["value", Battery, "percent", p => p > 0 ? p / 100 : 0],
        ["className", Battery, "charging", c => c ? "charging" : ""],
    ],
});

const right = () => Widget.Box({
    class_name: "right",
    children: [
        Widget.Box({ hexpand: true }),
        volume,
        network(),
        battery
    ]
})

export default (/** @type {number} */ monitor) => Widget.Window({
    name: `bar${monitor}`,
    exclusive: true,
    monitor,
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
        class_name: "panel",
        start_widget: left(),
        center_widget: center(),
        end_widget: right(),
    }),
})
