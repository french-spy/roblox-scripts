local lp = game:service"Players".LocalPlayer;
getgenv().stand_invis = true;
coroutine.wrap(function()
    while wait() do
        if stand_invis and lp.Character and lp.Character:FindFirstChild("Stand") then
            for i,v in pairs(lp.Character.Stand:GetChildren()) do
                if v.Name:find("HumanoidRootPart") and v:IsA("Part") and v:FindFirstChild("RootJoint") then
                    v.RootJoint:Destroy();
                end
            end
        end
    end
end)();
