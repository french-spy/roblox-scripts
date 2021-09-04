local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;
getgenv().on3 = true; --set to false if u want to disable it

local function noble()
    rs.Remotes.Input:FireServer("KEY", "H");
    wait();
    rs.Remotes.InputFunc:InvokeServer("H");
    wait();
    rs.Remotes.Input:FireServer("KEY", "END-H");
    wait();
    rs.Remotes.InputFunc:InvokeServer("END-H");
end
noble();

lp.PlayerGui.ChildAdded:Connect(function(c)
    if v.Name == "DialogueGUI" and v:IsA("ScreenGui") and on3 then
        v:WaitForChild("DialogueFrame");
        wait(1);
        if string.find(v.DialogueFrame.DialogueTXT.Text, "I shall guide you") then
            firesignal(v.DialogueFrame.ResponseFrame:FindFirstChildWhichIsA("TextButton", true).MouseButton1Click);
        end
    end
end)
lp.Cooldowns.ChildRemoved:Connect(function(c)
    if c.Name == "H" and c:IsA("StringValue") and on3 then
        noble();
    end
end)

coroutine.wrap(function()
    while wait() do
        if on3 then
            if lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.PrimaryPart then
                if lp.Character.Humanoid.Health > 75 then
                    lp.Character.PrimaryPart.CFrame = ws.ItemSpawns["Johnny Joestar"].SpawnLocation.CFrame;
                    repeat wait() until lp.Character.Humanoid.Health <= 75;
                    lp.Character.PrimaryPart.CFrame = ws.Map.GateLocations.Beach.CFrame;
                end
            end
        end
    end
end)();
