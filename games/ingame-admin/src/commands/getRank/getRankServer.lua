local cetus = require(script.Parent.Parent.Parent.cetus)

return function (context, players)
    if #players > 10 then
        return "Too many players: Please choose less than 10 at a time."
    end
    local groupInfo = cetus:getGroup()
    if groupInfo.error then
        error(groupInfo.error.message)
    end

    -- Cmdr only allows us to retrieve in-game users
    -- So this is significantly more effieicent than using the Cetus API.
    local function getRank (plr)
        local rank = plr:GetRankInGroup(groupInfo.id)
        local role = plr:GetRoleInGroup(groupInfo.id)

        return plr.Name .. "'s rank in " .. groupInfo.name .. " is " .. role .. " ("..rank..")"
    end

    if #players == 1 then
        return getRank(players[1])
    else
        for _, player in ipairs(players) do
            context:Reply(getRank(player))
        end
    end
    return "Got " .. #players .. " ranks in " .. groupInfo.Name
  end