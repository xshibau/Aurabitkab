local keyData = loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkat/refs/heads/main/premium_keys.lua"))()
local script_key = keyData.script_key or ""
local Scripts = {
    ["00000000"] = "script1",
    ["11111111"] = "script2"
}
local function isPremiumKey(key)
    for _, v in ipairs(keyData.PremiumKeys) do
        if v == key then
            return true
        end
    end
    return false
end
local function getBlacklistReason(key)
    return keyData.BlacklistKeys[key]
end
if not script_key or getBlacklistReason(script_key) then
    local reason = getBlacklistReason(script_key) or "Key Is Gay"
    game:GetService("Players").LocalPlayer:Kick(reason)
    return
end
if isPremiumKey(script_key) then
    local id = Scripts[tostring(game.GameId)]
    if id then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkab/refs/heads/main/" .. id .. ".lua"))()
    end
else
    game:GetService("Players").LocalPlayer:Kick("Invalid Key")
end
