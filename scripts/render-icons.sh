#!/usr/bin/env bash
# Renders the launcher icon assets from their only authored source,
# app/assets/branding/hayer_icon.svg.
#
# Two assets come out of one drawing:
#
#   hayer_icon.png             the whole drawing, edge to edge and fully
#                              opaque. Used as flutter_launcher_icons'
#                              image_path for the legacy Android icon, iOS,
#                              web, Windows and macOS, and shown in-app on the
#                              home screen.
#   hayer_icon_foreground.png  the drawing without its background, scaled into
#                              Android's adaptive safe zone on a transparent
#                              canvas. Used as adaptive_icon_foreground over a
#                              solid brand plate.
#
# Neither may carry transparent padding: padding plus a white plate is what put
# a white edge around the icon on every platform. Run this, then
# `dart run flutter_launcher_icons` from app/, and commit both.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
branding="$repo_root/app/assets/branding"
source_svg="$branding/hayer_icon.svg"
chrome="${HAYER_CHROME:-google-chrome}"

# The fraction of the canvas the adaptive foreground art may occupy. Android
# masks an adaptive icon to the middle 72/108 of its layers and animates within
# that, so art beyond ~0.66 risks being clipped on round or squircle masks.
safe_zone=0.56

command -v "$chrome" >/dev/null || {
  echo "render-icons: need a Chrome binary; set HAYER_CHROME" >&2
  exit 1
}
python3 -c 'import PIL' 2>/dev/null || {
  echo "render-icons: need Python Pillow" >&2
  exit 1
}

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# The foreground drops the one full-bleed background rect; everything else is
# the art itself.
python3 - "$source_svg" "$work/full.svg" "$work/fore.svg" <<'PY'
import re
import sys

source, full_out, fore_out = sys.argv[1:4]
svg = open(source, encoding='utf-8').read()
background = '<rect width="1024" height="1024" fill="url(#bg)"/>'
if background not in svg:
    raise SystemExit('render-icons: background rect not found in the source SVG')
open(full_out, 'w', encoding='utf-8').write(svg)
open(fore_out, 'w', encoding='utf-8').write(svg.replace(background, ''))
PY

render() {
  local svg="$1" out="$2"
  cp "$svg" "$work/render.svg"
  cat > "$work/render.html" <<'HTML'
<!doctype html>
<meta charset="utf-8">
<style>html,body{margin:0;padding:0;background:transparent}img{display:block}</style>
<img src="render.svg" width="1024" height="1024">
HTML
  "$chrome" --headless --disable-gpu --no-sandbox --hide-scrollbars \
    --force-device-scale-factor=1 --default-background-color=00000000 \
    --window-size=1024,1024 --screenshot="$out" \
    "file://$work/render.html" >/dev/null 2>&1
  [ -s "$out" ] || { echo "render-icons: Chrome produced no $out" >&2; exit 1; }
}

render "$work/full.svg" "$work/full.png"
render "$work/fore.svg" "$work/fore.png"

python3 - "$work/full.png" "$work/fore.png" "$branding" "$safe_zone" <<'PY'
import sys

from PIL import Image

full_png, fore_png, branding, safe_zone = sys.argv[1:5]
safe_zone = float(safe_zone)
size = 1024

full = Image.open(full_png).convert('RGB')
if full.size != (size, size):
    full = full.resize((size, size), Image.LANCZOS)
for corner in ((0, 0), (size - 1, 0), (0, size - 1), (size - 1, size - 1)):
    red, green, blue = full.getpixel(corner)
    if (red, green, blue) == (255, 255, 255):
        raise SystemExit(f'render-icons: {corner} came out white, not brand colour')
full.save(f'{branding}/hayer_icon.png')

# Centre the art itself rather than the canvas it was drawn on: the drawing
# sits low and left of centre, and an adaptive icon is masked about its middle.
fore = Image.open(fore_png).convert('RGBA')
if fore.size != (size, size):
    fore = fore.resize((size, size), Image.LANCZOS)
box = fore.getbbox()
if box is None:
    raise SystemExit('render-icons: the foreground rendered empty')
art = fore.crop(box)
scale = (size * safe_zone) / max(art.size)
art = art.resize(
    (max(1, round(art.width * scale)), max(1, round(art.height * scale))),
    Image.LANCZOS,
)
canvas = Image.new('RGBA', (size, size), (0, 0, 0, 0))
canvas.paste(art, ((size - art.width) // 2, (size - art.height) // 2), art)
canvas.save(f'{branding}/hayer_icon_foreground.png')

print(f'render-icons: wrote hayer_icon.png and hayer_icon_foreground.png ({art.size[0]}x{art.size[1]} art)')
PY
