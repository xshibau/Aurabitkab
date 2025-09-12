if game.GameId == 7326934954 then
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

local window = summitLib:CreateWindow({Name = "Aura Hub [Freemium]",AccentColor3 = Color3.new(1, 0.235294, 0.337255)})

local Settings = window:CreateTab({Name = "Ui Settings", Icon = 'rbxassetid://7734022041'})
local Premium = window:CreateTab({Name = "Premium Settings", Icon = 'rbxassetid://7733946818'})
local Player = window:CreateTab({Name = "Player Settings", Icon = 'rbxassetid://7743875962'})
local Tab1 = window:CreateTab({Name = "Main Settings", Icon = 'rbxassetid://7733960981'})
local Create = window:CreateTab({Name = "Create Settings", Icon = 'rbxassetid://7743874740'})

Player:CreateLabel("Player")
Player:CreateToggle({
    Text = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        local UserInputService = game:GetService("UserInputService")
        local player = game.Players.LocalPlayer

        if Value then
            _G.InfiniteJump = true
            UserInputService.JumpRequest:Connect(function()
                if _G.InfiniteJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                    player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        else
            _G.InfiniteJump = false
        end
    end
})
Player:CreateToggle({
    Text = "Super Jump",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Value then
                humanoid.JumpPower = 300
            else
                humanoid.JumpPower = 50
            end
        end
    end
})
Player:CreateToggle({
    Text = "Speed Hack",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Value then
                humanoid.WalkSpeed = 100
            else
                humanoid.WalkSpeed = 16
            end
        end
    end
})
Player:CreateLabel("Misc")
Player:CreateButton({
    Text = "Antilag",
    Callback = function()
        sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("WedgePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            end
        end

        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
    end
})

Tab1:CreateLabel("Tree")
Tab1:CreateToggle({
    Text = "Auto Chop TP",
    Default = false,
    Callback = function(v)
        _G.AutoChopTP = v
        local player = game.Players.LocalPlayer
        local UIS = game:GetService("UserInputService")

        if v then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local originalPos = hrp and hrp.CFrame
            task.spawn(function()
                while _G.AutoChopTP do
                    task.wait(0.3)
                    local trees = {}
                    for _, tree in pairs(workspace:GetDescendants()) do
                        if tree:IsA("Model") and tree.Name == "Small Tree" and tree.PrimaryPart then
                            table.insert(trees, tree)
                        end
                    end
                    for _, tree in ipairs(trees) do
                        if not _G.AutoChopTP then break end
                        if hrp and tree.PrimaryPart then
                            hrp.CFrame = tree.PrimaryPart.CFrame + Vector3.new(0,0,-3)
                            UIS.InputBegan:Fire({UserInputType=Enum.UserInputType.MouseButton1, Position=tree.PrimaryPart.Position}, false)
                            task.wait(0.1)
                            UIS.InputEnded:Fire({UserInputType=Enum.UserInputType.MouseButton1, Position=tree.PrimaryPart.Position}, false)
                            task.wait(0.5)
                        end
                    end
                end
                if hrp and originalPos then
                    hrp.CFrame = originalPos
                end
            end)
        else
            _G.AutoChopTP = false
        end
    end
})
Tab1:CreateLabel("Chest")
Tab1:CreateToggle({
    Text = "Auto Chest Nearby",
    Default = false,
    Callback = function(value)
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if not _G.AutoChestNearby then
            _G.AutoChestNearby = {running = false}
        end

        local function getPromptsInRange(range)
            local prompts = {}
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and string.find(obj.Name, "Item Chest") then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = (humanoidRootPart.Position - part.Position).Magnitude
                        if dist <= range then
                            for _, p in ipairs(obj:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then
                                    table.insert(prompts, p)
                                end
                            end
                        end
                    end
                end
            end
            return prompts
        end

        if value then
            if _G.AutoChestNearby.running then return end
            _G.AutoChestNearby.running = true
            task.spawn(function()
                while _G.AutoChestNearby.running do
                    local prompts = getPromptsInRange(20) -- chestRange mặc định = 20
                    for _, prompt in ipairs(prompts) do
                        fireproximityprompt(prompt, math.huge)
                    end
                    task.wait(0.5)
                end
            end)
        else
            _G.AutoChestNearby.running = false
        end
    end
})
Tab1:CreateLabel("Camp")
Tab1:CreateToggle({
    Text = "Auto Fire",
    Default = false,
    Callback = function(value)
        _G.AutoLog = value
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local originalPos = hrp and hrp.CFrame

        if value then
            task.spawn(function()
                while _G.AutoLog do
                    task.wait()
                    for _, m in pairs(workspace:GetDescendants()) do
                        if not _G.AutoLog then break end
                        if m:IsA("Model") and m.Name == "Log" and m.PrimaryPart then
                            if hrp then
                                hrp.CFrame = m.PrimaryPart.CFrame
                                m:SetPrimaryPartCFrame(CFrame.new(0.5406733155250549, 12.499372482299805, -0.718663215637207))
                                task.wait(0.2)
                            end
                        end
                    end
                end
                if hrp and originalPos then
                    hrp.CFrame = originalPos
                end
            end)
        else
            _G.AutoLog = false
        end
    end
})
Tab1:CreateLabel("Cooked")
Tab1:CreateToggle({
    Text = "Auto Cooked",
    Default = false,
    Callback = function(value)
        _G.AutoMorsel = value
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local originalPos = hrp and hrp.CFrame

        if value then
            task.spawn(function()
                while _G.AutoMorsel do
                    task.wait()
                    for _, m in pairs(workspace:GetDescendants()) do
                        if not _G.AutoMorsel then break end
                        if m:IsA("Model") and m.Name == "Morsel" and m.PrimaryPart then
                            if hrp then
                                hrp.CFrame = m.PrimaryPart.CFrame
                                m:SetPrimaryPartCFrame(CFrame.new(0.5406733155250549, 12.499372482299805, -0.718663215637207))
                                task.wait(0.2)
                            end
                        end
                    end
                end
                if hrp and originalPos then
                    hrp.CFrame = originalPos
                end
            end)
        else
            _G.AutoMorsel = false
        end
    end
})
Tab1:CreateLabel("Fly Up")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

local flyUpLoop = false
local flyUpNightLoop = false
local connAllTime
local connNightOnly

Tab1:CreateToggle({
    Text = "Fly Up (All Time)",
    Default = false,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local RunService = game:GetService("RunService")

        local character = player.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end

        flyUpLoop = value
        humanoid.PlatformStand = value

        if value then
            local ray = Ray.new(hrp.Position, Vector3.new(0, -1000, 0))
            local part, pos = workspace:FindPartOnRay(ray, hrp.Parent)
            local targetY = (part and pos.Y or hrp.Position.Y) + 30
            connAllTime = RunService.Heartbeat:Connect(function()
                if not flyUpLoop or not hrp.Parent then return end
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(hrp.Position.X, targetY, hrp.Position.Z)
            end)
        else
            if connAllTime then connAllTime:Disconnect() end
        end
    end
})
Tab1:CreateToggle({
    Text = "Fly Up (Only Night)",
    Default = false,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")

        local character = player.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end

        flyUpNightLoop = value

        if value then
            local currentTime = Lighting.ClockTime
            if currentTime >= 18 or currentTime < 6 then
                humanoid.PlatformStand = true
                local ray = Ray.new(hrp.Position, Vector3.new(0, -1000, 0))
                local part, pos = workspace:FindPartOnRay(ray, hrp.Parent)
                local targetY = (part and pos.Y or hrp.Position.Y) + 30
                connNightOnly = RunService.Heartbeat:Connect(function()
                    if not flyUpNightLoop or not hrp.Parent then return end
                    local t = Lighting.ClockTime
                    if t >= 18 or t < 6 then
                        hrp.Velocity = Vector3.new(0, 0, 0)
                        hrp.CFrame = CFrame.new(hrp.Position.X, targetY, hrp.Position.Z)
                    end
                end)
            else
                FlyUpNightOnlyToggle:SetValue(false)
            end
        else
            if connNightOnly then connNightOnly:Disconnect() end
            humanoid.PlatformStand = false
        end
    end
})
Create:CreateLabel("Coming Soon")


Settings:CreateColorPicker({Text = "Color Picker",Default = Color3.new(0.866667, 0.203922, 1),Callback = function(Color)
	print(Color)
end})

Settings:CreateBind({Text = "Press Keybind",Hold = false,Default = Enum.KeyCode.F,CallBack = function()
	print('Keybind Fired!') -- fires when the keybind is pressed.
end})

Settings:CreateBind({Text = "Hold Keybind",Hold = true,Default = Enum.KeyCode.E,CallBack = function(isHolding)
	print('Holding: ',isHolding) -- fires when the keybind is press and unpressed, with isHolding being what state it's in.
end})


Premium:CreateLabel("Buy Premium To Use This Feature")

else
game:GetService("Players").LocalPlayer:Kick("Load failure")
end
