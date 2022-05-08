repeat task.wait() until game:IsLoaded();
task.wait(2);
repeat task.wait() until game and game.Workspace and game.Players;

--getgenv().item_farm = true;
getgenv().speed = 300;

local lp = game:service"Players".LocalPlayer;
local ws = workspace;
local ts = game:service"TweenService";

repeat wait() until lp.PlayerGui:FindFirstChild("MenuGUI") and lp.Character.MenuGUI.Enabled
firesignal(lp.PlayerGui.MenuGUI.Play.MouseButton1Click);
task.wait(1);

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
				wait(1);
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

task.spawn(function()
    while task.wait() do
        if lp.Character and lp.Character.PrimaryPart and lp.Character:FindFirstChild("LowerTorso") and lp.Character.LowerTorso:FindFirstChild("Root") then
            lp.Character.LowerTorso.Root:Destroy();
        end
    end
end)

--while task.wait() do
    if lp.Character and lp.Character.PrimaryPart then
        for i,v in pairs(ws.Items:GetChildren()) do
            local found = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Part");
                print(found);
            if found then
                local t = (found.CFrame.Position - lp.Character.HumanoidRootPart.Position).magnitude / speed;
                local tween_info = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
                local tween = ts:Create(lp.Character.HumanoidRootPart, tween_info, { CFrame = found.CFrame } );
                tween:Play();
                repeat wait() until (lp.Character.HumanoidRootPart.Position - found.CFrame.Position).magnitude <= 100;
                tween:Cancel();
                lp.Character.HumanoidRootPart.CFrame = found.CFrame;
            end
            
        end
    end
--end

Teleport();

syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/Stand%20Upright%3A%20Rebooted%20item%20farm.lua"));
