local cetus = require(script.Parent.Parent.Parent.cetus)

return function (context, players, rank)
    if #players > 10 then
        return "Too many players: Please choose less than 10 at a time."
    end
    if not rank or rank <= 0 or rank >= 255 then
        context:Reply("Cannot rank to "..rank .. " as it is not a valid rank. ", Color3.new(1,0,0))
        return "Invalid rank"
    end

    local groupInfo = cetus:getGroup()
    if groupInfo.error then
        error(groupInfo.error.message)
    end

    local function setRank (plr)
        local resp = cetus.setRank(plr.UserId, rank)
        if resp.error then
            return "Failed to rank " .. plr.Name .. ": " .. resp.error.message
        end
        print(context.executor.Name .. "(" ..context.executor.UserId .. ") Ranked " .. plr.Name .. " to " ..rank ..
        " in " .. groupInfo.name)
        return "Ranked " .. plr.Name .. " to " .. rank .. " in " ..  groupInfo.name
    end

    if #players == 1 then
        return setRank(players[1])
    else
        for _, player in ipairs(players) do
            context:Reply(setRank(player))
        end
    end
    return "Ranked " .. #players .. " to " .. rank .. " in " .. groupInfo.Name
  end