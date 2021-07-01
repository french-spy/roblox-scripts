local LP = game:service"Players".LocalPlayer;
local Workspace = game:service"Workspace";
local mobs = {};
local oldPos = 0;
scruc = {};

local function getVals(t)
    if type(t) ~= "table" then return nil; end
    local temp = {};
    for k,v in pairs(t) do
        table.insert(temp, v);
    end
    return temp;
end

for i,v in pairs(Workspace:GetChildren()) do
    if v.Name == "QuestGiver" then
        mobs[v] = tostring(v.Interact.ProximityPrompt["Quest_Settings"].Enemy.Value);
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))();
local venyx = library.new("Venyx", 5013109572);

local a = venyx:addPage("a")
local b = a:addSection("b");

b:addDropdown("Mob", getVals(mobs), function(v)
    scruc.mob = v;
end)
b:addToggle("Auto Quest", nil, function(v)
    scruc.autoQuest = v;
end)
b:addToggle("Auto Farm", nil, function(v)
    scruc.autoFarm = v;
end)

spawn(function()
    pcall(function()
        while wait() do
            if scruc.autoQuest and scruc.mob ~= "" then
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character:FindFirstChild("Humanoid").Health > 0 then
                    if not LP.Quest_Data.ActiveQuest.Value then
                        for k,v in pairs(mobs) do
                            if v == scruc.mob then
                                scruc.tpingToQuest = true;
                                oldPos = LP.Character.HumanoidRootPart.CFrame;
                                repeat wait()
                                    LP.Character.HumanoidRootPart.CFrame = k.Interact.CFrame * CFrame.new(0, -7.5, 0);
                                    fireproximityprompt(k.Interact.ProximityPrompt);
                                until LP.Quest_Data.ActiveQuest.Value or not scruc.autoQuest or scruc.mob == "";
                                scruc.tpingToQuest = false;
                                --LP.Character.HumanoidRootPart.CFrame = oldPos;
                            end
                        end
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do
            if scruc.autoFarm and scruc.mob ~= "" then
                LP.Backpack.Player_Values.Ultimate.Value = 100;
                LP.Backpack.Player_Values.GlobalCool.Value = false;
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character:FindFirstChild("Humanoid").Health > 0 then
                    for i,v in pairs(Workspace:GetChildren()) do
                        if v.Name == scruc.mob and v:FindFirstChild("Humanoid").Health > 0 and v:FindFirstChild("HumanoidRootPart") and not scruc.tpingToQuest then
                            repeat wait()
                                LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, -7.5, 0) * CFrame.Angles(math.rad(90), 0, 0);
                                Workspace.EventHolder.Ultimate_Skills.Reactor:FireServer(LP.Character.HumanoidRootPart.Position);
                            until v.Humanoid.Health <= 0 or not scruc.autoFarm or scruc.mob == "" or scruc.tpingToQuest;
                        end
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do
            if LP.Character and LP.Character:FindFirstChild("Head") and LP.Character.Head:FindFirstChild("Overhead") then
                LP.Character.Head.Overhead:Destroy();
            end
        end
    end)
end)