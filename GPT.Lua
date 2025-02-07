local HttpService = game:GetService("HttpService")

local API_KEY = _G.Apikey
local API_URL = "https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill"

local function chatWithAI(question)
    local requestBody = HttpService:JSONEncode({ inputs = question })

    local success, response = pcall(function()
        return HttpService:PostAsync(API_URL, requestBody, Enum.HttpContentType.ApplicationJson, false, {
            ["Authorization"] = "Bearer " .. API_KEY
        })
    end)

    if success then
        local jsonResponse = HttpService:JSONDecode(response)
        return jsonResponse.generated_text or "AI Error: No response"
    else
        return "AI Error: HTTP blocked on this executor"
    end
end

-- Example Usage
_G.chatWithAI = chatWithAI
print("ChatGPT AI Loaded! Use `_G.chatWithAI('your message')`")
