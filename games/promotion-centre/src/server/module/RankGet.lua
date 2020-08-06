return function (plr, mainGroupId, settings)
	-- Returns table of ranks to give
	local promoRanks = {}
	if not settings.ranks and not settings.func then
		error("No ranks and no settings!")
	end
	if settings.ranks then
		for rankNum, rankOpt in pairs(settings.ranks) do
			for subgroupId, subgroupOpt in pairs(rankOpt) do
				if type(subgroupOpt) == "function" then
					if (subgroupOpt(plr, rankNum)) then
						table.insert(promoRanks, rankNum)
					end
				else
					if plr:IsInGroup(subgroupId) then
						if subgroupOpt == true then
							table.insert(promoRanks, rankNum)
						else
							local rank = plr:GetRankInGroup(subgroupId)
							for _, subRank in ipairs(subgroupOpt) do
								if rank == subRank then
									table.insert(promoRanks, rankNum)
									break;
								end
							end
						end
					end
				end
			end
		end
	end
	if settings.func then
		local ranks = settings.func(plr)
		if type(ranks) == "table" then
			for _, val in ipairs(ranks) do
				if type(val) == "number" then
					table.insert(promoRanks, val)
				end
			end
		end
	end


	if settings.baseRank and settings.baseRank > 0 then
		local r = plr:GetRankInGroup(mainGroupId)
		if r < settings.baseRank then
			table.insert(promoRanks, settings.baseRank)
		end
	end
	return promoRanks
end

