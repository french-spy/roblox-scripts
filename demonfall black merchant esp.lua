local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"RunService";
local camera = ws.CurrentCamera;
_G.espOn = true;

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
    Distance.Size = 16;
    Distance.Color = Color3.fromRGB(255, 255, 255);
    
    local function update()
        local a;
        a = rs.RenderStepped:Connect(function()
            local vector, onScreen = camera:WorldToViewportPoint(v.HumanoidRootPart.Position);
            if onScreen and _G.espOn then
                Name.Position = Vector2.new(vector.X, vector.Y);
                Name.Visible = true;
                Name.Text = v.Name;
                
                Distance.Position = Vector2.new(vector.X, vector.Y - 10);
                Distance.Visible = true;
                Distance.Text = tostring(math.floor((v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude + 0.5)) .. " studs";
            elseif not onScreen then
                Name.Visible = false;
                Distance.Visible = false;
            end
            if not _G.espOn then
                Name:Remove();
                Distance:Remove();
                a:Disconnect();
            end
        end)
    end
    update();
end

makeEsp(ws.Npcs:FindFirstChild("Black Merchant"));
