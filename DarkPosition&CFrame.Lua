-- feel free to modify or edit and you can save it too i happy to see you, happy coding bro ❤️
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local isUsingPosition = true
local guiParent
if gethui then
    guiParent = gethui()
elseif syn and syn.protect_gui then
    guiParent = game:GetService("CoreGui")
else
    guiParent = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
end
if guiParent:FindFirstChild("DarkPositionGui") then
    guiParent:FindFirstChild("DarkPositionGui"):Destroy()
end
local gui = Instance.new("ScreenGui")
gui.Name = "DarkPositionGui"
gui.Parent = guiParent
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundTransparency = 1
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.12, 0)
title.BackgroundTransparency = 1
title.Text = "Position & CFrame GUI | ScripterMrbacon"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame
local posBox = Instance.new("TextLabel")
posBox.Size = UDim2.new(0.9, 0, 0.2, 0)
posBox.Position = UDim2.new(0.05, 0, 0.15, 0)
posBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
posBox.Text = "0, 0, 0"
posBox.TextSize = 14
posBox.TextColor3 = Color3.fromRGB(255, 255, 255)
posBox.Font = Enum.Font.Gotham
posBox.TextWrapped = true
posBox.Parent = frame
local uiCornerBox = Instance.new("UICorner")
uiCornerBox.CornerRadius = UDim.new(0, 5)
uiCornerBox.Parent = posBox
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.12, 0, 0.12, 0)
closeButton.Position = UDim2.new(0.88, 0, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame
closeButton.MouseButton1Click:Connect(function()
    for _, v in pairs(frame:GetDescendants()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            TweenService:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                TextTransparency = 1
            }):Play()
        end
    end
    TweenService:Create(frame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.4)
    gui:Destroy()
end)
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.4, 0, 0.13, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Text = name
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Parent = frame
    local uiCornerBtn = Instance.new("UICorner")
    uiCornerBtn.CornerRadius = UDim.new(0, 5)
    uiCornerBtn.Parent = button
    button.MouseButton1Click:Connect(callback)
    return button
end
createButton("Check", UDim2.new(0.05, 0, 0.42, 0), function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        if isUsingPosition then
            posBox.Text = string.format("%.2f, %.2f, %.2f", root.Position.X, root.Position.Y, root.Position.Z)
        else
            posBox.Text = tostring(root.CFrame)
        end
    end
end)
createButton("Teleport", UDim2.new(0.55, 0, 0.42, 0), function()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(loadstring("return " .. posBox.Text)())
    end
end)
createButton("Copy", UDim2.new(0.05, 0, 0.57, 0), function()
    if setclipboard then
        setclipboard(posBox.Text)
    end
end)
createButton("Copy With TP", UDim2.new(0.55, 0, 0.57, 0), function()
    if setclipboard then setclipboard("game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(" .. posBox.Text .. ")")
    end
end)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.4, 0, 0.13, 0)
toggleButton.Position = UDim2.new(0.3, 0, 0.75, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Text = "Value: Position"
toggleButton.TextSize = 14
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = frame
local uiCornerToggle = Instance.new("UICorner")
uiCornerToggle.CornerRadius = UDim.new(0, 5)
uiCornerToggle.Parent = toggleButton
toggleButton.MouseButton1Click:Connect(function()
    isUsingPosition = not isUsingPosition
    if isUsingPosition then
        toggleButton.Text = "Value: Position"
    else
        toggleButton.Text = "Value: CFrame"
    end
end)
TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.new(0.4, 0, 0.55, 0),
    Position = UDim2.new(0.3, 0, 0.2, 0),
    BackgroundTransparency = 0
}):Play()
local dragging, dragInput, dragStart, startPos  
local function updateDrag(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)  
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPos}):Play()
end  
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)
