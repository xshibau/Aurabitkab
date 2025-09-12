--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "RainbowLoader"
loaderGui.Parent = player:WaitForChild("PlayerGui")
loaderGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.15)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = loaderGui

local rainbowBorder = Instance.new("Frame")
rainbowBorder.Size = UDim2.new(1, 6, 1, 6)
rainbowBorder.Position = UDim2.new(0, -3, 0, -3)
rainbowBorder.BackgroundTransparency = 1
rainbowBorder.BorderSizePixel = 0
rainbowBorder.ZIndex = 0
rainbowBorder.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Text = "AURA HUB"
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SciFi
title.TextSize = 24
title.TextStrokeTransparency = 0.7
title.ZIndex = 2
title.Parent = mainFrame

local keyInput = Instance.new("TextBox")
keyInput.PlaceholderText = "ENTER ACCESS KEY"
keyInput.Size = UDim2.new(0.8, 0, 0.25, 0)
keyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
keyInput.BackgroundColor3 = Color3.new(0.1, 0.1, 0.18)
keyInput.BackgroundTransparency = 0.2
keyInput.TextColor3 = Color3.new(1, 1, 1)
keyInput.Font = Enum.Font.RobotoMono
keyInput.TextSize = 16
keyInput.Text = ""
keyInput.ZIndex = 2
keyInput.Parent = mainFrame

local submitButton = Instance.new("TextButton")
submitButton.Text = "LOAD"
submitButton.Size = UDim2.new(0.3, 0, 0.25, 0)
submitButton.Position = UDim2.new(0.35, 0, 0.7, 0)
submitButton.BackgroundColor3 = Color3.new(0, 0.3, 0.5)
submitButton.TextColor3 = Color3.new(1, 1, 1)
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 14
submitButton.AutoButtonColor = false
submitButton.ZIndex = 2
submitButton.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Text = "AWAITING KEY"
statusText.Size = UDim2.new(1, 0, 0.2, 0)
statusText.Position = UDim2.new(0, 0, 0.85, 0)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.new(0.8, 0.8, 1)
statusText.Font = Enum.Font.Code
statusText.TextSize = 12
statusText.ZIndex = 2
statusText.Parent = mainFrame

local rainbowParts = {}
for i = 1, 6 do
    local part = Instance.new("Frame")
    part.Size = UDim2.new(0.2, 0, 0.05, 0)
    part.Position = UDim2.new(0, 0, 0, -5)
    part.BorderSizePixel = 0
    part.ZIndex = 1
    part.Parent = rainbowBorder
    
    rainbowParts[i] = part
end

task.spawn(function()
    local colors = {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),      --Red
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)), -- Orange 
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)), -- Yellow
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),    -- Green
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),    -- Blue
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(128, 0, 128))   -- Purple 
    }
    
    while loaderGui.Parent do
        for i, colorKey in ipairs(colors) do
            for j, part in ipairs(rainbowParts) do
                local targetColor = colors[((i + j - 2) % #colors) + 1].Value
                TweenService:Create(
                    part,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = targetColor}
                ):Play()
            end
            task.wait(0.15)
        end
    end
end)

task.spawn(function()
    local hue = 0
    while loaderGui.Parent do
        hue = (hue + 0.01) % 1
        title.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
        task.wait(0.05)
    end
end)

submitButton.MouseEnter:Connect(function()
    TweenService:Create(
        submitButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = UDim2.new(0.32, 0, 0.27, 0), Position = UDim2.new(0.34, 0, 0.69, 0)}
    ):Play()
end)

submitButton.MouseLeave:Connect(function()
    TweenService:Create(
        submitButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {Size = UDim2.new(0.3, 0, 0.25, 0), Position = UDim2.new(0.35, 0, 0.7, 0)}
    ):Play()
end)

keyInput.Focused:Connect(function()
    TweenService:Create(
        keyInput,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundColor3 = Color3.new(0.15, 0.15, 0.25)}
    ):Play()
end)

keyInput.FocusLost:Connect(function()
    TweenService:Create(
        keyInput,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundColor3 = Color3.new(0.1, 0.1, 0.18)}
    ):Play()
end)

local function loadMainScript()
    local tweenOut = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.35, 0, -0.3, 0), BackgroundTransparency = 1}
    )
    
    -- Радужный эффект кнопки при загрузке
    task.spawn(function()
        local hue = 0
        while loaderGui.Parent do
            hue = (hue + 0.05) % 1
            submitButton.BackgroundColor3 = Color3.fromHSV(hue, 0.9, 0.8)
            task.wait(0.03)
        end
    end)
    
    statusText.Text = "LOADING..."
    tweenOut:Play()
    tweenOut.Completed:Wait()
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Image = "rbxthumb://type=Asset&id=106019376492019&w=420&h=420"
getgenv().ToggleUI = "LeftControl"

task.spawn(function()
    if not getgenv().LoadedMobileUI then
        getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        OpenUI.Name = "OpenUI"
        OpenUI.Parent = game:GetService("CoreGui")
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ImageButton.Parent = OpenUI
        ImageButton.BackgroundColor3 = Color3.fromRGB(105, 105, 105)
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.5, 0, 0, 0)
        ImageButton.Size = UDim2.new(0, 50, 0, 50)
        ImageButton.Image = getgenv().Image
        ImageButton.Draggable = true
        ImageButton.Transparency = 1
        UICorner.CornerRadius = UDim.new(100)
        UICorner.Parent = ImageButton
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().ToggleUI, false, game)
        end)
    end
end)
local summitLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vovabro46/DinasMenu/refs/heads/main/DinasMenus.lua"))()

local window = summitLib:CreateWindow({Name = "Aura Hub [Premium]",AccentColor3 = Color3.new(1, 0.235294, 0.337255)})
local Tab1 = window:CreateTab({Name = "Script Settings", Icon = 'rbxassetid://7733765307'})
Tab1:CreateButton({Text = "🟢 | 99 Night In Forest",Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xshibau/Aurabitkab/refs/heads/main/99NightInForset.lua"))()
end})
  
    loaderGui:Destroy()
end

-- YOUR KEYS
local validKeys = {
    "RXD8R-S0EBU-N0TWI-U1L3R-O3MW4"
}

submitButton.MouseButton1Click:Connect(function()
    -- Анимация нажатия
    local clickTween = TweenService:Create(
        submitButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad),
        {Size = UDim2.new(0.28, 0, 0.23, 0), Position = UDim2.new(0.36, 0, 0.71, 0)}
    )
    
    clickTween:Play()
    clickTween.Completed:Wait()
    
    TweenService:Create(
        submitButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Back),
        {Size = UDim2.new(0.32, 0, 0.27, 0), Position = UDim2.new(0.34, 0, 0.69, 0)}
    ):Play()
    
    local inputKey = keyInput.Text
    
    local isValid = false
    for _, key in ipairs(validKeys) do
        if inputKey == key then
            isValid = true
            break
        end
    end
    
    if isValid then
        statusText.Text = "KEY ACCEPTED"
        statusText.TextColor3 = Color3.new(0, 1, 0.5)
        
        -- Плавное скрытие элементов
        TweenService:Create(
            keyInput,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad),
            {BackgroundTransparency = 1, TextTransparency = 1}
        ):Play()
        
        TweenService:Create(
            title,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {TextTransparency = 1}
        ):Play()
        
        task.wait(0.3)
        loadMainScript()
    else
        statusText.Text = "INVALID KEY!"
        statusText.TextColor3 = Color3.new(1, 0.3, 0.3)
        
        -- Анимация ошибки
        local errorTween = TweenService:Create(
            keyInput,
            TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 3, true),
            {Position = UDim2.new(0.11, 0, 0.4, 0)}
        )
        errorTween:Play()
        
        keyInput.Text = ""
        keyInput:CaptureFocus()
        
        task.wait(1)
        statusText.Text = "AWAITING KEY"
        statusText.TextColor3 = Color3.new(0.8, 0.8, 1)
    end
end)

keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        submitButton:Activate()
    end
end)

task.wait(0.5)
keyInput:CaptureFocus()

mainFrame.Position = UDim2.new(0.35, 0, -0.3, 0)
mainFrame.BackgroundTransparency = 1
title.TextTransparency = 1
keyInput.BackgroundTransparency = 1
keyInput.TextTransparency = 1
submitButton.BackgroundTransparency = 1
submitButton.TextTransparency = 1
statusText.TextTransparency = 1

local appearTween = TweenService:Create(
    mainFrame,
    TweenInfo.new(0.7, Enum.EasingStyle.Back),
    {Position = UDim2.new(0.35, 0, 0.4, 0), BackgroundTransparency = 0.3}
)
appearTween:Play()

appearTween.Completed:Connect(function()
    TweenService:Create(title, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    TweenService:Create(keyInput, TweenInfo.new(0.4), {BackgroundTransparency = 0.2, TextTransparency = 0}):Play()
    TweenService:Create(submitButton, TweenInfo.new(0.4), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    TweenService:Create(statusText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
end)
