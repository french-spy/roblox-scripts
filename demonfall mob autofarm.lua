_G.mob = "GenericSlayer"; --GenericOni/GenericSlayer/Green Demon(?)
_G.noclip = true;
_G.speed = 40;
_G.distFromMob = 6;
_G.maxDist = math.huge;
_G.autofarm = true;
_G.notExecuted = true; --dont touch


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
--Check for lp character
local b = coroutine.wrap(function()
    runs.RenderStepped:Connect(function()
        if not lp.Character then repeat wait() until lp.Character; end
    end)
end)
b();

--Noclip
local c =  coroutine.wrap(function()
    runs.RenderStepped:Connect(function()
        if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
    end)
end)
c();

local style = "";
if lp.Character.HumanoidRootPart:FindFirstChild("Breath") then
    style = "Katana";
else
    style = "Combat"
end

local function getClosestMob()
    local temp;
    for i,v in next, ws:GetChildren() do
        if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health").Value > 0 and not v:FindFirstChild("Down") then temp = v; break; end
    end
    for i,v in next, ws:GetChildren() do
        if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Health").Value > 0 and not v:FindFirstChild("Down") then
            if (v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude then
                temp = v;
            end
        end
    end
    return temp;
end

while wait() do
    if _G.autofarm then
        local closest = getClosestMob();
        repeat wait()
            closest = getClosestMob();
        until closest
        
        local dist = (closest.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
        local t = dist / _G.speed;
        
        if dist <= _G.maxDist then
            local tweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position)});
            tween:Play();
            repeat wait() until (closest.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude <= 100;
            tween:Cancel();

            _G.notExecuted = true;
            
            repeat wait()
                lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
                if closest:FindFirstChild("Block") and not closest:FindFirstChild("Ragdoll") or not closest:FindFirstChild("Ragdolled") then
                    rs.Remotes.Async:FireServer(style, "Heavy");
                end
                if not closest:FindFirstChild("Ragdoll") or not closest:FindFirstChild("Ragdolled") then rs.Remotes.Async:FireServer(style, "Server"); end
    
                if closest:FindFirstChild("Down") then
                    wait(0.5);
                    lp.Character.HumanoidRootPart.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
                    _G.noclip = false;
                    wait(0.1);
                    rs.Remotes.Sync:InvokeServer("Character", "Execute");
                    local br = ws.ChildAdded:Connect(function(c)
                        c:WaitForChild("ItemName");
                        if c.Name == "DropItem" and c.ItemName.Value == "Broken Nichirin" then
                            rs.Remotes.Async:FireServer("Character", "Interaction", c);
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
end