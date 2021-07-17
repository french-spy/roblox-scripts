local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager"; 

_G.speed = 45;
_G.noclip = true;

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

----[[

--Noclip
local c =  coroutine.wrap(function()
    runs.RenderStepped:Connect(function()
        if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
    end)
end)
c();

local dist = (coords["Rengoku"] - lp.Character.HumanoidRootPart.Position).magnitude;
local t = dist / _G.speed;

local tweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {Position = coords["Rengoku"]});
tween:Play();
repeat wait() until (coords["Rengoku"] - lp.Character.HumanoidRootPart.Position).magnitude <= 100;
tween:Cancel();
lp.Character.HumanoidRootPart.Position = coords["Rengoku"];
_G.noclip = false;
----]]


--[[Example

sss:Dropdown("Trainer TP", getKeys(coords), function(t)
    if coords[t] then
        local dist = (coords[t] - lp.Character.HumanoidRootPart.Position).magnitude;
		local t = dist / _G.speed;

		local tweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
		local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {Position = coords[t]});
		tween:Play();
		repeat wait() until (coords[t] - lp.Character.HumanoidRootPart.Position).magnitude <= 100;
		tween:Cancel();
		lp.Character.HumanoidRootPart.Position = coords[t];
		_G.noclip = false;
    end
end)

--]]
