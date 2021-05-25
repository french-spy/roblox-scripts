local LP = game:GetService("Players").LocalPlayer;
local a = {};
local n = 0;
for k, v in pairs(require(game:GetService("ReplicatedStorage").Info).Abilities) do
    n = n + 1;
    a[n] = k;
end
local playerAbility;
for k, v in pairs(a) do
    if LP:FindFirstChild(tostring(v)) then playerAbility = LP[tostring(v)] end;
end
_G.toggle = true; --Comment out the rest of the code, set this to false and execute if u want to turn it off

while wait() do
    if _G.toggle then
        if playerAbility:FindFirstChild("1") then
            playerAbility:FindFirstChild("1"):Destroy();
        elseif playerAbility:FindFirstChild("2") then
            playerAbility:FindFirstChild("2"):Destroy();
        end
    end
end
