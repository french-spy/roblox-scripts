getgenv().on = true;
---[[
if game.PlaceId == 6969185078 and on then
repeat task.wait() until game:IsLoaded();
repeat task.wait() until game.Workspace and game.Players;

repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui"); 
repeat wait() until gui:FindFirstChild("Start");

firesignal(gui.Start.PlayButton.MouseButton1Click);
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

for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
   v:Disable()
end

local Debounce = false
repeat wait() until game.ReplicatedStorage:FindFirstChild("Events")
local SpawnRemote = game.ReplicatedStorage.Events:WaitForChild("Spawn")

--game:GetService('RunService').Stepped:connect(function()
    if not Debounce and game.Players.LocalPlayer:FindFirstChild("PlayerGui") then
        Debounce = true
        local StatsGui = nil
        local PlayButton = nil
        local MPGui
        for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
            if v.Name == "StatsGUI" then
                StatsGui = v
            end
            if v.Name == "ME" and v.Parent.Name == "MagicEnergyGUI" then
                MPGui = v
            end
        end
        if SpawnRemote.ClassName == "RemoteFunction" then -- changed to a remote function after the latest update, this is for compatibility
            SpawnRemote:InvokeServer()
        elseif SpawnRemote.ClassName == "RemoteEvent" then
            pcall(function()
                local Events = getconnections(game.Players.LocalPlayer.PlayerGui.MainGUI.Start.PlayButton.MouseButton1Click)
                for i,v in pairs(Events) do
                    v:Fire()
                end
            end)
            SpawnRemote:FireServer()
        end
        wait(0.2)
        if StatsGui ~= nil and game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
             local Tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
             if Tool ~= nil then
                 for i,Tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                     if Tool:IsA("Tool") then
                         Tool.Parent = game.Players.LocalPlayer.Character
                         wait()
                         game:GetService("ReplicatedStorage").Events.SpellCast:FireServer({Tool,game.Players.LocalPlayer.Character.HumanoidRootPart.Position,Vector3.new(0,0,0),true})
                         wait()
                         game:GetService("ReplicatedStorage").Events.SpellCast:FireServer({Tool,game.Players.LocalPlayer.Character.HumanoidRootPart.Position})
                         wait()
                         Tool.Parent = game.Players.LocalPlayer.Backpack
                     end
                 end
                 if MPGui ~= nil then
                    local ManaNumbers = string.split(MPGui.Text,"/")
                    local Mana = tonumber(ManaNumbers[1])
                    local MaxMana = tonumber(ManaNumbers[2])
                    local Threshold = MaxMana / 3
                    if Mana ~= nil and MaxMana ~= nil and Mana < Threshold then
                        game.Players.LocalPlayer.Character:BreakJoints()
                        if SpawnRemote.ClassName == "RemoteFunction" then
                            SpawnRemote:InvokeServer()
                        elseif SpawnRemote.ClassName == "RemoteEvent" then
                            SpawnRemote:FireServer()
                        end
                    end
                 end
            end
        end
        Debounce = false
    end
    Teleport();
--end)
end
---]]
