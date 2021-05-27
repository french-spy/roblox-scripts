local LP = game:GetService("Players").LocalPlayer;

for i,v in pairs(game:GetService("Workspace"):GetChildren()) do

    if v:IsA("Folder") and string.match(v.Name, "Chest") then

        for i2,v2 in pairs(v:GetChildren()) do

            LP.Character.HumanoidRootPart.CFrame = v2.CFrame;

            wait(0.2);

        end

    end
end