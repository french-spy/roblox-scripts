local lp = game:service"Players".LocalPlayer;
local camera = game:service"Workspace".CurrentCamera;

local function azis(ledena_kralica)
    local sentrope = Drawing.new("Text");
    sentrope.Visible = false;
    sentrope.Center = true;
    sentrope.Outline = true;
    sentrope.Font = 1;
    sentrope.Size = 15;
    sentrope.Text = ledena_kralica.Name;
    sentrope.Color = Color3.fromRGB(0, 0, 0);
    
    local function toni_storaro()
        local c;
        c = game:service"RunService".RenderStepped:Connect(function()
            if ledena_kralica and game:service"Workspace":FindFirstChild(ledena_kralica.Name) and ledena_kralica:FindFirstChildWhichIsA("MeshPart") then
                local vector, onScreen = camera:WorldToViewportPoint(ledena_kralica:FindFirstChildWhichIsA("MeshPart").Position);
                
                if onScreen then
                    sentrope.Position = Vector2.new(vector.X, vector.Y);
                    sentrope.Visible = true;
                else
                    sentrope.Visible = false; 
                end
            else
                if not game:service"Workspace":FindFirstChild(ledena_kralica.Name) or not ledena_kralica:FindFirstChildWhichIsA("MeshPart") or not ledena_kralica:FindFirstChildWhichIsA("Part") then
                    c:Disconnect(); 
                end
                sentrope.Visible = false;
            end
        end)
    end
    coroutine.wrap(toni_storaro)();
end
for i,v in next, game:service"Workspace":GetChildren() do
    if v:IsA("Model") and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
        azis(v); 
    end
end

game:service"Workspace".ChildAdded:Connect(function(c)
    if c:IsA("Model") and c:FindFirstChild("Configuration") and c.Configuration:IsA("Configuration") and c:FindFirstChild("PickableItem") and c:FindFirstChildWhichIsA("MeshPart") then
        azis(c); 
    end
end)