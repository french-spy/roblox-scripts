local lp = game.Players.LocalPlayer;
local ws = workspace;

game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Comma, false, game);
wait();
game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Comma, false, game);

lp.Character.hitbox.CFrame = game:GetService("Workspace").placeFolders.entityManifestCollection.Crabby.CFrame;
wait();
game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.W, false, game);
wait();
game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.W, false, game);
