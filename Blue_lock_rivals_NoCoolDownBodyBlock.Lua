-- Yo dude good to see you bro! you can steal the code i made btw this is very basic and i don't want so you can have it or edit it don't thanks to me yet good luck with your skills of scripter coding i happy to see you level up just like me! ❤️🔥
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local AbilityEvent = ReplicatedStorage.Packages.Knit.Services.AbilityService.RE.Ability

local AbilityButton = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"]

if getgenv().ChangeStyle and LocalPlayer.PlayerStats.Style.Value == "Reo" then LocalPlayer.PlayerStats.Style.Value = "Kunigami" end

local function getNearestPlayer(maxDistance)
    local closestPlayer = nil
    local shortestDistance = maxDistance

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not getgenv().IsHitTeam and player.Team == LocalPlayer.Team then
                continue
            end
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance <= shortestDistance then
                closestPlayer = player
                shortestDistance = distance
            end
        end
    end

    return closestPlayer
end
local function activateAbility()
if getgenv().NoCD then
    local targetPlayer = getNearestPlayer(30)
    if targetPlayer then
        AbilityEvent:FireServer("BodyBlock", targetPlayer.Character)
    end
  end
end
if AbilityButton then
 AbilityButton.MouseButton1Click:Connect(activateAbility)
end
if LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("BodyBlockAll") == nil then
local BodyBlockAllButton = AbilityButton:Clone()
BodyBlockAllButton.Parent = AbilityButton.Parent
BodyBlockAllButton.Name = "BodyBlockAll"
BodyBlockAllButton.Timer.Text = "Body Block All"
BodyBlockAllButton.Position = AbilityButton.Position + UDim2.new(0, 0, 0.15, 0)
BodyBlockAllButton.MouseEnter:Connect(function()
local Sound = Instance.new("Sound")
Sound.Parent = BodyBlockAllButton
Sound.SoundId = "rbxassetid://10066931761"
Sound.Volume = 0.93
Sound.Looped = false
Sound:Play()
Sound.Ended:Connect(function()
    Sound:Destroy()
end)
BodyBlockAllButton:TweenSize(UDim2.new(1.035, 0, 1.035, 0), "Out", "Quad", 0.2, true)
end)
BodyBlockAllButton.MouseLeave:Connect(function()
    BodyBlockAllButton:TweenSize(UDim2.new(0.9, 0, 0.9, 0), "Out", "Quad", 0.2, true)
end)
BodyBlockAllButton.MouseButton1Click:Connect(function()
local Sound = Instance.new("Sound")
Sound.Parent = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
Sound.SoundId = "rbxassetid://10066968815"
Sound.Volume = 1.3
Sound.Looped = false
Sound:Play()
Sound.Ended:Connect(function()
    Sound:Destroy()
end)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character then
            local args = {
                [1] = "BodyBlock",
                [2] = v.Character
            }
            AbilityEvent:FireServer(unpack(args))
        end
    end
end)
end
if LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("BodyBlockOtht") == nil then
local BodyBlockAllButton = AbilityButton:Clone()
BodyBlockAllButton.Parent = AbilityButton.Parent
BodyBlockAllButton.Name = "BodyBlockOtht"
BodyBlockAllButton.Timer.Text = "Body Block Others Team"
BodyBlockAllButton.Position = AbilityButton.Position + UDim2.new(0, 0, 0.15, 0)
BodyBlockAllButton.MouseEnter:Connect(function()
local Sound = Instance.new("Sound")
Sound.Parent = BodyBlockAllButton
Sound.SoundId = "rbxassetid://10066931761"
Sound.Volume = 0.93
Sound.Looped = false
Sound:Play()
Sound.Ended:Connect(function()
    Sound:Destroy()
end)
BodyBlockAllButton:TweenSize(UDim2.new(1.035, 0, 1.035, 0), "Out", "Quad", 0.2, true)
end)
BodyBlockAllButton.MouseLeave:Connect(function()
    BodyBlockAllButton:TweenSize(UDim2.new(0.9, 0, 0.9, 0), "Out", "Quad", 0.2, true)
end)
BodyBlockAllButton.MouseButton1Click:Connect(function()
local Sound = Instance.new("Sound")
Sound.Parent = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
Sound.SoundId = "rbxassetid://10066968815"
Sound.Volume = 1.3
Sound.Looped = false
Sound:Play()
Sound.Ended:Connect(function()
    Sound:Destroy()
end)
 for _, v in pairs(Players:GetPlayers()) do
    if v ~= LocalPlayer and v.Team ~= LocalPlayer.Team and v.Character then
        local args = {
            [1] = "BodyBlock",
            [2] = v.Character
        }
        AbilityEvent:FireServer(unpack(args))
    end
end
end)
end
