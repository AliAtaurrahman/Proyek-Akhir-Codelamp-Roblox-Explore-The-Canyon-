local pad = script.Parent
local target = workspace.PadB
pad.Touched:Connect(function(hit)
	hit.Parent:PivotTo(
		target.CFrame)
end)