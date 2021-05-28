local LP = game:GetService("Players").LocalPlayer;
local VU = game:GetService("VirtualUser");
local UnAFK = game:GetService("ReplicatedStorage").UnAFK;

LP.Idled:Connect(function()
    VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
    wait(1);
    VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
end)

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
