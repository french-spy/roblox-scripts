--Free Swords
for i,v in pairs(getrenv()._G.SwordPrices) do
    getrenv()._G.SwordPrices[i] = 0;
end
--Infinite Stat Points
getrenv()._G.Data.Data.Stat_Points = 100000000000;
--Infinite Beli
getrenv()._G.Data.Data.Beli = 100000000000;
--Max Demon Art
getrenv()._G.Data.Data.Mastery["Demon Art"][1] = 100;
--Infinite Bounty
getrenv()._G.Data.Data.Bounty = 10000000000;
--Max level
local vu = game:service"VirtualUser";

while tonumber(string.sub(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Bars.Level.Text, 7)) < getrenv()._G.MaxLevel do
    wait();
    getrenv()._G.Data.Data.Exp[1] = getrenv()._G.Data.Data.Exp[2];
    vu:Button1Down(Vector2.new(0, 0), game:service"Workspace".CurrentCamera.CFrame);
    wait(0.01);
    vu:Button1Up(Vector2.new(0, 0), game:service"Workspace".CurrentCamera.CFrame);
end
--Hide Name
pcall(function() while wait() do game:GetService("Workspace").LocalPlayer.Torso.OverHead.Enabled = false; end end);
--Max Breathing Progression
getrenv()._G.Data.BreathingProgression[1] = getrenv()._G.Data.BreathingProgression[2];

