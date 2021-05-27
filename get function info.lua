local isExecutorClosure = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or checkclosure
local fName = "" --name of the function;
for i,v in pairs(getgc()) do
    if type(v) == "function" and not isExecutorClosure(v) then
        local funcName = debug.getinfo(v).name;
        if funcName == fName then
            print("Function Info -------------------");
            table.foreach(debug.getinfo(v), print);
            print("---------------------------------");
            print("Function Constants --------------");
            table.foreach(debug.getconstants(v), print);
            print("---------------------------------");
            print("Function Environment ------------");
            table.foreach(debug.getfenv(v), print);
            print("---------------------------------");
            print("Function Upvalues ---------------");
            table.foreach(debug.getupvalues(v), print);
            print("---------------------------------");
        end
    end
end
