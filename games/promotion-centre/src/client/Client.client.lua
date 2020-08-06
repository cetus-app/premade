--[[
   _____       _
  / ____|     | |
 | |      ___ | |_  _   _  ___     __ _  _ __   _ __
 | |     / _ \| __|| | | |/ __|   / _` || '_ \ | '_ \
 | |____|  __/| |_ | |_| |\__ \ _| (_| || |_) || |_) |
  \_____|\___| \__| \__,_||___/(_)\__,_|| .__/ | .__/
                                        | |    | |
										|_|    |_|
------------------------------------------------------
Cetus: Promotion centre
Github: https://github.com/cetus-app/cetus-rbx/
Our site: https://cetus.app
--]]


--[[
	Performs basic client setup, which is mainly loading ReplicatedPseudoInstance.
--]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))

Resources:LoadLibrary("ReplicatedPseudoInstance")

local players = game:GetService("Players")

-- Hide built in GUIs
pcall(function()
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)

end)
wait(.2)

pcall(function()
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)

end)
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable

	local target = players.LocalPlayer.Character:WaitForChild("Head")
	local angle = 0
	wait(1)
	target.Anchored = true
	while target ~= nil do
	wait()
    camera.CoordinateFrame = CFrame.new(target.Position)  --Start at the position of the part
                           * CFrame.Angles(0, angle, 0) --Rotate by the angle
                           * CFrame.new(0, 0, 8)       --Move the camera backwards 5 units
    angle = angle + math.rad(0.5)
end
