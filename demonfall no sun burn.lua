pcall(function()
    game:service"RunService".RenderStepped:Connect(function()
        if game:service"Players".LocalPlayer.Character:FindFirstChild("CanDie") then
            game:service"Players".LocalPlayer.Character:FindFirstChild("CanDie"):Destroy();
        end
        if game:service"Players".LocalPlayer.Character:FindFirstChild("Damaged") then
            game:service"Players".LocalPlayer.Character:FindFirstChild("Damaged"):Destroy();
        end
    end);
end);
