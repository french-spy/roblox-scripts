local LP = game:GetService("Players").LocalPlayer;
local UnAFK = game:GetService("ReplicatedStorage").UnAFK;

for _, v in pairs(getconnections(LP.Idled)) do
    v:Disable(); 
end

while wait() do
    if LP.PlayerGui.ScreenGui.AntiAFK.Visible then
        UnAFK:FireServer(10);
        LP.PlayerGui.ScreenGui.AntiAFK.Visible = false;
    elseif LP.PlayerGui.ScreenGui.income.TextButton.Visible then
        LP.PlayerGui.ScreenGui.income.TextButton.Visible = false;
        LP.PlayerGui.ScreenGui.AntiAFK.Visible = true;
        UnAFK:FireServer(10);
        LP.PlayerGui.ScreenGui.AntiAFK.Visible = false;
    end
end
