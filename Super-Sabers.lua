local HttpService = game:GetService("HttpService")
local Player = game.Players.LocalPlayer
local chat = Player.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller

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

chat.ChildAdded:Connect(function(instance)
    local TextColor3 = instance.TextLabel.TextColor3
    if string.find(instance.TextLabel.Text, Player.Name.." has hatched a") then
        local Data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = instance.TextLabel.Text,
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
        
        local HttpRequest = syn and syn.request or http_request
        HttpRequest({Url= _G.Webhook, Body = HttpService:JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"}})
    end
end)
