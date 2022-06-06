local spells = {
    ["Audere"] = {"LEFT", "UP", "RIGHT"}, --dash
    ["Impetu"] = {"LEFT", "UP", "DOWN", "RIGHT"}, --push
    ["Lux"] = {"DOWN", "UP"}, --light
    ["Perkeli"] = {"LEFT", "UP", "DOWN", "UP", "RIGHT"}, --portal
    ["Keros"] = {"DOWN", "RIGHT", "UP"}, --blood
    ["Vadovas"] = {"LEFT", "DOWN", "RIGHT", "DOWN", "UP"}, --sacred field
    ["Veraten"] = {"RIGHT", "LEFT", "UP", "DOWN"}, --heal
    ["Nirvas"] = {"LEFT", "UP", "RIGHT", "DOWN", "LEFT", "RIGHT"}, --ground explosion
    ["Folium"] = {"UP", "LEFT", "DOWN", "RIGHT", "UP"}, --tree
    ["Fulgur"] = {"UP", "LEFT", "RIGHT", "DOWN"} --electricity slam
};

local IO = game:service"ReplicatedStorage".IO;
local lp = game:service"Players".LocalPlayer;

local function cast(spell)
    if spells[spell] then
        IO:FireServer("Input", "C", true);
        for i,v in pairs(spells[spell]) do
            IO:FireServer("AltActions", "Sign", v);
        end
        IO:FireServer("Input", "C", false);
    end
end

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))();
local venyx = library.new("Venyx", 5013109572);

local page = venyx:addPage("Test", 5012544693);
local section2 = page:addSection("Section 2");
local section3 = page:addSection("Section 3");

section3:addKeybind("Destroy GUI", Enum.KeyCode.RightAlt, function() game:service"CoreGui".Venyx:Destroy() end, function() end);

for i,v in pairs(spells) do
    section2:addKeybind(i, nil, function()
        cast(i);
    end, function() end);
end

venyx:SelectPage(venyx.pages[1], true)
