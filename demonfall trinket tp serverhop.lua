repeat wait() until game:IsLoaded();
wait(1.5);

_G.trinketFarm = true;
_G.noclip = true;
_G.trinketsBeforeHop = 3; --The amount of trinkets to get before serverhopping

local lp = game:service"Players".LocalPlayer;
local ts = game:service"TweenService";
local vu = game:service"VirtualUser";
local rs = game:service"ReplicatedStorage";
local ws = game:service"Workspace";
local runs = game:service"RunService";

if lp.PlayerGui:FindFirstChild("LoadingScreen") then firesignal(lp.PlayerGui.LoadingScreen.Background.Loading.Skip.MouseButton1Click); wait(12.5); end
    
repeat wait() until lp.Character;

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
	AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
	table.insert(AllIDs, actualHour)
	writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
	local Site;
	if foundAnything == "" then
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
	else
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
	end
	local ID = ""
	if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
		foundAnything = Site.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Site.data) do
		local Possible = true
		ID = tostring(v.id)
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			for _,Existing in pairs(AllIDs) do
				if num ~= 0 then
					if ID == tostring(Existing) then
						Possible = false
					end
				else
					if tonumber(actualHour) ~= tonumber(Existing) then
						local delFile = pcall(function()
							delfile("NotSameServers.json")
							AllIDs = {}
							table.insert(AllIDs, actualHour)
						end)
					end
				end
				num = num + 1
			end
			if Possible == true then
				table.insert(AllIDs, ID)
				wait()
				pcall(function()
					writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
					wait()
					game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
				end)
				wait()
			end
		end
	end
end

function Teleport()
	while wait() do
		pcall(function()
			TPReturner()
			if foundAnything ~= "" then
				TPReturner()
				return true;
			end
		end)
	end
end

local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();

coroutine.wrap(function()
	pcall(function()
		while wait() do
			for i,v in pairs(lp.Character.Head:GetChildren()) do
				if v:IsA("BillboardGui") then
					v:Destroy(); 
				end
			end
		end
	end)
end)();

coroutine.wrap(function()
	pcall(function()
		local connection = runs.RenderStepped:Connect(function()
			if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
		end)
	end)
end)();

local function getClosestTrinket()
	local temp;
	
	for i,v in next, ws.Trinkets:GetChildren() do
		if v:IsA("Part") and v:FindFirstChild("Spawned") then
			temp = v;
		end
	end
	
	for i,v in next, ws.Trinkets:GetChildren() do
		if v:IsA("Part") and v:FindFirstChild("Spawned") then
			if (v.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.Position - lp.Character.HumanoidRootPart.Position).magnitude then temp = v; end
		end
	end
	return temp;
end

pcall(function()
	local aa = 0;
	while _G.trinketFarm and aa < _G.trinketsBeforeHop do wait()
		local closest = getClosestTrinket();
		repeat wait()
			closest = getClosestTrinket();
		until closest
		local trinket;
		
		for i,v in pairs(ws:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Spawn") and v.Spawn.Value ~= nil then
				if closest == v.Spawn.Value then
					trinket = v:FindFirstChild("Part");
				end
			end
		end
		
		local dist = (closest.Position - lp.Character.HumanoidRootPart.Position).magnitude;
		if dist <= 100 then
			lp.Character.HumanoidRootPart.CFrame = closest.CFrame;
			repeat wait() rs.Remotes.Async:FireServer("Character", "Interaction", trinket); until not closest:FindFirstChild("Spawned") or not trinket
		else
			tpBypass.bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = closest.CFrame;
			local count = 0;
			while count < 0.55 do
				count = count + runs.RenderStepped:Wait();
			end
			repeat wait() rs.Remotes.Async:FireServer("Character", "Interaction", trinket); until not closest:FindFirstChild("Spawned") or not trinket
		end
		aa = aa + 1;
		print(aa);
		wait(1);
	end
	syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20trinket%20tp%20serverhop.lua"));
	local success = pcall(Teleport);
	repeat wait()
		success = pcall(Teleport);
	until success
end)
