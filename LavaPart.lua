local part = script.Parent
part.Touched:Connect(function(hit)
	local h = hit.Parent:
		FindFirstChild("Humanoid")
	if h then h.Health -= 100 end
end)
