local old;
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...};
    if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "signal" and args[1] == "playerRequest_damageEntity" and args[4] == "monster" then
        return; 
    end
    return old(self, ...);
end)
