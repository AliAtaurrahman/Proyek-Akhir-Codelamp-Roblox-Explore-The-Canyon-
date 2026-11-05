local door = script.Parent
door.Touched:Connect(function()
	door.Transparency = 0.7
	door.CanCollide = false
end)
