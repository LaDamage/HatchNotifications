local HttpService = game:GetService("HttpService")
local Player = game:GetService("Players").LocalPlayer
local FunctionModule = require(game:GetService("ReplicatedStorage").FunctionsModule)
local chat = Player.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller

function toHex(x) 
    local hex =  string.format("%x", x)
    return hex:len() == 1 and "0"..hex or hex
end
function RGB2HEX(r,g,b) 
    return "0x" .. toHex(r) .. toHex(g) .. toHex(b)
end

_G.TimeFormat = _G.TimeFormat or "TIME12 (TIME24)" 

local Times = {}
Times["TIME12"] = "%%I:%%M %%p"
Times["TIME24"] = "%%H:%%M"
Times["DATE"] = "%%x"
Times["TIMEZONE"] = "%%Z"
Times["TIME"] = "%%X"

function FormatTime(str: string)
    for i,v in pairs(Times) do
        str = str:gsub(i,v)
    end
    return str
end

chat.ChildAdded:Connect(function(instance)
    local TextColor3 = instance.TextLabel.TextColor3
    if string.find(instance.TextLabel.Text, Player.Name.." just hatched a") then
        local ToSplit = instance.TextLabel.Text
        local split = ToSplit:split("]: ")

        local message = split[2]

        local Data = {
            ["username"] = "LSD - Clicker Simulator",
            ["avatar_url"] = "https://cdn.discordapp.com/icons/932297214578012200/6fc5ed42f22cd87965bbf123bf88dedd.png",
            ["embeds"] = {{
                ["title"] = message,
                ["color"] =  tonumber(RGB2HEX(unpack({TextColor3.R*255,TextColor3.G*255,TextColor3.B*255}))),
                ["fields"] = {{
                    ["name"] = "__Total Eggs Opened:__",
                    ["value"] = FunctionModule.comma(Player.leaderstats.Eggs.Value),
                    ["inline"] = true
                },
                {
                    ["name"] = "__Time:__",
                    ["value"] = os.date(FormatTime(_G.TimeFormat), os.time()),
                    ["inline"] = true
                }
                }
            }}
        }
        
        local HttpRequest = syn and syn.request or http_request
        HttpRequest({Url= getgenv().allah, Body = HttpService:JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"}})
    end
end)
