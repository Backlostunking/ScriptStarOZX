--[[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Notification%5B%5DStarlightM.Lua"))()
Usage: AddXNotification("Hello, This is a Notification!")
AddXNotification("Hello! This is a custom notification!", 3)
--]]

-- Variables
local TweenService = game:GetService("TweenService")

-- Create Notification UI
local function createNotificationUI()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UiLibraryNotification"
    screenGui.ResetOnSpawn = false

    -- Frame (Notification Container)
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.25, 0, 0.1, 0) -- Slim and compact
    frame.Position = UDim2.new(0.5, 0, 0.8, 0) -- Centered and near the bottom
    frame.AnchorPoint = Vector2.new(0.5, 0.5) -- Proper centering
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark background
    frame.BackgroundTransparency = 1 -- Initially invisible
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true -- Prevents overflow

    -- Rounded Corners
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0.15, 0) -- Slightly rounded edges

    -- Text Label (Message)
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -10, 1, -10) -- Fills the frame with padding
    textLabel.Position = UDim2.new(0, 5, 0, 5)
    textLabel.BackgroundTransparency = 1 -- No background for text
    textLabel.TextTransparency = 1 -- Fully transparent at start
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 16 -- Compact text
    textLabel.TextScaled = false
    textLabel.TextWrapped = true -- Wraps long text within the container

    return screenGui, frame, textLabel
end

-- Notification Function
function AddXNotification(text, duration)
    duration = duration or 2 -- Default duration is 2 seconds

    -- Create Notification UI
    local screenGui, NotificationFrame, NotificationLabel = createNotificationUI()
    screenGui.Parent = game.CoreGui

    -- Set Text
    NotificationLabel.Text = text

    -- Fade-In Animation
    local fadeInFrame = TweenService:Create(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0 -- Frame becomes visible
    })
    local fadeInText = TweenService:Create(NotificationLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0 -- Text becomes visible
    })

    fadeInFrame:Play()
    fadeInText:Play()
    fadeInFrame.Completed:Wait()

    -- Display for the specified duration
    task.wait(duration)

    -- Fade-Out Animation
    local fadeOutFrame = TweenService:Create(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1 -- Frame fades out
    })
    local fadeOutText = TweenService:Create(NotificationLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1 -- Text fades out
    })

    fadeOutFrame:Play()
    fadeOutText:Play()
    fadeOutFrame.Completed:Wait()

    -- Clean up after animation
    screenGui:Destroy()
end
