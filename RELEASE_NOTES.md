# Inspector Refresh v1.0.0

## Fixed
- Scale, Position and other Transform controls doing nothing on clips just dragged into the timeline from the Browser. The Inspector value changed but the viewer didn't, and playback could flicker between the old and new values.

## How
- Right after a drop into the timeline, newly dropped video clips get their own default Transform (100%, no visible change).
- The Inspector is then rebuilt so its controls edit that Transform instead of Final Cut's shared placeholder.

## Good to know
- Each drop adds one invisible "Transform" step to Undo; Cmd-Z after a drop undoes that first, then the drop.
- Your selection isn't touched. Clips that already have a Transform, and audio-only clips, are skipped.
- Requires SpliceKit. Tested on Final Cut Pro 12.4 / SpliceKit 3.3.9, Apple silicon, macOS 14+.

## Install
Run `bash install.sh`, then restart Final Cut Pro (SpliceKit build).
