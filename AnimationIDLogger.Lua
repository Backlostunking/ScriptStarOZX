-- feel free to modify or edit this to More batter, I make this only 23 minutes that why is gui frame it so simple, anyway Happy Coding ❤️
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local currentAnimTrack = nil
local guiparent
if gethui then
guiparent = gethui()
else
guiparent = game:GetService("CoreGui") or LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
end
if guiparent:FindFirstChild("AnimationLogger") then
    guiparent:FindFirstChild("AnimationLogger"):Destroy()
end
local ScreenGui = Instance.new("ScreenGui", guiparent)
ScreenGui.Name = "AnimationLogger"
local ButtonX = Instance.new("TextButton", ScreenGui)
    ButtonX.Size = UDim2.new(0, 35, 0, 30)
    ButtonX.Text = "X"
    ButtonX.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ButtonX.Font = Enum.Font.SourceSans
    ButtonX.TextSize = 16
    ButtonX.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonX.Position = UDim2.new(0.57, 0, 0, 0)
    ButtonX.MouseButton1Click:Connect(function()
     ScreenGui:Destroy()
    end)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 300)
MainFrame.Position = UDim2.new(0.5, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Animation Logger | ScripterMrbacon"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, 0, 0.5, -10)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
local PlayFrame = Instance.new("Frame", MainFrame)
PlayFrame.Size = UDim2.new(1, 0, 0, 50)
PlayFrame.Position = UDim2.new(0, 0, 0.7, 0)
PlayFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local TextBox = Instance.new("TextBox", PlayFrame)
TextBox.Size = UDim2.new(0.7, -5, 1, 0)
TextBox.Position = UDim2.new(0.05, 0, 0, 0)
TextBox.PlaceholderText = "Enter Animation ID..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextWrapped = true
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 18
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local PlayButton = Instance.new("TextButton", PlayFrame)
PlayButton.Size = UDim2.new(0.25, 0, 1, 0)
PlayButton.Position = UDim2.new(0.75, 0, 0, 0)
PlayButton.Text = "▶ Play"
PlayButton.TextWrapped = true
PlayButton.Font = Enum.Font.SourceSansBold
PlayButton.TextSize = 18
PlayButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
local function logAnimation(animationId)
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Text == animationId then
            return
        end
    end
    local Button = Instance.new("TextButton", ScrollingFrame)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Text = animationId
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.MouseButton1Click:Connect(function()
        setclipboard(animationId)
       Button.Text = "Copied Animation Id!"
        task.wait(0.4)
     Button.Text = animationId
    end)
    Button.MouseButton2Click:Connect(function()
        TextBox.Text = animationId
        PlayButton:Activate()
    end)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end
local function detectAnimations()
    if not Humanoid then return end Humanoid.AnimationPlayed:Connect(function(animationTrack)
   if animationTrack and animationTrack.Animation then
            local animationId = animationTrack.Animation.AnimationId
            if animationId and animationId ~= "" then
                logAnimation(animationId)
            end
        end
    end)
end
local function toggleAnimation(animationId)
    if not Humanoid then return end
    if currentAnimTrack then
        currentAnimTrack:Stop()
        currentAnimTrack = nil
        PlayButton.Text = "▶ Play"
        PlayButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. animationId
        currentAnimTrack = Humanoid:LoadAnimation(animation)
        currentAnimTrack:Play()
        PlayButton.Text = "▶ Stop"
        PlayButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end
PlayButton.MouseButton1Click:Connect(function()
local SavePlayButton = PlayButton.Text
    local animId = TextBox.Text:match("%d+")
    if animId then
        toggleAnimation(animId)
    else
     PlayButton.Text = "Invalid Animation ID!"
        task.wait(0.4)
    PlayButton.Text = SavePlayButton
    end
end)
detectAnimations()
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    detectAnimations()
end)
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 100, 0, 40)
OpenButton.Position = UDim2.new(0.5, -60, 0, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenButton.Text = "Open Animation"
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.TextSize = 16
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
local AnimationsFrame = Instance.new("Frame", ScreenGui)
AnimationsFrame.Size = UDim2.new(0, 320, 0, 450)
AnimationsFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
AnimationsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
AnimationsFrame.BorderSizePixel = 0
AnimationsFrame.Visible = false
local ScrollingFrame = Instance.new("ScrollingFrame", AnimationsFrame)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -10)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 5)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
local function logAnimation(animationId)
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Text == animationId then
            return
        end
    end
    local Button = Instance.new("TextButton", ScrollingFrame)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Text = animationId
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.MouseButton1Click:Connect(function()
        setclipboard(animationId)
        Button.Text = "Copied Animation Id!"
        task.wait(0.4)
      Button.Text = animationId
    end)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end
local function detectAllAnimations()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("Animation") then
            logAnimation(obj.AnimationId)
        end
    end
end
OpenButton.MouseButton1Click:Connect(function()
    if AnimationsFrame.Visible then
        AnimationsFrame.Visible = false
OpenButton.Text = "Open Animation"
    else
        detectAllAnimations()
        AnimationsFrame.Visible = true
     OpenButton.Text = "Close"
    end
end)
