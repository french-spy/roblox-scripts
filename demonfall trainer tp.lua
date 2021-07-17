local bindable = game:GetService("CoreGui"):FindFirstChild("teleporter") or Instance.new("BindableFunction") bindable.Name = "teleporter" bindable.Parent = game:GetService("CoreGui")

_G.canTeleport = false;

bindable.OnInvoke = function()
	if _G.canTeleport == false then
		if game:service"Players".LocalPlayer:FindFirstChild("LastSpawned") then repeat wait() until not game:service"Players".LocalPlayer:FindFirstChild("LastSpawned"); end
		_G.canTeleport = true
		game:GetService("ReplicatedStorage").Remotes.Sync:InvokeServer("Player", "SpawnCharacter")

		delay(8, function()
			_G.canTeleport = false
		end)

		return wait(2.5)
	else 
		return wait(1.25)
	end
end

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager"; 

local coords = 
{
	Rengoku = Vector3.new(1504.0355224609, 1236.1923828125, -342.61624145508),
	Wind = Vector3.new(-3307.7368164063, 703.95404052734, -1257.9039306641),
	Urokadaki = Vector3.new(-913.07073974609, 845.80383300781, -961.13238525391),
	Kujima = Vector3.new(-693.84558105469, 698.27703857422, 547.39538574219),
	Tokito =  Vector3.new(3248.8330078125, 778.80334472656, -4032.2995605469)
};

local function getKeys(t) --Use this for the dropdown table
	local temp = {};
	local i = 0;
	for k,v in pairs(t) do
		i = i + 1;
		temp[i] = k;
	end
	return temp;
end

local dist = (coords["Rengoku"] - lp.Character.HumanoidRootPart.Position).magnitude;

if dist <= 100 then
	lp.Character.HumanoidRootPart.CFrame = CFrame.new(coords["Rengoku"]);
else
	bindable:Invoke();
	lp.Character.HumanoidRootPart.CFrame = CFrame.new(coords["Rengoku"]);
end

--[[Example
sss:Dropdown("Trainer TP", getKeys(coords), function(t)
    if coords[t] then
        local dist = (coords[t] - lp.Character.HumanoidRootPart.Position).magnitude;
		
		if dist <= then
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(coords[t]);
		else
			bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(coords[t]);
		end
    end
end)
--]]
