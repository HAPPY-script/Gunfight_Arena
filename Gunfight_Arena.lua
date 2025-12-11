if _G.Gunfight_Arena then
    warn("Script đã chạy! Không thể chạy lại.")
    return
end
_G.Gunfight_Arena = true

local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AIMBOT_KEY = Enum.KeyCode.E
local EXCLUDE_KEY = Enum.KeyCode.Q
local CLEAR_EXCLUDES_KEY = Enum.KeyCode.T
local AUTO_SHOT_TOGGLE = Enum.KeyCode.Y
local DEFAULT_ESP_KEY = Enum.KeyCode.B

local autoShotEnabled = false
local shooting = false
local excluded = {}
local excludedNames = {}
local currentTarget = nil
local aiming = false
local defaultESPEnabled = true
local defaultESPColor = Color3.fromRGB(200, 200, 200)

-- chỉ còn 1 chế độ duy nhất: AutoGun
task.spawn(function()
	while true do
		if autoShotEnabled and aiming and currentTarget then
			if UserInputService.TouchEnabled then
				-- Mobile: click nhanh
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
				task.wait(0.025)
			else
				-- PC: giữ chuột
				if not shooting then
					shooting = true
					VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
				end
				task.wait(0.025)
			end
		else
			if shooting then
				-- Thả chuột khi không aim hoặc không có target
				VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
				shooting = false
			end
			task.wait(0.05)
		end
	end
end)

local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local existing = playerGui:FindFirstChild("AimbotGui")
if existing then
	existing.ResetOnSpawn = false
end

local gui = existing or Instance.new("ScreenGui")
if not existing then
	gui.Name = "AimbotGui"
	gui.Parent = playerGui
end
gui.ResetOnSpawn = false

local function createButton(name, color, position)
	local btn = gui:FindFirstChild(name)
	if btn and btn:IsA("TextButton") then
		btn.Position = position
		btn.Size = UDim2.new(0, 60, 0, 60)
		btn.BackgroundColor3 = color
		return btn
	end

	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(0, 60, 0, 60)
	button.Position = position
	button.BackgroundColor3 = color
	button.Text = ""
	button.AutoButtonColor = true
	button.Parent = gui

	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(1, 0)
	uicorner.Parent = button

	return button
end

local aimButton = createButton("AimButton", Color3.fromRGB(255, 0, 0), UDim2.new(0.8, 0, 0.7, -80))
local excludeButton = createButton("ExcludeButton", Color3.fromRGB(0, 255, 0), UDim2.new(0.8, 0, 0.5, -80))
local clearButton = createButton("ClearButton", Color3.fromRGB(255, 255, 0), UDim2.new(0.8, 0, 0.3, -80))

local function updateMobileVisibility()
	local isMobile = UserInputService.TouchEnabled
	gui.Enabled = isMobile
	aimButton.Visible = isMobile
	excludeButton.Visible = isMobile
	clearButton.Visible = isMobile
end
updateMobileVisibility()
UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(updateMobileVisibility)

local function createESP(target, color)
	if not target or not target:IsA("Model") then return end
	local highlight = target:FindFirstChild("ESP_Highlight")
	if not highlight then
		highlight = Instance.new("Highlight")
		highlight.Name = "ESP_Highlight"
		highlight.Adornee = target
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillTransparency = 0.8
		highlight.OutlineTransparency = 0
		highlight.Parent = target
	end
	highlight.FillColor = color
	highlight.OutlineColor = color
end

local function removeESP(target)
	if target and target:FindFirstChild("ESP_Highlight") then
		target.ESP_Highlight:Destroy()
	end
end

local function isValidTarget(model)
	if not model or not model:IsA("Model") then return false end
	if model == LocalPlayer.Character then return false end
	if excluded[model] or excludedNames[model.Name] then return false end
	if not model:FindFirstChild("HumanoidRootPart") then return false end
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return false end
	return true
end

local function getClosestToCenter()
	local closest = nil
	local minDist = math.huge
	local camPos = Camera.CFrame.Position
	local viewportCenter = Camera.ViewportSize / 2

	local children = workspace:GetChildren()
	for i = 1, #children do
		local model = children[i]
		if isValidTarget(model) then
			local hrp = model:FindFirstChild("HumanoidRootPart")
			if hrp then
				local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
				if onScreen then
					local origin = camPos
					local direction = (hrp.Position - origin)
					if direction.Magnitude ~= 0 then
						local rayParams = RaycastParams.new()
						rayParams.FilterType = Enum.RaycastFilterType.Blacklist
						rayParams.FilterDescendantsInstances = {LocalPlayer.Character, model}
						local result = workspace:Raycast(origin, direction, rayParams)

						if not result or (result.Instance and model:IsAncestorOf(result.Instance)) then
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
							if dist < minDist then
								minDist = dist
								closest = model
							end
						end
					end
				end
			end
		end
	end

	return closest
end

RunService.RenderStepped:Connect(function()
		
	if defaultESPEnabled then
		for _, model in pairs(workspace:GetChildren()) do
			if model:IsA("Model") and model ~= LocalPlayer.Character then
				-- Bỏ qua nếu model đã bị exclude (có tên trong excludedNames)
				if not excludedNames[model.Name] then
					if not model:FindFirstChild("ESP_Highlight") then
						createESP(model, defaultESPColor)
					end
				end
			end
		end
	else
		for _, model in pairs(workspace:GetChildren()) do
			if model:IsA("Model") then
				local h = model:FindFirstChild("ESP_Highlight")
				if h and h.FillColor == defaultESPColor then
					h:Destroy()
				end
			end
		end
	end

	if aiming then
		local newTarget = getClosestToCenter()

		if currentTarget then
			local humanoid = currentTarget:FindFirstChildOfClass("Humanoid")
			local hrp = currentTarget:FindFirstChild("HumanoidRootPart")
			if not humanoid or humanoid.Health <= 0 then
				removeESP(currentTarget)
				excluded[currentTarget] = true
				currentTarget = nil
			elseif hrp then
				local origin = Camera.CFrame.Position
				local direction = (hrp.Position - origin)
				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Blacklist
				rayParams.FilterDescendantsInstances = {LocalPlayer.Character, currentTarget}
				local result = workspace:Raycast(origin, direction, rayParams)
				if result and not currentTarget:IsAncestorOf(result.Instance) then
					removeESP(currentTarget)
					currentTarget = nil
				end
			end
		end

		if not currentTarget and newTarget then
			currentTarget = newTarget
			createESP(currentTarget, Color3.fromRGB(255, 0, 0))
		end

		if currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
			pcall(function()
				Camera.CFrame = CFrame.new(
					Camera.CFrame.Position,
					currentTarget.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
				)
			end)
		end
	else
		if currentTarget then
			removeESP(currentTarget)
			currentTarget = nil
		end
	end

	local children = workspace:GetChildren()
	for i = 1, #children do
		local model = children[i]
		if model and model:IsA("Model") and excludedNames[model.Name] and not excluded[model] then
			createESP(model, Color3.fromRGB(0, 255, 0))
			excluded[model] = true
		end
	end
end)

local function bindHoldBehavior(button, onDown, onUp)
	button.MouseButton1Down:Connect(function()
		onDown()
	end)
	button.MouseButton1Up:Connect(function()
		onUp()
	end)
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			onDown()
		end
	end)
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			onUp()
		end
	end)
end

bindHoldBehavior(aimButton, function()
	aiming = true
end, function()
	aiming = false
end)

excludeButton.MouseButton1Click:Connect(function()
	if currentTarget then
		excluded[currentTarget] = true
		excludedNames[currentTarget.Name] = true
		removeESP(currentTarget)
		createESP(currentTarget, Color3.fromRGB(0, 255, 0))
		currentTarget = nil
	end
end)
excludeButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		if currentTarget then
			excluded[currentTarget] = true
			excludedNames[currentTarget.Name] = true
			removeESP(currentTarget)
			createESP(currentTarget, Color3.fromRGB(0, 255, 0))
			currentTarget = nil
		end
	end
end)

clearButton.MouseButton1Click:Connect(function()
	for model, _ in pairs(excluded) do
		removeESP(model)
	end
	excluded = {}
	excludedNames = {}
end)
clearButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		for model, _ in pairs(excluded) do
			removeESP(model)
		end
		excluded = {}
		excludedNames = {}
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == AIMBOT_KEY then
		aiming = true
	end

	if input.KeyCode == EXCLUDE_KEY and currentTarget then
		excluded[currentTarget] = true
		excludedNames[currentTarget.Name] = true
		removeESP(currentTarget)
		createESP(currentTarget, Color3.fromRGB(0, 255, 0))
		currentTarget = nil
	end

	if input.KeyCode == CLEAR_EXCLUDES_KEY then
		for model, _ in pairs(excluded) do
			removeESP(model)
		end
		excluded = {}
		excludedNames = {}
	end

	if input.KeyCode == AUTO_SHOT_TOGGLE then
		autoShotEnabled = not autoShotEnabled
		shooting = false
		pcall(function()
			game.StarterGui:SetCore("SendNotification", {
				Title = "Auto Shot",
				Text = autoShotEnabled and "Đã BẬT tự động bắn" or "Đã TẮT tự động bắn",
				Duration = 2
			})
		end)
	end

    if input.KeyCode == DEFAULT_ESP_KEY then
		defaultESPEnabled = not defaultESPEnabled
		pcall(function()
			game.StarterGui:SetCore("SendNotification", {
				Title = "ESP",
				Text = defaultESPEnabled and "Đã BẬT ESP xám" or "Đã TẮT ESP xám",
				Duration = 2
			})
		end)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == AIMBOT_KEY then
		aiming = false
	end
end)

print("aimbot = true (local script, AutoGun only)")
