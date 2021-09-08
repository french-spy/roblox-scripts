local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;

getgenv().auto_take_damage = true; --set to false if u want to disable it
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
        if auto_take_damage and lp.Character and lp.Character.PrimaryPart then
            pcall(function() lp.Character.PrimaryPart.CFrame = ws.Living:FindFirstChild("Akira_DEV"):FindFirstChild("HumanoidRootPart").CFrame; end);
        end
    end
end)();
