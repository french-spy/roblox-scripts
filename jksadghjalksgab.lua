print("AAAA3")
if game.PlaceId == 5941294866 then
	print("AAAA2")
    repeat wait() until game:IsLoaded();
	wait(10);
    print("AAAA1")
	
    local LP = game:GetService("Players").LocalPlayer;
    local HRP = LP.Character.HumanoidRootPart;
    local s = game:GetService("Players").LocalPlayer.PlayerScripts.TrinketRender;
    local genv = getrenv(s)._G;
    local coords = {};
    coords.Snail = 
    {
        CFrame.new(3295.79395, 838.97229, -4212.05518, 0.999991238, 1.57946243e-08, -0.00422491273, -1.55450532e-08, 1, 5.9102355e-08, 0.00422491273, -5.90361431e-08, 0.999991238),
        CFrame.new(3294.89502, 838.97229, -4175.53418, -0.419149309, 7.77566811e-09, -0.90791744, -5.17138066e-09, 1, 1.09517106e-08, 0.90791744, 9.28558741e-09, -0.419149309),
        CFrame.new(3267.13379, 838.97229, -4148.84082, 0.0533254854, 3.66065898e-08, -0.998577595, 7.93677799e-08, 1, 4.08971204e-08, 0.998577595, -8.14357364e-08, 0.0533254854),
        CFrame.new(3293.91577, 838.97229, -4135.06982, -0.924859822, -3.81373653e-08, -0.380308181, -1.26684903e-08, 1, -6.94720441e-08, 0.380308181, -5.94339724e-08, -0.924859822),
        CFrame.new(3280.61987, 856.921875, -4233.31104, -0.941858172, 1.27430928e-08, -0.336010695, 3.11341033e-08, 1, -4.93460988e-08, 0.336010695, -5.69384149e-08, -0.941858172),
        CFrame.new(3299.20361, 856.921875, -4228.13867, -0.442789942, -5.96011996e-05, 0.896625221, -9.65894797e-05, 1, 1.87729765e-05, -0.896625221, -7.82920833e-05, -0.442789942)
    };
    
    grabTrinket();
	
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
                    wait(4)
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
                end
            end)
        end
    end
    
    local function grabTrinket()
        for i,v in pairs(genv) do
            if type(v) == "userdata" and string.match(tostring(i), "{") then
                local trinketId = string.match(tostring(i), "%t(.*)%.-");
                --print(i, v);
                print(trinketId);
                game:GetService("ReplicatedStorage").RequestPickup:FireServer(trinketId);
            end
        end 
    end
    
    --[[
    local function GAOT()
        local trinkets = 0;
        for i,v in pairs(genv) do
            if type(v) == "userdata" and string.match(tostring(i), "{") then
                trinkets = trinkets + 1;
            end
        end
        return trinkets;
    end
    --]]
    
	repeat wait() until LP.Character;
    --Hide Character
    for i,v in pairs(LP.Character:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("T-Shirt") then
            v:Destroy();
        end
        if v.Name == "CharacterName" then
            v:Destroy(); 
        end
    end
    
	print("AAAA")
    for i,v in pairs(coords) do
        for i = 1, 2 do
			for i2,v2 in pairs(v) do
				HRP.CFrame = v2;
				if i2 == 1 then wait(5) else wait(0.3); end
				grabTrinket();
			end
		end
    end
    Teleport();
end
