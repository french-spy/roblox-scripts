local a = {};
a.bindable = game:GetService("CoreGui"):FindFirstChild("teleporter") or Instance.new("BindableFunction") a.bindable.Name = "teleporter" a.bindable.Parent = game:GetService("CoreGui")

_G.canTeleport = false;

a.bindable.OnInvoke = function()
	if not game:service"Players".LocalPlayer:FindFirstChild("SecurityBypass") then
		repeat wait() until not game:service"Players".LocalPlayer:FindFirstChild("LastSpawned");
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
