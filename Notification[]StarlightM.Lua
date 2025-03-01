--[[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Notification%5B%5DStarlightM.Lua"))()
Usage: AddXNotification("Hello, This is a Notification!")
AddXNotification("notification with duration", 3)
--]]

-- Variables
local TweenService = game:GetService("TweenService")

-- Create Notification UI
local function createNotificationUI()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WxNotification"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = math.huge
    -- Frame (Notification Container)
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.2, 10, 0.1, 10) -- Slim and compact
    frame.Position = UDim2.new(0.5, 0, 0.85, 0) -- Centered and near the bottom
    frame.AnchorPoint = Vector2.new(0.5, 0.5) -- Ensures proper centering
    frame.BackgroundColor3 = Color3.new(1, 1, 1) -- White background
    frame.BackgroundTransparency = 1 -- Fully transparent at start
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true -- Prevents overflow

    -- Rounded Corners
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0.8, 0) -- Full rounded edges

    -- Text Label (Message)
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Position = UDim2.new(0, 0, 0, -5)
    textLabel.Size = UDim2.new(1, 0, 1, 10) -- Fills the frame
    textLabel.BackgroundTransparency = 1 -- No background for text
    textLabel.TextTransparency = 1 -- Fully transparent at start
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.new(0, 0, 0) -- Black text
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 19.00 -- Smaller text for compact look
    textLabel.TextScaled = false
    textLabel.TextWrapped = true -- Wraps long text within the container

    return screenGui, frame, textLabel
end

-- Fade-In and Fade-Out Animation
function AddXNotification(text,duration)
    duration = duration or 2 -- Default duration is 2 seconds

    -- Create Notification UI
    local screenGui, NotificationFrame, NotificationLabel = createNotificationUI()
    screenGui.Parent = gethui() or game.CoreGui

    -- Set Text
    NotificationLabel.Text = text

    -- Fade-In Animation
    local fadeInFrame = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0 -- Frame becomes visible
    })
    local fadeInText = TweenService:Create(NotificationLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0 -- Text becomes visible
    })

    fadeInFrame:Play()
    fadeInText:Play()
    fadeInFrame.Completed:Wait()

    -- Display for the specified duration
    task.wait(duration)

    -- Fade-Out Animation
    local fadeOutFrame = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1 -- Frame fades out
    })
    local fadeOutText = TweenService:Create(NotificationLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1 -- Text fades out
    })

    fadeOutFrame:Play()
    fadeOutText:Play()
    fadeOutFrame.Completed:Wait()

    -- Clean up after animation
    screenGui:Destroy()
end
