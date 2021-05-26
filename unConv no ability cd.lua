local LP = game:GetService("Players").LocalPlayer;
local abilities = require(game:GetService("ReplicatedStorage").Info).Abilities;
local a = {};
local n = 0;
for k, v in pairs(abilities) do
    n = n + 1;
    a[n] = k;
end
local playerAbility;
for k, v in pairs(a) do
    if LP:FindFirstChild(tostring(v)) then playerAbility = LP[tostring(v)] end;
end
local abilityCount;
for k, v in pairs(abilities) do
    if k == tostring(playerAbility) then
        abilityCount = #v.Skills;
    end
end

for i=1, abilityCount do
    spawn(function()
        while wait() do
            if playerAbility:FindFirstChild(tostring(i)) then
                playerAbility:FindFirstChild(tostring(i)):Destroy();
            end
        end
    end) 
end
