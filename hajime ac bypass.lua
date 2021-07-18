local old;
old = hookmetamethod(game, "__namecall", function(self, ...)
	local args = {...};
	if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "re" and table.find(args, "\240\159\240\159\240\159\208\176\208\176\208\176") then
		return;
	end
	return old(self, ...);
end)
