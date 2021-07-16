local lp = game:service"Players".LocalPlayer;
_G.noCD = true
local a = coroutine.wrap(function()
    pcall(function()
        while _G.noCD do wait()
            for i,v in pairs(lp.Character:GetChildren()) do
                if v:IsA("IntValue") and string.match(v.Name, "Cooldown") or string.match(v.Name,"Busy") then
                    v:Destroy(); 
                end
            end
        end
    end)
end)
a();

local b = coroutine.wrap(function()
    pcall(function()
        while _G.noCD do wait()
            for i,v in pairs(lp:GetChildren()) do
                if string.match(v.Name, "Cooldown") or string.match(v.Name, "Busy") then
                    v:Destroy(); 
                end
            end
        end
    end) 
end)
b();
