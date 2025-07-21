local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AIMBOT_KEY = Enum.KeyCode.E
local EXCLUDE_KEY = Enum.KeyCode.Q
local CLEAR_EXCLUDES_KEY = Enum.KeyCode.T

local excluded = {}
local currentTarget = nil
local aiming = false

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

local function removeESP(target)
	if target and target:FindFirstChild("ESP_Highlight") then
		target.ESP_Highlight:Destroy()
	end
end

-- Kiểm tra hợp lệ
local function isValidTarget(model)
	if not model:IsA("Model") or excluded[model] then return false end
	if model == LocalPlayer.Character then return false end
	if not model:FindFirstChild("HumanoidRootPart") then return false end
	return true
end

-- Tìm mục tiêu gần tâm màn hình
local function getClosestToCenter()
	local closest = nil
	local minDist = math.huge
	for _, model in ipairs(workspace:GetChildren()) do
		if isValidTarget(model) then
			local hrp = model:FindFirstChild("HumanoidRootPart")
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				local dist = (Vector2.new(pos.X, pos.Y) - Camera.ViewportSize / 2).Magnitude
				if dist < minDist then
					minDist = dist
					closest = model
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
		if newTarget and newTarget ~= currentTarget then
			if currentTarget then removeESP(currentTarget) end
			currentTarget = newTarget
			createESP(currentTarget, Color3.fromRGB(255, 0, 0)) -- Đỏ = bị aim
		end

		if currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
			Camera.CFrame = CFrame.new(
	        Camera.CFrame.Position,
	        currentTarget.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
		end
	elseif currentTarget then
		removeESP(currentTarget)
		currentTarget = nil
	end
end)

-- Bấm nút giữ để aimbot
aimButton.MouseButton1Down:Connect(function()
	aiming = true
end)
aimButton.MouseButton1Up:Connect(function()
	aiming = false
end)

-- Bấm nút loại bỏ khỏi aim
excludeButton.MouseButton1Click:Connect(function()
	if currentTarget then
		excluded[currentTarget] = true
		removeESP(currentTarget)
		createESP(currentTarget, Color3.fromRGB(0, 255, 0)) -- Xanh lá = loại trừ
		currentTarget = nil
	end
end)

-- Bấm nút xóa toàn bộ loại trừ
clearButton.MouseButton1Click:Connect(function()
	for model, _ in pairs(excluded) do
		removeESP(model)
	end
	excluded = {}
end)

-- Dành cho người dùng phím bấm (PC)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == AIMBOT_KEY then aiming = true end
	if input.KeyCode == EXCLUDE_KEY and currentTarget then
		excluded[currentTarget] = true
		removeESP(currentTarget)
		createESP(currentTarget, Color3.fromRGB(0, 255, 0))
		currentTarget = nil
	end
	if input.KeyCode == CLEAR_EXCLUDES_KEY then
		for model, _ in pairs(excluded) do removeESP(model) end
		excluded = {}
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == AIMBOT_KEY then aiming = false end
end)

print("aimbot = true")
