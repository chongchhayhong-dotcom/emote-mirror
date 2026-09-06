# Security Audit — 7yd7 Emotes Mirror

Audited on 2026-09-06. Files reviewed:

- `Emotes.lua` (main script, ~8,450 lines)
- `lib/Notify.lua`, `lib/Settings.lua`, `lib/OpenEmote.lua` (remotely-loaded modules)
- `data/*.json` (data lists, not code)

## How the original worked

The main script used `SafeLoad(url)` → `game:HttpGet(url)` → `loadstring(content)`
to download and **execute** 3 remote Lua files from the author's GitHub:

1. `Notify.lua` — notification UI (defines `getgenv().Notify`)
2. `Settings.lua` — settings window UI
3. `OpenEmote.lua` — mobile on-screen emote button

Because those URLs pointed at the author's repositories (`7yd7/...`), the author
could replace their contents at any time and every user would run the new code
on next injection — a classic **supply-chain / remote-code-update risk**.

## What the audit checked for

- ✅ No `.ROBLOSECURITY` / cookie / password access
- ✅ No clipboard abuse (only the Discord invite is copied, via a button)
- ✅ No `MarketplaceService:PromptPurchase` / Robux prompts
- ✅ No `hookfunction`/`hookmetamethod`/`setreadonly`/`getfenv` tampering
- ✅ No `os.execute`/`io.popen` or shell access
- ✅ Library files (`lib/*.lua`) contain no `loadstring`, no `HttpGet`, no
  external URLs at all — they are pure UI code
- ✅ File writes (`writefile`) are scoped to the `7yd7/` config/cache folder
  (settings, favorites, cached images) — standard behaviour
- ✅ The JSON endpoints are decoded as data only; their contents are never
  executed (`JSONDecode`, asset IDs used as numbers)

## Conclusion

No backdoor, credential stealer, or purchase prompt was found in the current
versions. **However**, the original design trusts the author's remote files.

This mirror eliminates that risk: the 3 executable modules are frozen inside
`lib/`, and all URLs point at *your own* repository. To stay safe:

- Keep the `lib/*.lua` files as they are (they were the audit subjects).
- If you ever update them from upstream, re-read them before committing.
- Do not add new `loadstring(game:HttpGet(...))` calls.
