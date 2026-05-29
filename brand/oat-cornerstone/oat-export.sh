#!/usr/bin/env bash
# OAT Logo Export Pipeline
# Badge source:  ~/dev/images/brand/oat-cornerstone/oatLogoGraniteGold.png
# Banner source: ~/dev/images/brand/oat-cornerstone/oatCornerstoneBuilding.png
# Outputs:       ~/dev/images/brand/oat-cornerstone/exports/

set -e

BADGE="$HOME/dev/images/brand/oat-cornerstone/oatLogoGraniteGold.png"
HERO="$HOME/dev/images/brand/oat-cornerstone/oatCornerstoneBuilding.png"
OUT="$HOME/dev/images/brand/oat-cornerstone/exports"

mkdir -p "$OUT"

echo "OAT Export Pipeline"
echo "  Badge source: $BADGE"
echo "  Hero source:  $HERO"
echo "  Output dir:   $OUT"
echo ""

# ── Square Badge exports (from badge master) ─────────────────────────────────
echo "── Square Badge exports ──"

square_export() {
  local size=$1 label=$2
  convert "$BADGE" -gravity center -extent 1:1 -resize "${size}x${size}" "$OUT/$label"
  echo "  ✓ $label (${size}x${size})"
}

square_export 16   "favicon-16.ico"
square_export 32   "favicon-32.ico"
square_export 64   "favicon-64.png"
square_export 180  "favicon-180.png"
square_export 400  "github-avatar-400.png"
square_export 400  "linkedin-profile-400.png"
square_export 256  "substack-profile-256.png"
square_export 128  "vscode-extension-icon-128.png"
square_export 1024 "app-icon-ios-1024.png"
square_export 512  "app-icon-android-512.png"
square_export 200  "oat-badge-large-200.png"
square_export 100  "oat-badge-small-100.png"

echo ""
echo "── Banner exports (from building hero) ──"

# ── Banner exports (from hero/building master) ────────────────────────────────
banner_export() {
  local w=$1 h=$2 label=$3
  convert "$HERO" -gravity center -resize "${w}x${h}^" \
    -extent "${w}x${h}" "$OUT/$label"
  echo "  ✓ $label (${w}x${h})"
}

banner_export 1584 396  "linkedin-banner-1584x396.png"
banner_export 1456 816  "substack-header-1456x816.png"
banner_export 600  200  "email-header-600x200.png"
banner_export 1500 500  "twitter-banner-1500x500.png"
banner_export 1280 640  "github-profile-banner-1280x640.png"

echo ""
echo "── Complete: 17 exports in $OUT ──"
