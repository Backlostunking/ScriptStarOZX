local UILibrary = {}

local UIS = game:GetService("UserInputService")

-- Create a Draggable Window
function UILibrary:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local Container = Instance.new("ScrollingFrame") -- SCROLLABLE CONTAINER!
    local UIListLayout = Instance.new("UIListLayout")

    ScreenGui.Parent = game.CoreGui
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Active = true
    MainFrame.Draggable = true -- PC Dragging

    -- Mobile Dragging Support
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

    -- Title Bar
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

    -- UI Toggle (Press "H")
    local isVisible = true
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.H then
            isVisible = not isVisible
            MainFrame.Visible = isVisible
        end
    end)

    -- SCROLLING FRAME (Handles Overflow)
    Container.Parent = MainFrame
    Container.Size = UDim2.new(1, 0, 1, -40)
    Container.Position = UDim2.new(0, 0, 0, 40)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 6

    -- Auto Layout (Stack UI elements)
    UIListLayout.Parent = Container
    UIListLayout.Padding = UDim.new(0, 10)

    -- Auto-Adjust Scroll Size
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)

    return Container
end

-- Create a Button
function UILibrary:CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.Size = UDim2.new(0.9, 0, 0, 40)
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

-- Create a Toggle
function UILibrary:CreateToggle(parent, text, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = parent
    Toggle.Size = UDim2.new(0.9, 0, 0, 40)
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

-- Create a Slider
function UILibrary:CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    local SliderLabel = Instance.new("TextLabel")
    local Slider = Instance.new("TextButton")

    SliderFrame.Parent = parent
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 40)
    SliderFrame.BackgroundTransparency = 1

    SliderLabel.Parent = SliderFrame
    SliderLabel.Size = UDim2.new(1, 0, 0, 20)
    SliderLabel.Text = text .. ": " .. default
    SliderLabel.TextColor3 = Color3.new(1, 1, 1)
    SliderLabel.TextSize = 14
    SliderLabel.BackgroundTransparency = 1

    Slider.Parent = SliderFrame
    Slider.Size = UDim2.new(0.9, 0, 0, 20)
    Slider.Position = UDim2.new(0.05, 0, 0.5, 0)
    Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Slider.Text = ""

    Slider.MouseButton1Click:Connect(function()
        local newValue = math.random(min, max)
        SliderLabel.Text = text .. ": " .. newValue
        callback(newValue)
    end)

    return SliderFrame
end

-- Create a Textbox
function UILibrary:CreateTextbox(parent, placeholder, callback)
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = parent
    TextBox.Size = UDim2.new(0.9, 0, 0, 40)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.Font = Enum.Font.SourceSansBold
    TextBox.TextSize = 16
    TextBox.PlaceholderText = placeholder

    TextBox.FocusLost:Connect(function()
        callback(TextBox.Text)
    end)

    return TextBox
end

return UILibrary
