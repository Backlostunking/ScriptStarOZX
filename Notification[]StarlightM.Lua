--[[
used it!
local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Notification%5B%5DStarlightM.Lua"))()

Notifications.Notify({
    Text = "🔥 Epic Notification!",
    Duration = 5,
    ImageId = "123456789" -- Replace with your ImageId (optional)
})

Notifications.Notify({
    Text = "🔥 Smooth Animations!",
    Duration = 4
})
--]]
-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- Create ScreenGui
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "GradientTextNotifications"
NotifGui.IgnoreGuiInset = true
NotifGui.Parent = RunService:IsStudio() and Player.PlayerGui or game:GetService("CoreGui")

-- Notification Container
local Container = Instance.new("Frame")
Container.Name = "NotificationContainer"
Container.AnchorPoint = Vector2.new(1, 1)
Container.Position = UDim2.new(1, -20, 0.85, 0) -- Bottom-right corner
Container.Size = UDim2.new(0.3, 0, 0.7, 0) -- Max width 30%, height 70%
Container.BackgroundTransparency = 1
Container.ClipsDescendants = true
Container.Parent = NotifGui

-- UIListLayout for Automatic Positioning
local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = Container

-- Library Table
local Notifications = {}

-- Constants
local TweenTime = 0.5
local TweenStyle = Enum.EasingStyle.Quint
local TweenDirection = Enum.EasingDirection.Out
local NotificationQueue = {}

-- Function to Create Notification
function Notifications:CreateNotification(Properties)
    -- Notification Frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 60) -- Full width with padding, fixed height
    Frame.BackgroundTransparency = 0
    Frame.LayoutOrder = #NotificationQueue + 1
    Frame.Position = UDim2.new(2, 0, 0, 0) -- Start off-screen to the right
    Frame.ClipsDescendants = true
    Frame.Parent = Container

    -- Gradient Background
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)), -- Dark
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), -- Red
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20)) -- Dark
    })
    Gradient.Rotation = 90
    Gradient.Parent = Frame

    -- Animate Gradient
    task.spawn(function()
        while Frame.Parent do
            for i = 0, 360, 1 do
                Gradient.Rotation = i
                task.wait(0.02)
            end
        end
    end)

    -- Rounded Corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame

    -- Stroke
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(255, 255, 255) -- White outline
    Stroke.Parent = Frame

    -- Optional Image
    if Properties.ImageId then
        local Image = Instance.new("ImageLabel", Frame)
        Image.Size = UDim2.new(0, 50, 0, 50)
        Image.Position = UDim2.new(0, 5, 0.5, 0)
        Image.AnchorPoint = Vector2.new(0, 0.5)
        Image.BackgroundTransparency = 1
        Image.Image = "rbxassetid://" .. Properties.ImageId
    end

    -- Text Label
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = Properties.Text or "Notification"
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 16
    TextLabel.TextTransparency = 0 -- Initially fully visible
    TextLabel.TextStrokeTransparency = 0.8 -- Slight text stroke
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, Properties.ImageId and -70 or -20, 1, 0) -- Adjust for image if present
    TextLabel.Position = UDim2.new(Properties.ImageId and 0.18 or 0.05, 0, 0, 0) -- Offset for image
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    TextLabel.Parent = Frame

    return Frame, TextLabel
end

-- Animate Notification
function Notifications:AnimateNotification(Frame, TextLabel, Duration)
    -- Slide In
    local SlideIn = TweenService:Create(Frame, TweenInfo.new(TweenTime, TweenStyle, TweenDirection), {
        Position = UDim2.new(1, 0, 0, 0) -- Move into the container
    })
    SlideIn:Play()

    -- Wait, then Slide Out to the Right and Fade
    task.wait(Duration or 4)
    local SlideOut = TweenService:Create(Frame, TweenInfo.new(0.5, TweenStyle, TweenDirection), {
        Position = UDim2.new(2, 0, Frame.Position.Y.Scale, Frame.Position.Y.Offset), -- Move off-screen to the right
        BackgroundTransparency = 1 -- Fade out
    })
    local TextFadeOut = TweenService:Create(TextLabel, TweenInfo.new(0.5, TweenStyle, TweenDirection), {TextTransparency = 1})
    SlideOut:Play()
    TextFadeOut:Play()

    -- Cleanup
    SlideOut.Completed:Wait()
    Frame:Destroy()
    table.remove(NotificationQueue, table.find(NotificationQueue, Frame))
end

-- Add Notification
function Notifications:Notify(Properties)
    local Frame, TextLabel = self:CreateNotification(Properties)
    table.insert(NotificationQueue, Frame)
    coroutine.wrap(function()
        self:AnimateNotification(Frame, TextLabel, Properties.Duration)
    end)()
end

-- Return Library
return Notifications
