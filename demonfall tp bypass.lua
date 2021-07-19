local a = {};
a.bindable = game:GetService("CoreGui"):FindFirstChild("teleporter") or Instance.new("BindableFunction") bindable.Name = "teleporter" bindable.Parent = game:GetService("CoreGui")

_G.canTeleport = false;

a.bindable.OnInvoke = function()
	if not game:service"Players".LocalPlayer:FindFirstChild("SecurityBypass") then 
		_G.canTeleport = true
		game:GetService("ReplicatedStorage").Remotes.Sync:InvokeServer("Player", "SpawnCharacter")

		delay(8, function()
			_G.canTeleport = false
		end)

		return wait(3)
	else 
		return wait(1.5)
	end
end
return a;
