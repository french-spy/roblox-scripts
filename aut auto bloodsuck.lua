local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;

getgenv().auto_suck = true; --set to false if u want to disable it
getgenv().char_invis = true;

coroutine.wrap(function()
    while wait() do
        if char_invis and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character.HumanoidRootPart:FindFirstChild("RootJoint") then
            lp.Character.HumanoidRootPart.RootJoint:Destroy();
        end
    end
end)();

coroutine.wrap(function()
    while wait() do
        if auto_suck and lp.Character and lp.Character.PrimaryPart then
            pcall(function() lp.Character.PrimaryPart.CFrame = ws.Living:FindFirstChild("Dummy"):FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, -2, 0); end);
        end
    end
end)();

local function succy_succy()
    rs.Remotes.Input:FireServer("KEY", "Y");
    wait();
    rs.Remotes.InputFunc:InvokeServer("Y");
    wait();
    rs.Remotes.Input:FireServer("KEY", "END-Y");
    wait();
    rs.Remotes.InputFunc:InvokeServer("END-Y");
end
succy_succy();

lp.Cooldowns.ChildRemoved:Connect(function(c)
    if c.Name == "BloodSuck" and c:IsA("StringValue") and auto_suck then
        succy_succy();
    end
end)
