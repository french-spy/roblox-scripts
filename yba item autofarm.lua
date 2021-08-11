local ws = workspace;
local lp = game.Players.LocalPlayer;

_G.itemFarm = true;

--Table functions
function searchTable(t, index)
	local temp = {};
	for i,v in pairs(t) do
		table.insert(temp, tostring(v));
	end
	if table.find(temp, index) then
		temp = nil;
		return true;
	end
	return false;
end

local function getTableLength(t)
    local temp = 0;
    for i,v in pairs(t) do temp = temp + 1; end
    return temp;
end

--This is used to get the return key in case they change it
local gc = getgc(true);
local key = nil;
for i = #gc, 1, -1 do
    if type(gc[i]) == "table" then
        if rawget(gc[i], "A") and type(rawget(gc[i], "A")) == "table" and #(rawget(gc[i], "A")) > 2 then
            key = rawget(gc[i], "A")[2];
            break;
        end
    end
end

--Bypasses
local oldNamecall;
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...};
    if not checkcaller() and getnamecallmethod() == "InvokeServer" and tostring(self) == "Returner" and args[1] == "idklolbrah2de" then
        if key then return key;
		else return "  ___XP DE KEY"; end
    end
	if not checkcaller() and getnamecallmethod() == "InvokeServer" and args[1] == "Reset" then
		return;
	end
	if not checkcaller() and getnamecallmethod() == "FireServer" and args[1] == "Reset" then
		return;
	end
    if not checkcaller() and getnamecallmethod() == "Kick" then
        return;
    end
    return oldNamecall(self, ...);
end);

for i,v in pairs(getgc()) do
	if type(v) == "function" and tostring(getfenv(v).script) == 'Client' and #debug.getprotos(v) == 7 and searchTable(debug.getupvalues(v), "RemoteEvent") then
		hookfunction(v, function()
			return wait(9e9);
		end);
		break;
	end
end
wait(0.5);

--Invis
local oldPos = lp.Character.HumanoidRootPart.CFrame;
lp.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1750.6010742188, 770.61102294922, 50));
wait(0.5);
lp.Character.LowerTorso.Root:Destroy();
wait(0.5);
lp.Character.HumanoidRootPart.CFrame = oldPos;
wait(0.5);

--Item farm
_G.items = {};
local oldNewIndex;
oldNewIndex = hookmetamethod(game, "__newindex", function(self, index, value)
	if index == "OnClientInvoke" and tostring(self) == "ItemSpawn" then
		local oldFunc = value;
		value = function(...)
			local itemData = select(2, ...);
			--pcall(function()
				table.foreach(itemData, print);
				_G.items[itemData.Replica.Name] = {CFrame = itemData.CFrame, clickDetector = itemData.CD, Name = itemData.Replica.Name};				
			--end)
			return oldFunc(...);
		end
	end
	return oldNewIndex(self, index, value);
end)
getscriptclosure(game:GetService("ReplicatedFirst"):WaitForChild("ItemSpawn"))();

while wait() do
	if (_G.itemFarm and getTableLength(_G.items) >= 1) then
		print("Yes");
		for i,v in pairs(_G.items) do
			if (lp.Character and lp.Character.PrimaryPart) then
				print("Yes2");
				lp.Character.PrimaryPart.CFrame = v.CFrame;
				wait(0.5);
				for i2,v2 in pairs(ws.Item_Spawns.Items:GetChildren()) do
					if v2:IsA("Model") and v2:FindFirstChildWhichIsA("MeshPart") or v2:FindFirstChildWhichIsA("Part") then
						print("Yes3");
						local br = v2:FindFirstChildWhichIsA("MeshPart") or v2:FindFirstChildWhichIsA("Part");
						if (br.Position - lp.Character.PrimaryPart.Position).magnitude <= 5 then
							print("Yes4");
							if br.Transparency ~= 1 then
								print("Yes5");
								if v.clickDetector:IsDescendantOf(game) then
									fireclickdetector(v.clickDetector);
									for i = 1, 4 do wait() 
										if (lp.PlayerGui:FindFirstChild("Message") and lp.PlayerGui.Message:FindFirstChild("TextLabel")) then
											if string.match(lp.PlayerGui.Message.TextLabel.Text, "You can't have more than") then
												_G.items[i] = nil;
											end
										end
									end
									_G.items[i] = nil;
								end
							end
						end
					end
				end
				wait(0.5);
			end
		end
	end	
end
