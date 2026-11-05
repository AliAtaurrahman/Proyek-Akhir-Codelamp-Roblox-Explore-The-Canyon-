local Players = game:GetService("Players")
local player = Players.LocalPlayer
local label = script.Parent:FindFirstChild("TextLabel")

local function setup(stats)
	local coins = stats and stats:FindFirstChild("Coins")
	if not coins then return end
	local function update()
		if label then
			label.Text = "Coins: " .. coins.Value
		end
	end
	update()
	coins.Changed:Connect(update)
end

if player:FindFirstChild("leaderstats") then
	setup(player.leaderstats)
else
	player:WaitForChild("leaderstats")
	setup(player.leaderstats)
end