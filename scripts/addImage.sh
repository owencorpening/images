#!/bin/bash
# addImage.sh — organize downloaded image into repo using clipboard JSON
# Works with Linux/KDE, handles clipboard, prompts for final name

# --- CONFIG ---
REPO="$HOME/dev/images"
TEMPLATE_DIR="$REPO/template"
DOWNLOAD_DIR="$HOME/Downloads"

# --- READ JSON FROM CLIPBOARD ---
# Try CLIPBOARD first, fall back to PRIMARY
DATA=$(xclip -selection clipboard -o 2>/dev/null || xclip -selection primary -o 2>/dev/null)
if [[ -z "$DATA" ]]; then
  kdialog --error "Clipboard is empty. Run the bookmarklet first."
  exit 1
fi

# --- PARSE JSON USING jq ---
NAME=$(echo "$DATA" | jq -r '.name')
PAGEURL=$(echo "$DATA" | jq -r '.url')
PHOTOGRAPHER=$(echo "$DATA" | jq -r '.photographer')

# --- PROMPT TO CONFIRM OR OVERRIDE NAME ---
NAME=$(kdialog --inputbox "Suggested image name:" "$NAME")
if [[ -z "$NAME" ]]; then
  kdialog --error "No name entered. Exiting."
  exit 1
fi

# --- CREATE DESTINATION FOLDER USING FINAL NAME ---
DEST_DIR="$REPO/$NAME"
mkdir -p "$DEST_DIR"

# --- COPY TEMPLATE FILES ---
cp "$TEMPLATE_DIR/license.txt" "$DEST_DIR/"
cp "$TEMPLATE_DIR/url.txt" "$DEST_DIR/"
cp "$TEMPLATE_DIR/photographer.txt" "$DEST_DIR/"

# --- FILL URL.TXT SAFELY ---
printf "%s" "$PAGEURL" > "$DEST_DIR/url.txt"

# --- FILL LICENSE.TXT BASED ON DOMAIN ---
domain=$(echo "$PAGEURL" | awk -F/ '{print $3}')
case "$domain" in
  unsplash.com) echo "Unsplash License" > "$DEST_DIR/license.txt" ;;
  pexels.com)   echo "Pexels License" > "$DEST_DIR/license.txt" ;;
  pixabay.com)  echo "Pixabay License" > "$DEST_DIR/license.txt" ;;
  *)            echo "Check manually" > "$DEST_DIR/license.txt" ;;
esac

# --- FILL PHOTOGRAPHER.TXT IF AVAILABLE ---
if [[ "$PHOTOGRAPHER" != "null" && "$PHOTOGRAPHER" != "" ]]; then
  echo "$PHOTOGRAPHER" > "$DEST_DIR/photographer.txt"
fi

# --- FIND LATEST DOWNLOADED IMAGE ---
IMAGE_FILE=$(ls -t "$DOWNLOAD_DIR"/*.{jpg,jpeg,png,gif} 2>/dev/null | head -n1)
if [[ -z "$IMAGE_FILE" ]]; then
  kdialog --error "No downloaded image found in $DOWNLOAD_DIR"
  exit 1
fi

# --- COPY IMAGE INTO DESTINATION FOLDER WITH FINAL NAME ---
EXT="${IMAGE_FILE##*.}"
cp "$IMAGE_FILE" "$DEST_DIR/$NAME.$EXT"

# --- DONE ---
kdialog --msgbox "Image saved to $DEST_DIR"

