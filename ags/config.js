import App from "resource:///com/github/Aylur/ags/app.js";

const main = `${App.configDir}/src/main.js`

const v = {
    ags: `v${pkg.version}`,
    expected: `v1.8.0`,
};

function mismatch() {
    print(`my config expects ${v.expected}, but your ags is ${v.ags}`);
    App.connect("config-parsed", (app) => app.Quit());
    return {};
}

await import(`file://${main}`);
export {};
