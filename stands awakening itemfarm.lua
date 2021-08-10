local lp = game.Players.LocalPlayer;
local ws = workspace;

while wait() do
    for i,v in pairs(ws:GetChildren()) do
      if v:IsA("Tool") and v:FindFirstChild("Handle") and v.Handle:FindFirstChild("TouchInterest") then
          firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 0);
          wait(0.1);
          firetouchinterest(lp.Character.HumanoidRootPart, v.Handle, 1);
      end
    end 
end
