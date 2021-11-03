coroutine.wrap(function () pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/HDTerebi/DSRPG2/master/DSRPG2%20Main%20Gui"))() end) end)();
wait(3.5);

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local ws = workspace;

local function hide_identity()
    lp.Character.FakeHead:Destroy();
    lp.Character.FakeTorso:Destroy();
    lp.Character.BodyColors:Destroy();
    
    for i,v in pairs(lp.Character:GetChildren()) do
        if v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then
            v:Destroy();
        end
    end
end

hide_identity();

lp.CharacterAdded:Connect(function()
    hide_identity();
end);

game:service"RunService".RenderStepped:Connect(function()
    lp.Character.Humanoid:ChangeState(11);
end);

local candies = {};
for i,v in pairs(ws.HE:GetChildren()) do
    if v:FindFirstChildOfClass("ClickDetector") and v:FindFirstChildOfClass("Part") and v:FindFirstChildOfClass("MeshPart") then
        local c = {};
        c[1] = v:FindFirstChildOfClass("Part");
        c[2] = v:FindFirstChildOfClass("MeshPart");
        local b = v:FindFirstChildOfClass("ClickDetector");
        if c[1].Transparency ~= 1 or c[2].Transparency ~= 1 then
            candies[((c[1].Transparency ~= 1 and c[1]) or c[2]):GetDebugId()] = {CFrame = ((c[1].Transparency ~= 1 and c[1]) or c[2]).CFrame, ClickDetector = b, DebugId = ((c[1].Transparency ~= 1 and c[1]) or c[2]):GetDebugId()};
        end
    end
end

table.foreach(candies, print);

local function get_closest()
    local temp;
    for i,v in pairs(candies) do temp = v; break end
    
    for i,v in pairs(candies) do
        if (v.CFrame.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.CFrame.Position - lp.Character.HumanoidRootPart.Position).magnitude then temp = v; end
    end
    
    return temp;
end

while candy_farm do wait()
    local closest = get_closest();
    --print(closest);
    local dist = (closest.CFrame.Position - lp.Character.HumanoidRootPart.Position).magnitude;
    local t = dist / speed;
    
    local tween_info = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local tween = ts:Create(lp.Character.HumanoidRootPart, tween_info, {CFrame = closest.CFrame});
    tween:Play();
    tween.Completed:Wait();
    
    fireclickdetector(closest.ClickDetector);
    wait(1);
    candies[closest.DebugId] = nil;
end
