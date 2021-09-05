local lp = game:service"Players".LocalPlayer;
getgenv().char_invis = true;
coroutine.wrap(function()
    while wait() do
        if char_invis and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character.HumanoidRootPart:FindFirstChild("RootJoint") then
            lp.Character.HumanoidRootPart.RootJoint:Destroy();
        end
    end
end)();
