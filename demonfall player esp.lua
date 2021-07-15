_G.playerEsp = true

local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"RunService";
local camera = ws.CurrentCamera;

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
            if v and v:IsDescendantOf(game) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then     
                local vector, onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position);
                if _G.playerEsp and onScreen then
                    Name.Position = Vector2.new(vector.X, vector.Y);
                    Name.Visible = true;
                    Name.Text = v.Name;
                    
                    Distance.Position = Vector2.new(vector.X, vector.Y - 10);
                    Distance.Visible = true;
                    Distance.Text = tostring(math.floor((v.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude + 0.5)) .. " studs";
					
					Hp.Position = Vector2.new(vector.X, vector.Y + 15);
					Hp.Visible = true;
					Hp.Text = tostring(v.Health.Value) .. "/" .. tostring(v.MaxHealth.Value) .. " HP";
                elseif not onScreen or not _G.playerEsp then
                    Name.Visible = false;
                    Distance.Visible = false;
					Hp.Visible = false;
                end
            elseif not v or not v:IsDescendantOf(game) or not v.Character or not v.Character:FindFirstChild("HumanoidRootPart") then
                Name:Remove()
                Distance:Remove();
				Hp:Remove();
                a:Disconnect();
            end
        end)
    end
    update();
end

for i,v in pairs(game:service"Players":GetPlayers()) do
    if v and v.Character and _G.playerEsp and v ~= lp then
        pcall(makeEsp, v);
    end
end

game:service"Players".PlayerAdded:Connect(function(p)
	if p ~= lp then
		p.CharacterAdded:Connect(function(c)
			print(c.Name .. " spawned");
			if c and c:FindFirstChild("HumanoidRootPart") then
				pcall(makeEsp, p);
			end
		end)
	end
end)
