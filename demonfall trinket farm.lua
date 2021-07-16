_G.speed = 40 --Recommended to keep it at 40 for optimal speed and detection rate
_G.maxDist = math.huge --Lower it if you get kicked
_G.trinketFarm = true;
_G.noclip = true;

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";

local a = coroutine.wrap(function()
	pcall(function()
		while wait() do
			for i,v in pairs(lp.Character.Head:GetChildren()) do
				if v:IsA("BillboardGui") then
					v:Destroy(); 
				end
			end
		end
	end)
end)
a();

local b = coroutine.wrap(function()
	pcall(function()
		local connection = runs.RenderStepped:Connect(function()
			if not _G.noclip then connection:Disconnect(); end
			lp.Character.Humanoid:ChangeState(11);
		end)
	end)
end)
b();	

local function getClosestTrinket()
	local temp;
	
	for i,v in next, ws.Trinkets:GetChildren() do
		if v:IsA("Part") and v:FindFirstChild("Spawned") then
			temp = v;
		end
	end
	
	for i,v in next, ws.Trinkets:GetChildren() do
		if v:IsA("Part") and v:FindFirstChild("Spawned") then
			if (v.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.Position - lp.Character.HumanoidRootPart.Position).magnitude then temp = v; end
		end
	end
	return temp;
end

pcall(function()
	while _G.trinketFarm do wait()
		local closest = getClosestTrinket();
		repeat wait()
			closest = getClosestTrinket();
		until closest
		local trinket;
		
		for i,v in pairs(ws:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Spawn") and v.Spawn.Value ~= nil then
				if closest == v.Spawn.Value then
					trinket = v:FindFirstChild("Part");
				end
			end
		end
		
		local dist = (closest.Position - lp.Character.HumanoidRootPart.Position).magnitude;
		if dist <= 100 then
			lp.Character.HumanoidRootPart.CFrame = closest.CFrame;
			repeat wait() rs.Remotes.Async:FireServer("Character", "Interaction", trinket); until not closest:FindFirstChild("Spawned") or not trinket
		else
			local t = dist / _G.speed;
			local tweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
			local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closest.Position)});
			tween:Play();
			repeat wait() until (lp.Character.HumanoidRootPart.Position - closest.Position).magnitude <= 100
			tween:Cancel();
			
			lp.Character.HumanoidRootPart.CFrame = closest.CFrame;
			repeat wait() rs.Remotes.Async:FireServer("Character", "Interaction", trinket); until not closest:FindFirstChild("Spawned") or not trinket
		end
		wait(1);
	end
end)
