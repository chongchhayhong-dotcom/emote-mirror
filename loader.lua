-- Loader for the self-hosted 7yd7 Emotes mirror.
-- Replace USERNAME / REPO with your GitHub username and repository name,
-- then run this single line in your executor:
--
--   loadstring(game:HttpGet("https://raw.githubusercontent.com/chongchhayhong-dotcom/emotes-mirror/main/Emotes.lua"))()
--
-- (You can also just execute this file directly after editing it.)

local USERNAME = "chongchhayhong-dotcom"
local REPO     = "emotes-mirror"
local BRANCH   = "main"

local url = ("https://raw.githubusercontent.com/%s/%s/refs/heads/%s/Emotes.lua")
    :format(USERNAME, REPO, BRANCH)

local ok, content = pcall(function() return game:HttpGet(url) end)
if not ok or not content or content == "" then
    warn("[EmotesMirror] Failed to download Emotes.lua. Check USERNAME/REPO.")
    return
end

local fn, err = loadstring(content)
if not fn then
    warn("[EmotesMirror] Failed to compile: " .. tostring(err))
    return
end

fn()
