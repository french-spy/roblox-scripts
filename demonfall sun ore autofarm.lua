_G.sunOreFarm = true;
_G.speed = 40;
_G.noclip = true;
_G.currentOre = nil;
_G.minedOre = true;

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager";

--Hide Name
local a = coroutine.wrap(function()
    runs.RenderStepped:Connect(function()
        pcall(function()
            for i,v in pairs(lp.Character.Head:GetChildren()) do
                if v:IsA("BillboardGui") then
                    v:Destroy(); 
                end
            end
        end);
    end)
end)
a();

--Noclip
local c =  coroutine.wrap(function()
    runs.RenderStepped:Connect(function()
        if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
    end)
end)
c();

--Dont touch(Tps to the ore)
local b = coroutine.wrap(function()
    while not _G.minedOre and _G.currentOre ~= nil do wait()
       lp.Character.HumanoidRootPart.CFrame = CFrame.new((_G.currentOre.Position + Vector3.new(0, -1.5, -2)), _G.currentOre.Position); 
    end
end)
b();

pcall(function()
	while _G.sunOreFarm do wait()
		for i,v in next, ws.Map.Minerals:GetDescendants() do
			if v and v:IsDescendantOf(game) and v:IsA("MeshPart") and v.Name == "Mineral" and v:FindFirstChild("MineralName").Value == "Sun Ore" and v:FindFirstChild("Spawn").Value ~= nil then
				local dist = (v.Position - lp.Character.HumanoidRootPart.Position).magnitude;
				local t = dist / _G.speed;

				local tweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
				local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo , {CFrame = v.CFrame});
				tween:Play();
				repeat wait() until (v.Position - lp.Character.HumanoidRootPart.Position).magnitude <= 100;
				tween:Cancel();
				lp.Character.HumanoidRootPart.CFrame = CFrame.new((v.Position + Vector3.new(0, -1.5, -2)), v.Position);
				_G.currentOre = v;
				_G.minedOre = false;
				local count = 0;
				repeat wait()
					rs.Remotes.Sync:InvokeServer("Pickaxe", "Server");
					wait(1.25);
					count = count + 1;
					if count >= 3 then _G.minedOre = true; _G.currentOre = nil end
				until _G.minedOre
			end
		end
	end
end)
