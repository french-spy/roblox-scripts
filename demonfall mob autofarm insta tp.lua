_G.mob = "Zenitsu"; --GenericOni/GenericSlayer/Green Demon(?)
_G.noclip = true;
_G.speed = 45;
_G.distFromMob = 6;
_G.autofarm = true;
_G.notExecuted = true; --dont touch


local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";
local vim = game:service"VirtualInputManager"; 

local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();
local drops = {"Green Horn", "Demon Horn", "Broken Nichirin", "Crystal Essence"};

local spawns = 
{
	["Zenitsu"] = CFrame.new(-2537.05103, 941.436035, -3351.02222, 0.30188486, -1.47914374e-08, 0.953344405, 5.87038906e-09, 1, 1.36564031e-08, -0.953344405, 1.47384116e-09, 0.30188486),
	["Green Demon"] = CFrame.new(1474.98828, 818.827637, -6379.07861, 0.00430911547, -7.22375617e-08, -0.999990702, -4.87611951e-10, 1, -7.22403328e-08, 0.999990702, 7.98899336e-10, 0.00430911547)
}

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
	pcall(function()
		runs.RenderStepped:Connect(function()
			if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
		end)
	end)
end)
c();

--Checks if you are a demon or a slayer
local style = "";
if getrenv()._G.PlayerData.Race == "Demon Slayer" then
    style = "Katana";
else
    style = "Combat";
end

local function getClosestMob()
    local temp = nil;
    for i,v in next, ws:GetChildren() do
        if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health") and v.Health.Value > 0 and not v:FindFirstChild("Down") then temp = v; break; end
    end
    for i,v in next, ws:GetChildren() do
        if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health") and v.Health.Value > 0 and not v:FindFirstChild("Down") then
            if (v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude then
                temp = v;
            end
        end
    end
    return temp;
end

pcall(function()
    while wait() do
        if _G.autofarm and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Health.Value ~= 0 then
			--EXPERIMENT WITH DISTANCE FOR GREEN DEMON
			if _G.mob == "Green Demon" then _G.distFromMob = 10; else _G.distFromMob = 6; end
			if _G.mob == "Zenitsu" or _G.mob == "Green Demon" then
				local dist = (spawns[_G.mob].Position - lp.Character.HumanoidRootPart.Position).magnitude;
				if dist <= 100 then
					lp.Character.HumanoidRootPart.CFrame = spawns[_G.mob];
				else
					tpBypass.bindable:Invoke();
					lp.Character.HumanoidRootPart.CFrame = spawns[_G.mob];
				end
			end
		
            local closest = getClosestMob();
            repeat wait()
                closest = getClosestMob();
            until closest
            
			local dist = (closest.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
            local t = dist / _G.speed;
			
			tpBypass.bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
			
			_G.notExecuted = true;
			
			repeat wait()
				lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
				if closest:FindFirstChild("Block") and not closest:FindFirstChild("Ragdoll") then
					if lp.Stamina.Value >= 20 then
						rs.Remotes.Async:FireServer(style, "Heavy");
					end
				end
				
				if not closest:FindFirstChild("Ragdoll") and not closest:FindFirstChild("Block") then wait(0.45); rs.Remotes.Async:FireServer(style, "Server"); end
				
				if closest:FindFirstChild("Down") then
					local count = 0;
					repeat wait()
						lp.Character.HumanoidRootPart.CFrame = closest.HumanoidRootPart.CFrame;
						wait(0.1);
						count = count + 1;
						vim:SendKeyEvent(true, Enum.KeyCode.B, false, game);
						wait(0.5);
						vim:SendKeyEvent(false, Enum.KeyCode.B, false, game);
						if lp.Character:FindFirstChild("OnExecute") or closest:FindFirstChild("Executing") then
							local cf = lp.Character.HumanoidRootPart.CFrame;
							local count2 = 0;
							repeat wait() lp.Character.HumanoidRootPart.Anchored = false; lp.Character.HumanoidRootPart.CFrame = cf * CFrame.new(0, -15, 0); count2 = count2 + 1; until closest:FindFirstChild("Executed") or count2 >= 100;	
						end
					until closest:FindFirstChild("Executed") or count > 10;
					local br = ws.ChildAdded:Connect(function(c)
						c:WaitForChild("ItemName");
						if c.Name == "DropItem" and drops[c.Name] then
							rs.Remotes.Async:FireServer("Character", "Interaction", c);
							vim:SendKeyEvent(true, Enum.KeyCode.E, false, game);
							wait(0.5);
							vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
						end
					end);
					wait(0.7);
					_G.notExecuted = false;
					br:Disconnect();
				end
			until not _G.autofarm or not _G.notExecuted
			_G.noclip = true;
			wait(1.5);
        end
    end
end)
