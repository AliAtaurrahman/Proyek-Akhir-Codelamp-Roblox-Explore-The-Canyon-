-- Server script untuk menangani permintaan respawn dari client
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")

local respawnEvent = ReplicatedStorage:WaitForChild("RespawnPlayer")

-- Fungsi untuk memulihkan semua coin di map
local function restoreCoins()
	local folder = Workspace:FindFirstChild("Folder")
	if folder then
		local coins = folder:FindFirstChild("Coins")
		if coins then
			for _, coin in ipairs(coins:GetChildren()) do
				coin:SetAttribute("Collected", false)
				coin.Transparency = 0
				coin.CanTouch = true
			end
		end
	end
end

respawnEvent.OnServerEvent:Connect(function(player)
	-- Validasi: pastikan player masih ada dan character ada
	if player and player.Parent then
		-- Reset coin player ke 0
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local coins = leaderstats:FindFirstChild("Coins")
			if coins then
				coins.Value = 0
			end
		end

		-- Set checkpoint ke SpawnLocation agar player spawn di lokasi awal
		local checkpointData = ServerStorage:FindFirstChild("CheckpointData")
		if checkpointData then
			local checkpoint = checkpointData:FindFirstChild(tostring(player.UserId))
			if checkpoint then
				checkpoint.Value = Workspace:FindFirstChild("SpawnLocation")
			end
		end

		-- Pulihkan semua coin di map
		restoreCoins()

		-- Load character (player akan spawn di SpawnLocation)
		player:LoadCharacter()
	end
end)