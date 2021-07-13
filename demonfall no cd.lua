local lp = game:service"Players".LocalPlayer;
_G.noCD = true
pcall(function()
    while wait() do
        if _G.noCD then
            for i,v in pairs(lp.Character:GetChildren()) do
                if v:IsA("IntValue") and string.match(v.Name, "Cooldown") or string.match(v.Name, "Busy") then
                    v:Destroy(); 
                end
            end
        end
    end
end)
