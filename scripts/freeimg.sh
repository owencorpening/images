#!/bin/bash
# freeimg - open Google Images restricted to Unsplash, Pexels, Pixabay

if [ $# -eq 0 ]; then
  echo "Usage: freeimg <search terms>"
  exit 1
fi

query="$*"
sites='site:unsplash.com OR site:pexels.com OR site:pixabay.com'

# URL encode using Python
encoded=$(python3 - <<PY
import sys, urllib.parse
print(urllib.parse.quote(sys.argv[1]))
PY
"$query $sites")

url="https://www.google.com/search?q=${encoded}&tbm=isch"

xdg-open "$url" >/dev/null 2>&1 &
