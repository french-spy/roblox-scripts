pcall(function()
    game:service"RunService".RenderStepped:Connect(function()
        if game:service"Players".LocalPlayer.Character:FindFirstChild("Sequence") then
            game:service"Players".LocalPlayer.Character:FindFirstChild("Sequence"):Destroy();
        end
    end);
end);
