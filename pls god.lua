_G.mob = "GenericOni"; --GenericOni/GenericSlayer/Green Demon(?)
_G.noclip = true;
_G.distFromMob = 6;
_G.autofarm = true;
_G.notExecuted = true; --dont touch

--pcall(function()
	if game.PlaceId == 5094651510 then
		print("brr")
		repeat wait() until game:IsLoaded();
		wait(5.5);
		print("GameLoaded");
		game:WaitForChild("Players");
		repeat wait() until game.Players.LocalPlayer;
		game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LoadingScreen");
		
		if #game.Players:GetChildren() == 1 then
			local lp = game:service"Players".LocalPlayer;
			local ts = game:service"TweenService";
			local vu = game:service"VirtualUser";
			local rs = game:service"ReplicatedStorage";
			local ws = game:service"Workspace";
			local runs = game:service"RunService";
			local vim = game:service"VirtualInputManager";
			local tps = game:service"TeleportService";
			
			repeat wait() until lp.Character;
			
			local demonsLeft = 30;

			for i=0, 3 do if lp.PlayerGui:FindFirstChild("LoadingScreen") then firesignal(lp.PlayerGui.LoadingScreen.Background.Loading.Skip.MouseButton1Click); end end
				
			repeat wait() until lp.Character;
			
			local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();
			repeat wait() until lp.Character;
			--Noclip
			coroutine.wrap(function()
				pcall(function()
					runs.RenderStepped:Connect(function()
						if _G.noclip then lp.Character.Humanoid:ChangeState(11); end
					end)
				end)
			end)();
			print("NoclipOn");
			
			repeat wait() until lp.Character;
			coroutine.wrap(function()
				pcall(function()
					while wait() do
						if lp.Character:FindFirstChild("Sequence") then
							lp.Character:FindFirstChild("Sequence"):Destroy();
						end
					end
				end);
			end)();
			print("InfM1sOn");
		
			wait(2);
			local instances = {
				"Busy";
				"Ragdoll";
				"Down";
				"Stun";
				"Combat";
				"Health";
				"Stamina";
			};
			lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
			
			repeat wait() until lp.Character;
			
			coroutine.wrap(function()
				while wait() do
					for _, object in next, lp.Character:GetChildren() do 
						if table.find(instances, object.Name) or string.lower(object.Name):find("cooldown") or string.lower(object.Name):find("activate") then 
							object:Destroy()
						end 
					end 
				end
			end)();
			print("GodModeOn");
			
			coroutine.wrap(function()
				while wait() do
					local questText = lp.PlayerGui.Interface.Quest.Todo.List.Quest.Text;

					for w in questText:gmatch("%S+") do 
						if tonumber(w) then demonsLeft = tonumber(w); end
					end
				end
			end)();
			print("DemonUpdatedOn");
			wait(2);
			print(demonsLeft);
			
			--Checks if you are a demon or a slayer
			local style = "";
			if getrenv()._G.PlayerData.Race == "Demon Slayer" then
				style = "Katana";
			else
				style = "Combat";
			end
			print("Style set to " .. style);
			
			
			local function getClosestMob()
				local temp = nil;
				for i,v in next, ws:GetChildren() do
					if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and not v:FindFirstChild("Down") then temp = v; break; end
				end
				for i,v in next, ws:GetChildren() do
					if v:IsA("Model") and v.Name == _G.mob and v:FindFirstChild("HumanoidRootPart") and not v:FindFirstChild("Down") then
						if (v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude < (temp.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude then
							temp = v;
						end
					end
				end
				return temp;
			end
			
			wait(2);
			print(demonsLeft);
			if style == "Katana" then
				rs.Remotes.Async:FireServer("Katana", "EquippedEvents", true, true);
			end
			local aa = 0;
			--pcall(function()
				while wait() do
					aa = aa + 1;
					if _G.autofarm and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Health.Value ~= 0 and demonsLeft >= 2 and aa == 1 then				
						local closest = getClosestMob();
						repeat wait()
							closest = getClosestMob();
						until closest
						
						local dist = (closest.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).magnitude;
						if dist <= 100 then
							lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
						else
							tpBypass.bindable:Invoke();
							lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
						end
						
						_G.notExecuted = true;
						
						repeat wait()
							lp.Character.HumanoidRootPart.CFrame = CFrame.new((closest.HumanoidRootPart.Position + Vector3.new(0, _G.distFromMob, 0)), closest.HumanoidRootPart.Position);
							if closest:FindFirstChild("Block") and not closest:FindFirstChild("Ragdoll") then
								if lp.Stamina.Value >= 20 then
									rs.Remotes.Async:FireServer(style, "Heavy");
								end
							end
							
							if not closest:FindFirstChild("Ragdoll") and not closest:FindFirstChild("Block") then wait(0.45); rs.Remotes.Async:FireServer(style, "Server"); end
							
							if closest:FindFirstChild("Down") then
								local count = 0;
								repeat wait()
									lp.Character.HumanoidRootPart.CFrame = closest.HumanoidRootPart.CFrame;
									wait(0.1);
									count = count + 1;
									vim:SendKeyEvent(true, Enum.KeyCode.B, false, game);
									wait(0.5);
									vim:SendKeyEvent(false, Enum.KeyCode.B, false, game);
									if lp.Character:FindFirstChild("OnExecute") or closest:FindFirstChild("Executing") then
										local cf = lp.Character.HumanoidRootPart.CFrame;
										local count2 = 0;
										repeat wait() lp.Character.HumanoidRootPart.Anchored = false; lp.Character.HumanoidRootPart.CFrame = cf * CFrame.new(0, -15, 0); count2 = count2 + 1; print("Attempting Execute"); until closest:FindFirstChild("Executed") or count2 >= 50;	
									end
								until closest:FindFirstChild("Executed") or count > 10;
								local br = ws.ChildAdded:Connect(function(c)
									c:WaitForChild("ItemName");
									if c.Name == "DropItem" and c.ItemName.Value == "Broken Nichirin" or c.ItemName.Value == "Demon Horn" then
										rs.Remotes.Async:FireServer("Character", "Interaction", c);
										vim:SendKeyEvent(true, Enum.KeyCode.E, false, game);
										wait(0.5);
										vim:SendKeyEvent(false, Enum.KeyCode.E, false, game);
									end
								end);
								wait(0.7);
								_G.notExecuted = false;
								br:Disconnect();
							end
						until not _G.autofarm or not _G.notExecuted
						_G.noclip = true;
						wait(1.5);
					elseif _G.autofarm and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Health.Value ~= 0 and demonsLeft <= 2 then
						syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/pls%20god.lua"));
						tps:Teleport(5094651510, lp);
					end
				end
			--end)
		elseif #game.Players:GetChildren() > 1 then
			local lp = game:service"Players".LocalPlayer;
			local ts = game:service"TweenService";
			local vu = game:service"VirtualUser";
			local rs = game:service"ReplicatedStorage";
			local ws = game:service"Workspace";
			local runs = game:service"RunService";
			local vim = game:service"VirtualInputManager";
			local camera = ws.CurrentCamera;
			
			if lp.PlayerGui:FindFirstChild("LoadingScreen") then firesignal(lp.PlayerGui.LoadingScreen.Background.Loading.Skip.MouseButton1Click); end
			
			local tpBypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/demonfall%20tp%20bypass.lua"))();
			
			wait(2.5);
			
			tpBypass.bindable:Invoke();
			lp.Character.HumanoidRootPart.CFrame = CFrame.new(-5201.61719, 792.619141, -3048.21924, 0.056257762, -1.04497587e-07, 0.998416424, -1.21436461e-08, 1, 1.05347581e-07, -0.998416424, -1.80510398e-08, 0.056257762);

			wait(2);

			local examNpc = ws.Npcs.Exam;
			local vector, onScreen = camera:WorldToViewportPoint(examNpc.HumanoidRootPart.Position);

			vim:SendMouseButtonEvent(vector.X, vector.Y, 0, true, game, 0);
			wait(0.5);
			vim:SendMouseButtonEvent(vector.X, vector.Y, 0, false, game, 0);
			wait(5);
			lp.PlayerGui.Interface.Dialogue.Answers:WaitForChild("Answer");
			for i,v in pairs(lp.PlayerGui.Interface.Dialogue.Answers:GetChildren()) do
				if v:IsA("TextButton") and v.Text == "I'm here to do the exam" then
					print("brrr");
					local x, y = math.floor(v.AbsolutePosition.X + 0.5), math.floor(v.AbsolutePosition.Y + 0.5);
					print(x, y);
					syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/french-spy/roblox-scripts/main/pls%20god.lua"));
					vim:SendMouseButtonEvent(x + 25, y + 40, 0, true, game, 0);
					wait(0.5);
					vim:SendMouseButtonEvent(x + 25, y + 40, 0, false, game, 0);
				end
			end 
		end
	end
--end)
