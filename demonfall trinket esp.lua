_G.trinketEsp = true

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
            if v and v:IsDescendantOf(game) and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
                local a;
                if v:FindFirstChild("MeshPart") then
                    a = v:FindFirstChild("MeshPart");
                elseif v:FindFirstChild("Main") then
                    a = v:FindFirstChild("Main");
                elseif v:FindFirstChild("Main") and v:FindFirstChild("Part") then
                    a = v:FindFirstChild("Part"); 
                end
                
                local vector, onScreen = camera:WorldToViewportPoint(a.Position);
                if _G.trinketEsp and onScreen then
                    Name.Position = Vector2.new(vector.X, vector.Y);
                    Name.Visible = true;
                    Name.Text = v.Name;
                    
                    Distance.Position = Vector2.new(vector.X, vector.Y - 10);
                    Distance.Visible = true;
                    Distance.Text = tostring(math.floor((a.Position - lp.Character.HumanoidRootPart.Position).magnitude + 0.5)) .. " studs";
                elseif not onScreen or not _G.trinketEsp then
                    Name.Visible = false;
                    Distance.Visible = false;
                end
            elseif not v or not v:IsDescendantOf(game) or not v:FindFirstChildWhichIsA("MeshPart") then
                Name:Remove()
                Distance:Remove();
                a:Disconnect();
            end
        end)
    end
    update();
end

for i,v in pairs(ws:GetChildren()) do
    if v and v:IsDescendantOf(game) and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
        pcall(makeEsp, v);
    end
end

ws.ChildAdded:Connect(function(v)
    if v and v:IsDescendantOf(game) then
        v:WaitForChild("Configuration");
        pcall(makeEsp, v);    
    end
end)
