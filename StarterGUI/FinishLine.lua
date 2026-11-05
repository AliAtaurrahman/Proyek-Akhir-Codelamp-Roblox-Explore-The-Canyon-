local FinishLine = game.Workspace:WaitForChild("Finish Line")
local Layer = FinishLine:WaitForChild("Detection Player")
local FinishUI = script.Parent
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local respawnEvent = ReplicatedStorage:WaitForChild("RespawnPlayer")
local coinsLabel = FinishUI:WaitForChild("Overlay"):WaitForChild("Panel"):WaitForChild("Content"):WaitForChild("CoinsLabel")
local playAgainBtn = FinishUI:WaitForChild("Overlay"):WaitForChild("Panel"):WaitForChild("Content"):WaitForChild("PlayAgainButton")
local overlay = FinishUI:WaitForChild("Overlay")
local panel = overlay:WaitForChild("Panel")
local finishSound = FinishUI:WaitForChild("FinishSound")

local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")
local wins = leaderstats:WaitForChild("Wins") -- Menambahkan referensi Wins

-- Update teks saat skor/kemenangan berubah
local function updateScoreText()
	coinsLabel.Text = "You collected " .. coins.Value .. " coins!"
end

-- Animasi muncul UI
local function showFinishUI()
	updateScoreText()
	FinishUI.Enabled = true
	finishSound:Play()

	-- Reset ke posisi awal
	overlay.BackgroundTransparency = 1
	panel.AnchorPoint = Vector2.new(0.5, 0.5)
	panel.Size = UDim2.new(0, 0, 0, 0)
	panel.GroupTransparency = 1

	-- Animasi overlay fade in
	TweenService:Create(overlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0.4
	}):Play()

	-- Animasi panel scale up
	TweenService:Create(panel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 450, 0, 320),
		GroupTransparency = 0
	}):Play()
end

-- Animasi hilang UI
local function hideFinishUI()
	TweenService:Create(overlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play()

	TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		GroupTransparency = 1
	}):Play()

	task.wait(0.35)
	FinishUI.Enabled = false
end

Layer.Touched:Connect(function(hit)
	local character = hit.Parent
	local touchedPlayer = Players:GetPlayerFromCharacter(character)

	if touchedPlayer == player then
		showFinishUI()
	end
end)

-- Tombol Play Again
playAgainBtn.MouseButton1Click:Connect(function()
	hideFinishUI()
	task.wait(0.4)
	respawnEvent:FireServer()
end)

coins.Changed:Connect(updateScoreText)
wins.Changed:Connect(updateScoreText)