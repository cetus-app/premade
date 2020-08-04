local cetus = require(script.Parent.Parent.Parent.cetus)

return function (context, players, rank)
    -- Deliberate to slow down exiling
    -- Because it is such a damaging action.
    if #players > 5 then
        return "Too many players: Please choose less than 5 at a time."
    end
    if not rank or rank <= 0 or rank >= 255 then
        context:Reply("Cannot rank to "..rank .. " as it is not a valid rank. ", Color3.new(1,0,0))
        return "Invalid rank"
    end

    local groupInfo = cetus:getGroup()
    if groupInfo.error then
        error(groupInfo.error.message)
    end

    local function exile (plr)
        local resp = cetus.exile(plr.UserId)
        if resp.error then
            return "Failed to rank " .. plr.Name .. ": " .. resp.error.message
        end
        print(context.executor.Name .. "(" ..context.executor.UserId .. ") Exiled " .. plr.Name ..
        " from " .. groupInfo.name)
        return "Exiled " .. plr.Name .. " from " .. groupInfo.name
    end

    if #players == 1 then
        return exile(players[1])
    else
        for _, player in ipairs(players) do
            context:Reply(exile(player))
        end
    end
    return "Exiled " .. #players .. " from " .. groupInfo.Name
  end