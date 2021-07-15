_G.mobEsp = true

local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"RunService";
local camera = ws.CurrentCamera;

local function getName(v)
    local scruc = v.Name;
    if v == "GenericSlayer" then
        scruc = "Demon Slayer";
    elseif v == "GenericOni" then
        scruc = "Demon";
    end
    return scruc;
end

local function makeEsp(v)
    local Name = Drawing.new("Text");
    Name.Visible = false;
    Name.Center = true;
    Name.Outline = false;
    Name.Font = 1;
    Name.Size = 20;
    Name.Color = Color3.fromRGB(255, 255, 255);
    
    local Distance = Drawing.new("Text");
    Distance.Visible = false;
    Distance.Center = true;
    Distance.Outline = false;
    Distance.Font = 1;
    Distance.Size = 18;
    Distance.Color = Color3.fromRGB(255, 255, 255);
    
    local Hp = Drawing.new("Text");
    Hp.Visible = false;
	Hp.Center = true;
	Hp.Outline = false;
	Hp.Font = 1;
	Hp.Size = 16;
	Hp.Color = Color3.fromRGB(255, 255, 255);
    
    local function update()
        local a;
        a = rs.RenderStepped:Connect(function()
            if v and v:IsDescendantOf(game) and v:FindFirstChild("HumanoidRootPart") then     
                local vector, onScreen = camera:WorldToViewportPoint(v.HumanoidRootPart.Position);
                if _G.mobEsp and onScreen then
                    Name.Position = Vector2.new(vector.X, vector.Y);
                    Name.Visible = true;
                    Name.Text = getName(v.Name);
                    
                    Distance.Position = Vector2.new(vector.X, vector.Y - 10);
                    Distance.Visible = true;
                    Distance.Text = tostring(math.floor((v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude + 0.5)) .. " studs";
					
					Hp.Position = Vector2.new(vector.X, vector.Y + 15);
					Hp.Visible = true;
					Hp.Text = tostring(v.Health.Value) .. "/" .. tostring(v.MaxHealth.Value) .. " HP";
                elseif not onScreen or not _G.mobEsp then
                    Name.Visible = false;
                    Distance.Visible = false;
					Hp.Visible = false;
                end
            elseif not v or not v:IsDescendantOf(game) or not v:FindFirstChild("HumanoidRootPart") then
                Name:Remove()
                Distance:Remove();
				Hp:Remove();
                a:Disconnect();
            end
        end)
    end
    update();
end

for i,v in pairs(ws:GetChildren()) do
    if v and v:IsDescendantOf(game) and v:FindFirstChild("Demon") or v:FindFirstChild("Slayer") or v.Name == "Zenitsu" or v.Name == "Green Demon" and v:FindFirstChild("HumanoidRootPart") and _G.mobEsp then
        pcall(makeEsp, v);
    end
end

ws.ChildAdded:Connect(function(v)
    if v and v:IsDescendantOf(game) and v.Name == "GenericOni" or v.Name == "GenericSlayer" or v.Name == "Zenitsu" or v.Name == "Green Demon" and _G.mobEsp then
        v:WaitForChild("HumanoidRootPart");
        print(v.Name .. " spawned");
        pcall(makeEsp, v);    
    end
end)
