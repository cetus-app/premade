--[[
    Cetus.app
    Premade integration: In-game admin
    Version: 0.0.1

    This integration makes use of the fantastic Cmdr tool.
    https://eryn.io/Cmdr/
]]

-- Configuration

-- Whether or not you want to use built-in Cmdr commands, like Kick, announce & bring
local useDefaultCommands = false


local PlayerScripts = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local clientCode = script.client

-- Initialise Cmdr

local Cmdr = require(script.dependencies.cmdr)
require(script.cetus)

if useDefaultCommands then
    Cmdr:RegisterDefaultCommands()
end

Cmdr:RegisterCommandsIn(script.commands)


local permissionHook = require(script.hooks.permissions)
permissionHook(Cmdr.Registry)
clientCode.Parent = PlayerScripts