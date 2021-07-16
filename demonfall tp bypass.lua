local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"ReplicatedStorage";

local npcs = {};
for i,v in next, ws.Npcs:GetChildren() do
    if v:IsA("Model") and not table.find(npcs, v.Name) then
        table.insert(npcs, v.Name); 
    end
end

if lp:FindFirstChild("LastSpawned") and lp:FindFirstChild("SecurityBypass") then
    repeat wait() until not lp:FindFirstChild("LastSpawned");
    --rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[4]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame; 
elseif not lp:FindFirstChild("LastSpawned") and lp:FindFirstChild("SecurityBypass") then
    --rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    --repeat wait() until 
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[4]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame; 
elseif lp:FindFirstChild("LastSpawned") and not lp:FindFirstChild("SecurityBypass") then
    repeat wait() until not lp:FindFirstChild("LastSpawned");
    rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    wait(1);
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[4]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame; 
elseif not lp:FindFirstChild("LastSpawned") and not lp:FindFirstChild("SecurityBypass") then
    rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
    wait(1);
    lp.Character.HumanoidRootPart.CFrame = ws.Npcs:FindFirstChild(npcs[4]--[[instead of the index use something like a dropdown to select npcs--]]).HumanoidRootPart.CFrame;
end
