local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"ReplicatedStorage";

_G.autoBreath = true;

if not lp:FindFirstChild("Breathing") then return; end

local function spamB()
	rs.Remotes.Async:FireServer("Character", "Breath", true);
end
local function haltB()
	rs.Remotes.Async:FireServer("Character", "Breath", false);
end

local isB = false;
coroutine.wrap(function()
	while wait() do
		if lp.Breathing.Value >= 95 and not _G.autoBreath then
			isB = false;
			haltB();
		elseif _G.autoBreath and not isB then
			isB = true;
			spamB();
		end
		wait(0.45);
	end
end)();
