local UILibrary = {}

-- Create a Draggable Window
function UILibrary:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    
    ScreenGui.Parent = game.CoreGui
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Active = true
    MainFrame.Draggable = true -- Makes the UI Movable (PC Only)

    -- Add Mobile Dragging
    local UIS = game:GetService("UserInputService")
    local dragging, dragInput, startPos, dragStart

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Title Label
    TitleLabel.Parent = MainFrame
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)

    -- Close Button
    CloseButton.Parent = MainFrame
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- UI Toggle Keybind (H to Show/Hide UI)
    local isVisible = true
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.H then
            isVisible = not isVisible
            MainFrame.Visible = isVisible
        end
    end)

    return MainFrame
end

-- Create a Button
function UILibrary:CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.Size = UDim2.new(0, 150, 0, 40)
    Button.Position = UDim2.new(0.5, -75, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.Text = text

    Button.MouseButton1Click:Connect(function()
        callback()
    end)

    return Button
end

-- Create a Toggle Button
function UILibrary:CreateToggle(parent, text, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = parent
    Toggle.Size = UDim2.new(0, 150, 0, 40)
    Toggle.Position = UDim2.new(0.5, -75, 0, 100)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.Font = Enum.Font.SourceSansBold
    Toggle.TextSize = 16
    Toggle.Text = text

    local toggled = false
    Toggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        Toggle.BackgroundColor3 = toggled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(40, 40, 40)
        callback(toggled)
    end)

    return Toggle
end

-- Create Notification System
function UILibrary:CreateNotification(message, duration)
    local ScreenGui = Instance.new("ScreenGui")
    local NotificationFrame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")

    ScreenGui.Parent = game.CoreGui
    NotificationFrame.Parent = ScreenGui
    NotificationFrame.Size = UDim2.new(0, 300, 0, 50)
    NotificationFrame.Position = UDim2.new(1, -310, 1, -60)
    NotificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    
    TextLabel.Parent = NotificationFrame
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = message
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextSize = 14
    TextLabel.BackgroundTransparency = 1

    -- Slide in animation
    NotificationFrame:TweenPosition(
        UDim2.new(1, -310, 1, -110),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )

    task.wait(duration or 3)

    -- Fade out animation
    for i = 1, 10 do
        NotificationFrame.BackgroundTransparency = NotificationFrame.BackgroundTransparency + 0.1
        task.wait(0.05)
    end

    NotificationFrame:Destroy()
end

return UILibrary
