local button = script.Parent
local shopGui = button.Parent
local shopFrame = shopGui:WaitForChild("ShopFrame")

button.MouseButton1Click:Connect(function()
	-- Mengubah status Visible (jika tertutup jadi terbuka, jika terbuka jadi tertutup)
	shopFrame.Visible = not shopFrame.Visible
end)