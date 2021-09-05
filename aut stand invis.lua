local lp = game:service"Players".LocalPlayer;
coroutine.wrap(function()
    while wait() do
        if lp.Character and lp.Character:FindFirstChild("Stand") then
            for i,v in pairs(lp.Character.Stand:GetChildren()) do
                if v.Name:find("HumanoidRootPart") and v:IsA("Part") and v:FindFirstChild("RootJoint") then
                    v.RootJoint:Destroy();
                end
            end
        end
    end
end)();
