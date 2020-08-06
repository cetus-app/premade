
--[[
   _____       _
  / ____|     | |
 | |      ___ | |_  _   _  ___     __ _  _ __   _ __
 | |     / _ \| __|| | | |/ __|   / _` || '_ \ | '_ \
 | |____|  __/| |_ | |_| |\__ \ _| (_| || |_) || |_) |
  \_____|\___| \__| \__,_||___/(_)\__,_|| .__/ | .__/
                                        | |    | |
										|_|    |_|
------------------------------------------------------
Cetus: Promotion centre
Github: https://github.com/cetus-app/cetus-rbx/
Our site: https://cetus.app
--]]

-- Require statements
local GroupService = game:GetService("GroupService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))
local cetusRbx = require(script.Parent.dependencies:WaitForChild("cetus-rbx"))

local loadingScreen = require(script.loadingScreen)
local rankCheck = require(script.RankGet)
local Misc = require(script.Misc)
local RankPrompt = require(script.Prompt)

-- Setup
Resources:LoadLibrary("ReplicatedPseudoInstance")

local testing = false


local Promo = {}
Promo.__index = Promo

function Promo.new(opt)
	local newClass = {}
	setmetatable(newClass, Promo)

	assert(opt, "You must provide configuration options")
	assert(opt.token, "You must provide an API key!")

	newClass.config = opt
	newClass.http = cetusRbx({
		token = opt.token
	})
	game:GetService("Players").PlayerAdded:connect(function (plr)
		newClass:handlePlayerJoin(plr)
	end)

    return newClass
end

function Promo:handlePlayerJoin (Player)
	Player.CharacterAdded:connect(function()
		wait(.1)
		local grp = self.http:getGroup()
		-- if valid
		if grp.error then
			-- Only return status code because the error isn't filtered
			local statusCode = tonumber(grp.error.status)
			if statusCode == 401 then
				Misc:displayError(Player, "Unauthorised: Is your API key correct? ", true)
			elseif statusCode == 0 then
				Misc:displayError(Player, "Roblox HTTP failed: Is HttpService enabled?", true)
			else
				Misc:displayError(Player, "HTTP: Error "..statusCode, true)
			end
			print(grp.error.message)
			loadingScreen.hide()
			wait(10)
			Player:Kick("HTTP error. Status: "..statusCode)
			return
		end
		local groupId = grp.id

		wait(1)
		-- Centre is active: Continue
		local promoRanks = rankCheck(Player, groupId, self.config)

		local settings = self.config
		-- Background checks
		-- AGE CHECK
		local minAge = 7
		if self.config.minAgeDays then
			minAge = settings.minAgeDays
		end

		if Player.AccountAge <= minAge and not testing then
			-- They're under 1 week old; reject.
			loadingScreen.hide()
			Misc:displayError(Player, "Your account must be at least "..minAge .. " days old.", true)
			Player:Kick("Your account must be at least " .. minAge .. " days old to use this service.")
			return false;
		end

		if not Player:IsInGroup(groupId) then
			local groupInfo = GroupService:GetGroupInfoAsync(groupId)
			Misc:displayError(Player, "You must be in "..groupInfo.Name .. ".", true)
			return;
		end

		-- It's all good.
		if not promoRanks then
			-- display error: bad formatting
			loadingScreen.hide()
			Misc:displayError(Player, "Invalid config. Contact owner.", true)
			return;
		else
			-- tis' choosing time
			RankPrompt(Player, groupId, promoRanks, function(newRank, newName)
				local ranked = self.http:setRank(Player.UserId, newRank)
				loadingScreen.hide()
				if ranked.error then
					Misc:displayError(Player, "Failed to rank you.", true)
				else
					Misc:displayMessage(Player, "Successfully ranked to "..newName, true)
				end
				wait(30)
				Player:Kick("Done")
			end)
		end
	end)
end
return function (opt)
	return Promo.new(opt)
end