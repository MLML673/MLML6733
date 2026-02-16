local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove all accessories from character
local function RemoveAccessories(character)
    if not character then return end
    
    for _, accessory in ipairs(character:GetDescendants()) do
        if accessory:IsA("Accessory") then
            accessory:Destroy()
        end
    end
    
    character.DescendantAdded:Connect(function(child)
        if child:IsA("Accessory") then
            child:Destroy()
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Accessory") then
                item:Destroy()
            end
        end
    end)
end

if LocalPlayer.Character then
    RemoveAccessories(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(RemoveAccessories)

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Killer_Toggles"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame with gradient and stroke
local MainFrame = Instance.new("Frame")
MainFrame.Name = "SpeedBooster"
MainFrame.Size = UDim2.new(0, 180, 0, 100) -- Smaller size
MainFrame.Position = UDim2.new(0, 20, 0, 20) -- Moved to corner
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Main frame corner
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- Gradient effect
local UIGradient = Instance.new("UIGradient", MainFrame)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
})
UIGradient.Rotation = 45

-- Animated white stroke
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.new(1, 1, 1)
Stroke.Thickness = 2
Stroke.Transparency = 0.3

-- Animate the stroke
local shineAnimation = RunService.Heartbeat:Connect(function()
    UIGradient.Offset = Vector2.new((tick() % 2) - 1, 0)
end)

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 20)
TitleLabel.Position = UDim2.new(0, 10, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "orangefish booster"
TitleLabel.TextColor3 = Color3.new(1, 0, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame



-- Speed Row
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 50, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED:"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Name = "SpeedBox"
SpeedBox.Size = UDim2.new(0, 60, 0, 22)
SpeedBox.Position = UDim2.new(0, 65, 0, 39)
SpeedBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
SpeedBox.Text = "22.5"
SpeedBox.TextColor3 = Color3.new(1, 0, 0)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 12
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = MainFrame

local SpeedBoxCorner = Instance.new("UICorner", SpeedBox)
SpeedBoxCorner.CornerRadius = UDim.new(0, 4)

local SpeedBoxStroke = Instance.new("UIStroke", SpeedBox)
SpeedBoxStroke.Color = Color3.new(1, 0, 0)
SpeedBoxStroke.Thickness = 1

-- Jump Row
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(0, 50, 0, 20)
JumpLabel.Position = UDim2.new(0, 10, 0, 65)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "JUMP:"
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Font = Enum.Font.Gotham
JumpLabel.TextSize = 12
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpLabel.Parent = MainFrame

local JumpBox = Instance.new("TextBox")
JumpBox.Name = "JumpBox"
JumpBox.Size = UDim2.new(0, 60, 0, 22)
JumpBox.Position = UDim2.new(0, 65, 0, 64)
JumpBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
JumpBox.Text = "35"
JumpBox.TextColor3 = Color3.new(1, 0, 0)
JumpBox.Font = Enum.Font.Gotham
JumpBox.TextSize = 12
JumpBox.ClearTextOnFocus = false
JumpBox.Parent = MainFrame

local JumpBoxCorner = Instance.new("UICorner", JumpBox)
JumpBoxCorner.CornerRadius = UDim.new(0, 4)

local JumpBoxStroke = Instance.new("UIStroke", JumpBox)
JumpBoxStroke.Color = Color3.new(1, 0, 0)
JumpBoxStroke.Thickness = 1

-- Toggle Button (Improved)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleBooster"
ToggleButton.Size = UDim2.new(0, 40, 0, 16)
ToggleButton.Position = UDim2.new(1, -50, 0, 8)
ToggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
ToggleButton.Text = ""
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(0, 8)

-- Toggle Background (Shows state)
local ToggleBackground = Instance.new("Frame", ToggleButton)
ToggleBackground.Size = UDim2.new(1, 0, 1, 0)
ToggleBackground.BackgroundColor3 = Color3.new(0.8, 0, 0) -- Red when off
ToggleBackground.BackgroundTransparency = 0.3
ToggleBackground.ZIndex = 0
Instance.new("UICorner", ToggleBackground).CornerRadius = UDim.new(0, 8)

-- Toggle Knob
local Knob = Instance.new("Frame", ToggleButton)
Knob.Name = "ToggleKnob"
Knob.Size = UDim2.new(0, 12, 0, 12)
Knob.Position = UDim2.new(0, 2, 0.5, 0)
Knob.AnchorPoint = Vector2.new(0, 0.5)
Knob.BackgroundColor3 = Color3.new(1, 1, 1)
Knob.ZIndex = 2
Knob.Parent = ToggleButton

local KnobCorner = Instance.new("UICorner", Knob)
KnobCorner.CornerRadius = UDim.new(0, 6)

-- Knob glow effect
local KnobGlow = Instance.new("ImageLabel", Knob)
KnobGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
KnobGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
KnobGlow.BackgroundTransparency = 1
KnobGlow.Image = "rbxassetid://8992231221"
KnobGlow.ImageColor3 = Color3.new(1, 1, 1)
KnobGlow.ImageTransparency = 0.7
KnobGlow.ScaleType = Enum.ScaleType.Slice
KnobGlow.SliceScale = 0.1

-- Status indicator
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 40, 0, 12)
StatusLabel.Position = UDim2.new(1, -50, 0, 26)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "OFF"
StatusLabel.TextColor3 = Color3.new(1, 0, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- Booster State
local BoosterEnabled = false
local SpeedValue = 22.5
local JumpValue = 35

local TweenInfoSmooth = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenInfoBounce = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Toggle Logic
ToggleButton.MouseButton1Click:Connect(function()
    BoosterEnabled = not BoosterEnabled
    
    local targetColor = BoosterEnabled and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
    local targetPos = BoosterEnabled and UDim2.new(1, -14, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    local statusText = BoosterEnabled and "ON" or "OFF"
    local statusColor = BoosterEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
    -- Animate toggle
    TweenService:Create(ToggleBackground, TweenInfoSmooth, { BackgroundColor3 = targetColor }):Play()
    TweenService:Create(Knob, TweenInfoBounce, { Position = targetPos }):Play()
    TweenService:Create(StatusLabel, TweenInfoSmooth, { TextColor3 = statusColor }):Play()
    
    -- Bounce effect on knob
    TweenService:Create(Knob, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, 16, 0, 16) }):Play()
    task.wait(0.1)
    TweenService:Create(Knob, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, 12, 0, 12) }):Play()
    
    StatusLabel.Text = statusText
    
    -- Pulse effect on frame when turned on
    if BoosterEnabled then
        TweenService:Create(Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Thickness = 3 }):Play()
        task.wait(0.3)
        TweenService:Create(Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Thickness = 2 }):Play()
    end
end)

-- Update values when typing
SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(SpeedBox.Text)
        if num and num > 0 then
            SpeedValue = num
            -- Feedback animation
            TweenService:Create(SpeedBoxStroke, TweenInfo.new(0.2), { Color = Color3.new(0, 1, 0) }):Play()
            task.wait(0.2)
            TweenService:Create(SpeedBoxStroke, TweenInfo.new(0.2), { Color = Color3.new(1, 0, 0) }):Play()
        else
            SpeedBox.Text = tostring(SpeedValue)
        end
    end
end)
JumpBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(JumpBox.Text)
        if num and num > 0 then
            JumpValue = num
            TweenService:Create(JumpBoxStroke, TweenInfo.new(0.2), { Color = Color3.new(0, 1, 0) }):Play()
            task.wait(0.2)
            TweenService:Create(JumpBoxStroke, TweenInfo.new(0.2), { Color = Color3.new(1, 0, 0) }):Play()
        else
            JumpBox.Text = tostring(JumpValue)
        end
    end
end)
RunService.Heartbeat:Connect(function()
    if not BoosterEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    if humanoid.MoveDirection.Magnitude > 0 then
        rootPart.Velocity = Vector3.new(
            humanoid.MoveDirection.X * SpeedValue,
            rootPart.Velocity.Y,
            humanoid.MoveDirection.Z * SpeedValue
        )
    end
    humanoid.UseJumpPower = true
    humanoid.JumpPower = JumpValue
end)
local dragging = false
local dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
      
        TweenService:Create(MainFrame, TweenInfo.new(0.1), { BackgroundTransparency = 0.3 }):Play()
    
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                TweenService:Create(MainFrame, TweenInfo.new(0.1), { BackgroundTransparency = 0.2 }):Play()
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
MainFrame.MouseEnter:Connect(function()
    TweenService:Create(Stroke, TweenInfo.new(0.2), { Transparency = 0.1 }):Play()
end)
MainFrame.MouseLeave:Connect(function()
    TweenService:Create(Stroke, TweenInfo.new(0.2), { Transparency = 0.3 }):Play()
end)
