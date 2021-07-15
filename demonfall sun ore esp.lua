_G.sunOreEsp = true;

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
    
    local function update()
        local a;
        a = rs.RenderStepped:Connect(function()
            if v and v:IsDescendantOf(game) and v:FindFirstChild("Spawn").Value ~= nil then  
                local vector, onScreen = camera:WorldToViewportPoint(v.Position);
                if _G.sunOreEsp and onScreen then
                    Name.Position = Vector2.new(vector.X, vector.Y);
                    Name.Visible = true;
                    Name.Text = "Sun Ore";
                    
                    Distance.Position = Vector2.new(vector.X, vector.Y - 10);
                    Distance.Visible = true;
                    Distance.Text = tostring(math.floor((v.Position - lp.Character.HumanoidRootPart.Position).magnitude + 0.5)) .. " studs";
                elseif not onScreen or not _G.sunOreEsp then
                    Name.Visible = false;
                    Distance.Visible = false;
                end
            elseif not v or not v:IsDescendantOf(game) or v:FindFirstChild("Spawn").Value == nil  then
                Name:Remove()
                Distance:Remove();
                a:Disconnect();
            end
        end)
    end
    update();
end

for i,v in pairs(ws.Map.Minerals:GetDescendants()) do
    if v and v:IsDescendantOf(game) and v:IsA("MeshPart") and v.Name == "Mineral" and v:FindFirstChild("MineralName").Value == "Sun Ore" and v:FindFirstChild("Spawn") and _G.sunOreEsp then
        pcall(makeEsp, v);
    end
end

ws.DescendantAdded:Connect(function(v)
    if v and v:IsDescendantOf(game) and v.Name == "Mineral" and _G.sunOreEsp then
        v:WaitForChild("MineralName");
	v:WaitForChild("Spawn");
	if v.MineralName.Value == "Sun Ore" then
		print(v.Name .. " spawned");
		pcall(makeEsp, v);
	end
    end
end)
