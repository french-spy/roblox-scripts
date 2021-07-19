local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager"; 

local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();

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

for i,v in pairs(getKeys(npcs)) do
	local dist = (ws.Npcs:FindFirstChild(npcs[v]).HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
	if dist <= 100 then
		lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[v]).HumanoidRootPart.CFrame;
	else
		tpBypass.bindable:Invoke();
		lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[v]).HumanoidRootPart.CFrame;
	end
end

--[[Example
sss:Dropdown("Place Teleport", getKeys(npcs), function(t)
    if coords[t] then
        local dist = (ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
		if dist <= 100 then
			lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.CFrame;
		else
			tpBypass.bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[t]).HumanoidRootPart.CFrame;
		end
	end
end)
--]]
