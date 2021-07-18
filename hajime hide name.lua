local lp = game:service"Players".LocalPlayer;

coroutine.wrap(function()
    pcall(function()
        while wait() do
            for i,v in pairs(lp.Character:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("head_owner") then
                    v:Destroy(); 
                end
            end
        end
    end) 
end)();
