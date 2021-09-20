local altname = "cirrws" -- name of your alt
local framed = 427348404 -- user id of person you want to frame

local function morph()
local appearance = game.Players:GetCharacterAppearanceAsync(framed)
local player = game.Players:FindFirstChild(altname)

for i,v in pairs(player.Character:GetChildren()) do
   if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") or v:IsA("BodyColors") then
       v:Destroy()
   end
end

if player.Character.Head:FindFirstChild("face") then
   player.Character.Head.face:Destroy()
end
   
for i,v in pairs(appearance:GetChildren()) do
   if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
       v.Parent = player.Character
   elseif v:IsA("Accessory") then
       player.Character.Humanoid:AddAccessory(v)
       local weld = Instance.new("Weld")
       weld.Name = "AccessoryWeld"
       weld.Part0 = v.Handle
       weld.Part1 = player.Character.Head
       weld.Parent = v.Handle
   elseif v.Name == "R6" then
       if player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
           v:FindFirstChildOfClass("CharacterMesh").Parent = player.Character
       end
   elseif v.Name == "R15" then
       if player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
           v:FindFirstChildOfClass("CharacterMesh").Parent = player.Character
       end
   end
end

if appearance:FindFirstChild("face") then
   appearance.face.Parent = player.Character.Head
else
   local face = Instance.new("Decal")
   face.Face = "Front"
   face.Name = "face"
   face.Texture = "rbxasset://textures/face.png"
   face.Transparency = 0
   face.Parent = player.Character.Head
end

-- Reload Character
local parent = player.Character.Parent
player.Character.Parent = nil
player.Character.Parent = parent
end

morph()

local fakename = game:GetService("Workspace").Users:FindFirstChild(altname).NameOverhead.UI.Username:Clone()
fakename.Name = "Fakename"
fakename.Parent = game:GetService("Workspace").Users:FindFirstChild(altname).NameOverhead.UI
game:GetService("Workspace").Users:FindFirstChild(altname).NameOverhead.UI.Username:Destroy()
fakename.Text = game:GetService("Players"):GetNameFromUserIdAsync(framed)
