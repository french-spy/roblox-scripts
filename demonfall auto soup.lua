_G.autoEatSoup = true;
_G.slot = "Z" --Z or X(Slot to equipt it to)

local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";

coroutine.wrap(function()
	while _G.autoEatSoup do wait()
		if lp.Hunger.Value <= 80 then
			rs.Remotes.Sync:InvokeServer("HUD", "Inventory", "Equip", "Soup", _G.slot);
			wait(0.7);
			rs.Remotes.Sync:InvokeServer("Soup", "Server");
		end
	end
end)();
