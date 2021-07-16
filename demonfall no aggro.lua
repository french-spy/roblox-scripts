local lp = game:service"Players".LocalPlayer;
_G.noAggro = true
local a = coroutine.wrap(function()
    pcall(function()
        while _G.noAggro do wait()
            for i,v in pairs(lp.Character:GetChildren()) do
                if v.Name == "Aggro" or v.Name == "Combat" then
                    v:Destroy(); 
                end
            end
        end
    end)
end)
a();

local b = coroutine.wrap(function()
    pcall(function()
        while _G.noAggro do wait()
            for i,v in pairs(lp:GetChildren()) do
                if v.Name == "Aggro" or v.Name == "Combat" then
                    v:Destroy(); 
                end
            end
        end
    end)
end)
b();
