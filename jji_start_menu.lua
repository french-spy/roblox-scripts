if not game.Loaded then game.Loaded:Wait()
task.wait(1.5)
while not game do task.wait() end
while not game:service"Players".LocalPlayer do task.wait() end
local lp = game:service"Players".LocalPlayer
while not lp:FindFirstChild("PlayerGui") do task.wait() end
while not lp.PlayerGui:FindFirstChild("Menu") do task.wait() end
while not lp.PlayerGui.Menu:FindFirstChild("MenuButtons") do task.wait() end
while not lp.PlayerGui.Menu.MenuButtons.Visible do task.wait() end

pcall(function()
    repeat task.wait()
        for i,v in getconnections(lp.PlayerGui.Menu.MenuButtons.Play.MouseButton1Click) do
            v.Function()
        end
    until lp.PlayerGui.Menu.MenuButtons.Visible == false
end)
    
