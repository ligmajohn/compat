local tracker = Signal.new()

LocalPlayer.CharacterAdded:Connect(function()
	repeat heartbeat:Wait() until GetHumanoid() ~= nil
	GetHumanoid().Died:Connect(function() tracker:Fire() end)
end)

spawn(function()
	repeat heartbeat:Wait() until GetHumanoid() ~= nil
	GetHumanoid().Died:Connect(function() tracker:Fire() end)
end)

return tracker
