local misc = {};

-- Require statements
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage:WaitForChild("Resources"))

local Color = Resources:LoadLibrary("Color")
local Enumeration = Resources:LoadLibrary("Enumeration")
local Tween = Resources:LoadLibrary("Tween")

local SourceSansSemibold = Enum.Font.SourceSansSemibold.Value
local Code = Enum.Font.Code
local Align = Enum.TextXAlignment.Center


local ENTER_TIME = 150 / 1000 * 2
local OutBack = Enumeration.EasingFunction.OutBack.Value


local function createBox(where, name, size)
	if not size then
		size = UDim2.new(0, 280, 0, 117)
	end
	if not name then
		name = "Frame"
	end

	local Frame = Instance.new("Frame")
		Frame.BackgroundTransparency = 1
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.Name = name
		Frame.Parent = where

	local UIScale = Instance.new("UIScale")
		UIScale.Scale = 0
		UIScale.Name = "UIScale"
		UIScale.Parent = Frame

	local Background = Instance.new("ImageLabel")
		Background.BackgroundTransparency = 1
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(4, 4, 256 - 4, 256 - 4)
		Background.Image = "rbxassetid://1934624205"
		Background.Size = size
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.Name = "Background"
		Background.ZIndex = 2
		Background.Parent = Frame
	return Frame
end

function misc:displayError (plr, msg, persist)
	local LoadingScreen = Instance.new("ScreenGui")
		LoadingScreen.Name = "errorScreen"
		LoadingScreen.DisplayOrder = 2

	local Frame = createBox(LoadingScreen)

	local Header = Instance.new("TextLabel")
		Header.Font = SourceSansSemibold
		Header.TextSize = 26
		Header.Size = UDim2.new(1, -48, 0, 64)
		Header.Position = UDim2.new(0, 24, -0.1, 0)
		Header.BackgroundTransparency = 1
		Header.TextXAlignment = Align
		Header.TextTransparency = 0.13
		Header.TextColor3 = Color.Red[600]
		Header.Name = "Header"
		Header.ZIndex = 3
		Header.Text = "Error"
		Header.Parent = Frame.Background

		local Sub = Instance.new("TextLabel")
		Sub.Font = Code
		Sub.TextSize = 13
		Sub.Size = UDim2.new(1, -24, 0.6, 0)
		Sub.Position = UDim2.new(0, 12, 0.4, -12)
		Sub.BackgroundTransparency = 1
		Sub.TextXAlignment = Align
		Sub.TextTransparency = 0.13
		Sub.TextColor3 = Color.Black
		Sub.Name = "Subtext"
		Sub.ZIndex = 3
		Sub.Text = msg
		Sub.TextWrapped = true
		Sub.Parent = Frame.Background

		LoadingScreen.Parent = plr.PlayerGui
		Tween(Frame.UIScale, "Scale", 1, OutBack, ENTER_TIME, true)

		wait(ENTER_TIME + 3)
		if not persist then
			Tween(Frame.UIScale, "Scale", 0, OutBack, ENTER_TIME, true)
			LoadingScreen:Destroy()
		end

end

function misc:displayMessage (plr, msg, p)

	local MsgScreen = Instance.new("ScreenGui")
		MsgScreen.Name = "msgScreen"
		MsgScreen.DisplayOrder = 1

	local Frame = createBox(MsgScreen)

	local Header = Instance.new("TextLabel")
		Header.Font = SourceSansSemibold
		Header.TextSize = 26
		Header.Size = UDim2.new(1, -48, 0, 64)
		Header.Position = UDim2.new(0, 24, -0.1, 0)
		Header.BackgroundTransparency = 1
		Header.TextXAlignment = Align
		Header.TextTransparency = 0.13
		Header.TextColor3 = Color.Black
		Header.Name = "Header"
		Header.ZIndex = 3
		Header.Text = "Message"
		Header.Parent = Frame.Background

		local Sub = Instance.new("TextLabel")
		Sub.Font = Code
		Sub.TextSize = 13
		Sub.Size = UDim2.new(1, -24, 0.6, 0)
		Sub.Position = UDim2.new(0, 12, 0.4, -12)
		Sub.BackgroundTransparency = 1
		Sub.TextXAlignment = Align
		Sub.TextTransparency = 0.13
		Sub.TextColor3 = Color.Black
		Sub.Name = "Subtext"
		Sub.ZIndex = 3
		Sub.Text = msg
		Sub.TextWrapped = true
		Sub.Parent = Frame.Background

		MsgScreen.Parent = plr.PlayerGui
		Tween(Frame.UIScale, "Scale", 1, OutBack, ENTER_TIME, true)
		wait(ENTER_TIME + 3)

		if not p then
			Tween(Frame.UIScale, "Scale", 0, OutBack, ENTER_TIME, true)
			MsgScreen:Destroy()
		end

end

return misc


