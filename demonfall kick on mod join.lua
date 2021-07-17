local groupId = 4294803
local roles = {"Moderators", "Admins", "Developers", "Torso", "Head"};

for i,v in pairs(game:service"Players":GetPlayers()) do
	if roles[v:GetRoleInGroup(groupId)] then
		game:service"Players".LocalPlayer:Kick("Mod is in the server");
	end
end

game:service"Players".PlayerAdded:Connect(function(p)
	if roles[p:GetRoleInGroup(groupId)] then
		game:service"Players".LocalPlayer:Kick("Mod joined the server");
	end
end)
