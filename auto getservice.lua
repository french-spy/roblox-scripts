local services = {};
for i,v in next, game:GetChildren() do
    table.insert(services, tostring(v));
end

local old;
old = hookmetamethod(game, "__index", function(t, k)
    if t == game and services[tostring(k)] then
        print("yues");
        return game:GetService(services[tostring[k]]);
    end
    return old(t, k);
end);
