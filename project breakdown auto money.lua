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
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, CurY - 2, Pos.Z);
        CurY = CurY - 1;
        wait();
    end
    while CurY < -26 do
        lp.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y + 2, Pos.Z);
        CurY = CurY + 1;
        wait();
    end
    workspace.Gravity = 1;
    while lp.Character.HumanoidRootPart.Position.X < NX - 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X + 6, Pos.Y, Pos.Z);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.X > NX + 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X - 6, Pos.Y, Pos.Z);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.Z < NZ - 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z + 6);
        wait();
    end
    while lp.Character.HumanoidRootPart.Position.Z > NZ + 7 do
        local Pos = lp.Character.HumanoidRootPart.Position;
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z - 6);
        wait();
    end
    local Pos = lp.Character.HumanoidRootPart.Position;
    local CurY = Pos.Y;
    while CurY < NY + 3 do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(Pos.X, CurY, Pos.Z);
        CurY = CurY + 1;
        wait();
    end
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(X, Y, Z);
    workspace.Gravity = 196.19999694824;
end

local function moveTo(humanoid, targetPoint, andThen)
	local targetReached = false;
 
	local connection;
	connection = humanoid.MoveToFinished:Connect(function(reached)
		targetReached = true;
		connection:Disconnect();
		connection = nil;
		if andThen then
			andThen();
		end
	end)
	humanoid:MoveTo(targetPoint)
 
	coroutine.wrap(function()
		while not targetReached do
			if not (humanoid and humanoid.Parent) then
				break;
			end
			if humanoid.WalkToPoint ~= targetPoint then
				break;
			end
			humanoid:MoveTo(targetPoint);
			wait(6);
		end
		
		if connection then
			connection:Disconnect();
			connection = nil;
		end
	end)();
end

coroutine.wrap(function()
    pcall(function()
        while wait() do
            for i,v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v.Name == "face" then
                    v:Destroy();
                end
            end
        end
    end)
end)();
coroutine.wrap(function()
    pcall(function()
        while wait() do
            if lp.Character then
                lp.Character.Humanoid.NameDisplayDistance = 0;
            end
        end
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
            lp.Bypass.Value = true;
            if _G.autoPizza and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                if lp.Character:FindFirstChild("Mission") then
                    local dest = ws.PizzaLocations:FindFirstChild(lp.Character:FindFirstChild("Mission").Location.Value);
                    TPBypass(dest.Position.X, dest.Position.Y, dest.Position.Z - 10);
                    moveTo(lp.Character.Humanoid, dest.Position);
                    wait(1);
                    TPBypass(ws.Missions.PizzaDelivery.Position.X, ws.Missions.PizzaDelivery.Position.Y, ws.Missions.PizzaDelivery.Position.Z + 7);
                    wait(1);
                    fireclickdetector(ws.Missions.PizzaDelivery.ClickDetector);
                    wait(1);
                else
                    TPBypass(ws.Missions.PizzaDelivery.Position.X, ws.Missions.PizzaDelivery.Position.Y, ws.Missions.PizzaDelivery.Position.Z + 7);
                    wait(1);
                    fireclickdetector(ws.Missions.PizzaDelivery.ClickDetector)
                    wait(1);
                    local dest = ws.PizzaLocations:FindFirstChild(lp.Character:FindFirstChild("Mission").Location.Value);
                    TPBypass(dest.Position.X, dest.Position.Y, dest.Position.Z - 10);
                    moveTo(lp.Character.Humanoid, dest.Position);
                    wait(1);
                end
            end
        end
    end) 
end)();
