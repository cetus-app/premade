-- Takes the identifiers passed in and parsers them to determine user access
local cetus = require(script.Parent.Parent.cetus)

local getOptions = require(script.Parent.getOptions)
return function (plr, accessIdentifier)
	if not plr or not accessIdentifier then
		return warn("Bad values passed to checkAccess ", plr.Name, accessIdentifier)
	end

    -- Check for userId only
    if tonumber(accessIdentifier) ~= nil then
        if plr.UserId == tonumber(accessIdentifier) then
            return true
        else
            return false
        end
    end

    local validated = getOptions(accessIdentifier)
    local firstStr = string.lower(validated[1])

	if firstStr == "" or firstStr == " " then
		return warn("Invalid access string passed ", accessIdentifier)
    end

	if firstStr == "rank" then
        if validated[2] and tonumber(validated[2]) then
            local num = tonumber(validated[2])
            -- Cached
            local group = cetus:getGroup()
            if group.error then
                warn("Cetus admin: Failed to get group info! "..group.error.message)
            end
            local rank = plr:GetRankInGroup(group.id)
            if rank == num then
                return true
            end
		else
			warn("Bad rank permission string "..accessIdentifier)
		end
	elseif firstStr == "group" then
		local groupId, rankId = tonumber(validated[2]), tonumber(validated[3])
		if groupId then
			local rank = plr:GetRankInGroup(groupId)
			if rank ~= 0 then
				-- They are in it. Check if rankId was provided
				if rankId then
					return (rank == rankId)
				else
					-- They pass the group check
					return true
				end
			end
		else
		    warn("Bad group id permission string ",groupId)
		end
	end
-- If nothing else returns
return false
end