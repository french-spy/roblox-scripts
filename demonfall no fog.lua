for i,v in next, game:service"Workspace":FindFirstChild("Folder"):GetChildren() do v:Destroy(); end
pcall(function()
    game:service"RunService".RenderStepped:Connect(function()
        game:GetService("Lighting").Atmosphere.Haze = 0;
        game:GetService("Lighting").Atmosphere.Density = 0;
        game:GetService("Lighting").Atmosphere.Offset = 0;
        game:GetService("Lighting").Atmosphere.Glare = 0;
    end)
end)
