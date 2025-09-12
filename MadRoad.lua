if game.GameId == 7939389895 then
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
local Tab1 = window:CreateTab({Name = "Main Settings", Icon = 'rbxassetid://7733765307'})




Settings:CreateColorPicker({Text = "Color Picker",Default = Color3.new(0.866667, 0.203922, 1),Callback = function(Color)
	print(Color)
end})

Settings:CreateBind({Text = "Press Keybind",Hold = false,Default = Enum.KeyCode.F,CallBack = function()
	print('Keybind Fired!') -- fires when the keybind is pressed.
end})

Settings:CreateBind({Text = "Hold Keybind",Hold = true,Default = Enum.KeyCode.E,CallBack = function(isHolding)
	print('Holding: ',isHolding) -- fires when the keybind is press and unpressed, with isHolding being what state it's in.
end})


Tab1:CreateLabel("Win")
local SliderValue = 500

Tab1:CreateSlider({Text = "Speed Tween", Default = 500, Minimum = 50, Maximum = 1000, Callback = function(Value)
end})
Tab1:CreateToggle({Text = "Auto Win [Premium]",Default = false,Callback = function(Value)
end})
Tab1:CreateLabel("Play")
Tab1:CreateToggle({
    Text = "Super Jump",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Value then
                humanoid.JumpPower = 150
            else
                humanoid.JumpPower = 50
            end
        end
    end
})
Tab1:CreateToggle({
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
Tab1:CreateToggle({
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
Tab1:CreateToggle({
    Text = "Unblock Camera",
    Default = false,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera

        if value then
            _G.UnblockCam = true
            player.CameraMode = Enum.CameraMode.Classic
            player.CameraMinZoomDistance = 0.5
            player.CameraMaxZoomDistance = 1000
        else
            _G.UnblockCam = false
            player.CameraMode = Enum.CameraMode.LockFirstPerson
            player.CameraMinZoomDistance = 0.5
            player.CameraMaxZoomDistance = 0.5
        end
    end
})
Tab1:CreateLabel("Teleport")
Tab1:CreateButton({Text = "Teleport To Car",Callback = function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    local function findBasePartRecursive(model)
        if model:IsA("BasePart") then
            return model
        elseif model:IsA("Model") then
            if model.PrimaryPart then
                return model.PrimaryPart
            end
            for _, child in pairs(model:GetChildren()) do
                local part = findBasePartRecursive(child)
                if part then
                    return part
                end
            end
        end
        return nil
    end

    local function findTrain()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:lower():find("car_truck") then
                local basePart = findBasePartRecursive(v)
                if basePart then
                    return basePart
                end
            end
        end
        return nil
    end

    local function findNearestChair(position)
        local nearestSeat = nil
        local nearestDist = math.huge
        for _, seat in pairs(workspace:GetDescendants()) do
            if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
                local dist = (seat.Position - position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestSeat = seat
                end
            end
        end
        return nearestSeat
    end

    local targetPart = findTrain()
    if targetPart then
        character:MoveTo(targetPart.Position + Vector3.new(0, 5, 0))
        wait(0.5)
        local chair = findNearestChair(targetPart.Position)
        if chair then
            chair:Sit(character:FindFirstChildOfClass("Humanoid"))
        else
            warn("Không tìm thấy ghế gần Train.")
        end
    else
        warn("Không tìm thấy BasePart trong model chứa 'Train'.")
    end
end})
Tab1:CreateButton({Text = "Teleport To Starting",Callback = function()
local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(-20.54305648803711, 4.689598560333252, -47.02955627441406)
        end
end})
Tab1:CreateButton({Text = "Tween To Military Base",Callback = function()
local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local targetCFrame = CFrame.new(251.45944213867188, 4.509633541107178, 5475.53759765625)
            local distance = (hrp.Position - targetCFrame.Position).Magnitude
            local time = distance / 500
            local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end
end})
else
print("Fail"
end
