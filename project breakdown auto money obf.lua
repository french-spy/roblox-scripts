local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local runs = game:service"RunService";

function TPBypass(X, Y, Z)
    local NX = math.floor(X + 0.5);
    local NY = math.floor(Y + 0.5);
    local NZ = math.floor(Z + 0.5);
    local Pos = lp.Character.HumanoidRootPart.Position;
    local CurY = Pos.Y;
    while CurY > -24 do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, CurY - _G.speed, Pos.Z);
        CurY = CurY - _G.speed;
        wait();
    end
    while CurY < -26 do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y + _G.speed, Pos.Z);
        CurY = CurY + _G.speed;
        wait();
    end
    workspace.Gravity = 0;
    while lp.Character.HumanoidRootPart.Position.X < NX - 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X + _G.speed, Pos.Y, Pos.Z);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.X > NX + 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X - _G.speed, Pos.Y, Pos.Z);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.Z < NZ - 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z + _G.speed);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.Z > NZ + 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z - _G.speed);
        wait();
    end
    local Pos = lp.Character.HumanoidRootPart.Position;
    local CurY = Pos.Y;
    while CurY < NY + 3 do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, CurY, Pos.Z);
        CurY = CurY + _G.speed;
        wait();
    end
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(X, Y, Z);
    workspace.Gravity = 196.19999694824;
end

coroutine.wrap(function()
    pcall(function()
        runs.RenderStepped:Connect(function()
            for i,v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v.Name == "face" or v.Name:find("Arm") or v.Name:find("Leg") then
                    v:Destroy();
                end
            end
        end)
    end)
end)();
coroutine.wrap(function()
    pcall(function()
        runs.RenderStepped:Connect(function()
            lp.Character.Humanoid.NameDisplayDistance = 0;
        end)
    end) 
end)();

coroutine.wrap(function()
    pcall(function()
        runs.RenderStepped:Connect(function()
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid:ChangeState(11); 
            end
        end) 
    end) 
end)();

coroutine.wrap(function()
    pcall(function()
        while wait() do
            if _G.autoPizza and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                if lp.Character:FindFirstChild("Mission") then
                    local dest = ws.PizzaLocations:FindFirstChild(lp.Character:FindFirstChild("Mission").Location.Value);
                    TPBypass(dest.Position.X, dest.Position.Y, dest.Position.Z - 10);
                    lp.Character.Humanoid:MoveTo(dest.Position);
                    repeat wait() until (dest.Position - lp.Character.HumanoidRootPart.Position).magnitude <= 5
                    wait(0.5);
                    TPBypass(ws.Missions.PizzaDelivery.Position.X, ws.Missions.PizzaDelivery.Position.Y, ws.Missions.PizzaDelivery.Position.Z + 7);
                    wait(0.5);
                    repeat wait(); lp.Character.HumanoidRootPart.CFrame = ws.Missions.PizzaDelivery.CFrame; fireclickdetector(ws.Missions.PizzaDelivery.ClickDetector); until lp.Character:FindFirstChild("Mission");
                else
                    TPBypass(ws.Missions.PizzaDelivery.Position.X, ws.Missions.PizzaDelivery.Position.Y, ws.Missions.PizzaDelivery.Position.Z + 7);
                    wait(0.5);
                    repeat wait(); lp.Character.HumanoidRootPart.CFrame = ws.Missions.PizzaDelivery.CFrame; fireclickdetector(ws.Missions.PizzaDelivery.ClickDetector); until lp.Character:FindFirstChild("Mission");
                    local dest = ws.PizzaLocations:FindFirstChild(lp.Character:FindFirstChild("Mission").Location.Value);
                    TPBypass(dest.Position.X, dest.Position.Y, dest.Position.Z - 10);
                    lp.Character.Humanoid:MoveTo(dest.Position);
                    repeat wait() until (dest.Position - lp.Character.HumanoidRootPart.Position).magnitude <= 5
                    wait(0.5);
                end
            end
        end
    end) 
end)();
