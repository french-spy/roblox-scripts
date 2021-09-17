if game.PlaceId == 7484251959 then
    repeat wait() until game:IsLoaded();
    wait(5);
    
    local lp = game:service"Players".LocalPlayer;
    local rs = game:service"ReplicatedStorage";
    local ws = workspace;
    local run_s = game:service"RunService";
    
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
    
    local instance_names = {"Torso", "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg"};
    coroutine.wrap(function()
        run_s.RenderStepped:Connect(function()
            if item_farm and lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid:ChangeState(11);
            end
        end);
        while wait() do
            if hide_character and lp and lp.Character then
                for i,v in pairs(lp.Character:GetChildren()) do
                    if v:IsA("Part") and table.find(instance_names, v.Name) then
                        v:Destroy(); 
                    end
                end
            end
        end
    end)();
    
    for i=0, 3 do wait()
        for i2,v in pairs(ws.Drops.Active:GetChildren()) do
            if not table.find(item_blacklist, v.Name) and v:FindFirstChildOfClass("ProximityPrompt", true) then
                local a = v:FindFirstChildOfClass("ProximityPrompt", true);
                local b = a:FindFirstAncestorOfClass("Part") or a:FindFirstAncestorOfClass("MeshPart") or a:FindFirstAncestorOfClass("Handle");
                if b and a then
                    lp.Character.PrimaryPart.CFrame = b.CFrame * CFrame.new(0, -5, 0);
                    wait(.25);
                    fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt", true), 10);
                    wait(.25);
                end
            end
        end
    end
    wait(1);
    Teleport();
end
