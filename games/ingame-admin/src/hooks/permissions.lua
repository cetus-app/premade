local config = require(script.Parent.Parent:WaitForChild("config"))
local checkAccess= require(script.Parent.Parent.util.checkAccess)

local RunService = game:GetService("RunService")
return function (registry)
    registry:RegisterHook("BeforeRun", function(context)
        if (context.Group == "DefaultAdmin" or context.Group == "Admin" or context.Group == "DefaultDebug")
        and context.Executor.UserId ~= game.CreatorId then
            if #config.admins == 0 then
                warn("No admins specified for In-game admin")
                if RunService:IsStudio() then
                    print("Giving access as in Studio mode")
                else
                    return "Access denied; There are no permissions set."
                end
            end
            local allow = false
            for _, perm in ipairs(config.admins) do
                local hasAccess = checkAccess(context.Executor, perm)
                if hasAccess then
                    allow = true
                    break;
                end
            end
            if not allow then
                return "You do not have access to that command."
            end
		end
	end)
end

