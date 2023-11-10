import * as Utils from "resource:///com/github/Aylur/ags/utils.js"

export default Utils

export const range = (len, start = 1) => {
    return Array.from({ len }, (_, i) => i + start);
}
