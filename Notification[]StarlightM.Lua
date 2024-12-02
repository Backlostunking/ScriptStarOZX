--[[
used it!
local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/XXX.Lua"))()

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
-- Notifications Library
local Notifications = {}

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Local Player
local Player = Players.LocalPlayer

-- Create ScreenGui
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "EpicNotifications"
NotifGui.IgnoreGuiInset = true
NotifGui.Parent = RunService:IsStudio() and Player.PlayerGui or game:GetService("CoreGui")

-- Notification Container
local Container = Instance.new("Frame")
Container.Name = "NotificationContainer"
Container.AnchorPoint = Vector2.new(1, 1)
Container.Position = UDim2.new(0.98, 0, 0.85, 0) -- Slightly higher for stacking
Container.Size = UDim2.new(0.3, 0, 0.7, 0) -- Max width 30%, height 70%
Container.BackgroundTransparency = 1
Container.ClipsDescendants = true
Container.Parent = NotifGui

-- UIListLayout for Automatic Stacking
local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = Container

-- Constants
local TweenTime = 0.3
local TweenStyle = Enum.EasingStyle.Quad
local TweenDirection = Enum.EasingDirection.Out
local NotificationsList = {}

-- Function to Create Notification
local function CreateNotification(Text, Duration, ImageId)
    -- Notification Frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 60) -- Full width with padding, fixed height
    Frame.BackgroundTransparency = 0
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark base color
    Frame.LayoutOrder = #NotificationsList + 1
    Frame.ClipsDescendants = true
    Frame.Parent = Container

    -- Gradient Background
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)), -- Dark
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), -- Red
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30)) -- Dark
    })
    Gradient.Rotation = 90
    Gradient.Parent = Frame

    -- Animate Gradient Rotation
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

    -- Stroke Outline
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(255, 255, 255) -- White stroke
    Stroke.Parent = Frame

    -- Optional Image
    if ImageId then
        local Image = Instance.new("ImageLabel", Frame)
        Image.Size = UDim2.new(0, 50, 0, 50)
        Image.Position = UDim2.new(0, 5, 0.5, 0)
        Image.AnchorPoint = Vector2.new(0, 0.5)
        Image.BackgroundTransparency = 1
        Image.Image = "rbxassetid://" .. ImageId
    end

    -- Text Label
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = Text
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 16
    TextLabel.TextTransparency = 0
    TextLabel.TextStrokeTransparency = 0.8
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, ImageId and -70 or -20, 1, 0) -- Adjust for image if present
    TextLabel.Position = UDim2.new(ImageId and 0.18 or 0.05, 0, 0, 0) -- Offset for image
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    TextLabel.Parent = Frame

    return Frame, TextLabel
end

-- Animate Notification
local function AnimateNotification(Frame, TextLabel, Duration)
    -- Slide In
    local TweenIn = TweenService:Create(Frame, TweenInfo.new(TweenTime, TweenStyle, TweenDirection), {
        BackgroundTransparency = 0
    })
    TweenIn:Play()

    -- Fade In Text
    TweenService:Create(TextLabel, TweenInfo.new(0.5, TweenStyle, TweenDirection), {TextTransparency = 0}):Play()

    -- Wait, then Slide Out to the Right and Fade
    task.wait(Duration or 4)
    local FadeOutTween = TweenService:Create(Frame, TweenInfo.new(0.5, TweenStyle, TweenDirection), {
        BackgroundTransparency = 1,
        Position = UDim2.new(2, 0, Frame.Position.Y.Scale, Frame.Position.Y.Offset) -- Slide out to the right
    })
    local TextFadeTween = TweenService:Create(TextLabel, TweenInfo.new(0.5, TweenStyle, TweenDirection), {TextTransparency = 1})
    FadeOutTween:Play()
    TextFadeTween:Play()

    -- Cleanup
    FadeOutTween.Completed:Wait()
    Frame:Destroy()
    table.remove(NotificationsList, table.find(NotificationsList, Frame))
end

-- Add Notification Function
function Notifications.Notify(Properties)
    local Text = Properties.Text or "Notification"
    local Duration = Properties.Duration or 5
    local ImageId = Properties.ImageId

    local Notification, TextLabel = CreateNotification(Text, Duration, ImageId)
    table.insert(NotificationsList, Notification)
    coroutine.wrap(AnimateNotification)(Notification, TextLabel, Duration)
end

return Notifications
