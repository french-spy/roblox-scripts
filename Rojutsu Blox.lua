local LP = game:service"Players".LocalPlayer;
local Workspace = game:service"Workspace";
local quests = {};
local oldPos = 0;
quest = "";
autoQuest = false;

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
        quests[v] = v.Interact.ProximityPrompt["Quest_Settings"].Enemy.Value;
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))();
local venyx = library.new("Venyx", 5013109572);

local a = venyx:addPage("a")
local b = a:addSection("b");

b:addDropdown("Quest", getVals(quests), function(v)
    quest = v;
end)
b:addToggle("Auto Quest", nil, function(v)
    autoQuest = v;
end)

spawn(function()
    pcall(function()
        while wait() do
            if autoQuest and quest ~= "" then
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character:FindFirstChild("Humanoid") and LP.Character.Humanoid.Health > 0 then
                    if not LP.Quest_Data.ActiveQuest.Value then
                        for k,v in pairs(quests) do
                            if v == quest then
                                oldPos = LP.Character.HumanoidRootPart.CFrame;
                                LP.Character.HumanoidRootPart.CFrame = k.Interact.CFrame * CFrame.new(0, -10, 0);
                                fireproximityprompt(k.Interact.ProximityPrompt);
                                wait(0.3);
                                LP.Character.HumanoidRootPart.CFrame = oldPos
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
            if LP.Character and LP.Character:FindFirstChild("Head") and LP.Character.Head:FindFirstChild("Overhead") then
                LP.Character.Head.Overhead:Destroy();
            end
        end
    end)
end)