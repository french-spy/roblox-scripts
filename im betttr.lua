repeat task.wait() until game:IsLoaded()
task.wait(3)

local lp = game:service"Players".LocalPlayer
local vu = game:service"VirtualUser"

local a = lp.PlayerGui.MainGui:WaitForChild("TalkBox")
repeat task.wait() until a.Visible

repeat task.wait()
    game:GetService("ReplicatedStorage").GameStorage.Remotes.TalkEvent:FireServer("Skip")
until not lp.PlayerGui.MainGui.TalkBox.Visible

if not lp.Character then lp.CharacterAdded:Wait() end
if not lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character:WaitForChild("HumanoidRootPart") end

lp.Character.HumanoidRootPart.Anchored = true;

repeat task.wait()
    game:service"VirtualInputManager":SendMouseButtonEvent(500, 500, 0, true, game, 1)
    task.wait()
    game:service"VirtualInputManager":SendMouseButtonEvent(500, 500, 0, false, game, 1)
until lp.PlayerGui.MainGui.SClearBox.Visible

task.wait()

game:GetService("ReplicatedStorage").GameStorage.Remotes.StageEvents:FireServer("Replay")
