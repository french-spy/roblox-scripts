local function valueTracker(table)
    local proxy = newproxy(true); local meta = getmetatable(proxy);
    
    meta.__newindex = function(_, k, v)
        table[k] = v;
        --do stuff
    end;
    return proxy;
end
