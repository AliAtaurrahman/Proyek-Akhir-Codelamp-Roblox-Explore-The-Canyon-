local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Remote Event untuk pembelian Coins/Wins
local buyItemEvent = ReplicatedStorage:WaitForChild("BuyItemEvent")

-- Daftar Developer Product ID untuk Robux
local ROBUX_PRODUCTS = {
	[3715293027] = "SlapHand", -- ID Robux Slap Hand (3 Robux)
	[3715293091] = "SpeedCoil",     -- ID Robux Coil (3 Robux)
	[3715293140] = "Carpet",   -- ID Robux Carpet (5 Robux)
	[3715289003] = "Sword",    -- ID Robux Sword (10 Robux)
	[3715289079] = "LaserGun",      -- ID Robux Gun (10 Robux)
	[3715289110] = "RPG",      -- ID Robux Pen (20 Robux)
}

-- Fungsi Pembantu Memberikan Item (DIREVISI)
local function giveItem(player, itemName)
	local tool = ServerStorage:FindFirstChild(itemName)
	if tool then
		-- 1. Cek jika player belum memiliki item ini sama sekali
		local hasInBackpack = player.Backpack:FindFirstChild(itemName)
		local hasInCharacter = player.Character and player.Character:FindFirstChild(itemName)
		local hasInStarterGear = player.StarterGear:FindFirstChild(itemName)

		if not hasInBackpack and not hasInCharacter then
			-- Masukkan ke Backpack agar bisa langsung dipakai saat ini
			local clonedTool = tool:Clone()
			clonedTool.Parent = player.Backpack
		end

		if not hasInStarterGear then
			-- Masukkan ke StarterGear agar TETAP ADA saat mati / respawn
			local starterTool = tool:Clone()
			starterTool.Parent = player.StarterGear
		end

		print(player.Name .. " berhasil mendapatkan " .. itemName)
		return true
	else
		warn("Tool " .. itemName .. " tidak ditemukan di ServerStorage!")
		return false
	end
end

-- =========================================================
-- 1. PROSES PEMBELIAN DENGAN COINS / WINS
-- =========================================================
buyItemEvent.OnServerEvent:Connect(function(player, itemName, currencyType, price)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local stat = leaderstats:FindFirstChild(currencyType) -- "Coins" atau "Wins"
	if stat then
		if stat.Value >= price then
			stat.Value = stat.Value - price
			giveItem(player, itemName)
		else
			print("Gagal: " .. currencyType .. " tidak mencukupi!")
		end
	end
end)

-- =========================================================
-- 2. PROSES PEMBELIAN DENGAN ROBUX (DEVELOPER PRODUCT)
-- =========================================================
MarketplaceService.ProcessReceipt = function(receiptInfo)
	local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local itemName = ROBUX_PRODUCTS[receiptInfo.ProductId]
	if itemName then
		local success = giveItem(player, itemName)
		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end