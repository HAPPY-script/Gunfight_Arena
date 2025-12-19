local GuideScript = Instance.new("ScreenGui")
GuideScript.Name = "GuideScript"
GuideScript.ResetOnSpawn = false
GuideScript.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GuideScript.DisplayOrder = 999
GuideScript.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0.35, 0, 0.35, 0)
Main.BackgroundColor3 = Color3.new(0.0470588, 0, 0.141176)
Main.BorderSizePixel = 0
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.ZIndex = 999
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = GuideScript

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1.5
UIAspectRatioConstraint.Parent = Main

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 0.5
Title.BorderSizePixel = 0
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 0.5
Title.Text = "Instruct"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14
Title.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextScaled = true
Title.TextWrapped = true
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Position = UDim2.new(0.865, 0, 0, 0)
Close.Size = UDim2.new(1, 0, 1, 0)
Close.BackgroundColor3 = Color3.new(0.737255, 0, 0)
Close.BorderSizePixel = 0
Close.BorderColor3 = Color3.new(0, 0, 0)
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 14
Close.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Close.TextScaled = true
Close.TextWrapped = true
Close.Parent = Title

local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint2.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint2.Parent = Close

local Key1 = Instance.new("ImageButton")
Key1.Name = "Key1"
Key1.Position = UDim2.new(0.157532, 0, 0.252057, 0)
Key1.Size = UDim2.new(0.35, 0, 0.35, 0)
Key1.BackgroundColor3 = Color3.new(1, 1, 1)
Key1.BackgroundTransparency = 1
Key1.BorderSizePixel = 0
Key1.BorderColor3 = Color3.new(0, 0, 0)
Key1.Transparency = 1
Key1.Image = "rbxassetid://74180562403532"
Key1.Parent = Main

local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint3.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint3.Parent = Key1

local TextKey = Instance.new("TextLabel")
TextKey.Name = "TextKey"
TextKey.Size = UDim2.new(1, 0, 1, 0)
TextKey.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey.BackgroundTransparency = 1
TextKey.BorderSizePixel = 0
TextKey.BorderColor3 = Color3.new(0, 0, 0)
TextKey.TextTransparency = 0
TextKey.Text = "E"
TextKey.TextColor3 = Color3.new(0, 0, 0)
TextKey.TextSize = 14
TextKey.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey.TextScaled = true
TextKey.TextWrapped = true
TextKey.Parent = Key1

local Key2 = Instance.new("ImageButton")
Key2.Name = "Key2"
Key2.Position = UDim2.new(0.382532, 0, 0.252057, 0)
Key2.Size = UDim2.new(0.35, 0, 0.35, 0)
Key2.BackgroundColor3 = Color3.new(1, 1, 1)
Key2.BackgroundTransparency = 1
Key2.BorderSizePixel = 0
Key2.BorderColor3 = Color3.new(0, 0, 0)
Key2.Transparency = 1
Key2.Image = "rbxassetid://74180562403532"
Key2.Parent = Main

local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint4.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint4.Parent = Key2

local TextKey2 = Instance.new("TextLabel")
TextKey2.Name = "TextKey"
TextKey2.Size = UDim2.new(1, 0, 1, 0)
TextKey2.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey2.BackgroundTransparency = 1
TextKey2.BorderSizePixel = 0
TextKey2.BorderColor3 = Color3.new(0, 0, 0)
TextKey2.TextTransparency = 0
TextKey2.Text = "Q"
TextKey2.TextColor3 = Color3.new(0, 0, 0)
TextKey2.TextSize = 14
TextKey2.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey2.TextScaled = true
TextKey2.TextWrapped = true
TextKey2.Parent = Key2

local Key3 = Instance.new("ImageButton")
Key3.Name = "Key3"
Key3.Position = UDim2.new(0.607532, 0, 0.252057, 0)
Key3.Size = UDim2.new(0.35, 0, 0.35, 0)
Key3.BackgroundColor3 = Color3.new(1, 1, 1)
Key3.BackgroundTransparency = 1
Key3.BorderSizePixel = 0
Key3.BorderColor3 = Color3.new(0, 0, 0)
Key3.Transparency = 1
Key3.Image = "rbxassetid://74180562403532"
Key3.Parent = Main

local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint5.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint5.Parent = Key3

local TextKey3 = Instance.new("TextLabel")
TextKey3.Name = "TextKey"
TextKey3.Size = UDim2.new(1, 0, 1, 0)
TextKey3.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey3.BackgroundTransparency = 1
TextKey3.BorderSizePixel = 0
TextKey3.BorderColor3 = Color3.new(0, 0, 0)
TextKey3.TextTransparency = 0
TextKey3.Text = "T"
TextKey3.TextColor3 = Color3.new(0, 0, 0)
TextKey3.TextSize = 14
TextKey3.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey3.TextScaled = true
TextKey3.TextWrapped = true
TextKey3.Parent = Key3

local Key4 = Instance.new("ImageButton")
Key4.Name = "Key4"
Key4.Position = UDim2.new(0.267008, 0, 0.599145, 0)
Key4.Size = UDim2.new(0.35, 0, 0.35, 0)
Key4.BackgroundColor3 = Color3.new(1, 1, 1)
Key4.BackgroundTransparency = 1
Key4.BorderSizePixel = 0
Key4.BorderColor3 = Color3.new(0, 0, 0)
Key4.Transparency = 1
Key4.Image = "rbxassetid://74180562403532"
Key4.Parent = Main

local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint6.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint6.Parent = Key4

local TextKey4 = Instance.new("TextLabel")
TextKey4.Name = "TextKey"
TextKey4.Size = UDim2.new(1, 0, 1, 0)
TextKey4.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey4.BackgroundTransparency = 1
TextKey4.BorderSizePixel = 0
TextKey4.BorderColor3 = Color3.new(0, 0, 0)
TextKey4.TextTransparency = 0
TextKey4.Text = "Y"
TextKey4.TextColor3 = Color3.new(0, 0, 0)
TextKey4.TextSize = 14
TextKey4.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey4.TextScaled = true
TextKey4.TextWrapped = true
TextKey4.Parent = Key4

local Key5 = Instance.new("ImageButton")
Key5.Name = "Key5"
Key5.Position = UDim2.new(0.493836, 0, 0.599145, 0)
Key5.Size = UDim2.new(0.35, 0, 0.35, 0)
Key5.BackgroundColor3 = Color3.new(1, 1, 1)
Key5.BackgroundTransparency = 1
Key5.BorderSizePixel = 0
Key5.BorderColor3 = Color3.new(0, 0, 0)
Key5.Transparency = 1
Key5.Image = "rbxassetid://74180562403532"
Key5.Parent = Main

local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint7.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint7.Parent = Key5

local TextKey5 = Instance.new("TextLabel")
TextKey5.Name = "TextKey"
TextKey5.Size = UDim2.new(1, 0, 1, 0)
TextKey5.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey5.BackgroundTransparency = 1
TextKey5.BorderSizePixel = 0
TextKey5.BorderColor3 = Color3.new(0, 0, 0)
TextKey5.TextTransparency = 0
TextKey5.Text = "B"
TextKey5.TextColor3 = Color3.new(0, 0, 0)
TextKey5.TextSize = 14
TextKey5.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey5.TextScaled = true
TextKey5.TextWrapped = true
TextKey5.Parent = Key5

local GuideKey = Instance.new("Frame")
GuideKey.Name = "GuideKey"
GuideKey.Size = UDim2.new(1, 0, 1, 0)
GuideKey.BackgroundColor3 = Color3.new(0.0470588, 0, 0.141176)
GuideKey.BorderSizePixel = 0
GuideKey.BorderColor3 = Color3.new(0, 0, 0)
GuideKey.Visible = false
GuideKey.Parent = Main

local Back = Instance.new("TextButton")
Back.Name = "Back"
Back.Size = UDim2.new(0.25, 0, 0.25, 0)
Back.BackgroundColor3 = Color3.new(0, 0.431373, 0.831373)
Back.BorderSizePixel = 0
Back.BorderColor3 = Color3.new(0, 0, 0)
Back.Text = "<"
Back.TextColor3 = Color3.new(1, 1, 1)
Back.TextSize = 14
Back.FontFace = Font.new("rbxassetid://12187360881", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Back.TextScaled = true
Back.TextWrapped = true
Back.Parent = GuideKey

local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint8.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint8.Parent = Back

local LogoKey = Instance.new("ImageLabel")
LogoKey.Name = "LogoKey"
LogoKey.Position = UDim2.new(0.5, 0, 0.25, 0)
LogoKey.Size = UDim2.new(0.4, 0, 0.4, 0)
LogoKey.BackgroundColor3 = Color3.new(1, 1, 1)
LogoKey.BackgroundTransparency = 1
LogoKey.BorderSizePixel = 0
LogoKey.BorderColor3 = Color3.new(0, 0, 0)
LogoKey.AnchorPoint = Vector2.new(0.5, 0.5)
LogoKey.Transparency = 1
LogoKey.Image = "rbxassetid://74180562403532"
LogoKey.Parent = GuideKey

local UIAspectRatioConstraint9 = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint9.Name = "UIAspectRatioConstraint"

UIAspectRatioConstraint9.Parent = LogoKey

local TextKey6 = Instance.new("TextLabel")
TextKey6.Name = "TextKey"
TextKey6.Size = UDim2.new(1, 0, 1, 0)
TextKey6.BackgroundColor3 = Color3.new(1, 1, 1)
TextKey6.BackgroundTransparency = 1
TextKey6.BorderSizePixel = 0
TextKey6.BorderColor3 = Color3.new(0, 0, 0)
TextKey6.TextTransparency = 0
TextKey6.Text = "?"
TextKey6.TextColor3 = Color3.new(0, 0, 0)
TextKey6.TextSize = 14
TextKey6.FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextKey6.TextScaled = true
TextKey6.TextWrapped = true
TextKey6.Parent = LogoKey

local Text = Instance.new("TextLabel")
Text.Name = "Text"
Text.Position = UDim2.new(0.5, 0, 0.725, 0)
Text.Size = UDim2.new(1, 0, 0.55, 0)
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderSizePixel = 0
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.AnchorPoint = Vector2.new(0.5, 0.5)
Text.TextTransparency = 0
Text.Text = "N/A"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 14
Text.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Text.TextScaled = true
Text.TextWrapped = true
Text.Parent = GuideKey

--============================================================================================================--
-- SYSTEM
--============================================================================================================--

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Config: edit these texts for each key
local GUIDE_TEXTS = {
	Key1 = "Holding down the [E] key will automatically aim at opponents; obscured opponents will not be automatically aimed at.",
	Key2 = "The [Q] key must be combined with the [E] key. When holding down the [E] key to aim at a target, simply pressing the [Q] key will turn the currently targeted target into a teammate (you cannot aim at a teammate).",
	Key3 = "The [T] key is used to remove all teammates that you have selected using the [Q] key.",
	Key4 = "Press the [Y] key to turn auto-fire on/off. When auto-fire is enabled and you hold down the [E] key, it will automatically fire if you aim at a target.",
	Key5 = "Press the [B] key to turn gray ESP on/off.",
}

-- Try to get GuideScript ScreenGui
local success, screen = pcall(function() return playerGui:WaitForChild("GuideScript", 5) end)
if not success or not screen then
	warn("[Guide] Không tìm thấy GuideScript trong PlayerGui")
	return
end

-- Locals for UI
local main = screen:FindFirstChild("Main")
local guideKey = main and main:FindFirstChild("GuideKey")
local title = main and main:FindFirstChild("Title")

if not main or not guideKey or not title then
	warn("[Guide] UI structure không đúng hoặc thiếu Main/GuideKey/Title")
	return
end

-- Buttons Key1..Key5 (inside Main)
local keys = {
	main:FindFirstChild("Key1"),
	main:FindFirstChild("Key2"),
	main:FindFirstChild("Key3"),
	main:FindFirstChild("Key4"),
	main:FindFirstChild("Key5"),
}

-- Inner controls of GuideKey
local backBtn = guideKey:FindFirstChild("Back")
local logoKey = guideKey:FindFirstChild("LogoKey")
local logoKeyText = (logoKey and logoKey:FindFirstChild("TextKey"))
local guideTextLabel = guideKey:FindFirstChild("Text")

-- Close button inside Title
local closeBtn = title:FindFirstChild("Close")

-- Safety checks
if not backBtn or not logoKey or not logoKeyText or not guideTextLabel then
	warn("[Guide] thiếu control trong GuideKey (Back / LogoKey / Text)")
	return
end
if not closeBtn then
	warn("[Guide] Title.Close không tìm thấy")
	-- continue but Close won't work
end

local function setKeysVisible(state)
	for _, btn in ipairs(keys) do
		if btn then
			btn.Visible = state
		end
	end
end

-- initial states
setKeysVisible(true)
guideKey.Visible = false

-- store connections so we can disconnect on destroy
local connections = {}

local function safeConnect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(connections, c)
	return c
end

-- Utility to read TextKey inside a button (button has a TextLabel named TextKey)
local function getButtonTextKey(btn)
	if not btn then return nil end
	local tl = btn:FindFirstChild("TextKey") or btn:FindFirstChildWhichIsA("TextLabel", true)
	return tl and tl.Text or nil
end

-- Show guide for a specific key name (e.g. "Key1")
local function showGuideFor(keyName, sourceButton)
	-- get label content: prefer mapping in GUIDE_TEXTS; fall back to button's TextKey text
	local content = GUIDE_TEXTS[keyName] or getButtonTextKey(sourceButton) or ("No guide for " .. tostring(keyName))
	-- set logo text (inside LogoKey.TextKey)
	if logoKeyText then
		pcall(function() logoKeyText.Text = tostring(getButtonTextKey(sourceButton) or keyName) end)
	end
	-- set main text
	pcall(function() guideTextLabel.Text = tostring(content) end)

	-- show GuideKey
	setKeysVisible(false)
	guideKey.Visible = true

end

local function hideGuide()
	guideKey.Visible = false
	setKeysVisible(true)
end

-- Hook up Key buttons
for i, btn in ipairs(keys) do
	if btn and btn:IsA("ImageButton") or btn and btn:IsA("TextButton") then
		-- capture name ("Key1" .. "Key5")
		local name = btn.Name
		safeConnect(btn.MouseButton1Click, function()
			showGuideFor(name, btn)
		end)
	end
end

-- Back button
safeConnect(backBtn.MouseButton1Click, function()
	hideGuide()
end)

-- Close button: destroy the ScreenGui and disconnect connections, then end script
local function cleanupAndExit()
	-- disconnect connections
	for _, c in ipairs(connections) do
		if c and c.Disconnect then
			pcall(function() c:Disconnect() end)
		end
	end
	-- destroy GUI
	if screen and screen.Parent then
		pcall(function() screen:Destroy() end)
	end
	-- end (return from script)
end

if closeBtn then
	safeConnect(closeBtn.MouseButton1Click, function()
		cleanupAndExit()
	end)
end

-- Optional: if GuideScript is removed externally, clean up connections
safeConnect(screen.AncestryChanged, function()
	if not screen:IsDescendantOf(game) then
		for _, c in ipairs(connections) do
			if c and c.Disconnect then
				pcall(function() c:Disconnect() end)
			end
		end
	end
end)

return
