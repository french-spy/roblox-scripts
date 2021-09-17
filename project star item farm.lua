local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;
local run_s = game:service"RunService";
getgenv().item_farm = true;
getgenv().hide_character = true;
coroutine.wrap(function()
    run_s.RenderStepped:Connect(function()
        if item_farm and lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid:ChangeState(11);
        end
    end)
end)();
local instance_names = {"Torso", "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg"};
coroutine.wrap(function()
    while wait() do
        if hide_character and lp and lp.Character then
            for i,v in pairs(lp.Character:GetChildren()) do
                if v:IsA("Part") and table.find(instance_names, v.Name) then
                    v:Destroy(); 
                end
            end
        end
    end
end)();
coroutine.wrap(function()
    while wait() do
        if item_farm and lp.Character and lp.Character.PrimaryPart then
            for i,v in pairs(ws.Drops.Active:GetChildren()) do
                if v:FindFirstChildOfClass("ProximityPrompt", true) and v:FindFirstChild("DropCenter") then
                    lp.Character.PrimaryPart.CFrame = v.DropCenter.CFrame * CFrame.new(0, -5, 0);
                    wait(.25);
                    fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt", true), 10);
                    wait(.25);
                end
            end
        end
    end
end)();
