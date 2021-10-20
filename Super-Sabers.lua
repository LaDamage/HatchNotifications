--// Script Loader
repeat wait() until game:IsLoaded()

--// Core Variables
local HttpService = game:GetService("HttpService")
local HttpRequest = syn and syn.request or http_request

--// Get Tier Variables
local Tiers = {
    "Golden",
    "Diamond",
    "Emerald",
    "Celestial"
}

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

        local Rarity = instance.PetTemplate.Secret.Text
        local PetName = instance.PetTemplate.PetName.Text

        local find_golden = string.find(PetName, "Golden")
        local find_diamond = string.find(PetName, "Diamond")
        local find_emerald = string.find(PetName, "Emerald")
        local find_celestial = string.find(PetName, "Celestial")

        if Rarity == "SECRET" then
            embed_color = 0x55ffff
        elseif Rarity == "MYTHIC" then
            embed_color = 0xa020f0
        end

        for i, v in pairs(Tiers) do
            if find_golden or find_diamond or find_emerald or find_celestial then
                Send_Message = player.Name.." just crafted a "..Rarity.." "..PetName
                embed_color = 0xffff33
            else
                Send_Message = player.Name.." just hatched a "..Rarity.." "..PetName
            end
        end

        local Data = {
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = Send_Message,
                ["color"] =  tonumber(embed_color),
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
