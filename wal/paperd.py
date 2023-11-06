import os
import psutil
import time
import numpy as np
from argparse import ArgumentParser

import datetime as dt
from zoneinfo import ZoneInfo

from astral import LocationInfo
from astral.sun import sun as Sun

import pywal
import pywalfox
from PIL import Image, ImageEnhance
from colorzero import *

np.set_printoptions(precision=1)

# Settings

lat = 42.87
lon = -8.55
city = "Santiago"
country = "Spain"
timezone = "Europe/Madrid"

# Naming: n-from-to.ext
dir = "/home/eri/Media/Pictures/Wallpapers/Desert"

adjust = {
    "dawn": -30,
    "sunrise": +30,
    "pre_noon": -120,
    "post_noon": +120,
    "sunset": -30,
    "dusk": +30
}

# ---

# Suntimes

loc = LocationInfo(city, country, timezone, lat, lon)

def now(silent = True):
    t = dt.datetime.now(ZoneInfo(loc.timezone))

    global time_overwrite
    try: time_overwrite
    except NameError: time_overwrite = None
    if isinstance(time_overwrite, dt.datetime):
        t = time_overwrite

    if not silent:
        print(f"time: {t.strftime('%H:%M')}")

    return t

def sun():
    times = Sun(loc.observer, date=now(), tzinfo=loc.timezone)

    times["pre_noon"] = times["noon"]
    times["post_noon"] = times["noon"]
    times.pop("noon")

    for k, v in adjust.items():
        times[k] += dt.timedelta(minutes=v)

    times = dict(sorted(times.items(), key=lambda x: x[1]))

    return times

def print_sun(sun, curr):
    global time_overwrite
    curr = current(sun)

    for k, v in sun.items():
        time_overwrite = v + dt.timedelta(minutes=10)
        print(f"{k:10}: {v.strftime('%H:%M')}{' (current)' if k == curr[0] else ''}")
        w = get_wal(current(s))
        t = get_theme(current(s), w)
        preview_theme(t)


def current(sun):
    t = now()
    curr = "dusk"

    for k, v in sun.items():
        if t > v:
            curr = k

    l = list(sun)
    next = l[(l.index(curr) + 1) % len(l)]

    return curr, next

# Wallpaper

def get_wal(curr, silent = True):
    files = os.listdir(dir)

    wallpaper = ""
    for f in files:
        file, ext = f.split(".")
        n, fr, to = file.split("-")
        if fr == curr[0] and to == curr[1]:
            wallpaper = f

    if wallpaper == "":
        print(f"error: no wallpaper was found for n-{curr[0]}-{curr[1]}.ext, please review your naming")

    if not silent:
        print(f"wallpaper: {wallpaper}")

    return wallpaper

def check_running(ps):
    for proc in psutil.process_iter():
        try:
            if ps.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False;

def set_wal(wall, silent = True):
    if (not check_running("swww-daemon")):
        print("swww is not running, starting now...")
        os.system("swww init")
        while (not check_running("swww-daemon")):
            time.sleep(0.5); 

    path = f"{dir}/{wall}"
    with open("/home/eri/.cache/swww/eDP-1") as cache:
        if (cache.readline() == path):
            return False

    if not silent:
        print(f"setting wallpaper {wall}")

    os.system(f"swww img {path} --transition-step 2 --transition-fps 10")
    return True

# Color theme

termcol_names = ["red", "green", "yellow", "blue", "purple", "cyan", "white"]
termcol_values = ["#F65361", "#67BB97", "#F8B65B", "#789AEB", "#C08BE1", "#A2D9C3", "#FFF1CC"]
termcol = { c: Color(c).lab for c in termcol_values }

def colored_hex(text, hexcode, background = False):
    valid_hex = '0123456789ABCDEF'.__contains__
    def cleanhex(data):
        return ''.join(filter(valid_hex, data.upper()))

    hexint = int(cleanhex(hexcode), 16)
    code = "48" if background else "38"
    return f"\x1B[{code};2;{hexint>>16};{hexint>>8&0xFF};{hexint&0xFF}m{text}\x1B[0m"

def rgb_hex(r, g, b):
    return f"#{r:02x}{g:02x}{b:02x}"

def get_colors_wallpaper(wall):
    path = f"{dir}/{wall}"

    img = Image.open(path).reduce(12)
    contrast = ImageEnhance.Contrast(img)
    img = contrast.enhance(1.8)
    # brightness = ImageEnhance.Brightness(img)
    # img = brightness.enhance(1.2)
    # saturation = ImageEnhance.Color(img)
    # img = saturation.enhance(0.8)

    img = img.quantize(colors=12)#, method=Image.Quantize.MAXCOVERAGE)
    col = [c for c in img.getpalette() if c > 0]
    col = [Color(*c) for c in zip(*(iter(col),) * 3)]

    return col

def get_theme(curr, wall):
    col = get_colors_wallpaper(wall)
    hue, _, _ = col[0].hsv
    col = [c * Saturation(0.9) * Luma(1.3) for c in col]

    ratings = np.array([
        [cie1994g(c.lab, tc) for tc in termcol.values()]
        for c in col
    ])

    new_col = {}
    for i in range(len(termcol_names)):
        j = np.argmin(ratings)
        a, b = np.unravel_index(j, ratings.shape)

        dif = ratings[(a, b)] / 100.
        k = termcol_names[b]

        global theme_overwrite
        try: theme_overwrite
        except NameError: theme_overwrite = 0.5
        c = col[a] * Lightness(1.0 - dif * theme_overwrite) + Color(termcol_values[b]) * Lightness(dif * theme_overwrite)

        # print(f"{k:10} {colored_hex('  ', col[a].html, True)} {dif:.2f} -> {colored_hex('  ', c.html, True)}")
        ratings[a,:] = 1000.
        ratings[:,b] = 1000.

        new_col[k] = c 

    col = { k: new_col[k] for k in termcol_names if k in new_col }

    # l = list(col.items())
    # for i in range(len(col)):
    #     for j in range(i):
    #         rate = euclid(l[i][1], l[j][1])
    #         if rate < 0.22:
    #             print(l[i][0], l[j][0])
    #             col[l[i][0]] = col[l[i][0]] * Lightness(0.9) + Color(l[i][0]) * Lightness(0.1)
    #             col[l[j][0]] = col[l[j][0]] * Lightness(0.9) + Color(l[j][0]) * Lightness(0.1)
    #             l = list(col.items())

    hsv = np.array([ c.hsv for c in col.values() ])
    _, avg_s, avg_v = np.mean(hsv, axis=0)
    _, std_s, std_v = np.std(hsv, axis=0)
    avg_s = np.clip(avg_s, 0.3, 0.5)
    avg_v = np.clip(avg_v, avg_s * 2, 0.9)
    
    for i, k in enumerate(col):
        h, s, v = hsv[i]

        if (i == len(col) - 1):
            col[k] = Color.from_hsv(h, 0.2, 0.9)
            continue

        s = np.clip(s, avg_s - std_s, avg_s)
        v = np.clip(v, avg_v + std_v * 0.5, avg_v + std_v) - 0.05

        col[k] = Color.from_hsv(h, s, v)

    col_alt = {}
    for k, c in col.items():
        col_alt[k+"_alt"] = c * Luma(0.8)

    col = col | col_alt
    col["background"] = Color.from_hsv(hue, 0.2, 0.05)

    return col

def preview_theme(theme):
    for i, (k, c) in enumerate(list(theme.items())[:-1]):
        print(colored_hex("  ", c.html, True), end="")
        if i % 7 == 6:
            print("")

def set_theme(theme):
    col = {
        "special": {
            "background": theme["background"].html,
            "foreground": theme["white"].html,
            "cursor": theme["white"].html, 
        },
        "alpha": "100",
        "wallpaper": "none",
        "colors": {
            "color0": theme["background"].html,
            "color1": theme["red"].html,
            "color2": theme["green"].html,
            "color3": theme["yellow"].html,
            "color4": theme["blue"].html,
            "color5": theme["purple"].html,
            "color6": theme["cyan"].html,
            "color7": theme["white"].html,
            "color8": theme["background"].html,
            "color9": theme["red_alt"].html,
            "color10": theme["green_alt"].html,
            "color11": theme["yellow_alt"].html,
            "color12": theme["blue_alt"].html,
            "color13": theme["purple_alt"].html,
            "color14": theme["cyan_alt"].html,
            "color15": theme["white_alt"].html
        }
    }

    pywal.sequences.send(col)
    pywal.export.every(col)
    pywal.reload.env()
    os.system("pywalfox update")

# Arguments

def parse():
    parser = ArgumentParser(prog="paperd", description="changes the wallpaper and theme during the day", epilog="uwu")
    parser.add_argument("-t", "--time", help="overwrite the current time to test the configuration")
    parser.add_argument("-c", "--color-theme", help="theme overwrite, makes the colors more distinct and closer to the terminal (between 0 and 1)")
    parser.add_argument("-l", "--list-times", action="store_true", help="show the sun timetable for table")
    parser.add_argument("-w", "--wallpaper", action="store_true", help="print the current wallpaper")
    parser.add_argument("-p", "--preview-theme", action="store_true", help="preview the new theme colors")
    parser.add_argument("-s", "--set", action="store_true", help="set the wallpaper and theme now")
    return parser.parse_args() 

s = sun()
args = parse()
for a, v in vars(args).items():
    if v == None or not v:
        continue
    match a:
        case "time":
            try:
                dt.datetime.strptime(v, "%H:%M")
            except:
                print("the time must be formatted like 00:00")
                exit(1)

            h, m = v.split(":")

            global time_overwrite
            time_overwrite = dt.datetime.now(ZoneInfo(loc.timezone)).replace(hour=int(h), minute=int(m))

            now(silent = False)

        case "color_theme":
            global theme_overwrite
            theme_overwrite = float(v)

        case "list_times":
            print_sun(s, current(s))

        case "wallpaper":
            w = get_wal(current(s))
            print(f"wallpaper {w}")

        case "preview_theme":
            w = get_wal(current(s))
            t = get_theme(current(s), w)
            preview_theme(t)

        case "set":
            w = get_wal(current(s))
            if set_wal(w, silent=False):
                t = get_theme(current(s), w)
                set_theme(t)
        case _:
            print("illegal argument")
