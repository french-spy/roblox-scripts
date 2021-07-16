local lp = game:service"Players".LocalPlayer;
local ws = game:service"Workspace";
local rs = game:service"ReplicatedStorage";

local function canTp()
	local canTp = false;
	if lp:FindFirstChild("LastSpawned") and lp:FindFirstChild("SecurityBypass") then
		canTp = true;
	elseif not lp:FindFirstChild("LastSpawned") and lp:FindFirstChild("SecurityBypass") then
		canTp = true;
	elseif lp:FindFirstChild("LastSpawned") and not lp:FindFirstChild("SecurityBypass") then
		repeat wait() until not lp:FindFirstChild("LastSpawned");
		rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
		wait(1);
		canTp = true;
	elseif not lp:FindFirstChild("LastSpawned") and not lp:FindFirstChild("SecurityBypass") then
		rs.Remotes.Sync:InvokeServer("Player", "SpawnCharacter");
		wait(1);
		canTp = true;
	end
	return canTp;
end
