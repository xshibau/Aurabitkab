local keyData = loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkab/refs/heads/main/Keystone.lua"))()
local script_key = keyData.script_key or ""
local Scripts = {
    ["7939389895"] = "Mad_Road.lua",

}
function isPremiumKey(key)
    for _, v in ipairs(keyData.PremiumKeys) do
        if v == key then return true end
    end
    return false
end
function getBlacklistReason(key)
    return keyData.BlacklistKeys[key]
end
if not script_key or getBlacklistReason(script_key) then
    game:GetService("Players").LocalPlayer:Kick(getBlacklistReason(script_key) or "Key bị chặn")
    return
end
if isPremiumKey(script_key) then
    id = Scripts[tostring(game.GameId)]
    if id then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkat/refs/heads/main/" .. id .. ".lua"))()
    end
else
    game:GetService("Players").LocalPlayer:Kick("Invalid Key")
end
