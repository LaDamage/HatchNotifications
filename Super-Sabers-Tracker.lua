--// Script Loader
repeat wait() until game:IsLoaded()

--// Core Variables
_G.Interval = 60
local HttpService = game:GetService("HttpService")
local HttpRequest = syn and syn.request or http_request

_G.StrengthTable = {}
_G.CoinTable = {}
_G.GemTable = {}
_G.CandyCornTable = {}
_G.HeavenCoinTable = {}
_G.EggTable = {}

--// Game Variables
local player = game:GetService("Players").LocalPlayer
local BigNum = require(game:GetService("ReplicatedStorage").Utilities.BigNum)

--// Number Formatter
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

while true do
    local StartStrength = player.leaderstats["Total Swords"].Value
    local StartCoins = player.leaderstats["Total Coins"].Value
    local StartGems = player.leaderstats["Total Gems"].value
    local StartCandyCorn = player.leaderstats["TotalCandyCorns"].Value
    local StartHeavenCoins = player.leaderstats["Total Heaven Coins"].Value
    local StartEggs = player.leaderstats["Eggs Opened"].Value

    wait(_G.Interval)

    local EndStrength = player.leaderstats["Total Swords"].Value
    local EndCoins = player.leaderstats["Total Coins"].Value
    local EndGems = player.leaderstats["Total Gems"].value
    local EndCandyCorn = player.leaderstats["TotalCandyCorns"].Value
    local EndHeavenCoins = player.leaderstats["Total Heaven Coins"].Value
    local EndEggs = player.leaderstats["Eggs Opened"].Value

    local StrengthCalc = tonumber(EndStrength) - tonumber(StartStrength)
    local CoinCalc = tonumber(EndCoins) - tonumber(StartCoins)
    local GemCalc = tonumber(EndGems) - tonumber(StartGems)
    local CandyCornCalc = tonumber(EndCandyCorn) - tonumber(StartCandyCorn)
    local HeavenCoinCalc = tonumber(EndHeavenCoins) - tonumber(StartHeavenCoins)
    local EggCalc = tonumber(EndEggs) - tonumber(StartEggs)

    table.insert(_G.StrengthTable, StrengthCalc)
    table.insert(_G.CoinTable, CoinCalc)
    table.insert(_G.GemTable, GemCalc)
    table.insert(_G.CandyCornTable, CandyCornCalc)
    table.insert(_G.HeavenCoinTable, HeavenCoinCalc)
    table.insert(_G.EggTable, EggCalc)

    local strength_time = 0
    local coin_time = 0
    local gem_time = 0
    local candycorn_time = 0
    local heavencoin_time = 0
    local egg_time = 0

    for i,v in pairs(_G.StrengthTable) do
        strength_time = strength_time + v
    end
    for i,v in pairs(_G.CoinTable) do
        coin_time = coin_time + v
    end
    for i,v in pairs(_G.GemTable) do
        gem_time = gem_time + v
    end
    for i,v in pairs(_G.CandyCornTable) do
        candycorn_time = candycorn_time + v
    end
    for i,v in pairs(_G.HeavenCoinTable) do
        heavencoin_time = heavencoin_time + v
    end
    for i,v in pairs(_G.EggTable) do
        egg_time = egg_time + v
    end

    local Data = {
        ["username"] = "Tracking "..player.Name.."'s Super Sabers Stats!",
        ["avatar_url"] = "https://cdn.discordapp.com/attachments/879308410208804904/893583260746137600/WebhookImage.jpg",
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "**Strength Tracker**",
            ["color"] =  tonumber(0x8a2be2),
            ["fields"] = {{
                ["name"] = "__Total Strength:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["Total Swords"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Strength Gained In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(StrengthCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Strength Gained In "..#_G.StrengthTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(strength_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Strength Gain Per 60 Seconds__", -- "__Average Strength Gain Per "..#_G.StrengthTable.." minutes__",
                ["value"] = BigNum.short(BigNum.convert(strength_time/#_G.StrengthTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "**Coin Tracker**",
            ["color"] =  tonumber(0xffd700),
            ["fields"] = {{
                ["name"] = "__Total Coins:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["Total Coins"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Coins Gained In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(CoinCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Coins Gained In "..#_G.CoinTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(coin_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Coin Gain Per 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(coin_time/#_G.CoinTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "**Gem Tracker**",
            ["color"] =  tonumber(0x1e90ff),
            ["fields"] = {{
                ["name"] = "__Total Gems:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["Total Gems"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Gems Gained In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(GemCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Gems Gained In "..#_G.GemTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(gem_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Gem Gain Per 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(gem_time/#_G.GemTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "**Heaven Coin Tracker**",
            ["color"] =  tonumber(0x32cd32),
            ["fields"] = {{
                ["name"] = "__Total Heaven Coins:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["Total Heaven Coins"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Heaven Coins Gained In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(HeavenCoinCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Heaven Coins Gained In "..#_G.HeavenCoinTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(heavencoin_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Heaven Coin Gain Per 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(heavencoin_time/#_G.HeavenCoinTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "**Candy Corn Tracker**",
            ["color"] =  tonumber(0xff8c00),
            ["fields"] = {{
                ["name"] = "__Total Candy Corn:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["TotalCandyCorns"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Candy Corn Gained In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(CandyCornCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Candy Corn Gained In "..#_G.CandyCornTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(candycorn_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Candy Corn Gain Per 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(candycorn_time/#_G.CandyCornTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "**Egg Tracker**",
            ["color"] =  tonumber(0xe8beac),
            ["fields"] = {{
                ["name"] = "__Total Eggs Hatched:__",
                ["value"] = BigNum.short(BigNum.convert(player.leaderstats["Eggs Opened"].Value)),
                ["inline"] = false
            },
            {
                ["name"] = "__Eggs Hatched In 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(EggCalc)),
                ["inline"] = false
            },
            {
                ["name"] = "__Total Eggs Hatched In "..#_G.EggTable.." Minute(s)__",
                ["value"] = BigNum.short(BigNum.convert(egg_time)),
                ["inline"] = false
            },
            {
                ["name"] = "__Average Eggs Hatched Per 60 Seconds__",
                ["value"] = BigNum.short(BigNum.convert(egg_time/#_G.EggTable)),
                ["inline"] = false
            }
            },
        },
        {
            ["title"] = "---------------------------------------",
            ["color"] =  tonumber(0x2f3136),
            },
        }
    }

    HttpRequest({Url= _G.StatWebhook, Body = HttpService:JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"}})
end
