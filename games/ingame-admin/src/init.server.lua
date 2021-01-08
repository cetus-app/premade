--[[
    Cetus.app
    Premade integration: In-game admin
    Version: 1.0.0

    This integration makes use of the fantastic Cmdr tool.
    https://eryn.io/Cmdr/
]]

local PlayerScripts = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local clientCode = script.client
local config = require(script.config)

-- Initialise Cmdr

local Cmdr = require(script.dependencies.cmdr)
require(script.cetus)

local commandsToRegister = {"Help"}

if config.useDefaultAdmin then
    table.insert(commandsToRegister, "DefaultAdmin")
end

if config.useDefaultDebug then
    table.insert(commandsToRegister, "DefaultDebug")
end

-- Register default commands. At minimum, this registers help.
Cmdr:RegisterDefaultCommands(commandsToRegister)

-- Register our custom commands.
Cmdr:RegisterCommandsIn(script.commands)


local permissionHook = require(script.hooks.permissions)
permissionHook(Cmdr.Registry)
clientCode.Parent = PlayerScripts