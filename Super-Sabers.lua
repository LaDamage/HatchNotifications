--// Script Loader
repeat wait() until game:IsLoaded()

--// Core Variables
local HttpService = game:GetService("HttpService")
local HttpRequest = syn and syn.request or http_request

--// Game Variables
local player = game:GetService("Players").LocalPlayer
local chat = player.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller

--// Get Functions
function toHex(x) 
    local hex =  string.format("%x", x)
    return hex:len() == 1 and "0"..hex or hex
end
function RGB2HEX(r,g,b) 
    return "0x" .. toHex(r) .. toHex(g) .. toHex(b)
end
function comma_value(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

--// Message Searching
chat.ChildAdded:Connect(function(chat_message)
    if chat_message.TextLabel.TextColor3 == Color3.fromRGB(85, 255, 255) then
        local TextColor3 = chat_message.TextLabel.TextColor3
        local Data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = player.Name.." just hatched a Secret or a Mythic!",
                ["color"] =  tonumber(RGB2HEX(unpack({TextColor3.R*255,TextColor3.G*255,TextColor3.B*255}))),
                ["fields"] = {{
                    ["name"] = "__Total Eggs Opened:__",
                    ["value"] = comma_value(game:GetService("Players").LocalPlayer.leaderstats["Eggs Opened"].Value),
                    ["inline"] = true
                },
                {
                    ["name"] = "__Time:__",
                    ["value"] = os.date("%I:%M %p", os.time()),
                    ["inline"] = true
                }
                }
            }}
        }
        
        HttpRequest({Url= _G.Webhook, Body = HttpService:JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"}})
    end
end)
print("Super Sabers Hatch Notifications - Provided by CollateralDamage")
