local types = {"HeavyWeaponEquip", "BluntWeaponEquip", "SwordEquip", "CannonEquip", "AccessoryEquip"};
local _max = 10;

local v2 = game:GetService("Players").LocalPlayer.Inventory.I;
local event = game:GetService("ReplicatedStorage").Remotes.Item;

local v1 = "AccessoryEquip36";
local v3 = "Accessory1";

event:InvokeServer(v1, v2, v3);

--[[
for _i=0, 30 do
    local v1 = "AccessoryEquip" .. tostring(_i);
    local v3 = "Accessory1";
    
    event:InvokeServer(v1, v2, v3);
end
--]]

---[[
for i,v in next, types do
    if v == "SwordEquip" then
        for _i=0, _max do
            local v3 = "PrimaryWeapon1";
            
            local v1 = v .. tostring(_i);
            event:InvokeServer(v1, v2, v3);
        end
    elseif v == "AccessoryEquip" then
        for _i=0, 30 do
            local v1 = v .. tostring(_i);
            local v3 = "Accessory1";
            
            event:InvokeServer(v1, v2, v3);
        end
    else
        for _i=0, _max do
            local v1 = v .. tostring(_i);
            event:InvokeServer(v1, v2);
        end
    end
end
---]]
