_G.speed = 40 --Recommended to keep it at 40 for optimal speed and detection rate
_G.maxDist = 900 --Lower it if you get kicked
if game.PlaceId == 5094651510 then
    repeat wait() until game:IsLoaded();
    wait(1.5);
    
    
    local lp = game:service"Players".LocalPlayer;
    local ts = game:service"TweenService";
    local vu = game:service"VirtualUser";
    
    if lp.PlayerGui:FindFirstChild("LoadingScreen") then firesignal(lp.PlayerGui.LoadingScreen.Background.Loading.Skip.MouseButton1Click); end
    
    repeat wait() until lp.Character;
    wait(5);
    
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
                    return true;
                end
            end)
        end
    end
    
    for i,v in pairs(getgc()) do
        if type(v) == "function" and debug.getinfo(v).name == "CheckGround" then
            v = function() return game:GetService("Workspace").Npcs.Esnor.HumanoidRootPart end 
        end
    end
    
    for i,v in pairs(game:service"Players".LocalPlayer.Character.Head:GetChildren()) do
        if v:IsA("BillboardGui") then
            v:Destroy(); 
        end
    end
    
    spawn(function()
        game:service"RunService".RenderStepped:Connect(function()
            lp.Character.Humanoid:ChangeState(11);
        end);
    end)
    
    local trinkets = {};
    local function grabTrinkets()
        for i,v in next, trinkets do trinkets[i] = nil; end
        for i,v in next, game:service"Workspace":GetChildren() do
            if v:IsA("Model") and v:FindFirstChild("Configuration") and v.Configuration:IsA("Configuration") and v:FindFirstChild("PickableItem") and v:FindFirstChildWhichIsA("MeshPart") then
                local a;
                if v:FindFirstChild("MeshPart") then
                    a = v:FindFirstChild("MeshPart");
                elseif v:FindFirstChild("Main") then
                    a = v:FindFirstChild("Main");
                elseif v:FindFirstChild("Main") and v:FindFirstChild("Part") then
                    a = v:FindFirstChild("Part"); 
                end
                if not table.find(trinkets, a) then
                    table.insert(trinkets, a);
                end
            end
        end
    end
    grabTrinkets();
        
    local function getClosestTrinket()
        grabTrinkets();
        local temp = trinkets[1];
        local index;
        for i,v in next, trinkets do
            if (v.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.Position - lp.Character.HumanoidRootPart.Position).magnitude then temp = v; index = i; end
        end
        return temp, index;
    end
    
    pcall(function()
        for i,v in next, trinkets do
                local closest, index = getClosestTrinket();
        
                local dist = (closest.Position - lp.Character.HumanoidRootPart.Position).magnitude;
                print(dist);
                if dist <= _G.maxDist then
                    local time = dist / _G.speed; 
                        
                    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
                    local tween = ts:Create(lp.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closest.Position)});
                    tween:Play();
                    repeat wait() until (lp.Character.HumanoidRootPart.Position - closest.Position).magnitude < 1
                        local args = 
                        {
                            [1] = "Character",
                            [2] = "Interaction",
                            [3] = closest;
                        };
                        game:GetService("ReplicatedStorage").Remotes.Async:FireServer(unpack(args));
                    wait();
                    trinkets[index] = nil;
                    wait(1.5);
                end
        end
    end)
    repeat wait()
        local success = pcall(Teleport);
    until success
end
