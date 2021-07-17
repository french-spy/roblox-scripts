local bindable = game:GetService("CoreGui"):FindFirstChild("teleporter") or Instance.new("BindableFunction") bindable.Name = "teleporter" bindable.Parent = game:GetService("CoreGui")

_G.canTeleport = false;

bindable.OnInvoke = function()
	if _G.canTeleport == false then 
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

local npcs = {};
for i,v in next, ws.Npcs:GetChildren() do
    if v:IsA("Model") and not table.find(npcs, v.Name) and v:FindFirstChild("HumanoidRootPart") then
        npcs[v.Name] = v.Name;
    end
end

local function getKeys(t) --Use this for the dropdown table
	local temp = {};
	local i = 0;
	for k,v in pairs(t) do
		i = i + 1;
		temp[i] = k;
	end
	return temp;
end

local dist = (ws.Npcs:FindFirstChild(npcs["Esnor"]).HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
if dist <= 100 then
	lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs["Esnor"]).HumanoidRootPart.CFrame;
else
	bindable:Invoke();
	lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs["Esnor"]).HumanoidRootPart.CFrame;
end


--[[Example
sss:Dropdown("Place Teleport", getKeys(npcs), function(t)
    if coords[t] then
        local dist = (ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
		if dist <= 100 then
			lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.CFrame;
		else
			bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.CFrame;
		end
	end
end)
--]]
