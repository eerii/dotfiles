import Gdk from 'gi://Gdk';

/** @type {function(number, number): number[]}*/
export function range(length, start = 1) {
    return Array.from({ length }, (_, i) => i + start);
}

/** @type {function((id: number) => typeof Gtk.Widget): typeof Gtk.Widget[]}*/
export function forMonitors(widget) {
    const n = Gdk.Display.get_default().get_n_monitors();
    return range(n, 0).map(widget);
}
