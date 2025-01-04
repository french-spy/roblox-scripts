while not game do task.wait() end
while not game:service"Players".LocalPlayer do task.wait()
local lp = game:service"Players".LocalPlayer
while not lp:FindFirstChild("PlayerGui") and not lp.PlayerGui:FindFirstChild("Menu") do task.wait()

for i,v in getconnections(lp.PlayerGui.Menu.MenuButtons.Play.MouseButton1Click) do
    v.Function()
end
