--Show health and names
for i,v in next, game:service"Players":GetPlayers() do
    if v.Character and v.Character:FindFirstChild("Humanoid") and v ~= game:service"Players".LocalPlayer then
        v.Character.Humanoid.HealthDisplayDistance = math.huge;
        v.Character.Humanoid.HealthDisplayType = 1;
        v.Character.Humanoid.NameDisplayDistance = math.huge;
    end
end
--AC Bypass
local old;
old = hookmetamethod(game, "__namecall", function(...)
    local self, args = ..., {...};
    if not checkcaller() and tostring(self) == "LameSploit" and getnamecallmethod() == "FireServer" then
        return wait(math.huge);
    end
    return old(...);
end);
