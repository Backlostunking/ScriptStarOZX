-- feel free to modify or edit this and you can save it, i make it like 5 hours, but enjoy if this is a good notification ❤️
--[[
here if need to use it!
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/IfXDarkNotification.Lua"))()
createNotification("Title", "message", 5) -- the number is duration enjoy ❤️
]]
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local guiParent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
local gui = guiParent:FindFirstChild("DarkNotiGui") or Instance.new("ScreenGui", guiParent)
gui.Name = "DarkNotiGui"
gui.DisplayOrder = math.huge
_G.notificationStack = _G.notificationStack or {}
function createNotification(title, message, duration)
    duration = duration or 5
    local notiFrame = Instance.new("Frame")
    notiFrame.Size = UDim2.new(0, 270, 0, 70)
    notiFrame.Position = UDim2.new(1, 10, 1, -130)
    notiFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notiFrame.BorderSizePixel = 0
    notiFrame.Parent = gui
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notiFrame
    local glowEffect = Instance.new("ImageLabel")
    glowEffect.Size = UDim2.new(1, 20, 1, 20)
    glowEffect.Position = UDim2.new(0, -10, 0, -10)
    glowEffect.BackgroundTransparency = 1
    glowEffect.Image = "rbxassetid://5108535323"
    glowEffect.ImageColor3 = Color3.fromRGB(0, 0, 0)
    glowEffect.ImageTransparency = 0.7
    glowEffect.Parent = notiFrame
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = title
    titleLabel.Parent = notiFrame
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 0, 40)
    messageLabel.Position = UDim2.new(0, 10, 0, 25)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.TextWrapped = true
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.Text = message
    messageLabel.Parent = notiFrame
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -30, 0, 5)
    closeButton.Text = "X"
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local timeBar = Instance.new("Frame")
    timeBar.Size = UDim2.new(1, 0, 0, 4.1)
    timeBar.Position = UDim2.new(0, 0, 1, -4)
    timeBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    timeBar.BorderSizePixel = 0
    timeBar.Parent = notiFrame
    local timeBarCorner = Instance.new("UICorner", timeBar)
    timeBarCorner.CornerRadius = UDim.new(1, 0)
    task.spawn(function()
      while timeBar.Parent do
        TweenService:Create(timeBar, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
        task.wait(1)
        TweenService:Create(timeBar, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(85, 85, 85)}):Play()
    end
end)
local permFrame = Instance.new("Frame")
permFrame.Size = UDim2.new(1, 4, 1, 4)
permFrame.Position = UDim2.new(0, -2, 0, -2)
permFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
permFrame.BackgroundTransparency = 0.6
permFrame.BorderSizePixel = 0
permFrame.Parent = notiFrame
local permFrameCorner = Instance.new("UICorner", permFrame)
permFrameCorner.CornerRadius = UDim.new(0, 10)
TweenService:Create(timeBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 4)}):Play()
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = notiFrame
    notiFrame.BackgroundTransparency = 1
    glowEffect.ImageTransparency = 1
    titleLabel.TextTransparency = 1
    messageLabel.TextTransparency = 1
    closeButton.TextTransparency = 1
    TweenService:Create(notiFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
    TweenService:Create(glowEffect, TweenInfo.new(0.5), {ImageTransparency = 0.7}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(messageLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(closeButton, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    table.insert(_G.notificationStack, {frame = notiFrame, time = tick()})
    for i, data in ipairs(_G.notificationStack) do
        local frame = data.frame
        local targetPosition = UDim2.new(1, -280, 1, -130 - ((i - 1) * 80))
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = targetPosition}):Play()
    end
    TweenService:Create(notiFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -280, 1, -130 - ((#_G.notificationStack - 1) * 80))}):Play()
    local isClosing = false
    local function closeNotification(notiFrame, timeBar, glowEffect, titleLabel, messageLabel, closeButton, duration)
    if notiFrame:GetAttribute("isClosing") then return end
    notiFrame:SetAttribute("isClosing", true)
    local shouldWait = duration > 0
    TweenService:Create(notiFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -130)}):Play()
    TweenService:Create(notiFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(glowEffect, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(messageLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(closeButton, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    if shouldWait then task.wait(0.5) end
    notiFrame:Destroy()
    for i, data in ipairs(_G.notificationStack) do
        if data.frame == notiFrame then
            table.remove(_G.notificationStack, i)
            break
        end
    end
    local otherClosing = false
    for _, data in ipairs(_G.notificationStack) do
        if data.frame:GetAttribute("isClosing") then
            otherClosing = true
            break
        end
    end
    if not otherClosing then
        task.wait(0.1)
        for i, data in ipairs(_G.notificationStack) do
            local frame = data.frame
            local targetPosition = UDim2.new(1, -280, 1, -130 - ((i - 1) * 80))
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = targetPosition}):Play()
        end
    end
end
closeButton.MouseButton1Click:Connect(function()
    TweenService:Create(timeBar, TweenInfo.new(0.4), {Size = UDim2.new(0, 0, 0, 4)}):Play()
    closeNotification(notiFrame, timeBar, glowEffect, titleLabel, messageLabel, closeButton, duration)
end)
if duration > 0 then
    task.delay(duration, function()
        if not notiFrame:GetAttribute("isClosing") then
            closeNotification(notiFrame, timeBar, glowEffect, titleLabel, messageLabel, closeButton, duration)
        end
    end)
  end
return createNotification
end
