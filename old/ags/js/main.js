import Notifications from './notifications/Notifications.js';
import { forMonitors } from './utils.js';

const windows = () => [
    forMonitors(Notifications),
]

export default {
    windows: windows().flat(2),
}
