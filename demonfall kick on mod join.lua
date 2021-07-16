local modsIds = 
{
	666087238,
	927875377,
	1337156246,
	742406104,
	1483657440,
	1224956693,
	477198208,
	150657944,
	60676205,
	1188893926,
	879624436,
	85778076,
	472236361,
	141687683,
	2271659462,
	399930437,
	382649287,
	548334040,
	1587973624,
	276017027,
	304646590,
	56969615,
	28392137
}

for i,v in pairs(game:service"Players":GetPlayers()) do
	if modsIds[v.UserId] then
		game:service"Players".LocalPlayer:Kick("Mod is in the server");
	end
end

game:service"Players".PlayerAdded:Connect(function(p)
	if modsIds[p.UserId] then
		game:service"Players".LocalPlayer:Kick("Mod joined the server");
	end
end)
