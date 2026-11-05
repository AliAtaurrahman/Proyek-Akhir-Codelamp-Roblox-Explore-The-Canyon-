function onTouched(hit)
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	if humanoid~=nil then
		wait(0.01)
		script.Parent.Sound:Play()
	end 
end 

script.Parent.Touched:connect(onTouched)