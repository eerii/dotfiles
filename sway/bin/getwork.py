#!/usr/bin/env python3

import json
import sys
import subprocess

def get_work():
    w = subprocess.getoutput("swaymsg --type get_workspaces --raw")
    j = json.loads(w)
    m = {}

    for n in j:
        m[n["name"]] = {"name": n["name"], "focused": n["focused"], "empty": False}
    for i in range(1, 5):
        if not str(i) in m:
            m[str(i)] = {"name": str(i), "focused": False, "empty": True}

    m = list(m.values())
    m.sort(key=lambda x: x["name"])
    
    return json.dumps(m)

def listen_sway():
    r = json.dumps(["workspace"])
    cmd = ["swaymsg", "--type", "subscribe", "--monitor", f"{r}"]
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE)

    for _ in iter(popen.stdout.readline, ""):
        yield

def write(s):
    sys.stdout.write(s + "\n")
    sys.stdout.flush()

write(get_work())
for l in listen_sway():
    write(get_work())
