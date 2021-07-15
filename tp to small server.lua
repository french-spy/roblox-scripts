local placeId = game.PlaceId;
local foundAnything = "";
local function brr()
    local site;
    if foundAnything == "" then
        site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
    else
        site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local id = "";
    if site.nextPageCursor and site.nextPageCursor ~= "null" and site.nextPageCursor ~= nil then
        foundAnything = site.nextPageCursor;
    end
    local num = 0;
    for i,v in pairs(site.data) do
        id = tostring(v.id);
        print(id);
        if tonumber(v.playing) <= 3 then
            pcall(function()
                game:service"TeleportService":TeleportToPlaceInstance(placeId, id, game:service"Players".LocalPlayer); 
            end)
            wait(4);
        end
    end
end
