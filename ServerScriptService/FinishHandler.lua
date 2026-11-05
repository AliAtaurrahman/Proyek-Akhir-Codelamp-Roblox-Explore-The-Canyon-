local FinishLine = workspace:WaitForChild("Finish Line")
local Layer = FinishLine:WaitForChild("Detection Player")
local Players = game:GetService("Players")

local cooldowns = {}

Layer.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = Players:GetPlayerFromCharacter(character)

	if player and not cooldowns[player] then
		cooldowns[player] = true

		-- Menambahkan Wins di Server
		player.leaderstats.Wins.Value = player.leaderstats.Wins.Value + 1

		task.wait(3) -- Cooldown agar tidak bertambah terus-menerus
		cooldowns[player] = nil
	end
end)