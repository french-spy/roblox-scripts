local lp = game.Players.LocalPlayer;

lp:WaitForChild("Chosen"):WaitForChild("Magic");
lp:WaitForChild("Chosen"):WaitForChild("Melee");

local chosenMagic = lp.Chosen.Magic.Value;
local chosenMelee = lp.Chosen.Melee.Value;
local meleeRemote;
local magicRemote;

lp.Chosen.Magic:GetPropertyChangedSignal("Value"):Connect(function()
    chosenMagic = lp.Chosen.Magic.Value;
    for i,v in pairs(game.ReplicatedStorage.Remotes:GetChildren()) do
        if v.Name == chosenMagic .. "Remote" then
            magicRemote = v;
        end
    end
    print(chosenMagic, magicRemote);
end);
lp.Chosen.Melee:GetPropertyChangedSignal("Value"):Connect(function()
    chosenMelee = lp.Chosen.Melee.Value;
    if chosenMelee == "Dagger" then chosenMelee = "Tanto"; end
    for i,v in pairs(game.ReplicatedStorage.Remotes:GetChildren()) do
        if v.Name == chosenMelee .. "Remote" then
            meleeRemote = v;
        end
    end
    print(chosenMelee, meleeRemote);
end)

if chosenMelee == "Dagger" then chosenMelee = "Tanto"; end
for i,v in pairs(game.ReplicatedStorage.Remotes:GetChildren()) do
    if v.Name == chosenMagic .. "Remote" then
        magicRemote = v;
    elseif v.Name == chosenMelee .. "Remote" then
        meleeRemote = v; 
    end
end

local old;
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...};
    if not checkcaller() and getnamecallmethod() == "FireServer" and (self == meleeRemote and not table.find(args, "Hitbox")) or self == magicRemote then
        for i=1, 3 do
            old(self, ...);
        end
    end
    return old(self, ...);
end)

print(chosenMelee, chosenMagic, meleeRemote, magicRemote);
