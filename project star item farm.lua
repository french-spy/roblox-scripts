local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;
local run_s = game:service"RunService";
local ts = game:service"TweenService";

lp:Kick("Script is patched");

local a = lp.Character.Humanoid:Clone();
a.Parent = lp.Character;
lp.Character.Humanoid:Destroy();
wait(1);

local instance_names = {"Torso", "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg"};
coroutine.wrap(function()
	---[[
	run_s.RenderStepped:Connect(function()
		if item_farm and lp.Character and lp.Character:FindFirstChild("Humanoid") then
			lp.Character.Humanoid:ChangeState(11);
		end
	end);
	---]]
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
wait(1);

--[[
local function get_closest_item()
	local temp = nil;
	
	for i,v in pairs(ws.Drops.Active:GetChildren()) do
		if not table.find(item_blacklist, v.Name) and v:FindFirstChildOfClass("ProximityPrompt", true) then
			local a = v:FindFirstChildOfClass("ProximityPrompt", true);
			local b = v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Handle") or v;
			if b and a then
				temp = v;
				break;
			end
		end
	end
	
	for i,v in pairs(ws.Drops.Active:GetChildren()) do
		if not table.find(item_blacklist, v.Name) and v:FindFirstChildOfClass("ProximityPrompt", true) then
			local a = v:FindFirstChildOfClass("ProximityPrompt", true);
			local b = v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Handle") or v;
			if b and a then
				local aaa = temp:FindFirstChildOfClass("Part") or temp:FindFirstChildOfClass("MeshPart") or temp:FindFirstChildOfClass("Handle") or temp;
				if (b.Position - lp.Character.PrimaryPart.Position).magnitude < (aaa.Position - lp.Character.PrimaryPart.Position).magnitude then
					temp = v;
				end
			end
		end
	end
	
	print(temp);
	return temp;
end
coroutine.wrap(function()
    pcall(function()
		while wait() do
			if item_farm then
				for i,v in pairs(ws.Drops.Active:GetChildren()) do
					if lp.Character and lp.Character.PrimaryPart then
						local closest = nil;
						repeat wait()
							closest = get_closest_item();
						until closest;
						
						local part = closest:FindFirstChildOfClass("Part") or closest:FindFirstChildOfClass("MeshPart") or closest:FindFirstChildOfClass("Handle") or closest;
						local pp = closest:FindFirstChildOfClass("ProximityPrompt", true);
						local dist = (part.Position - lp.Character.PrimaryPart.Position).magnitude;
						if dist <= dist_before_tp then
							lp.Character.PrimaryPart.CFrame = part.CFrame;
						else
							local time = dist / speed;
							local tween_info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
							local tween = ts:Create(lp.Character.PrimaryPart, tween_info, {CFrame = part.CFrame});
							tween:Play();
							repeat wait() until (part.Position - lp.Character.PrimaryPart.Position).magnitude <= dist_before_tp;
							tween:Cancel();
							lp.Character.PrimaryPart.CFrame = part.CFrame;
						end
						wait(.25);
						local count = 0;
						repeat wait()
							fireproximityprompt(pp);
							count = count + 1;
						until not pp or not pp:IsDescendantOf(game) or count >= 10;
						wait(.25);
					end
				end
			end
		end
	end)
end)();
--]]
coroutine.wrap(function()
	pcall(function()
		while wait() do
			if item_farm then
				for i,v in pairs(ws.Drops.Active:GetChildren()) do
					if not table.find(item_blacklist, v.Name) and v:FindFirstChildOfClass("ProximityPrompt", true) then
						local a = v:FindFirstChildOfClass("ProximityPrompt", true);
						local b = v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Handle") or v;
						if b and a then
							lp.Character.PrimaryPart.CFrame = b.CFrame;
							wait(.25);
							local count = 0;
							repeat wait()
								fireproximityprompt(a);
								count = count + 1;
							until not a or not a:IsDescendantOf(game) or count >= 10;
							wait(.25);
						end
					end
				end
			end
		end
	end)
end)();
