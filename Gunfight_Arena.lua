local VirtualInputManager = game:GetService("VirtualInputManager")
local autoShotEnabled = false
local shooting = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AIMBOT_KEY = Enum.KeyCode.E
local EXCLUDE_KEY = Enum.KeyCode.Q
local CLEAR_EXCLUDES_KEY = Enum.KeyCode.T

local excluded = {}
local excludedNames = {}
local currentTarget = nil
local aiming = false

task.spawn(function()
	while true do
		if autoShotEnabled and aiming and currentTarget then
			VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
			VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
		end
		task.wait(0.025) -- điều chỉnh tốc độ bắn
	end
end)

-- Tạo GUI nếu chưa có
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "AimbotGui"

local function createButton(name, color, position)
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

-- Tạo nút
local aimButton = createButton("AimButton", Color3.fromRGB(255, 0, 0), UDim2.new(0.8, 0, 0.7, -80))
local excludeButton = createButton("ExcludeButton", Color3.fromRGB(0, 255, 0), UDim2.new(0.8, 0, 0.5, -80))
local clearButton = createButton("ClearButton", Color3.fromRGB(255, 255, 0), UDim2.new(0.8, 0, 0.3, -80))

-- ESP
local function createESP(target, color)
	if not target:FindFirstChild("ESP_Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "ESP_Highlight"
		highlight.Adornee = target
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillTransparency = 0.8
		highlight.OutlineTransparency = 0
		highlight.FillColor = color
		highlight.OutlineColor = color
		highlight.Parent = target
	end
end

local function removeESP(target)
	if target and target:FindFirstChild("ESP_Highlight") then
		target.ESP_Highlight:Destroy()
	end
end

-- Kiểm tra hợp lệ
local function isValidTarget(model)
	if not model:IsA("Model") then return false end
	if model == LocalPlayer.Character then return false end
	if excluded[model] or excludedNames[model.Name] then return false end
	if not model:FindFirstChild("HumanoidRootPart") then return false end
	return true
end

-- Tìm mục tiêu gần tâm màn hình và không bị vật che khuất
local function getClosestToCenter()
	local closest = nil
	local minDist = math.huge

	for _, model in ipairs(workspace:GetChildren()) do
		if isValidTarget(model) then
			local hrp = model:FindFirstChild("HumanoidRootPart")
			if hrp then
				local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
				if onScreen then
					local origin = Camera.CFrame.Position
					local direction = (hrp.Position - origin).Unit * (hrp.Position - origin).Magnitude
					local rayParams = RaycastParams.new()
					rayParams.FilterType = Enum.RaycastFilterType.Blacklist
					rayParams.FilterDescendantsInstances = {LocalPlayer.Character, model}
					local result = workspace:Raycast(origin, direction, rayParams)

					if not result or (result.Instance and model:IsAncestorOf(result.Instance)) then
						local dist = (Vector2.new(screenPos.X, screenPos.Y) - Camera.ViewportSize / 2).Magnitude
						if dist < minDist then
							minDist = dist
							closest = model
						end
					end
				end
			end
		end
	end

	return closest
end

-- Render mỗi frame
RunService.RenderStepped:Connect(function()
	if aiming then
		local newTarget = getClosestToCenter()

		if currentTarget then
			local humanoid = currentTarget:FindFirstChildOfClass("Humanoid")
			local hrp = currentTarget:FindFirstChild("HumanoidRootPart")

			if humanoid and humanoid.Health <= 0 then
				removeESP(currentTarget)
				excluded[currentTarget] = true
				currentTarget = nil
			elseif hrp then
				local origin = Camera.CFrame.Position
				local direction = (hrp.Position - origin).Unit * (hrp.Position - origin).Magnitude
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
			Camera.CFrame = CFrame.new(
				Camera.CFrame.Position,
				currentTarget.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0))
		end
	else
		if currentTarget then
			removeESP(currentTarget)
			currentTarget = nil
		end
	end

	for _, model in ipairs(workspace:GetChildren()) do
		if model:IsA("Model") and excludedNames[model.Name] and not excluded[model] then
			createESP(model, Color3.fromRGB(0, 255, 0))
			excluded[model] = true
		end
	end
end)

-- Nút GUI
aimButton.MouseButton1Down:Connect(function()
	aiming = true
end)
aimButton.MouseButton1Up:Connect(function()
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

clearButton.MouseButton1Click:Connect(function()
	for model, _ in pairs(excluded) do
		removeESP(model)
	end
	excluded = {}
	excludedNames = {}
end)

-- Bắt phím
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

    	if input.KeyCode == Enum.KeyCode.Y then
    	autoShotEnabled = not autoShotEnabled
	    shooting = false
    
    	game.StarterGui:SetCore("SendNotification", {
	    	Title = "Auto Shot",
	    	Text = autoShotEnabled and "Đã BẬT tự động bắn" or "Đã TẮT tự động bắn",
    		Duration = 2
    	})
    end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == AIMBOT_KEY then
		aiming = false
	end
end)

print("aimbot = true")
