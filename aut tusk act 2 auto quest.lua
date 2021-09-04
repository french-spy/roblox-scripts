local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
getgenv().on = true; --set to false if u want to disable it

local function glide()
    rs.Remotes.Input:FireServer("KEY", "V");
    wait();
    rs.Remotes.InputFunc:InvokeServer("V");
    wait(3.4);
    rs.Remotes.Input:FireServer("KEY", "END-V");
    wait();
    rs.Remotes.InputFunc:InvokeServer("END-V");
end
glide();

lp.Cooldowns.ChildRemoved:Connect(function(c)
    if c.Name == "V" and c:IsA("StringValue") and on then
        glide();
    end
end)
