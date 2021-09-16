local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;

getgenv().auto_skill = true;
getgenv().skills_to_use = {"E", "R", "T", "Y", "F", "G", "H", "V", "B"};

local function use_skill(skill)
	if type(skill) ~= "string" then return warn("Argument is not a string"); end
	rs.Remotes.Input:FireServer("KEY", skill);
    wait();
    rs.Remotes.InputFunc:InvokeServer(skill);
    wait();
    rs.Remotes.Input:FireServer("KEY", "END-" .. skill);
    wait();
    rs.Remotes.InputFunc:InvokeServer("END-" .. skill);
end

coroutine.wrap(function()
	while wait() do
		if auto_skill and skills_to_use[1] then
			for i,v in pairs(skills_to_use) do
				use_skill(v);
				wait(.5);
			end
		end
	end
end)();
