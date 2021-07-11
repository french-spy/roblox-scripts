_G.speed = 40 --Recommended to keep it at 40 for optimal speed and detection rate

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";

for i,v in pairs(game:service"Players".LocalPlayer.Character.Head:GetChildren()) do
    if v:IsA("BillboardGui") then
        v:Destroy(); 
    end
end

spawn(function()
    while wait() do
        lp.Character.Humanoid:ChangeState(11);
    end
end)


local trinkets = {};
local function getClosestTrinket()
    local temp = trinkets[1];
    local index;
    for i,v in next, trinkets do
        if (v.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.Position - lp.Character.HumanoidRootPart.Position).magnitude then temp = v; index = i; end
    end
    return temp, index;
end

for i,v in next, game:service"Workspace":GetChildren() do
    if v:IsA("Model") and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
        local a;
        if v:FindFirstChild("MeshPart") then
            a = v:FindFirstChild("MeshPart");
        elseif v:FindFirstChild("Main") then
            a = v:FindFirstChild("Main");
        elseif v:FindFirstChild("Main") and v:FindFirstChild("Part") then
            a = v:FindFirstChild("Part"); 
        end
        table.insert(trinkets, a);
    end
end

pcall(function()
    for i,v in next, game:service"Workspace":GetChildren() do
        if v:IsA("Model") and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
            local closest, index = getClosestTrinket();
    
            local dist = (closest.Position - lp.Character.HumanoidRootPart.Position).magnitude;
            local time = dist / _G.speed; 
    
            local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closest.Position)});
            tween:Play();
            repeat wait() until (lp.Character.HumanoidRootPart.Position - closest.Position).magnitude < 1
                local args = 
                {
                    [1] = "Character",
                    [2] = "Interaction",
                    [3] = closest;
                };
                game:GetService("ReplicatedStorage").Remotes.Async:FireServer(unpack(args));
            wait(1.5);
            trinkets[index] = nil;
        end
    end
end)