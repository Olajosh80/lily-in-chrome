#!/usr/bin/env bash
# Build the Chrome Web Store upload zip from extension/.
# The archive has manifest.json at its ROOT (CWS requires that), and keeps the
# manifest "key" so the published item ID matches the dev ID.
set -euo pipefail
cd "$(dirname "$0")/.."
VER="$(node -p "require('./extension/manifest.json').version")"
mkdir -p dist
find extension -name '.DS_Store' -delete 2>/dev/null || true
ZIP="dist/lily-in-chrome-$VER.zip"
rm -f "$ZIP"
( cd extension && zip -rq "../$ZIP" . -x '*.DS_Store' '*/.git/*' )
echo "built $ZIP ($(du -h "$ZIP" | cut -f1))"
