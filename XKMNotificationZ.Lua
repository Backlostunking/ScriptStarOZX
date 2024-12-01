--[[
used:
local Notifications = loadstring(game:HttpGet(""))()

Notifications.Notify({
    Title = "🔥 Welcome!",
    Description = "This is a notification!",
    Duration = 5
})

Notifications.Notify({
    Title = "Info",
    Description = "You can now stack up to 6 notifications!",
    Duration = 5
})
--]]

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- ScreenGui Setup
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "MaxNotifGui"
NotifGui.IgnoreGuiInset = true
NotifGui.Parent = RunService:IsStudio() and Player.PlayerGui or game:GetService("CoreGui")

-- Container
local Container = Instance.new("Frame")
Container.Name = "NotificationContainer"
Container.AnchorPoint = Vector2.new(1, 1)
Container.Position = UDim2.new(1, -20, 1, -20)
Container.Size = UDim2.new(0.3, 0, 0.8, 0)
Container.BackgroundTransparency = 1
Container.ClipsDescendants = true
Container.Parent = NotifGui

-- Constants
local Padding = 10
local CachedNotifications = {}
local TweenTime = 0.3
local TweenStyle = Enum.EasingStyle.Quint
local TweenDirection = Enum.EasingDirection.Out

-- Utility Functions
local function CalculateBounds()
    local totalHeight = 0
    for _, notif in ipairs(CachedNotifications) do
        totalHeight += notif.AbsoluteSize.Y + Padding
    end
    return totalHeight
end

local function CreateRoundFrame()
    local Frame = Instance.new("Frame")
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Frame.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame

    return Frame
end

local function CreateShadow()
    local Shadow = Instance.new("ImageLabel")
    Shadow.Image = "rbxassetid://5761498316"
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(17, 17, 283, 283)
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.ImageTransparency = 0.4
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    return Shadow
end

local function CreateTitle(Text)
    local Title = Instance.new("TextLabel")
    Title.Text = Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    return Title
end

local function CreateDescription(Text)
    local Desc = Instance.new("TextLabel")
    Desc.Text = Text
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 14
    Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    Desc.BackgroundTransparency = 1
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextWrapped = true
    return Desc
end

-- Fade Out Effect
local function FadeOutAfter(Notification, Duration)
    task.wait(Duration)

    local FadeTween = TweenService:Create(Notification, TweenInfo.new(0.5, TweenStyle, TweenDirection), {
        BackgroundTransparency = 1
    })
    FadeTween:Play()

    for _, Descendant in ipairs(Notification:GetDescendants()) do
        if Descendant:IsA("TextLabel") then
            TweenService:Create(Descendant, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
        elseif Descendant:IsA("ImageLabel") then
            TweenService:Create(Descendant, TweenInfo.new(0.5), { ImageTransparency = 1 }):Play()
        end
    end

    FadeTween.Completed:Wait()
    Notification:Destroy()

    for i, notif in ipairs(CachedNotifications) do
        if notif == Notification then
            table.remove(CachedNotifications, i)
            break
        end
    end
end

-- Notification Function
local function Notify(Properties)
    Properties = typeof(Properties) == "table" and Properties or {}
    local Title = Properties.Title or "Notification"
    local Description = Properties.Description or ""
    local Duration = Properties.Duration or 5

    -- Calculate Height
    local TotalHeight = 50 -- Base height
    if Description ~= "" then
        local DescSize = TextService:GetTextSize(Description, 14, Enum.Font.Gotham, Vector2.new(Container.AbsoluteSize.X - Padding * 2, math.huge))
        TotalHeight += DescSize.Y + 10
    end

    -- Create Notification
    local NewNotification = CreateRoundFrame()
    NewNotification.Size = UDim2.new(1, 0, 0, TotalHeight)
    NewNotification.Position = UDim2.new(1, 0, 1, -CalculateBounds() - Padding * (#CachedNotifications + 1))
    NewNotification.AnchorPoint = Vector2.new(1, 1)

    -- Title
    local TitleLabel = CreateTitle(Title)
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.Parent = NewNotification

    -- Description
    if Description ~= "" then
        local DescLabel = CreateDescription(Description)
        DescLabel.Size = UDim2.new(1, -20, 0, TotalHeight - 35)
        DescLabel.Position = UDim2.new(0, 10, 0, 30)
        DescLabel.Parent = NewNotification
    end

    -- Shadow
    local Shadow = CreateShadow()
    Shadow.Parent = NewNotification

    -- Add to Container
    NewNotification.Parent = Container
    table.insert(CachedNotifications, NewNotification)

    -- Animate In
    local ShowTween = TweenService:Create(NewNotification, TweenInfo.new(TweenTime, TweenStyle, TweenDirection), {
        Position = UDim2.new(1, 0, 1, -CalculateBounds())
    })
    ShowTween:Play()

    -- Fade Out After Duration
    coroutine.wrap(FadeOutAfter)(NewNotification, Duration)
end

-- Module Return
return {
    Notify = Notify
}
