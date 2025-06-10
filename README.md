## mcs

**Version 1**
Lots of features, maybe some bugs... but if there are no more bugs mcs will be open source.

## Installation

No compiling needed but the code is open sourced soon.. install it with:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/emexos/mcs/main/install.sh)"
```

* The installer checks for **mpv**

  * If you don’t have it, you can choose to let the script install it via Homebrew
* Installs everything under `~/.config/mcs`

## Usage

```bash
mcs <command|name> [args]
```

### Commands

* `mcs help` (or `-h`, `--help`) Show this help

* `mcs <name>` Play a song you’ve added

* `mcs list` List all songs and playlists

* `mcs add <name> <url>` Add a new song

* `mcs remove <name>` Delete a song

* `mcs rename <old> <new>` Rename a song (updates playlists, too)

* Playlist management:

  * `mcs playlist create <pl>`
  * `mcs playlist add <pl> <name>`
  * `mcs playlist remove <pl> <name>`
  * `mcs playlist list`
  * `mcs playlist play <pl>`

* Press **q** to quit the program.

## How It Works

*  Uses **cJSON** to store everything in `msongs.json` (in `~/.config/mcs`)
*  Every action gets logged to `mcs.log` (timestamped)
*  Backups of your JSON are made before any change (`.bak`)
*  Forks off **mpv** for playback so the UI never blocks

## Requirements

* Unix-like OS (Linux/macOS)
* **mpv** (audio-only mode)
* **cJSON** library
* `bash`, `curl`, `mv`, `mkdir`, etc...
