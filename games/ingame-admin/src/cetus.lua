-- Requires Cetus-RBX and exports our "Instance" of the client
-- Allows multiple modules (Commands) to access the same instance.
local cetus = require(script.Parent.dependencies:WaitForChild("cetus-rbx"))
local config = require(script.Parent.config)
return cetus({
    token = config.token,
    _overrideBase = "http://localhost:4000"
})