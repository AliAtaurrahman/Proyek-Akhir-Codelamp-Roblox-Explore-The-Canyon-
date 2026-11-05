local Players = game:GetService("Players")

-- 1. Membuat leaderstats saat pemain masuk
Players.PlayerAdded:Connect(function(plr)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = plr

	local wins = Instance.new("IntValue")
	wins.Name = "Wins"
	wins.Value = 0
	leaderstats.Parent = plr
	wins.Parent = leaderstats
end)

-- 2. Fungsi melacak saat pemain menyentuh garis Finish
local finishPart = workspace:WaitForChild("Finish Line") -- Ganti dengan nama Part Finish milikmu
local cooldowns = {}

finishPart.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = Players:GetPlayerFromCharacter(character)

	if player and not cooldowns[player] then
		cooldowns[player] = true

		-- Tambahkan 1 kemenangan
		player.leaderstats.Wins.Value = player.leaderstats.Wins.Value + 1

		-- Cooldown agar poin tidak bertambah terus-menerus saat tersentuh berkali-kali
		task.wait(3) 
		cooldowns[player] = nil
	end
end)