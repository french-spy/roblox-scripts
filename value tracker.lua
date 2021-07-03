local function valueTracker(table)
    local proxy = newproxy(true); local meta = getmetatable(proxy);
    
    meta.__newindex = function(_, k, v)
        table[k] = v;
        local a = game:service"ReplicatedStorage"[v]:Clone();
        a.Parent = lp.Backpack;
    end;
    return proxy;
end
