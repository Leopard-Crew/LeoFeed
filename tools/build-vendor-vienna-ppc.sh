#!/bin/sh
set -eu

SRC_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VENDOR_SRC="$SRC_ROOT/vendor/vienna-rss"
WORK_SRC="/tmp/LeoFeed-Vienna-src"
SYMROOT="/tmp/LeoFeed-Vienna-build"
OBJROOT="/tmp/LeoFeed-Vienna-obj"

echo "Preparing temporary Vienna build source..."
rm -rf "$WORK_SRC" "$SYMROOT" "$OBJROOT"
mkdir -p "$WORK_SRC"

rsync -a "$VENDOR_SRC/" "$WORK_SRC/"

echo "Building Vienna vendor baseline for Leopard/PPC..."
cd "$WORK_SRC"

xcodebuild \
  -project Vienna.xcodeproj \
  -configuration Deployment \
  -sdk macosx10.5 \
  GCC_VERSION=4.2 \
  ARCHS=ppc \
  ONLY_ACTIVE_ARCH=YES \
  SYMROOT="$SYMROOT" \
  OBJROOT="$OBJROOT"

echo "Build completed."
echo "App:"
echo "$SYMROOT/Deployment/Vienna.app"
