local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";

_G.autoPickup = true;

coroutine.wrap(function()
    while _G.autoPickup and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") do wait()
        for i,v in pairs(ws:GetChildren()) do
            if v.Name == "DropItem" and (v.Position - lp.Character.HumanoidRootPart.Position).magnitude <= 6.2 then
                rs.Remotes.Async:FireServer("Character", "Interaction", v);
            end
        end
    end
end)();
