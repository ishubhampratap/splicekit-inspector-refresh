# Inspector Refresh (SpliceKit plugin)

A small SpliceKit plugin for Final Cut Pro that fixes Transform controls (Scale, Position, Rotation…) doing nothing on clips you have just dragged into the timeline.

## The problem

When you drag a clip (often a still image) from the Browser into the timeline and then change its Scale in the Inspector, the number changes but the picture in the viewer does not. Playback may flicker or show the old size.

## Why it happens

A freshly dropped clip has no Transform effect of its own yet. Final Cut normally creates one the first time you edit it, and until then the Inspector shows a shared placeholder Transform. When that step fails, your Scale/Position edits go into the placeholder instead of the clip, so nothing changes on screen.

## What the plugin does

Right after anything is dropped into the timeline, it:

1. Gives each newly dropped video clip its own default Transform (100%, no visible change).
2. Rebuilds the Inspector so its controls point at that Transform.

It doesn't change your selection, and it skips clips that already have a Transform and audio-only clips.

## Requirements

- Final Cut Pro with [SpliceKit](https://github.com/elliotttate/SpliceKit) installed
- Apple silicon Mac, macOS 14 or later
- Xcode Command Line Tools (`xcode-select --install`) to build from source

## Install

```bash
bash install.sh
```

Then restart Final Cut Pro (the SpliceKit build). The plugin installs to `~/Library/Application Support/SpliceKit/plugins/inspector-refresh/`.

Or use the prebuilt `InspectorRefresh.dylib` from the release: put it in that folder together with `plugin.json`.

## Uninstall

Delete `~/Library/Application Support/SpliceKit/plugins/inspector-refresh/` and restart Final Cut Pro.

## Notes

- Each drop adds one extra "Transform" step to Undo. Pressing Cmd-Z right after a drop first undoes that invisible step, then the drop.
- Log: `~/Library/Logs/SpliceKit/inspector-refresh.log`
- Tested with Final Cut Pro 12.4 and SpliceKit 3.3.9.
