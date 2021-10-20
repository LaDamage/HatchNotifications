--// Script Loader
repeat wait() until game:IsLoaded()

--// Core Variables
local Rarity 
local HttpService = game:GetService("HttpService")
local HttpRequest = syn and syn.request or http_request

--// Game Variables
local player = game:GetService("Players").LocalPlayer
local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Main.PetFrame.PetFrame.Pets.ScrollingFrame

--// Get Functions
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

--// Pet Finder
inventory.ChildAdded:Connect(function(instance)
    if instance.PetTemplate.Secret.Visible == true then
        Rarity = instance.PetTemplate.Secret.Text
        local Data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = player.Name.." just hatched a "..Rarity.." "..instance.PetTemplate.PetName.Text,
                ["color"] =  tonumber(0x55ffff),
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
