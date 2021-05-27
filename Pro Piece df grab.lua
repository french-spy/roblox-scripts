local LP = game:GetService("Players").LocalPlayer;

for i,v in pairs(game:GetService("Workspace"):GetChildren()) do

    if v:IsA("Tool") and string.match(v.Name, "Fruit") then

        local Handle = v:FindFirstChildWhichIsA("Part");

        LP.Character.HumanoidRootPart.CFrame = Handle.CFrame;

        wait(0.2);

    end
end