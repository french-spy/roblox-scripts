local rs = game:service"ReplicatedStorage";
local old;
old = hookmetamethod(game, "__namecall", function(...)
    local self, args = ..., {...};
    if not checkcaller() and getnamecallmethod() == "FireServer" and self == rs.Remotes.Async and table.find(args, "Character") and table.find(args, "FallDamageServer") then
        return; 
    end
    return old(...);
end);
