--[[
Use;
-- This Requires to have style Reo or Kunigami to use and work!
getgenv().ChangeStyle = true -- set this to false if you don't need to change your style to Kunigami (use Reo style to change)
getgenv().NoCD = true -- set this to false if you don't want the Body block no cd (reset the button click function modified)
getgenv().IsHitTeam = true -- set this to false if you don't want to Hit your Team with Body block
getgenv().ReachHit = 30 -- you can set how much reach for use bodyblock if you need, normal is 30 or more
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Blue_lock_rivals_NoCoolDownBodyBlock.Lua"))()
and if you run like this is will work?
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Blue_lock_rivals_NoCoolDownBodyBlock.Lua"))()
yes is still work and it will be normal settings
--]]
-- Yo dude good to see you bro! you can steal the code i made btw this is very basic and i don't want so you can have it or edit it don't thanks to me yet good luck with your skills of scripter coding i happy to see you level up just like me! ❤️🔥
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local AbilityEvent = ReplicatedStorage.Packages.Knit.Services.AbilityService.RE.Ability
local AbilityButton = LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"]
loadstring(game:HttpGet("https://raw.githubusercontent.com/Backlostunking/ScriptStarOZX/refs/heads/main/Notification%5B%5DStarlightM.Lua"))()
if getgenv().ChangeStyle == nil then getgenv().ChangeStyle = true end
if getgenv().NoCD == nil then getgenv().NoCD = true end
if getgenv().IsHitTeam == nil then getgenv().IsHitTeam = true end
if getgenv().ReachHit == nil then getgenv().ReachHit = 30 end
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
    local targetPlayer = getNearestPlayer(getgenv().ReachHit)
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
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KsUi"
ScreenGui.Parent = game.CoreGui
local ks = Instance.new("TextButton")
ks.Name = "ks"
ks.Parent = ScreenGui
ks.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ks.Position = UDim2.new(0.1, 0, 0.1, 0)
ks.Size = UDim2.new(0, 56, 0, 25)
ks.Font = Enum.Font.SourceSans
ks.Text = "Kill Server"
ks.TextColor3 = Color3.fromRGB(248, 248, 248)
ks.TextSize = 15
ks.AutoButtonColor = true -- Better button effect
ks.BorderSizePixel = 2
ks.BorderColor3 = Color3.fromRGB(255, 0, 0)
local Corner = Instance.new("UICorner")
Corner.Name = "Corner"
Corner.Parent = ks
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
ks.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ks.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
ks.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ks.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
ks.MouseButton1Click:Connect(function()
    local bindableFunction = Instance.new("BindableFunction")
    bindableFunction.OnInvoke = function(choice)
        if choice == "Sure" then
            getgenv().unknow = true
            while getgenv().unknow do
                task.wait()
                pcall(function()
                    task.spawn(function()
                        for _, v in pairs(game.Players:GetChildren()) do
                            if v ~= game.Players.LocalPlayer and v.Character then
                                for _ = 1, 20 do
                                    local args = {
                                        [1] = "BodyBlock",
                                        [2] = v.Character
                                      }
                                        AbilityEvent:FireServer(unpack(args))
                                      end
                                 end
                            end
                      end)
                end)
             end
          end
      end
        game.StarterGui:SetCore("SendNotification", {
            Title    = "Kill Server",
            Text     = "Click 'Sure' if you want to Kill Server (Reo Style or Kunigami Required)!",
            Icon     = "",
            Duration = 25,
            Callback = bindableFunction,
            Button1  = "Sure",
            Button2  = "No",
        })
    end)
AddXNotification("Script Made By ScripterMrbacon")
