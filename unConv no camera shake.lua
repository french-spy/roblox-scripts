local isExecutorClosure = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or checkclosure
for i,v in pairs(getgc()) do
    if type(v) == "function" and not isExecutorClosure(v) then
        local funcName = debug.getinfo(v).name;
        if funcName == "camshake" then
            v = newcclosure(function() end);
        end
    end
end
