repeat task.wait() until game:IsLoaded()
task.wait(3)

local lp = game:service"Players".LocalPlayer
local vu = game:service"VirtualUser"

if not getgenv().trial then
    local a = lp.PlayerGui.MainGui:WaitForChild("TalkBox")
    repeat task.wait() until a.Visible
    repeat task.wait()
        game:GetService("ReplicatedStorage").GameStorage.Remotes.TalkEvent:FireServer("Skip")
    until not lp.PlayerGui.MainGui.TalkBox.Visible
end

if not lp.Character then lp.CharacterAdded:Wait() end
if not lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character:WaitForChild("HumanoidRootPart") end

lp.Character.HumanoidRootPart.Anchored = true;

repeat task.wait()
    game:service"VirtualInputManager":SendMouseButtonEvent(500, 500, 0, true, game, 1)
    task.wait()
    game:service"VirtualInputManager":SendMouseButtonEvent(500, 500, 0, false, game, 1)
    
    game:service"VirtualInputManager":SendKeyEvent(true, Enum.KeyCode.Two, false, game)
    task.wait()
    game:service"VirtualInputManager":SendKeyEvent(false, Enum.KeyCode.Two, false, game)
    
    game:service"VirtualInputManager":SendKeyEvent(true, Enum.KeyCode.One, false, game)
    task.wait()
    game:service"VirtualInputManager":SendKeyEvent(false, Enum.KeyCode.One, false, game)
    
    game:service"VirtualInputManager":SendKeyEvent(true, Enum.KeyCode.Three, false, game)
    task.wait()
    game:service"VirtualInputManager":SendKeyEvent(false, Enum.KeyCode.Three, false, game)
until lp.PlayerGui.MainGui.SClearBox.Visible

task.wait()
--aa
game:GetService("ReplicatedStorage").GameStorage.Remotes.StageEvents:FireServer("Replay")
