local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";

local npcs = {};
for i,v in next, ws.Npcs:GetChildren() do
    if v:IsA("Model") and not table.find(npcs, v.Name) then
        table.insert(npcs, v.Name); 
    end
end

if lp:FindFirstChild("LastSpawned") then
    repeat wait() until not lp:FindFirstChild("LastSpawned");
    rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    wait(1.2);
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[10]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame; 
else
    rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    wait(1.2);
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[10]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame; 
end

