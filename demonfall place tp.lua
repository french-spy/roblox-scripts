local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager"; 

local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();

local coords = 
{
	["Hayakawa Village"] = CFrame.new(920.434387, 757.866943, -2254.14722, 0.287112683, 0.00420951564, 0.95788759, 0, 0.999990344, -0.00439453963, -0.957896829, 0.00126172812, 0.287109911),
	["Farm near the waterfall"] = CFrame.new(-1474.21838, 744.153259, -767.348267, 0.999273896, 0.00444891257, -0.0378420725, 0, 0.993160129, 0.116761103, 0.0381026939, -0.116676323, 0.992438853),
	["Fall's Bridge"] = CFrame.new(-1819.33801, 711.637878, -644.845276, 0.0117059154, -0.136461899, 0.990576148, -1.16415336e-10, 0.990644097, 0.136471242, -0.999931574, -0.0015975209, 0.0115963938),
	["Okuyia Village"] = CFrame.new(-3304.74292, 703.954041, -1275.20239, 0.00171148917, -0.0544422157, 0.998515487, 0, 0.998517036, 0.0544422902, -0.999998629, -9.31773902e-05, 0.00170895073),
	["Kamakura Village"] = CFrame.new(-2482.86426, 1161.79785, -1683.6217, -0.0300377496, 0.0205000155, -0.999338567, 0, 0.999789774, 0.0205092691, 0.999548852, 0.000616052304, -0.0300314296),
	["Slayer's Exam"] = CFrame.new(-5201.61719, 792.619141, -3048.21924, 0.056257762, -1.04497587e-07, 0.998416424, -1.21436461e-08, 1, 1.05347581e-07, -0.998416424, -1.80510398e-08, 0.056257762),
	["Slayer Corps"] = CFrame.new(-1652.82227, 871.53186, -6450.69141, 0.964885414, 0.0239821076, -0.261574328, 0, 0.995823443, 0.091300793, 0.262671411, -0.0880948007, 0.960855365),
	["Corps Groove"] = CFrame.new(-3696.42896, 726.615295, -5580.87402, 0.982420027, 0.0160170123, -0.185995907, 0, 0.996312678, 0.0857973248, 0.186684281, -0.0842890069, 0.978797376),
	["Zenitsu"] = CFrame.new(-2949.40649, 760.085632, -3319.16724, 0.22583659, 0.0343555808, -0.973558843, 2.02746542e-05, 0.999377787, 0.0352713801, 0.974164724, -0.0079853097, 0.225695699)
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

for i,v in pairs(getKeys(coords)) do
    if coords[v] then
        local dist = (coords[v].Position - lp.Character.HumanoidRootPart.Position).magnitude;
        if dist <= 100 then
        	lp.Character.HumanoidRootPart.CFrame = coords[v];
        else
        	tpBypass.bindable:Invoke();
        	lp.Character.HumanoidRootPart.CFrame = coords[v];
        end
    end
end



--[[Example
sss:Dropdown("Place Teleport", getKeys(coords), function(t)
    if coords[t] then
        local dist = (coords[t].Position - lp.Character.HumanoidRootPart.Position).magnitude;
		if dist <= 100 then
			lp.Character.HumanoidRootPart.CFrame = coords[t];
		else
			tpBypass.bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = coords[t];
		end
	end
end)
--]]
