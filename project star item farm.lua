local lp = game:service"Players".LocalPlayer;
local rs = game:service"ReplicatedStorage";
local ws = workspace;
local run_s = game:service"RunService";

lp:Kick("the script is patched u scrub");

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
coroutine.wrap(function()
    while wait() do
        if item_farm and lp.Character and lp.Character.PrimaryPart then
            for i,v in pairs(ws.Drops.Active:GetChildren()) do
                if not table.find(item_blacklist, v.Name) and v:FindFirstChildOfClass("ProximityPrompt", true) then
					local a = v:FindFirstChildOfClass("ProximityPrompt", true);
					local b = v:FindFirstChildOfClass("Part") or v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("Handle");
					if b and a then
					    lp.Character.PrimaryPart.CFrame = b.CFrame * CFrame.new(0, -5, 0);
					    wait(.25);
					    fireproximityprompt(a);
					    wait(.25);
					end
				end
            end
        end
    end
end)();
