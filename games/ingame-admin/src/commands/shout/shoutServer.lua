local cetus = require(script.Parent.Parent.Parent.cetus)
local TextService = game:GetService("TextService")

local function hasTags (str)
    return string.match(str, "#")
end

return function (context, message)
    local withUsername = message .. " ~ " ..context.Executor.Name
    if string.len(withUsername) <= 254 then
        message = withUsername
    end
    local resp = cetus:shout(message)
    if resp.error then
        context:Reply(cetus.shout.error.message, Color3.new(1, 0, 0))
        error(cetus.shout.error.message)
    end
    -- Filtering
    local out = TextService:FilterStringAsync(resp.message, context.Executor.UserId)
    local outStr = out:GetNonChatStringForUserAsync()

    -- Provide some util information
    if hasTags(outStr) and not hasTags(resp.message) then
        context:Reply("Note: The original shout is not hash-tagged. We are required to filter our response to you,"..
        "which has been hashtagged.")
    elseif hasTags(resp.message) then
        context:Reply("The group shout was hashtagged.")
    end

    return "Posted shout " .. outStr .. " to the group shout."
  end