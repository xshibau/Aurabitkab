local rawData = game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkab/refs/heads/main/Keystone.lua")
local keyDataFunc = loadstring(rawData)
local keyData = keyDataFunc()

local Scripts = {
    ["7939389895"] = "Mad_Road",

}

local function isPremiumKey(key)
    for _, v in ipairs(keyData.PremiumKeys) do
        if v == key then return true end
    end
    return false
end

local function getBlacklistReason(key)
    return keyData.BlacklistKeys and keyData.BlacklistKeys[key]
end

if not script_key or getBlacklistReason(script_key) then
    game:GetService("Players").LocalPlayer:Kick(getBlacklistReason(script_key) or "Key bị chặn")
    return
end

if isPremiumKey(script_key) then
    local id = Scripts[tostring(game.GameId)]
    if id then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkab/refs/heads/main/"..id..".lua"))()
    end
else
    game:GetService("Players").LocalPlayer:Kick("Invalid Key")
end
