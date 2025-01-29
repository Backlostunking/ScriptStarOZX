local UILibrary = {}

-- Create a draggable window
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
    
    TitleLabel.Parent = MainFrame
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    
    CloseButton.Parent = MainFrame
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    return MainFrame
end

-- Create a button
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

-- Create a toggle button
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

-- Return the library
return UILibrary
