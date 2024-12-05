local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI Elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local SelectedPartLabel = Instance.new("TextLabel")
local ButtonContainer = Instance.new("Frame")
local UIGridLayout = Instance.new("UIGridLayout")
local ToggleSelectionButton = Instance.new("TextButton")

-- SelectionBox
local selectionBox = Instance.new("SelectionBox")
selectionBox.Color3 = Color3.fromRGB(0, 255, 0) -- Green highlight color
selectionBox.LineThickness = 0.05
selectionBox.Visible = false
selectionBox.Parent = workspace

-- Parent GUI to PlayerGui
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "PartInteractionGUI"

-- MainFrame Properties
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- TitleLabel Properties
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleLabel.Text = "Part Interaction GUI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.Parent = MainFrame

-- SelectedPartLabel Properties
SelectedPartLabel.Size = UDim2.new(1, -20, 0, 50)
SelectedPartLabel.Position = UDim2.new(0, 10, 0, 60)
SelectedPartLabel.Text = "Selected Part: None/nil"
SelectedPartLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedPartLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SelectedPartLabel.Font = Enum.Font.Gotham
SelectedPartLabel.TextSize = 16
SelectedPartLabel.Parent = MainFrame

-- ButtonContainer Properties
ButtonContainer.Size = UDim2.new(1, -20, 0, 380)
ButtonContainer.Position = UDim2.new(0, 10, 0, 120)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- UIGridLayout Properties
UIGridLayout.CellSize = UDim2.new(0, 160, 0, 40)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.Parent = ButtonContainer

-- Button Template Function
local function createButton(parent, buttonText, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Text = buttonText
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Variables
local selectedPart = nil
local selectionEnabled = false

-- Functions
local function highlightPart(part)
    if part then
        selectionBox.Adornee = part
        selectionBox.Visible = true
    else
        selectionBox.Adornee = nil
        selectionBox.Visible = false
    end
end

local function fireClickDetector(part)
    local clickDetector = part:FindFirstChildOfClass("ClickDetector")
    if clickDetector then
        clickDetector.MouseClick:Fire(LocalPlayer)
    else
        warn("No ClickDetector found on " .. part.Name)
    end
end

local function fireProximityPrompt(part)
    local prompt = part:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        prompt:InputHoldBegin()
        task.wait(1) -- Simulate holding
        prompt:InputHoldEnd()
    else
        warn("No ProximityPrompt found on " .. part.Name)
    end
end

local function fireTouchInterest(part)
    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 1)
    task.wait(0.1)
    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 0)
end

local function copyFireScript(part)
    if part then
        local partPath = part:GetFullName()
        local fireScript = string.format(
            "fireclickdetector(%s)\nfireproximityprompt(%s, 1, true)\nfiretouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, %s, 0)",
            partPath, partPath, partPath
        )
        setclipboard(fireScript)
        warn("Copied fire script to clipboard!")
    else
        warn("No part selected!")
    end
end

-- Mouse Click Event
Mouse.Button1Down:Connect(function()
    if selectionEnabled and Mouse.Target then
        selectedPart = Mouse.Target
        SelectedPartLabel.Text = "Selected Part: " .. selectedPart.Name
        highlightPart(selectedPart)
    end
end)

-- Create Buttons
createButton(ButtonContainer, "Fire ClickDetector", function()
    if selectedPart then fireClickDetector(selectedPart) else warn("No part selected!") end
end)

createButton(ButtonContainer, "Fire ProximityPrompt", function()
    if selectedPart then fireProximityPrompt(selectedPart) else warn("No part selected!") end
end)

createButton(ButtonContainer, "Fire TouchInterest", function()
    if selectedPart then fireTouchInterest(selectedPart) else warn("No part selected!") end
end)

createButton(ButtonContainer, "Test All Interactions", function()
    if selectedPart then
        fireClickDetector(selectedPart)
        fireProximityPrompt(selectedPart)
        fireTouchInterest(selectedPart)
    else
        warn("No part selected!")
    end
end)

createButton(ButtonContainer, "Copy Part Info", function()
    if selectedPart then
        setclipboard(selectedPart:GetFullName())
        warn("Copied part path: " .. selectedPart:GetFullName())
    else
        warn("No part selected!")
    end
end)

createButton(ButtonContainer, "Copy Fire Script", function()
    copyFireScript(selectedPart)
end)

ToggleSelectionButton.Text = "Toggle Selection Mode: OFF"
ToggleSelectionButton.MouseButton1Click:Connect(function()
    selectionEnabled = not selectionEnabled
    ToggleSelectionButton.Text = selectionEnabled and "Toggle Selection Mode: ON" or "Toggle Selection Mode: OFF"
end)
ToggleSelectionButton.Parent = ButtonContainer
ToggleSelectionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleSelectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
