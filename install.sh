#!/bin/bash
cd "$(dirname "$0")"
exec > >(tee install.log) 2>&1
clang -arch arm64 -mmacosx-version-min=14.0 -dynamiclib -fobjc-arc -framework AppKit -Wl,-undefined,dynamic_lookup -o InspectorRefresh.dylib InspectorRefresh.m && codesign -s - -f InspectorRefresh.dylib && echo BUILD_OK || exit 1
P="$HOME/Library/Application Support/SpliceKit/plugins/inspector-refresh"
mkdir -p "$P" && cp InspectorRefresh.dylib "$P/InspectorRefresh.tmp" && mv -f "$P/InspectorRefresh.tmp" "$P/InspectorRefresh.dylib" && cat > "$P/plugin.json" <<'J'
{ "id": "local.inspectorrefresh", "name": "Inspector Refresh", "version": "1.0.0",
  "description": "Fixes Scale/Position doing nothing on clips just dropped into the timeline: gives them their own Transform and refreshes the Inspector.",
  "author": "local", "apiVersion": 1, "entry": { "native": "InspectorRefresh.dylib" }, "methods": [], "dependencies": [] }
J
echo "INSTALLED - restart Final Cut Pro (SpliceKit) to load it"
