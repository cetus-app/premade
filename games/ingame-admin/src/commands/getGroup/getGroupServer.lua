-- I don't think this is very useful
-- But might as well provide it!
local cetus = require(script.Parent.Parent.Parent.cetus)
local GroupService = game:GetService("GroupService")

return function (context)
    local rawGroupInfo = cetus:getGroup()
    if rawGroupInfo.error then
        context:Reply(rawGroupInfo.error.message, Color3.new(1,0,0))
        error(rawGroupInfo.error.message)
    end
    --[[
        * The full group info is availible from the above response, however
        while it is from Roblox's website, Roblox doesn't know that.
        * So we re-get the same information but this way we don't have to filter
        * and filting is expensive.
    ]]

    local groupInfo = GroupService:GetGroupInfoAsync(rawGroupInfo.id)
    context:Reply("The current group is " .. groupInfo.Name .. " ("..groupInfo.Id..")")
    context:Reply("It is owned by " .. groupInfo.Owner.Name .. " ("..groupInfo.Owner.Id..")")
    context:Reply("It has " .. #groupInfo.Roles .. " ranks: ")
    for _, role in pairs(groupInfo.Roles) do
        context:Reply("-  " .. role.Name .. " ("..role.Rank .. ")")
    end
    return "Displaying group information for " .. groupInfo.Name
  end