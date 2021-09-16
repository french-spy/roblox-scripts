local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;
local run_s = game:service"RunService";

getgenv().to_farm = {"Sand Debris", "Chests", "Meteors"};
getgenv().farm = true;

coroutine.wrap(function()
    run_s.RenderStepped:Connect(function()
        if farm and to_farm[1] and lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid:ChangeState(11);
        end
    end)
end)();

coroutine.wrap(function()
    while wait() do
        if farm and to_farm[1] and lp.Character and lp.Character.PrimaryPart then
            for i,v in pairs(ws.ItemSpawns:GetChildren()) do
                if table.find(to_farm, v.Name) then
                    for i2,v2 in pairs(v:GetChildren()) do
                        if #(v2:GetChildren()) == 1 and lp.Character and lp.Character.PrimaryPart then
                            local a = v2:GetChildren()[1];
                            if a:FindFirstChildWhichIsA("ProximityPrompt", true) then
                                lp.Character.PrimaryPart.CFrame = v2.CFrame * CFrame.new(0, -5, 0);
                                wait(.25);
                                --This check is here again cuz without it, it errors for no reason
                                if a:FindFirstChildWhichIsA("ProximityPrompt", true) then
                                    fireproximityprompt(a:FindFirstChildWhichIsA("ProximityPrompt", true), 10);
                                end
                                wait(.25);
                                lp.Character.PrimaryPart.CFrame = CFrame.new(545.23822, 2369.11377, 386.453979, 0.0471762903, -0.0941329375, 0.994441271, 0, 0.995549798, 0.0942378566, -0.998886645, -0.00444579264, 0.0469663404);
                            end
                        end
                    end
                end
            end
            lp.Character.PrimaryPart.CFrame = CFrame.new(545.23822, 2369.11377, 386.453979, 0.0471762903, -0.0941329375, 0.994441271, 0, 0.995549798, 0.0942378566, -0.998886645, -0.00444579264, 0.0469663404);
        end
    end
end)();
