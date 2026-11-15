#!/bin/sh
# Print a YouTube video's captions as "[m:ss] text" lines.
# Usage: youtube-transcript.sh <url> [language-code]   (default: en)
# Exit 1 when no captions could be fetched; yt-dlp's reason is on stderr.
set -eu

url=${1:?usage: youtube-transcript.sh <url> [language-code]}
lang=${2:-en}

command -v yt-dlp >/dev/null || {
  echo "yt-dlp is not installed" >&2
  exit 127
}

dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT

# The default player clients often return no captions ("PO token" warning) or
# "page needs to be reloaded", so ask as android_vr, then tv.
# Languages are named exactly: a pattern like "en.*" also requests every
# translation and gets rate-limited (HTTP 429).
for client in android_vr tv; do
  yt-dlp --extractor-args "youtube:player_client=$client" --skip-download \
    --write-subs --write-auto-subs --sub-langs "$lang,$lang-orig" \
    --sub-format json3 -o "$dir/%(id)s" "$url" >&2 || true
  file=$(find "$dir" -name '*.json3' | head -n 1)
  [ -n "$file" ] && break
done

[ -n "$file" ] || {
  echo "no '$lang' captions fetched for $url" >&2
  exit 1
}

python3 -I -c '
import json, sys
for e in json.load(open(sys.argv[1])).get("events", []):
    t = "".join(s.get("utf8", "") for s in e.get("segs", [])).replace("\n", " ").strip()
    ms = e.get("tStartMs", 0)
    if t: print("[%d:%02d] %s" % (ms // 60000, ms // 1000 % 60, t))
' "$file"
