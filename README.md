# 7yd7 Emotes GUI — Community Mirror (audited & self-hosted)

This is a **self-hosted mirror** of the Roblox "7yd7 | Emote Script" (Emotes GUI).

The original script fetches additional Lua code from the author's GitHub repos at
runtime. That means the author can change those files at any time — including
pushing malicious code later. This mirror removes that risk: **all code and data
is loaded from your own repository**, which you control.

## What was changed

All remote URLs inside `Emotes.lua` were redirected to files inside **this** repo:

| Original remote file | Mirror location |
|---|---|
| `7yd7/Menu-7yd7/.../Off-site/Notify.lua` | `Notify.lua` |
| `7yd7/Hub/.../GUIS/Settings.lua` | `Settings.lua` |
| `7yd7/Hub/.../GUIS/OpenEmote.lua` | `OpenEmote.lua` |
| `7yd7/sniper-Emote/.../EmoteSniper.json` | `EmoteSniper.json` |
| `7yd7/sniper-Emote/.../AnimationSniper.json` | `AnimationSniper.json` |
| `7yd7/sniper-Emote/.../AnimationSniperoffsale.json` | `AnimationSniperoffsale.json` |

The 3 module `.lua` files are the only ones that can execute code — they are
now frozen copies in this repo (flat root folder, easy to upload on mobile). The
3 `.json` files are data only (lists of emote/animation asset IDs: ~52,700
emotes + ~5,600 animations).

## How to use (setup once)

1. Create a new GitHub repository (any name, e.g. `Emotes-Mirror`).
2. Upload **all 9 files** from this folder to the repo root (flat, no subfolders needed):
   `Emotes.lua`, `loader.lua`, `Notify.lua`, `Settings.lua`, `OpenEmote.lua`,
   `EmoteSniper.json`, `AnimationSniper.json`, `AnimationSniperoffsale.json`, `README.md`.
3. Open `Emotes.lua`, find this block near the top and set your username/repo:

```lua
local MIRROR_USER = "USERNAME"   -- <-- your GitHub username
local MIRROR_REPO = "REPO"       -- <-- your repo name
local MIRROR_BRANCH = "main"
```

4. Commit the change. Your loader is then:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/REPO/main/Emotes.lua"))()
```

(Or use `loader.lua` the same way.)

## Security

See [SECURITY.md](SECURITY.md) for the audit report.

## Credits

- Original script: **7yd7** — https://github.com/7yd7/Hub
- Base emote system: Roblox creator docs — https://github.com/Roblox/creator-docs

This mirror is for personal/safety use. Respect the original author's license.
