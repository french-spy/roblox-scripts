--! Orion Library
--! Recode@2024.1.5

--! Author: ttwiz_z (ttwizz)
--! License: MIT
--! GitHub: https://github.com/ttwizz/Roblox/blob/master/Orion.lua

--! Issues: https://github.com/ttwizz/Roblox/issues
--! Pull requests: https://github.com/ttwizz/Roblox/pulls
--! Discussions: https://github.com/ttwizz/Roblox/discussions

--! twix.cyou/pix


--? Source Code

local L_1_ = game:GetService("ScriptContext")
local L_2_ = game:GetService("UserInputService")
local L_3_ = game:GetService("TweenService")
local L_4_ = game:GetService("RunService")
local L_5_ = game:GetService("Players").LocalPlayer
local L_6_ = L_5_:GetMouse()
local L_7_ = game:GetService("HttpService")
local L_8_ = game:GetService("CoreGui")
local L_9_ = game:GetService("Debris")


if getfenv().getconnections then
    for _, L_33_forvar2 in next, getfenv().getconnections(L_1_.Error) do
        L_33_forvar2:Disable()
    end
end


local L_10_ = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
    Themes = {
        Default = {
            Main = Color3.fromRGB(25, 25, 25),
            Second = Color3.fromRGB(32, 32, 32),
            Stroke = Color3.fromRGB(60, 60, 60),
            Divider = Color3.fromRGB(60, 60, 60),
            Text = Color3.fromRGB(240, 240, 240),
            TextDark = Color3.fromRGB(150, 150, 150)
        }
    },
    SelectedTheme = "Default",
    SaveCfg = false
}

local L_11_ = [[
    {
      "icons": {
        "aperture": "rbxassetid://7733666258",
        "bug": "rbxassetid://7733701545",
        "chevrons-down-up": "rbxassetid://7733720483",
        "clock-6": "rbxassetid://8997384977",
        "egg": "rbxassetid://8997385940",
        "external-link": "rbxassetid://7743866903",
        "lightbulb-off": "rbxassetid://7733975123",
        "file-check-2": "rbxassetid://7733779610",
        "settings": "rbxassetid://7734053495",
        "crown": "rbxassetid://7733765398",
        "coins": "rbxassetid://7743866529",
        "battery": "rbxassetid://7733674820",
        "flashlight-off": "rbxassetid://7733798799",
        "camera-off": "rbxassetid://7733919260",
        "function-square": "rbxassetid://7733799682",
        "mountain-snow": "rbxassetid://7743870286",
        "gamepad": "rbxassetid://7733799901",
        "gift": "rbxassetid://7733946818",
        "globe": "rbxassetid://7733954760",
        "option": "rbxassetid://7734021300",
        "hand": "rbxassetid://7733955740",
        "hard-hat": "rbxassetid://7733955850",
        "hash": "rbxassetid://7733955906",
        "server": "rbxassetid://7734053426",
        "align-horizontal-space-around": "rbxassetid://8997381738",
        "highlighter": "rbxassetid://7743868648",
        "bike": "rbxassetid://7733678330",
        "home": "rbxassetid://7733960981",
        "image": "rbxassetid://7733964126",
        "indent": "rbxassetid://7733964452",
        "infinity": "rbxassetid://7733964640",
        "inspect": "rbxassetid://7733964808",
        "alert-triangle": "rbxassetid://7733658504",
        "align-start-horizontal": "rbxassetid://8997381965",
        "figma": "rbxassetid://7743867310",
        "pin": "rbxassetid://8997386648",
        "corner-up-right": "rbxassetid://7733764915",
        "list-x": "rbxassetid://7743869517",
        "monitor-off": "rbxassetid://7734000184",
        "chevron-first": "rbxassetid://8997383275",
        "package-search": "rbxassetid://8997386448",
        "pencil": "rbxassetid://7734022107",
        "cloud-fog": "rbxassetid://7733920317",
        "grip-horizontal": "rbxassetid://7733955302",
        "align-center-vertical": "rbxassetid://8997380737",
        "outdent": "rbxassetid://7734021384",
        "more-vertical": "rbxassetid://7734006187",
        "package-plus": "rbxassetid://8997386355",
        "bluetooth": "rbxassetid://7733687147",
        "pen-tool": "rbxassetid://7734022041",
        "person-standing": "rbxassetid://7743871002",
        "tornado": "rbxassetid://7743873633",
        "phone-incoming": "rbxassetid://7743871120",
        "phone-off": "rbxassetid://7734029534",
        "dribbble": "rbxassetid://7733770843",
        "at-sign": "rbxassetid://7733673907",
        "edit-2": "rbxassetid://7733771217",
        "sheet": "rbxassetid://7743871876",
        "tv": "rbxassetid://7743874674",
        "headphones": "rbxassetid://7733956063",
        "qr-code": "rbxassetid://7743871575",
        "reply": "rbxassetid://7734051594",
        "rewind": "rbxassetid://7734051670",
        "bell-off": "rbxassetid://7733675107",
        "file-check": "rbxassetid://7733779668",
        "quote": "rbxassetid://7734045100",
        "rotate-ccw": "rbxassetid://7734051861",
        "library": "rbxassetid://7743869054",
        "clock-1": "rbxassetid://8997383694",
        "on-charge": "rbxassetid://7734021231",
        "video-off": "rbxassetid://7743876466",
        "save": "rbxassetid://7734052335",
        "arrow-left-circle": "rbxassetid://7733673056",
        "screen-share": "rbxassetid://7734052814",
        "clock-3": "rbxassetid://8997384456",
        "help-circle": "rbxassetid://7733956210",
        "server-crash": "rbxassetid://7734053281",
        "bluetooth-searching": "rbxassetid://7733914320",
        "equal": "rbxassetid://7733771811",
        "shield-close": "rbxassetid://7734056470",
        "phone": "rbxassetid://7734032056",
        "type": "rbxassetid://7743874740",
        "file-x-2": "rbxassetid://7743867554",
        "sidebar": "rbxassetid://7734058260",
        "sigma": "rbxassetid://7734058345",
        "smartphone-charging": "rbxassetid://7734058894",
        "arrow-left": "rbxassetid://7733673136",
        "framer": "rbxassetid://7733799486",
        "currency": "rbxassetid://7733765592",
        "star": "rbxassetid://7734068321",
        "stretch-horizontal": "rbxassetid://8997387754",
        "smile": "rbxassetid://7734059095",
        "subscript": "rbxassetid://8997387937",
        "sun": "rbxassetid://7734068495",
        "switch-camera": "rbxassetid://7743872492",
        "table": "rbxassetid://7734073253",
        "tag": "rbxassetid://7734075797",
        "cross": "rbxassetid://7733765224",
        "gem": "rbxassetid://7733942651",
        "link": "rbxassetid://7733978098",
        "terminal": "rbxassetid://7743872929",
        "thermometer-sun": "rbxassetid://7734084018",
        "share-2": "rbxassetid://7734053595",
        "timer-off": "rbxassetid://8997388325",
        "megaphone": "rbxassetid://7733993049",
        "timer-reset": "rbxassetid://7743873336",
        "phone-forwarded": "rbxassetid://7734027345",
        "unlock": "rbxassetid://7743875263",
        "trello": "rbxassetid://7743873996",
        "camera": "rbxassetid://7733708692",
        "triangle": "rbxassetid://7743874367",
        "truck": "rbxassetid://7743874482",
        "file-output": "rbxassetid://7733788742",
        "gamepad-2": "rbxassetid://7733799795",
        "network": "rbxassetid://7734021047",
        "users": "rbxassetid://7743876054",
        "electricity-off": "rbxassetid://7733771563",
        "book": "rbxassetid://7733914390",
        "clock-9": "rbxassetid://8997385485",
        "corner-down-left": "rbxassetid://7733764327",
        "locate-fixed": "rbxassetid://7733992424",
        "bar-chart": "rbxassetid://7733674319",
        "shield-check": "rbxassetid://7734056411",
        "signal-low": "rbxassetid://8997387189",
        "reply-all": "rbxassetid://7734051524",
        "zoom-in": "rbxassetid://7743878977",
        "grip-vertical": "rbxassetid://7733955410",
        "ticket": "rbxassetid://7734086558",
        "smartphone": "rbxassetid://7734058979",
        "arrow-big-right": "rbxassetid://7733671493",
        "tv-2": "rbxassetid://7743874599",
        "flashlight": "rbxassetid://7733798851",
        "database": "rbxassetid://7743866778",
        "plus-square": "rbxassetid://7734040369",
        "align-justify": "rbxassetid://7733661326",
        "clipboard-list": "rbxassetid://7733920117",
        "github": "rbxassetid://7733954058",
        "columns": "rbxassetid://7733757178",
        "arrow-big-down": "rbxassetid://7733668653",
        "cloud-off": "rbxassetid://7733745572",
        "target": "rbxassetid://7743872758",
        "skip-back": "rbxassetid://7734058404",
        "x-circle": "rbxassetid://7743878496",
        "clock-10": "rbxassetid://8997383876",
        "align-right": "rbxassetid://7733663582",
        "clock-5": "rbxassetid://8997384798",
        "bell-plus": "rbxassetid://7733675181",
        "battery-medium": "rbxassetid://7733674731",
        "arrow-down": "rbxassetid://7733672933",
        "inbox": "rbxassetid://7733964370",
        "cast": "rbxassetid://7733919326",
        "gift-card": "rbxassetid://7733945018",
        "webcam": "rbxassetid://7743877896",
        "folder-minus": "rbxassetid://7733799022",
        "scan-line": "rbxassetid://8997386772",
        "shovel": "rbxassetid://7734056878",
        "download-cloud": "rbxassetid://7733770689",
        "list-checks": "rbxassetid://7743869317",
        "file-text": "rbxassetid://7733789088",
        "codesandbox": "rbxassetid://7733752575",
        "laptop-2": "rbxassetid://7733965313",
        "podcast": "rbxassetid://7734042234",
        "log-out": "rbxassetid://7733992677",
        "thumbs-up": "rbxassetid://7743873212",
        "timer": "rbxassetid://7743873443",
        "text-cursor": "rbxassetid://8997388195",
        "file-search": "rbxassetid://7733788966",
        "thermometer": "rbxassetid://7734084149",
        "bluetooth-off": "rbxassetid://7733914252",
        "refresh-cw": "rbxassetid://7734051052",
        "clipboard-check": "rbxassetid://7733919947",
        "languages": "rbxassetid://7733965249",
        "asterisk": "rbxassetid://7733673800",
        "superscript": "rbxassetid://8997388036",
        "user-check": "rbxassetid://7743875503",
        "move-diagonal": "rbxassetid://7743870505",
        "copy": "rbxassetid://7733764083",
        "bot": "rbxassetid://7733916988",
        "alarm-minus": "rbxassetid://7733656164",
        "log-in": "rbxassetid://7733992604",
        "maximize": "rbxassetid://7733992982",
        "align-horizontal-space-between": "rbxassetid://8997381854",
        "brush": "rbxassetid://7733701455",
        "equal-not": "rbxassetid://7733771726",
        "upload": "rbxassetid://7743875428",
        "minus-circle": "rbxassetid://7733998053",
        "graduation-cap": "rbxassetid://7733955058",
        "edit-3": "rbxassetid://7733771361",
        "check": "rbxassetid://7733715400",
        "scissors": "rbxassetid://7734052570",
        "info": "rbxassetid://7733964719",
        "align-horizonal-distribute-start": "rbxassetid://8997381290",
        "book-open": "rbxassetid://7733687281",
        "divide-circle": "rbxassetid://7733769152",
        "file": "rbxassetid://7733793319",
        "clock-2": "rbxassetid://8997384295",
        "corner-right-up": "rbxassetid://7733764680",
        "clover": "rbxassetid://7733747233",
        "expand": "rbxassetid://7733771982",
        "gauge": "rbxassetid://7733799969",
        "phone-outgoing": "rbxassetid://7743871253",
        "shield-alert": "rbxassetid://7734056326",
        "paperclip": "rbxassetid://7734021680",
        "arrow-big-left": "rbxassetid://7733911731",
        "album": "rbxassetid://7733658133",
        "bookmark": "rbxassetid://7733692043",
        "check-circle-2": "rbxassetid://7733710700",
        "list-ordered": "rbxassetid://7743869411",
        "delete": "rbxassetid://7733768142",
        "axe": "rbxassetid://7733674079",
        "radio": "rbxassetid://7743871662",
        "octagon": "rbxassetid://7734021165",
        "git-commit": "rbxassetid://7743868360",
        "shirt": "rbxassetid://7734056672",
        "corner-right-down": "rbxassetid://7733764605",
        "trending-down": "rbxassetid://7743874143",
        "airplay": "rbxassetid://7733655834",
        "repeat": "rbxassetid://7734051454",
        "layers": "rbxassetid://7743868936",
        "chevron-right": "rbxassetid://7733717755",
        "chevrons-right": "rbxassetid://7733919682",
        "folder-plus": "rbxassetid://7733799092",
        "alarm-check": "rbxassetid://7733655912",
        "arrow-up-right": "rbxassetid://7733673646",
        "user-plus": "rbxassetid://7743875759",
        "file-minus": "rbxassetid://7733936115",
        "cloud-drizzle": "rbxassetid://7733920226",
        "stretch-vertical": "rbxassetid://8997387862",
        "align-vertical-distribute-start": "rbxassetid://8997382428",
        "unlink": "rbxassetid://7743875149",
        "wand": "rbxassetid://8997388430",
        "regex": "rbxassetid://7734051188",
        "command": "rbxassetid://7733924046",
        "haze": "rbxassetid://7733955969",
        "trash": "rbxassetid://7743873871",
        "battery-full": "rbxassetid://7733674503",
        "flag-triangle-left": "rbxassetid://7733798509",
        "server-off": "rbxassetid://7734053361",
        "loader-2": "rbxassetid://7733989869",
        "monitor-speaker": "rbxassetid://7743869988",
        "shuffle": "rbxassetid://7734057059",
        "tablet": "rbxassetid://7743872620",
        "cloud-moon": "rbxassetid://7733920519",
        "clipboard-x": "rbxassetid://7733734668",
        "pocket": "rbxassetid://7734042139",
        "watch": "rbxassetid://7743877668",
        "file-plus": "rbxassetid://7733788885",
        "locate": "rbxassetid://7733992469",
        "share": "rbxassetid://7734053697",
        "thermometer-snowflake": "rbxassetid://7743873074",
        "volume-1": "rbxassetid://7743877081",
        "arrow-left-right": "rbxassetid://8997382869",
        "coffee": "rbxassetid://7733752630",
        "chevron-last": "rbxassetid://8997383390",
        "cloud-hail": "rbxassetid://7733920444",
        "alarm-clock-off": "rbxassetid://7733656003",
        "pound-sterling": "rbxassetid://7734042354",
        "tent": "rbxassetid://7734078943",
        "toggle-left": "rbxassetid://7734091286",
        "dollar-sign": "rbxassetid://7733770599",
        "sunrise": "rbxassetid://7743872365",
        "sunset": "rbxassetid://7734070982",
        "code": "rbxassetid://7733749837",
        "thumbs-down": "rbxassetid://7734084236",
        "trending-up": "rbxassetid://7743874262",
        "clock-12": "rbxassetid://8997384150",
        "rocking-chair": "rbxassetid://7734051769",
        "check-square": "rbxassetid://7733919526",
        "cpu": "rbxassetid://7733765045",
        "palette": "rbxassetid://7734021595",
        "minimize-2": "rbxassetid://7733997870",
        "cloud-sun": "rbxassetid://7733746880",
        "copyleft": "rbxassetid://7733764196",
        "archive": "rbxassetid://7733911621",
        "building": "rbxassetid://7733701625",
        "image-minus": "rbxassetid://7733963797",
        "italic": "rbxassetid://7733964917",
        "link-2-off": "rbxassetid://7733975283",
        "sort-asc": "rbxassetid://7734060715",
        "underline": "rbxassetid://7743874904",
        "gitlab": "rbxassetid://7733954246",
        "file-minus-2": "rbxassetid://7733936010",
        "play-circle": "rbxassetid://7734037784",
        "clock-8": "rbxassetid://8997385352",
        "file-input": "rbxassetid://7733935917",
        "beaker": "rbxassetid://7733674922",
        "shopping-bag": "rbxassetid://7734056747",
        "navigation": "rbxassetid://7734020989",
        "moon": "rbxassetid://7743870134",
        "align-vertical-space-between": "rbxassetid://8997382793",
        "glasses": "rbxassetid://7733954403",
        "clipboard-copy": "rbxassetid://7733920037",
        "feather": "rbxassetid://7733777166",
        "skip-forward": "rbxassetid://7734058495",
        "wind": "rbxassetid://7743878264",
        "frown": "rbxassetid://7733799591",
        "move-vertical": "rbxassetid://7743870608",
        "umbrella": "rbxassetid://7743874820",
        "package": "rbxassetid://7734021469",
        "chevrons-up": "rbxassetid://7733723433",
        "download": "rbxassetid://7733770755",
        "eye": "rbxassetid://7733774602",
        "files": "rbxassetid://7743867811",
        "arrow-down-right": "rbxassetid://7733672831",
        "code-2": "rbxassetid://7733920644",
        "wrap-text": "rbxassetid://8997388548",
        "file-digit": "rbxassetid://7733935829",
        "x-square": "rbxassetid://7743878737",
        "clipboard": "rbxassetid://7733734762",
        "maximize-2": "rbxassetid://7733992901",
        "send": "rbxassetid://7734053039",
        "alarm-clock": "rbxassetid://7733656100",
        "sliders": "rbxassetid://7734058803",
        "refresh-ccw": "rbxassetid://7734050715",
        "music": "rbxassetid://7734020554",
        "banknote": "rbxassetid://7733674153",
        "hard-drive": "rbxassetid://7733955793",
        "search": "rbxassetid://7734052925",
        "layout-list": "rbxassetid://7733970442",
        "edit": "rbxassetid://7733771472",
        "contrast": "rbxassetid://7733764005",
        "wifi": "rbxassetid://7743878148",
        "swiss-franc": "rbxassetid://7734071038",
        "ghost": "rbxassetid://7743868000",
        "laptop": "rbxassetid://7733965386",
        "clock-4": "rbxassetid://8997384603",
        "layout-dashboard": "rbxassetid://7733970318",
        "align-vertical-justify-end": "rbxassetid://8997382584",
        "circle": "rbxassetid://7733919881",
        "file-x": "rbxassetid://7733938136",
        "award": "rbxassetid://7733673987",
        "corner-left-down": "rbxassetid://7733764448",
        "arrow-up-left": "rbxassetid://7733673539",
        "carrot": "rbxassetid://8997382987",
        "globe-2": "rbxassetid://7733954611",
        "compass": "rbxassetid://7733924216",
        "git-branch": "rbxassetid://7733949149",
        "vibrate": "rbxassetid://7743876302",
        "pause-circle": "rbxassetid://7734021767",
        "minus-square": "rbxassetid://7743869899",
        "mic-off": "rbxassetid://7743869714",
        "arrow-down-circle": "rbxassetid://7733671763",
        "move-horizontal": "rbxassetid://7734016210",
        "chrome": "rbxassetid://7733919783",
        "radio-receiver": "rbxassetid://7734045155",
        "shield": "rbxassetid://7734056608",
        "image-plus": "rbxassetid://7733964016",
        "more-horizontal": "rbxassetid://7734006080",
        "slash": "rbxassetid://8997387644",
        "divide": "rbxassetid://7733769365",
        "view": "rbxassetid://7743876754",
        "list": "rbxassetid://7743869612",
        "printer": "rbxassetid://7734042580",
        "corner-left-up": "rbxassetid://7733764536",
        "meh": "rbxassetid://7733993147",
        "copyright": "rbxassetid://7733764275",
        "align-end-vertical": "rbxassetid://8997380907",
        "heart": "rbxassetid://7733956134",
        "lock": "rbxassetid://7733992528",
        "align-center": "rbxassetid://7733909776",
        "signal-high": "rbxassetid://8997387110",
        "upload-cloud": "rbxassetid://7743875358",
        "arrow-up-circle": "rbxassetid://7733673466",
        "git-branch-plus": "rbxassetid://7743868200",
        "align-vertical-justify-center": "rbxassetid://8997382502",
        "screen-share-off": "rbxassetid://7734052653",
        "git-pull-request": "rbxassetid://7733952287",
        "flag": "rbxassetid://7733798691",
        "star-half": "rbxassetid://7734068258",
        "minus": "rbxassetid://7734000129",
        "mountain": "rbxassetid://7734008868",
        "volume": "rbxassetid://7743877487",
        "mouse-pointer-2": "rbxassetid://7734010405",
        "package-x": "rbxassetid://8997386545",
        "indian-rupee": "rbxassetid://7733964536",
        "speaker": "rbxassetid://7734063416",
        "flame": "rbxassetid://7733798747",
        "circle-slashed": "rbxassetid://8997383530",
        "crop": "rbxassetid://7733765140",
        "clock-11": "rbxassetid://8997384034",
        "stop-circle": "rbxassetid://7734068379",
        "align-horizontal-justify-end": "rbxassetid://8997381549",
        "power-off": "rbxassetid://7734042423",
        "bell-minus": "rbxassetid://7733675028",
        "undo": "rbxassetid://7743874974",
        "link-2": "rbxassetid://7743869163",
        "lightbulb": "rbxassetid://7733975185",
        "shrink": "rbxassetid://7734056971",
        "mail": "rbxassetid://7733992732",
        "pause": "rbxassetid://7734021897",
        "bold": "rbxassetid://7733687211",
        "calendar": "rbxassetid://7733919198",
        "x-octagon": "rbxassetid://7743878618",
        "russian-ruble": "rbxassetid://7734052248",
        "file-code": "rbxassetid://7733779730",
        "life-buoy": "rbxassetid://7733973479",
        "import": "rbxassetid://7733964240",
        "video": "rbxassetid://7743876610",
        "clock-7": "rbxassetid://8997385147",
        "align-center-horizontal": "rbxassetid://8997380477",
        "bell": "rbxassetid://7733911828",
        "move-diagonal-2": "rbxassetid://7734013178",
        "message-circle": "rbxassetid://7733993311",
        "skull": "rbxassetid://7734058599",
        "battery-charging": "rbxassetid://7733674402",
        "ruler": "rbxassetid://7734052157",
        "binary": "rbxassetid://7733678388",
        "cloud-rain-wind": "rbxassetid://7733746456",
        "briefcase": "rbxassetid://7733919017",
        "terminal-square": "rbxassetid://7734079055",
        "scale": "rbxassetid://7734052454",
        "lasso": "rbxassetid://7733967892",
        "piggy-bank": "rbxassetid://7734034513",
        "battery-low": "rbxassetid://7733674589",
        "arrow-up": "rbxassetid://7733673717",
        "list-plus": "rbxassetid://7733984995",
        "bookmark-plus": "rbxassetid://7734111084",
        "box-select": "rbxassetid://7733696665",
        "filter": "rbxassetid://7733798407",
        "play": "rbxassetid://7743871480",
        "align-vertical-space-around": "rbxassetid://8997382708",
        "calculator": "rbxassetid://7733919105",
        "bell-ring": "rbxassetid://7733675275",
        "plane": "rbxassetid://7734037723",
        "plus-circle": "rbxassetid://7734040271",
        "power": "rbxassetid://7734042493",
        "phone-missed": "rbxassetid://7734029465",
        "percent": "rbxassetid://7743870852",
        "jersey-pound": "rbxassetid://7733965029",
        "mouse-pointer": "rbxassetid://7743870392",
        "box": "rbxassetid://7733917120",
        "separator-vertical": "rbxassetid://7734053213",
        "snowflake": "rbxassetid://7734059180",
        "sort-desc": "rbxassetid://7743871973",
        "flag-triangle-right": "rbxassetid://7733798634",
        "bar-chart-2": "rbxassetid://7733674239",
        "hand-metal": "rbxassetid://7733955664",
        "map": "rbxassetid://7733992829",
        "eye-off": "rbxassetid://7733774495",
        "align-end-horizontal": "rbxassetid://8997380820",
        "cloud-rain": "rbxassetid://7733746651",
        "contact": "rbxassetid://7743866666",
        "signal": "rbxassetid://8997387546",
        "mouse-pointer-click": "rbxassetid://7734010488",
        "settings-2": "rbxassetid://8997386997",
        "sidebar-open": "rbxassetid://7734058165",
        "unlink-2": "rbxassetid://7743875069",
        "pause-octagon": "rbxassetid://7734021827",
        "user-minus": "rbxassetid://7743875629",
        "cloud": "rbxassetid://7733746980",
        "arrow-right-circle": "rbxassetid://7733673229",
        "align-horizonal-distribute-center": "rbxassetid://8997381028",
        "fast-forward": "rbxassetid://7743867090",
        "volume-2": "rbxassetid://7743877250",
        "grab": "rbxassetid://7733954884",
        "arrow-right": "rbxassetid://7733673345",
        "chevron-down": "rbxassetid://7733717447",
        "volume-x": "rbxassetid://7743877381",
        "cloud-snow": "rbxassetid://7733746798",
        "car": "rbxassetid://7733708835",
        "bluetooth-connected": "rbxassetid://7734110952",
        "CD": "rbxassetid://7734110220",
        "cookie": "rbxassetid://8997385628",
        "message-square": "rbxassetid://7733993369",
        "repeat-1": "rbxassetid://7734051342",
        "codepen": "rbxassetid://7733920768",
        "voicemail": "rbxassetid://7743876916",
        "text-cursor-input": "rbxassetid://8997388094",
        "package-check": "rbxassetid://8997386143",
        "shopping-cart": "rbxassetid://7734056813",
        "corner-down-right": "rbxassetid://7733764385",
        "folder-open": "rbxassetid://8997386062",
        "charge": "rbxassetid://8997383136",
        "layout-grid": "rbxassetid://7733970390",
        "clock": "rbxassetid://7733734848",
        "corner-up-left": "rbxassetid://7733764800",
        "align-horizontal-justify-start": "rbxassetid://8997381652",
        "git-merge": "rbxassetid://7733952195",
        "verified": "rbxassetid://7743876142",
        "redo": "rbxassetid://7743871739",
        "hexagon": "rbxassetid://7743868527",
        "square": "rbxassetid://7743872181",
        "align-horizontal-justify-center": "rbxassetid://8997381461",
        "chevrons-up-down": "rbxassetid://7733723321",
        "bus": "rbxassetid://7733701715",
        "file-plus-2": "rbxassetid://7733788816",
        "alarm-plus": "rbxassetid://7733658066",
        "divide-square": "rbxassetid://7733769261",
        "pie-chart": "rbxassetid://7734034378",
        "signal-zero": "rbxassetid://8997387434",
        "hammer": "rbxassetid://7733955511",
        "history": "rbxassetid://7733960880",
        "align-vertical-justify-start": "rbxassetid://8997382639",
        "flask-round": "rbxassetid://7733798957",
        "wifi-off": "rbxassetid://7743878056",
        "zoom-out": "rbxassetid://7743879082",
        "toggle-right": "rbxassetid://7743873539",
        "monitor": "rbxassetid://7734002839",
        "x": "rbxassetid://7743878857",
        "align-horizonal-distribute-end": "rbxassetid://8997381144",
        "user": "rbxassetid://7743875962",
        "sprout": "rbxassetid://7743872071",
        "move": "rbxassetid://7743870731",
        "gavel": "rbxassetid://7733800044",
        "package-minus": "rbxassetid://8997386266",
        "drumstick": "rbxassetid://8997385789",
        "forward": "rbxassetid://7733799371",
        "sidebar-close": "rbxassetid://7734058092",
        "electricity": "rbxassetid://7733771628",
        "plus": "rbxassetid://7734042071",
        "pipette": "rbxassetid://7743871384",
        "cloud-lightning": "rbxassetid://7733741741",
        "lasso-select": "rbxassetid://7743868832",
        "phone-call": "rbxassetid://7734027264",
        "droplet": "rbxassetid://7733770982",
        "key": "rbxassetid://7733965118",
        "map-pin": "rbxassetid://7733992789",
        "navigation-2": "rbxassetid://7734020942",
        "list-minus": "rbxassetid://7733980795",
        "chevron-up": "rbxassetid://7733919605",
        "layout-template": "rbxassetid://7733970494",
        "no_entry": "rbxassetid://7734021118",
        "scan": "rbxassetid://8997386861",
        "arrow-big-up": "rbxassetid://7733671663",
        "bookmark-minus": "rbxassetid://7733689754",
        "activity": "rbxassetid://7733655755",
        "grid": "rbxassetid://7733955179",
        "user-x": "rbxassetid://7743875879",
        "alert-circle": "rbxassetid://7733658271",
        "menu": "rbxassetid://7733993211",
        "form-input": "rbxassetid://7733799275",
        "rss": "rbxassetid://7734052075",
        "loader": "rbxassetid://7733992358",
        "align-vertical-distribute-end": "rbxassetid://8997382326",
        "strikethrough": "rbxassetid://7734068425",
        "mic": "rbxassetid://7743869805",
        "landmark": "rbxassetid://7733965184",
        "crosshair": "rbxassetid://7733765307",
        "alert-octagon": "rbxassetid://7733658335",
        "anchor": "rbxassetid://7733911490",
        "separator-horizontal": "rbxassetid://7734053146",
        "chevron-left": "rbxassetid://7733717651",
        "flask-conical": "rbxassetid://7733798901",
        "wallet": "rbxassetid://7743877573",
        "euro": "rbxassetid://7733771891",
        "trash-2": "rbxassetid://7743873772",
        "check-circle": "rbxassetid://7733919427",
        "layout": "rbxassetid://7733970543",
        "droplets": "rbxassetid://7733771078",
        "align-start-vertical": "rbxassetid://8997382085",
        "rotate-cw": "rbxassetid://7734051957",
        "minimize": "rbxassetid://7733997941",
        "arrow-down-left": "rbxassetid://7733672282",
        "signal-medium": "rbxassetid://8997387319",
        "align-vertical-distribute-center": "rbxassetid://8997382212",
        "image-off": "rbxassetid://7733963907",
        "cloudy": "rbxassetid://7733747106",
        "align-left": "rbxassetid://7733911357",
        "film": "rbxassetid://7733942579",
        "chevrons-down": "rbxassetid://7733720604",
        "pointer": "rbxassetid://7734042307",
        "folder": "rbxassetid://7733799185",
        "chevrons-left": "rbxassetid://7733720701",
        "shield-off": "rbxassetid://7734056540",
        "wrench": "rbxassetid://7743878358"
      }
    }
]]

local success, L_11_ = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/ttwizz/Documents/master/icons.json", true)
end)

if success then
    local successDecode, decodedData = pcall(function()
        return L_7_:JSONDecode(L_11_)
    end)

    if successDecode and decodedData then
        L_11_ = decodedData.icons
    else
        warn("Failed to decode JSON. Using default or empty icons.")
        L_11_ = {} -- Set to an empty table or default icons if JSON decoding fails
    end
else
    warn("Failed to fetch JSON from the URL. Using default or empty icons.")
    L_11_ = {} -- Set to an empty table or default icons if HTTP request fails
end

-- Rest of your code continues here...
local L_12_ = Instance.new("ScreenGui")
L_12_.Name = "Orion"  -- Name the ScreenGui "Orion"
if getfenv().syn then
    getfenv().syn.protect_gui(L_12_)
    L_12_.Parent = L_8_
else
    xpcall(function()
        L_12_.Parent = getfenv().gethui and getfenv().gethui() or L_8_
    end, function()
        L_12_.DisplayOrder = 9e8
        L_12_.ResetOnSpawn = false
        L_12_.Parent = L_5_:WaitForChild("PlayerGui", math.huge)
    end)
end


local L_13_ = L_12_.Parent

function L_10_:IsRunning()
    return L_12_.Parent == L_13_
end


local function L_14_func(L_34_arg1, L_35_arg2)
    if not L_10_:IsRunning() then
        return
    end
    local L_36_ = L_34_arg1:Connect(L_35_arg2)
    table.insert(L_10_.Connections, L_36_)
    return L_36_
end


task.spawn(function()
    while L_10_:IsRunning() do
        task.wait()
    end
    for _, L_38_forvar2 in next, L_10_.Connections do
        L_38_forvar2.Function = function() end
    end
end)


local function L_15_func(L_39_arg1, L_40_arg2)
    pcall(function()
        local L_41_, L_42_, L_43_, L_44_ = false, nil
        L_14_func(L_39_arg1.InputBegan, function(L_45_arg1)
            if L_45_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_45_arg1.UserInputType == Enum.UserInputType.Touch then
                L_41_ = true
                L_43_ = L_45_arg1.Position
                L_44_ = L_40_arg2.Position
                L_45_arg1.Changed:Connect(function()
                    if L_45_arg1.UserInputState == Enum.UserInputState.End then
                        L_41_ = false
                    end
                end)
            end
        end)
        L_14_func(L_39_arg1.InputChanged, function(L_46_arg1)
            if L_46_arg1.UserInputType == Enum.UserInputType.MouseMovement or L_46_arg1.UserInputType == Enum.UserInputType.Touch then
                L_42_ = L_46_arg1
            end
        end)
        L_14_func(L_2_.InputChanged, function(L_47_arg1)
            if L_47_arg1 == L_42_ and L_41_ then
                local L_48_ = L_47_arg1.Position - L_43_
                L_40_arg2.Position = UDim2.new(L_44_.X.Scale, L_44_.X.Offset + L_48_.X, L_44_.Y.Scale, L_44_.Y.Offset + L_48_.Y)
            end
        end)
    end)
end


local function L_16_func(L_49_arg1, L_50_arg2, L_51_arg3)
    local L_52_ = Instance.new(L_49_arg1)
    for L_53_forvar1, L_54_forvar2 in next, L_50_arg2 or {} do
        L_52_[L_53_forvar1] = L_54_forvar2
    end
    for _, L_56_forvar2 in next, L_51_arg3 or {} do
        L_56_forvar2.Parent = L_52_
    end
    return L_52_
end


local function L_17_func(L_57_arg1, L_58_arg2)
    L_10_.Elements[L_57_arg1] = function(...)
        return L_58_arg2(...)
    end
end


local function L_18_func(L_59_arg1, ...)
    return L_10_.Elements[L_59_arg1](...)
end


local function L_19_func(L_60_arg1, L_61_arg2)
    for L_62_forvar1, L_63_forvar2 in next, L_61_arg2 do
        L_60_arg1[L_62_forvar1] = L_63_forvar2
    end
    return L_60_arg1
end


local function L_20_func(L_64_arg1, L_65_arg2)
    for _, L_67_forvar2 in next, L_65_arg2 do
        L_67_forvar2.Parent = L_64_arg1
    end
    return L_64_arg1
end


local function L_21_func(L_68_arg1, L_69_arg2)
    local L_70_ = math.floor(L_68_arg1 / L_69_arg2 + math.sign(L_68_arg1) * 0.5) * L_69_arg2
    if L_70_ < 0 then
        L_70_ = L_70_ + L_69_arg2
    end
    return L_70_
end


local function L_22_func(L_71_arg1)
    if L_71_arg1:IsA("Frame") or L_71_arg1:IsA("TextButton") then
        return "BackgroundColor3"
    elseif L_71_arg1:IsA("ScrollingFrame") then
        return "ScrollBarImageColor3"
    elseif L_71_arg1:IsA("UIStroke") then
        return "Color"
    elseif L_71_arg1:IsA("TextLabel") or L_71_arg1:IsA("TextBox") then
        return "TextColor3"
    elseif L_71_arg1:IsA("ImageLabel") or L_71_arg1:IsA("ImageButton") then
        return "ImageColor3"
    end
end


local function L_23_func(L_72_arg1, L_73_arg2)
    if not L_10_.ThemeObjects[L_73_arg2] then
        L_10_.ThemeObjects[L_73_arg2] = {}
    end
    table.insert(L_10_.ThemeObjects[L_73_arg2], L_72_arg1)
    L_72_arg1[L_22_func(L_72_arg1)] = L_10_.Themes[L_10_.SelectedTheme][L_73_arg2]
    return L_72_arg1
end


local function L_24_func(L_74_arg1)
    return {
        R = L_74_arg1.R * 255,
        G = L_74_arg1.G * 255,
        B = L_74_arg1.B * 255
    }
end


local function L_25_func(L_75_arg1)
    return Color3.fromRGB(L_75_arg1.R, L_75_arg1.G, L_75_arg1.B)
end


local function L_26_func(L_76_arg1)
    local L_77_ = L_7_:JSONDecode(L_76_arg1)
    for L_78_forvar1, L_79_forvar2 in next, L_77_ do
        if L_10_.Flags[L_78_forvar1] then
            task.spawn(function()
                if L_10_.Flags[L_78_forvar1].Type == "Colorpicker" then
                    L_10_.Flags[L_78_forvar1]:Set(L_25_func(L_79_forvar2))
                else
                    L_10_.Flags[L_78_forvar1]:Set(L_79_forvar2)
                end
            end)
        end
    end
end


local function L_27_func(L_80_arg1)
    local L_81_ = {}
    for L_82_forvar1, L_83_forvar2 in next, L_10_.Flags do
        if L_83_forvar2.Save then
            if L_83_forvar2.Type == "Colorpicker" then
                L_81_[L_82_forvar1] = L_24_func(L_83_forvar2.Value)
            else
                L_81_[L_82_forvar1] = L_83_forvar2.Value
            end
        end
    end
    if getfenv().writefile then
        getfenv().writefile(string.format("%s/%s.txt", L_10_["Folder"], L_80_arg1), L_7_:JSONEncode(L_81_))
    end
end


local L_28_ = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3
}

local L_29_ = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Left,
    Enum.KeyCode.Down,
    Enum.KeyCode.Right,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Tab,
    Enum.KeyCode.Backspace,
    Enum.KeyCode.Escape
}


local function L_30_func(L_84_arg1, L_85_arg2)
    for _, L_87_forvar2 in next, L_84_arg1 do
        if L_87_forvar2 == L_85_arg2 then
            return true
        end
    end
end


L_17_func("Corner", function(L_88_arg1, L_89_arg2)
    local L_90_ = L_16_func("UICorner", {
        CornerRadius = UDim.new(L_88_arg1 or 0, L_89_arg2 or 10)
    })
    return L_90_
end)


L_17_func("Stroke", function(L_91_arg1, L_92_arg2)
    local L_93_ = L_16_func("UIStroke", {
        Color = L_91_arg1 or Color3.fromRGB(255, 255, 255),
        Thickness = L_92_arg2 or 1
    })
    return L_93_
end)


L_17_func("List", function(L_94_arg1, L_95_arg2)
    local L_96_ = L_16_func("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(L_94_arg1 or 0, L_95_arg2 or 0)
    })
    return L_96_
end)


L_17_func("Padding", function(L_97_arg1, L_98_arg2, L_99_arg3, L_100_arg4)
    local L_101_ = L_16_func("UIPadding", {
        PaddingBottom = UDim.new(0, L_97_arg1 or 4),
        PaddingLeft = UDim.new(0, L_98_arg2 or 4),
        PaddingRight = UDim.new(0, L_99_arg3 or 4),
        PaddingTop = UDim.new(0, L_100_arg4 or 4)
    })
    return L_101_
end)


L_17_func("TFrame", function()
    local L_102_ = L_16_func("Frame", {
        BackgroundTransparency = 1
    })
    return L_102_
end)


L_17_func("Frame", function(L_103_arg1)
    local L_104_ = L_16_func("Frame", {
        BackgroundColor3 = L_103_arg1 or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    return L_104_
end)


L_17_func("RoundFrame", function(L_105_arg1, L_106_arg2, L_107_arg3)
    local L_108_ = L_16_func("Frame", {
        BackgroundColor3 = L_105_arg1 or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    }, {
        L_16_func("UICorner", {
            CornerRadius = UDim.new(L_106_arg2, L_107_arg3)
        })
    })
    return L_108_
end)


L_17_func("Button", function()
    local L_109_ = L_16_func("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    return L_109_
end)


L_17_func("ScrollFrame", function(L_110_arg1, L_111_arg2)
    local L_112_ = L_16_func("ScrollingFrame", {
        BackgroundTransparency = 1,
        MidImage = "rbxassetid://7445543667",
        BottomImage = "rbxassetid://7445543667",
        TopImage = "rbxassetid://7445543667",
        ScrollBarImageColor3 = L_110_arg1,
        BorderSizePixel = 0,
        ScrollBarThickness = L_111_arg2,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    return L_112_
end)


L_17_func("Image", function(L_113_arg1)
    local L_114_ = L_16_func("ImageLabel", {
        Image = L_113_arg1,
        BackgroundTransparency = 1
    })
    if L_11_[L_113_arg1] then
        L_114_.Image = L_11_[L_113_arg1]
    end
    return L_114_
end)


L_17_func("ImageButton", function(L_115_arg1)
    local L_116_ = L_16_func("ImageButton", {
        Image = L_115_arg1,
        BackgroundTransparency = 1
    })
    return L_116_
end)


L_17_func("Label", function(L_117_arg1, L_118_arg2, L_119_arg3)
    local L_120_ = L_16_func("TextLabel", {
        Text = L_117_arg1 or "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextTransparency = L_119_arg3 or 0,
        TextSize = L_118_arg2 or 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return L_120_
end)


local L_31_ = L_19_func(L_20_func(L_18_func("TFrame"), {
    L_19_func(L_18_func("List"), {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 5)
    })
}), {
    Position = UDim2.new(1, -25, 1, -25),
    Size = UDim2.new(0, 300, 1, -25),
    AnchorPoint = Vector2.new(1, 1),
    Parent = L_12_
})


function L_10_:MakeNotification(L_121_arg1)
    task.spawn(function()
        L_121_arg1.Name = L_121_arg1.Name or "Notification"
        L_121_arg1.Content = L_121_arg1.Content or "Test"
        L_121_arg1.Image = L_121_arg1.Image or "rbxassetid://4384403532"
        L_121_arg1.Time = L_121_arg1.Time or 15
        local L_122_ = L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = L_31_
        })
        local L_123_ = L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 10), {
            Parent = L_122_,
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(1, -55, 0, 0),
            BackgroundTransparency = 0,
            AutomaticSize = Enum.AutomaticSize.Y
        }), {
            L_18_func("Stroke", Color3.fromRGB(93, 93, 93), 1.2),
            L_18_func("Padding", 12, 12, 12, 12),
            L_19_func(L_18_func("Image", L_121_arg1.Image), {
                Size = UDim2.new(0, 20, 0, 20),
                ImageColor3 = Color3.fromRGB(240, 240, 240),
                Name = "Icon"
            }),
            L_19_func(L_18_func("Label", L_121_arg1.Name, 15), {
                Size = UDim2.new(1, -30, 0, 20),
                Position = UDim2.new(0, 30, 0, 0),
                Font = Enum.Font.GothamBold,
                Name = "Title"
            }),
            L_19_func(L_18_func("Label", L_121_arg1.Content, 14), {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                Font = Enum.Font.GothamMedium,
                Name = "Content",
                AutomaticSize = Enum.AutomaticSize.Y,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextWrapped = true
            })
        })
        L_3_:Create(L_123_, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(L_121_arg1.Time - 0.88)
        L_3_:Create(L_123_.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            ImageTransparency = 1
        }):Play()
        L_3_:Create(L_123_, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 0.6
        }):Play()
        task.wait(0.3)
        L_3_:Create(L_123_.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            Transparency = 0.9
        }):Play()
        L_3_:Create(L_123_.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            TextTransparency = 0.4
        }):Play()
        L_3_:Create(L_123_.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            TextTransparency = 0.5
        }):Play()
        task.wait(0.05)
        L_123_:TweenPosition(UDim2.new(1, 20, 0, 0), "In", "Quint", 0.8, true)
        L_9_:AddItem(L_123_, 1.35)
    end)
end


function L_10_:Init()
    pcall(function()
        if L_10_.SaveCfg and getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s/%s.txt", L_10_["Folder"], game.PlaceId)) then
            L_26_func(getfenv().readfile(string.format("%s/%s.txt", L_10_["Folder"], game.PlaceId)))
            L_10_:MakeNotification({
                Name = "Configuration",
                Content = string.format("Auto-loaded configuration for the place %s.", game.PlaceId),
                Time = 5
            })
        end
    end)
end


function L_10_:MakeWindow(L_124_arg1)
    local L_125_ = false
    local L_126_ = false
    local L_127_ = false
    L_124_arg1 = L_124_arg1 or {}
    L_124_arg1.Name = L_124_arg1.Name or "Orion Library"
    L_124_arg1.ConfigFolder = L_124_arg1.ConfigFolder or L_124_arg1.Name
    L_124_arg1.SaveConfig = L_124_arg1.SaveConfig or false
    L_124_arg1.TestMode = L_124_arg1.TestMode or false
    if L_124_arg1.IntroEnabled == nil then
        L_124_arg1.IntroEnabled = true
    end
    L_124_arg1.IntroText = L_124_arg1.IntroText or "Orion Library"
    L_124_arg1.CloseCallback = L_124_arg1.CloseCallback or function() end
    L_124_arg1.ShowIcon = L_124_arg1.ShowIcon or false
    L_124_arg1.Icon = L_124_arg1.Icon or "rbxassetid://8834748103"
    L_124_arg1.IntroIcon = L_124_arg1.IntroIcon or "rbxassetid://8834748103"
    L_10_.Folder = L_124_arg1.ConfigFolder
    L_10_.SaveCfg = L_124_arg1.SaveConfig
    if L_124_arg1.SaveConfig and getfenv().isfolder and getfenv().makefolder and not getfenv().isfolder(L_124_arg1.ConfigFolder) then
        getfenv().makefolder(L_124_arg1.ConfigFolder)
    end
    local L_128_ = L_23_func(L_20_func(L_19_func(L_18_func("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
        Size = UDim2.new(1, 0, 1, -50)
    }), {
        L_18_func("List"),
        L_18_func("Padding", 8, 0, 0, 8)
    }), "Divider")
    L_14_func(L_128_.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        L_128_.CanvasSize = UDim2.new(0, 0, 0, L_128_.UIListLayout.AbsoluteContentSize.Y + 16)
    end)
    local L_129_ = L_20_func(L_19_func(L_18_func("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        L_23_func(L_19_func(L_18_func("Image", "rbxassetid://7072725342"), {
            Position = UDim2.new(0, 9, 0, 6),
            Size = UDim2.new(0, 18, 0, 18)
        }), "Text")
    })
    local L_130_ = L_20_func(L_19_func(L_18_func("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1
    }), {
        L_23_func(L_19_func(L_18_func("Image", "rbxassetid://7072719338"), {
            Position = UDim2.new(0, 9, 0, 6),
            Size = UDim2.new(0, 18, 0, 18),
            Name = "Ico"
        }), "Text")
    })
    local L_131_ = L_19_func(L_18_func("TFrame"), {
        Size = UDim2.new(1, 0, 0, 50)
    })
    local L_132_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
        Size = UDim2.new(0, 150, 1, -50),
        Position = UDim2.new(0, 0, 0, 50)
    }), {
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(1, 0, 0, 10),
            Position = UDim2.new(0, 0, 0, 0)
        }), "Second"),
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(0, 10, 1, 0),
            Position = UDim2.new(1, -10, 0, 0)
        }), "Second"),
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(0, 1, 1, 0),
            Position = UDim2.new(1, -1, 0, 0)
        }), "Stroke"),
        L_128_,
        L_20_func(L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 50),
            Position = UDim2.new(0, 0, 1, -50)
        }), {
            L_23_func(L_19_func(L_18_func("Frame"), {
                Size = UDim2.new(1, 0, 0, 1)
            }), "Stroke"),
            L_23_func(L_20_func(L_19_func(L_18_func("Frame"), {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 32, 0, 32),
                Position = UDim2.new(0, 10, 0.5, 0)
            }), {
                L_19_func(L_18_func("Image", string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png", L_5_.UserId)), {
                    Size = UDim2.new(1, 0, 1, 0)
                }),
                L_23_func(L_19_func(L_18_func("Image", "rbxassetid://4031889928"), {
                    Size = UDim2.new(1, 0, 1, 0)
                }), "Second"),
                L_18_func("Corner", 1)
            }), "Divider"),
            L_20_func(L_19_func(L_18_func("TFrame"), {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 32, 0, 32),
                Position = UDim2.new(0, 10, 0.5, 0)
            }), {
                L_23_func(L_18_func("Stroke"), "Stroke"),
                L_18_func("Corner", 1)
            }),
            L_23_func(L_19_func(L_18_func("Label", L_5_.DisplayName, L_124_arg1.TestMode and 13 or 14), {
                Size = UDim2.new(1, -60, 0, 13),
                Position = L_124_arg1.TestMode and UDim2.new(0, 50, 0, 12) or UDim2.new(0, 50, 0, 19),
                Font = Enum.Font.GothamBold,
                ClipsDescendants = true
            }), "Text"),
            L_23_func(L_19_func(L_18_func("Label", "Tester", 12), {
                Size = UDim2.new(1, -60, 0, 12),
                Position = UDim2.new(0, 50, 1, -25),
                Visible = L_124_arg1.TestMode
            }), "TextDark")
        })
    }), "Second")
    local L_133_ = L_23_func(L_19_func(L_18_func("Label", L_124_arg1.Name, 14), {
        Size = UDim2.new(1, -30, 2, 0),
        Position = UDim2.new(0, 25, 0, -24),
        Font = Enum.Font.GothamBlack,
        TextSize = 20
    }), "Text")
    local L_134_ = L_23_func(L_19_func(L_18_func("Frame"), {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1)
    }), "Stroke")
    local L_135_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
        Parent = L_12_,
        Position = UDim2.new(0.5, -307, 0.5, -172),
        Size = UDim2.new(0, 615, 0, 344),
        ClipsDescendants = true
    }), {
        L_20_func(L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 50),
            Name = "TopBar"
        }), {
            L_133_,
            L_134_,
            L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
                Size = UDim2.new(0, 70, 0, 30),
                Position = UDim2.new(1, -90, 0, 10)
            }), {
                L_23_func(L_18_func("Stroke"), "Stroke"),
                L_23_func(L_19_func(L_18_func("Frame"), {
                    Size = UDim2.new(0, 1, 1, 0),
                    Position = UDim2.new(0.5, 0, 0, 0)
                }), "Stroke"),
                L_129_,
                L_130_
            }), "Second")
        }),
        L_131_,
        L_132_
    }), "Main")
    if L_124_arg1.ShowIcon then
        L_133_.Position = UDim2.new(0, 50, 0, -24)
        local L_138_ = L_19_func(L_18_func("Image", L_124_arg1.Icon), {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 25, 0, 15)
        })
        L_138_.Parent = L_135_.TopBar
    end
    L_15_func(L_131_, L_135_)
    L_14_func(L_129_.MouseButton1Up, function()
        L_135_.Visible = false
        L_127_ = true
        L_10_:MakeNotification({
            Name = "Interface Hidden",
            Content = "Tap RightShift to reopen the interface",
            Time = 5
        })
        L_124_arg1.CloseCallback()
    end)
    L_14_func(L_2_.InputBegan, function(L_139_arg1)
        if L_139_arg1.KeyCode == Enum.KeyCode.RightShift and L_127_ then
            L_135_.Visible = true
        end
    end)
    L_14_func(L_130_.MouseButton1Up, function()
        if L_126_ then
            L_3_:Create(L_135_, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 615, 0, 344)
            }):Play()
            L_130_.Ico.Image = "rbxassetid://7072719338"
            task.wait(0.02)
            L_135_.ClipsDescendants = false
            L_132_.Visible = true
            L_134_.Visible = true
        else
            L_135_.ClipsDescendants = true
            L_134_.Visible = false
            L_130_.Ico.Image = "rbxassetid://7072720870"
            L_3_:Create(L_135_, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, L_133_.TextBounds.X + 140, 0, 50)
            }):Play()
            task.wait(0.1)
            L_132_.Visible = false
        end
        L_126_ = not L_126_
    end)
    local function L_136_func()
        L_135_.Visible = false
        local L_140_ = L_19_func(L_18_func("Image", L_124_arg1.IntroIcon), {
            Parent = L_12_,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.4, 0),
            Size = UDim2.new(0, 28, 0, 28),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 1
        })
        local L_141_ = L_19_func(L_18_func("Label", L_124_arg1.IntroText, 14), {
            Parent = L_12_,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 19, 0.5, 0),
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.GothamBold,
            TextTransparency = 1
        })
        L_3_:Create(L_140_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.8)
        L_3_:Create(L_140_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -(L_141_.TextBounds.X / 2), 0.5, 0)
        }):Play()
        task.wait(0.3)
        L_3_:Create(L_141_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        task.wait(2)
        L_3_:Create(L_141_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play()
        L_135_.Visible = true
        L_9_:AddItem(L_140_, 0)
        L_9_:AddItem(L_141_, 0)
    end
    if L_124_arg1.IntroEnabled then
        L_136_func()
    end
    local L_137_ = {}
    function L_137_:MakeTab(L_142_arg1)
        L_142_arg1 = L_142_arg1 or {}
        L_142_arg1.Name = L_142_arg1.Name or "Tab"
        L_142_arg1.Icon = L_142_arg1.Icon or ""
        L_142_arg1.TestersOnly = L_142_arg1.TestersOnly or false
        local L_143_ = L_20_func(L_19_func(L_18_func("Button"), {
            Size = UDim2.new(1, 0, 0, 30),
            Parent = L_128_,
            Visible = L_124_arg1.TestMode and L_142_arg1.TestersOnly or not L_142_arg1.TestersOnly
        }), {
            L_23_func(L_19_func(L_18_func("Image", L_142_arg1.Icon), {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 10, 0.5, 0),
                ImageTransparency = 0.4,
                Name = "Ico"
            }), "Text"),
            L_23_func(L_19_func(L_18_func("Label", L_142_arg1.Name, 14), {
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 35, 0, 0),
                Font = Enum.Font.GothamMedium,
                TextTransparency = 0.4,
                Name = "Title"
            }), "Text")
        })
        if L_11_[L_142_arg1.Icon] then
            L_143_.Ico.Image = L_11_[L_142_arg1.Icon]
        end
        local L_144_ = L_23_func(L_20_func(L_19_func(L_18_func("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
            Size = UDim2.new(1, -150, 1, -50),
            Position = UDim2.new(0, 150, 0, 50),
            Parent = L_135_,
            Visible = false,
            Name = "ItemContainer"
        }), {
            L_18_func("List", 0, 6),
            L_18_func("Padding", 15, 10, 10, 15)
        }), "Divider")
        L_14_func(L_144_.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            L_144_.CanvasSize = UDim2.new(0, 0, 0, L_144_.UIListLayout.AbsoluteContentSize.Y + 30)
        end)
        if not L_125_ then
            L_125_ = L_143_.Visible
            if L_125_ then
                L_143_.Ico.ImageTransparency = 0
                L_143_.Title.TextTransparency = 0
                L_143_.Title.Font = Enum.Font.GothamBlack
                L_144_.Visible = true
            end
        end
        L_14_func(L_143_.MouseButton1Down, function()
            for _, L_149_forvar2 in next, L_128_:GetChildren() do
                if L_149_forvar2:IsA("TextButton") then
                    L_149_forvar2.Title.Font = Enum.Font.GothamMedium
                    L_3_:Create(L_149_forvar2.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ImageTransparency = 0.4
                    }):Play()
                    L_3_:Create(L_149_forvar2.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        TextTransparency = 0.4
                    }):Play()
                end
            end
            for _, L_151_forvar2 in next, L_135_:GetChildren() do
                if L_151_forvar2.Name == "ItemContainer" then
                    L_151_forvar2.Visible = false
                end
            end
            L_3_:Create(L_143_.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play()
            L_3_:Create(L_143_.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play()
            L_143_.Title.Font = Enum.Font.GothamBlack
            L_144_.Visible = true
        end)
        local function L_145_func(L_152_arg1)
            local L_153_ = {}
            function L_153_:AddLabel(L_155_arg1)
                local L_156_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 0.7,
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_155_arg1, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                local L_157_ = {}
                function L_157_:Set(L_158_arg1)
                    L_156_.Content.Text = L_158_arg1
                end
                return L_157_
            end
            function L_153_:AddParagraph(L_159_arg1, L_160_arg2)
                L_159_arg1 = L_159_arg1 or "Text"
                L_160_arg2 = L_160_arg2 or "Content"
                local L_161_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 0.7,
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_159_arg1, 15), {
                        Size = UDim2.new(1, -12, 0, 14),
                        Position = UDim2.new(0, 12, 0, 10),
                        Font = Enum.Font.GothamBold,
                        Name = "Title"
                    }), "Text"),
                    L_23_func(L_19_func(L_18_func("Label", "", 13), {
                        Size = UDim2.new(1, -24, 0, 0),
                        Position = UDim2.new(0, 12, 0, 26),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content",
                        TextWrapped = true
                    }), "TextDark"),
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                L_14_func(L_161_.Content:GetPropertyChangedSignal("Text"), function()
                    L_161_.Content.Size = UDim2.new(1, -24, 0, L_161_.Content.TextBounds.Y)
                    L_161_.Size = UDim2.new(1, 0, 0, L_161_.Content.TextBounds.Y + 35)
                end)
                L_161_.Content.Text = L_160_arg2
                local L_162_ = {}
                function L_162_:Set(L_163_arg1)
                    L_161_.Content.Text = L_163_arg1
                end
                return L_162_
            end
            function L_153_:AddButton(L_164_arg1)
                L_164_arg1 = L_164_arg1 or {}
                L_164_arg1.Name = L_164_arg1.Name or "Button"
                L_164_arg1.Callback = L_164_arg1.Callback or function() end
                L_164_arg1.Icon = L_164_arg1.Icon or "rbxassetid://3944703587"
                local L_165_ = {}
                local L_166_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_167_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 33),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_164_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_19_func(L_18_func("Image", L_164_arg1.Icon), {
                        Size = UDim2.new(0, 20, 0, 20),
                        Position = UDim2.new(1, -30, 0, 7)
                    }), "TextDark"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_166_
                }), "Second")
                L_14_func(L_166_.MouseEnter, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_166_.MouseLeave, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_166_.MouseButton1Up, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    task.spawn(L_164_arg1.Callback)
                end)
                L_14_func(L_166_.MouseButton1Down, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                function L_165_:Set(L_168_arg1)
                    L_167_.Content.Text = L_168_arg1
                end
                return L_165_
            end
            function L_153_:AddToggle(L_169_arg1)
                L_169_arg1 = L_169_arg1 or {}
                L_169_arg1.Name = L_169_arg1.Name or "Toggle"
                L_169_arg1.Default = L_169_arg1.Default or false
                L_169_arg1.Callback = L_169_arg1.Callback or function() end
                L_169_arg1.Color = L_169_arg1.Color or Color3.fromRGB(9, 99, 195)
                L_169_arg1.Flag = L_169_arg1.Flag or nil
                L_169_arg1.Save = L_169_arg1.Save or false
                local L_170_ = {
                    Value = L_169_arg1.Default,
                    Save = L_169_arg1.Save
                }
                local L_171_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_172_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_169_arg1.Color, 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -24, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }), {
                    L_19_func(L_18_func("Stroke"), {
                        Color = L_169_arg1.Color,
                        Name = "Stroke",
                        Transparency = 0.5
                    }),
                    L_19_func(L_18_func("Image", "rbxassetid://3944680095"), {
                        Size = UDim2.new(0, 20, 0, 20),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                        Name = "Ico"
                    })
                })
                local L_173_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_169_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_172_,
                    L_171_
                }), "Second")
                function L_170_:Set(L_174_arg1)
                    L_170_.Value = L_174_arg1
                    L_3_:Create(L_172_, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_170_.Value and L_169_arg1.Color or L_10_.Themes.Default.Divider
                    }):Play()
                    L_3_:Create(L_172_.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Color = L_170_.Value and L_169_arg1.Color or L_10_.Themes.Default.Stroke
                    }):Play()
                    L_3_:Create(L_172_.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ImageTransparency = L_170_.Value and 0 or 1,
                        Size = L_170_.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)
                    }):Play()
                    L_169_arg1.Callback(L_170_.Value)
                end
                L_170_:Set(L_170_.Value)
                L_14_func(L_171_.MouseEnter, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_171_.MouseLeave, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_171_.MouseButton1Up, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    L_27_func(game.PlaceId)
                    L_170_:Set(not L_170_.Value)
                end)
                L_14_func(L_171_.MouseButton1Down, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                if L_169_arg1.Flag then
                    L_10_.Flags[L_169_arg1.Flag] = L_170_
                end
                return L_170_
            end
            function L_153_:AddSlider(L_175_arg1)
                L_175_arg1 = L_175_arg1 or {}
                L_175_arg1.Name = L_175_arg1.Name or "Slider"
                L_175_arg1.Min = L_175_arg1.Min or 0
                L_175_arg1.Max = L_175_arg1.Max or 100
                L_175_arg1.Increment = L_175_arg1.Increment or 1
                L_175_arg1.Default = L_175_arg1.Default or 50
                L_175_arg1.Callback = L_175_arg1.Callback or function() end
                L_175_arg1.ValueName = L_175_arg1.ValueName or ""
                L_175_arg1.Color = L_175_arg1.Color or Color3.fromRGB(9, 149, 98)
                L_175_arg1.Flag = L_175_arg1.Flag or nil
                L_175_arg1.Save = L_175_arg1.Save or false
                local L_176_ = {
                    Value = L_175_arg1.Default,
                    Save = L_175_arg1.Save
                }
                local L_177_ = false
                local L_178_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_175_arg1.Color, 0, 5), {
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundTransparency = 0.3,
                    ClipsDescendants = true
                }), {
                    L_23_func(L_19_func(L_18_func("Label", "value", 13), {
                        Size = UDim2.new(1, -12, 0, 14),
                        Position = UDim2.new(0, 12, 0, 6),
                        Font = Enum.Font.GothamBold,
                        Name = "Value",
                        TextTransparency = 0
                    }), "Text")
                })
                local L_179_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_175_arg1.Color, 0, 5), {
                    Size = UDim2.new(1, -24, 0, 26),
                    Position = UDim2.new(0, 12, 0, 30),
                    BackgroundTransparency = 0.9
                }), {
                    L_19_func(L_18_func("Stroke"), {
                        Color = L_175_arg1.Color
                    }),
                    L_23_func(L_19_func(L_18_func("Label", "value", 13), {
                        Size = UDim2.new(1, -12, 0, 14),
                        Position = UDim2.new(0, 12, 0, 6),
                        Font = Enum.Font.GothamBold,
                        Name = "Value",
                        TextTransparency = 0.8
                    }), "Text"),
                    L_178_
                })
                L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(1, 0, 0, 65),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_175_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 0, 14),
                        Position = UDim2.new(0, 12, 0, 10),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_179_
                }), "Second")
                L_179_.InputBegan:Connect(function(L_180_arg1)
                    if L_180_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_180_arg1.UserInputType == Enum.UserInputType.Touch then
                        L_177_ = true
                    end
                end)
                L_179_.InputEnded:Connect(function(L_181_arg1)
                    if L_181_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_181_arg1.UserInputType == Enum.UserInputType.Touch then
                        L_177_ = false
                    end
                end)
                function L_176_:Set(L_182_arg1)
                    L_182_arg1 = math.clamp(L_21_func(L_182_arg1, L_175_arg1.Increment), L_175_arg1.Min, L_175_arg1.Max)
                    L_3_:Create(L_178_, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale((L_182_arg1 - L_175_arg1.Min) / (L_175_arg1.Max - L_175_arg1.Min), 1)
                    }):Play()
                    L_179_.Value.Text = string.format("%s %s", L_182_arg1, L_175_arg1.ValueName)
                    L_178_.Value.Text = string.format("%s %s", L_182_arg1, L_175_arg1.ValueName)
                    L_175_arg1.Callback(L_182_arg1)
                end
                L_2_.InputChanged:Connect(function(L_183_arg1)
                    if L_177_ and (L_183_arg1.UserInputType == Enum.UserInputType.MouseMovement or L_183_arg1.UserInputType == Enum.UserInputType.Touch) then
                        local L_184_ = math.clamp((L_183_arg1.Position.X - L_179_.AbsolutePosition.X) / L_179_.AbsoluteSize.X, 0, 1)
                        L_176_:Set(L_175_arg1.Min + (L_175_arg1.Max - L_175_arg1.Min) * L_184_)
                        L_27_func(game.PlaceId)
                    end
                end)
                L_176_:Set(L_176_.Value)
                if L_175_arg1.Flag then
                    L_10_.Flags[L_175_arg1.Flag] = L_176_
                end
                return L_176_
            end
            function L_153_:AddDropdown(L_185_arg1)
                L_185_arg1 = L_185_arg1 or {}
                L_185_arg1.Name = L_185_arg1.Name or "Dropdown"
                L_185_arg1.Options = L_185_arg1.Options or {}
                L_185_arg1.Default = L_185_arg1.Default or ""
                L_185_arg1.Callback = L_185_arg1.Callback or function() end
                L_185_arg1.Flag = L_185_arg1.Flag or nil
                L_185_arg1.Save = L_185_arg1.Save or false
                local L_186_ = {
                    Value = L_185_arg1.Default,
                    Options = L_185_arg1.Options,
                    Buttons = {},
                    Toggled = false,
                    Type = "Dropdown",
                    Save = L_185_arg1.Save
                }
                local L_187_ = 5
                if not table.find(L_186_.Options, L_186_.Value) then
                    L_186_.Value = "..."
                end
                local L_188_ = L_18_func("List")
                local L_189_ = L_23_func(L_19_func(L_20_func(L_18_func("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
                    L_188_
                }), {
                    Parent = L_152_arg1,
                    Position = UDim2.new(0, 0, 0, 38),
                    Size = UDim2.new(1, 0, 1, -38),
                    ClipsDescendants = true
                }), "Divider")
                local L_190_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_191_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1,
                    ClipsDescendants = true
                }), {
                    L_189_,
                    L_19_func(L_20_func(L_18_func("TFrame"), {
                        L_23_func(L_19_func(L_18_func("Label", L_185_arg1.Name, 15), {
                            Size = UDim2.new(1, -12, 1, 0),
                            Position = UDim2.new(0, 12, 0, 0),
                            Font = Enum.Font.GothamBold,
                            Name = "Content"
                        }), "Text"),
                        L_23_func(L_19_func(L_18_func("Image", "rbxassetid://7072706796"), {
                            Size = UDim2.new(0, 20, 0, 20),
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(1, -30, 0.5, 0),
                            ImageColor3 = Color3.fromRGB(240, 240, 240),
                            Name = "Ico"
                        }), "TextDark"),
                        L_23_func(L_19_func(L_18_func("Label", "Selected", 13), {
                            Size = UDim2.new(1, -40, 1, 0),
                            Font = Enum.Font.Gotham,
                            Name = "Selected",
                            TextXAlignment = Enum.TextXAlignment.Right
                        }), "TextDark"),
                        L_23_func(L_19_func(L_18_func("Frame"), {
                            Size = UDim2.new(1, 0, 0, 1),
                            Position = UDim2.new(0, 0, 1, -1),
                            Name = "Line",
                            Visible = false
                        }), "Stroke"),
                        L_190_
                    }), {
                        Size = UDim2.new(1, 0, 0, 38),
                        ClipsDescendants = true,
                        Name = "F"
                    }),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_18_func("Corner")
                }), "Second")
                L_14_func(L_188_:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                    L_189_.CanvasSize = UDim2.new(0, 0, 0, L_188_.AbsoluteContentSize.Y)
                end)
                local function L_192_func(L_193_arg1)
                    for _, L_195_forvar2 in next, L_193_arg1 do
                        local L_196_ = L_23_func(L_19_func(L_20_func(L_18_func("Button", Color3.fromRGB(40, 40, 40)), {
                            L_18_func("Corner", 0, 6),
                            L_23_func(L_19_func(L_18_func("Label", L_195_forvar2, 13, 0.4), {
                                Position = UDim2.new(0, 8, 0, 0),
                                Size = UDim2.new(1, -8, 1, 0),
                                Name = "Title"
                            }), "Text")
                        }), {
                            Parent = L_189_,
                            Size = UDim2.new(1, 0, 0, 28),
                            BackgroundTransparency = 1,
                            ClipsDescendants = true
                        }), "Divider")
                        L_14_func(L_196_.MouseButton1Down, function()
                            L_186_:Set(L_195_forvar2)
                            L_27_func(game.PlaceId)
                        end)
                        L_186_.Buttons[L_195_forvar2] = L_196_
                    end
                end
                function L_186_:Refresh(L_197_arg1, L_198_arg2)
                    if L_198_arg2 then
                        for _, L_200_forvar2 in next, L_186_.Buttons do
                            L_9_:AddItem(L_200_forvar2, 0)
                        end
                        table.clear(L_186_.Options)
                        table.clear(L_186_.Buttons)
                    end
                    L_186_.Options = L_197_arg1
                    L_192_func(L_186_.Options)
                end
                function L_186_:Set(L_201_arg1)
                    if not table.find(L_186_.Options, L_201_arg1) then
                        L_186_.Value = "..."
                        L_191_.F.Selected.Text = L_186_.Value
                        for _, L_203_forvar2 in next, L_186_.Buttons do
                            L_3_:Create(L_203_forvar2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 1
                            }):Play()
                            L_3_:Create(L_203_forvar2.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                TextTransparency = 0.4
                            }):Play()
                        end
                        return
                    end
                    L_186_.Value = L_201_arg1
                    L_191_.F.Selected.Text = L_186_.Value
                    for _, L_205_forvar2 in next, L_186_.Buttons do
                        L_3_:Create(L_205_forvar2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play()
                        L_3_:Create(L_205_forvar2.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            TextTransparency = 0.4
                        }):Play()
                    end
                    L_3_:Create(L_186_.Buttons[L_201_arg1], TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0
                    }):Play()
                    L_3_:Create(L_186_.Buttons[L_201_arg1].Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    }):Play()
                    return L_185_arg1.Callback(L_186_.Value)
                end
                L_14_func(L_190_.MouseButton1Down, function()
                    L_186_.Toggled = not L_186_.Toggled
                    L_191_.F.Line.Visible = L_186_.Toggled
                    L_3_:Create(L_191_.F.Ico, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Rotation = L_186_.Toggled and 180 or 0
                    }):Play()
                    if #L_186_.Options > L_187_ then
                        L_3_:Create(L_191_, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = L_186_.Toggled and UDim2.new(1, 0, 0, 38 + L_187_ * 28) or UDim2.new(1, 0, 0, 38)
                        }):Play()
                    else
                        L_3_:Create(L_191_, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = L_186_.Toggled and UDim2.new(1, 0, 0, L_188_.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)
                        }):Play()
                    end
                end)
                L_186_:Refresh(L_186_.Options, false)
                L_186_:Set(L_186_.Value)
                if L_185_arg1.Flag then
                    L_10_.Flags[L_185_arg1.Flag] = L_186_
                end
                return L_186_
            end
            local L_154_ = nil
            function L_153_:AddBind(L_206_arg1)
                L_206_arg1.Name = L_206_arg1.Name or "Bind"
                L_206_arg1.Default = L_206_arg1.Default or Enum.KeyCode.Unknown
                L_206_arg1.Hold = L_206_arg1.Hold or false
                L_206_arg1.Callback = L_206_arg1.Callback or function() end
                L_206_arg1.Flag = L_206_arg1.Flag or nil
                L_206_arg1.Save = L_206_arg1.Save or false
                local L_207_ = {
                    L_154_,
                    Binding = false,
                    Type = "Bind",
                    Save = L_206_arg1.Save
                }
                local L_208_ = false
                local L_209_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_210_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_23_func(L_19_func(L_18_func("Label", L_206_arg1.Name, 14), {
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Name = "Value"
                    }), "Text")
                }), "Main")
                local L_211_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_206_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_210_,
                    L_209_
                }), "Second")
                L_14_func(L_210_.Value:GetPropertyChangedSignal("Text"), function()
                    L_3_:Create(L_210_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, L_210_.Value.TextBounds.X + 16, 0, 24)
                    }):Play()
                end)
                L_14_func(L_209_.InputEnded, function(L_212_arg1)
                    if (L_212_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_212_arg1.UserInputType == Enum.UserInputType.Touch) and not L_207_.Binding then
                        L_207_.Binding = true
                        L_210_.Value.Text = ""
                    end
                end)
                function L_207_:Set(L_213_arg1)
                    L_207_.Binding = false
                    L_207_.Value = L_213_arg1 or L_207_.Value
                    L_207_.Value = L_207_.Value.Name or L_207_.Value
                    L_210_.Value.Text = L_207_.Value
                end
                L_14_func(L_2_.InputBegan, function(L_214_arg1)
                    if L_2_:GetFocusedTextBox() then
                        return
                    end
                    if (L_214_arg1.KeyCode.Name == L_207_.Value or L_214_arg1.UserInputType.Name == L_207_.Value) and not L_207_.Binding then
                        if L_206_arg1.Hold then
                            L_208_ = true
                            L_206_arg1.Callback(L_208_)
                        else
                            L_206_arg1.Callback()
                        end
                    elseif L_207_.Binding then
                        local L_215_
                        pcall(function()
                            if not L_30_func(L_29_, L_214_arg1.KeyCode) then
                                L_215_ = L_214_arg1.KeyCode
                            end
                        end)
                        pcall(function()
                            if L_30_func(L_28_, L_214_arg1.UserInputType) and not L_215_ then
                                L_215_ = L_214_arg1.UserInputType
                            end
                        end)
                        L_215_ = L_215_ or L_207_.Value
                        L_207_:Set(L_215_)
                        L_27_func(game.PlaceId)
                    end
                end)
                L_14_func(L_2_.InputEnded, function(L_216_arg1)
                    if (L_216_arg1.KeyCode.Name == L_207_.Value or L_216_arg1.UserInputType.Name == L_207_.Value) and L_206_arg1.Hold and L_208_ then
                        L_208_ = false
                        L_206_arg1.Callback(L_208_)
                    end
                end)
                L_14_func(L_209_.MouseEnter, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_209_.MouseLeave, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_209_.MouseButton1Up, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_209_.MouseButton1Down, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                L_207_:Set(L_206_arg1.Default)
                if L_206_arg1.Flag then
                    L_10_.Flags[L_206_arg1.Flag] = L_207_
                end
                return L_207_
            end
            function L_153_:AddTextbox(L_217_arg1)
                L_217_arg1 = L_217_arg1 or {}
                L_217_arg1.Name = L_217_arg1.Name or "Textbox"
                L_217_arg1.Default = L_217_arg1.Default or ""
                L_217_arg1.TextDisappear = L_217_arg1.TextDisappear or false
                L_217_arg1.Callback = L_217_arg1.Callback or function() end
                local L_218_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_219_ = L_23_func(L_16_func("TextBox", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    PlaceholderColor3 = Color3.fromRGB(210, 210, 210),
                    PlaceholderText = "Input",
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextSize = 14,
                    ClearTextOnFocus = false
                }), "Text")
                local L_220_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_219_
                }), "Main")
                local L_221_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_217_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_220_,
                    L_218_
                }), "Second")
                L_14_func(L_219_:GetPropertyChangedSignal("Text"), function()
                    L_3_:Create(L_220_, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, L_219_.TextBounds.X + 16, 0, 24)
                    }):Play()
                end)
                L_14_func(L_219_.FocusLost, function()
                    L_217_arg1.Callback(L_219_.Text)
                    if L_217_arg1.TextDisappear then
                        L_219_.Text = ""
                    end
                end)
                L_219_.Text = L_217_arg1.Default
                L_14_func(L_218_.MouseEnter, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_218_.MouseLeave, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_218_.MouseButton1Up, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    L_219_:CaptureFocus()
                end)
                L_14_func(L_218_.MouseButton1Down, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
            end
            function L_153_:AddColorpicker(L_222_arg1)
                L_222_arg1 = L_222_arg1 or {}
                L_222_arg1.Name = L_222_arg1.Name or "Colorpicker"
                L_222_arg1.Default = L_222_arg1.Default or Color3.fromRGB(255, 255, 255)
                L_222_arg1.Callback = L_222_arg1.Callback or function() end
                L_222_arg1.Flag = L_222_arg1.Flag or nil
                L_222_arg1.Save = L_222_arg1.Save or false
                local L_223_, L_224_, L_225_ = 1, 1, 1
                local L_226_ = {
                    Value = L_222_arg1.Default,
                    Toggled = false,
                    Type = "Colorpicker",
                    Save = L_222_arg1.Save
                }
                local L_227_ = L_16_func("ImageLabel", {
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(select(3, L_226_.Value:ToHSV())),
                    ScaleType = Enum.ScaleType.Fit,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://4805639000"
                })
                local L_228_ = L_16_func("ImageLabel", {
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(0.5, 0, 1 - select(1, L_226_.Value:ToHSV())),
                    ScaleType = Enum.ScaleType.Fit,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://4805639000"
                })
                local L_229_ = L_16_func("ImageLabel", {
                    Size = UDim2.new(1, -25, 1, 0),
                    Visible = false,
                    Image = "rbxassetid://4155801252"
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(0, 5)
                    }),
                    L_227_
                })
                local L_230_ = L_16_func("Frame", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -20, 0, 0),
                    Visible = false
                }, {
                    L_16_func("UIGradient", {
                        Rotation = 270,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
                            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)),
                            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)),
                            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)),
                            ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 251)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4))
                        }
                    }),
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(0, 5)
                    }),
                    L_228_
                })
                local L_231_ = L_16_func("Frame", {
                    Position = UDim2.new(0, 0, 0, 32),
                    Size = UDim2.new(1, 0, 1, -32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true
                }, {
                    L_230_,
                    L_229_,
                    L_16_func("UIPadding", {
                        PaddingLeft = UDim.new(0, 35),
                        PaddingRight = UDim.new(0, 35),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingTop = UDim.new(0, 17)
                    })
                })
                local L_232_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_233_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Main")
                local L_234_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_19_func(L_20_func(L_18_func("TFrame"), {
                        L_23_func(L_19_func(L_18_func("Label", L_222_arg1.Name, 15), {
                            Size = UDim2.new(1, -12, 1, 0),
                            Position = UDim2.new(0, 12, 0, 0),
                            Font = Enum.Font.GothamBold,
                            Name = "Content"
                        }), "Text"),
                        L_233_,
                        L_232_,
                        L_23_func(L_19_func(L_18_func("Frame"), {
                            Size = UDim2.new(1, 0, 0, 1),
                            Position = UDim2.new(0, 0, 1, -1),
                            Name = "Line",
                            Visible = false
                        }), "Stroke")
                    }), {
                        Size = UDim2.new(1, 0, 0, 38),
                        ClipsDescendants = true,
                        Name = "F"
                    }),
                    L_231_,
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                L_14_func(L_232_.MouseButton1Down, function()
                    L_226_.Toggled = not L_226_.Toggled
                    L_3_:Create(L_234_, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = L_226_.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)
                    }):Play()
                    L_229_.Visible = L_226_.Toggled
                    L_230_.Visible = L_226_.Toggled
                    L_234_.F.Line.Visible = L_226_.Toggled
                end)
                function L_226_:Set(L_238_arg1)
                    L_226_.Value = L_238_arg1
                    L_233_.BackgroundColor3 = L_226_.Value
                    L_222_arg1.Callback(L_226_.Value)
                end
                local function L_235_func()
                    L_233_.BackgroundColor3 = Color3.fromHSV(L_223_, L_224_, L_225_)
                    L_229_.BackgroundColor3 = Color3.fromHSV(L_223_, 1, 1)
                    L_226_:Set(L_233_.BackgroundColor3)
                    L_222_arg1.Callback(L_233_.BackgroundColor3)
                    L_27_func(game.PlaceId)
                end
                L_223_ = 1 - math.clamp(L_228_.AbsolutePosition.Y - L_230_.AbsolutePosition.Y, 0, L_230_.AbsoluteSize.Y) / L_230_.AbsoluteSize.Y
                L_224_ = math.clamp(L_227_.AbsolutePosition.X - L_229_.AbsolutePosition.X, 0, L_229_.AbsoluteSize.X) / L_229_.AbsoluteSize.X
                L_225_ = 1 - math.clamp(L_227_.AbsolutePosition.Y - L_229_.AbsolutePosition.Y, 0, L_229_.AbsoluteSize.Y) / L_229_.AbsoluteSize.Y
                local L_236_
                L_14_func(L_229_.InputBegan, function(L_239_arg1)
                    if L_239_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_239_arg1.UserInputType == Enum.UserInputType.Touch then
                        if L_236_ then
                            L_236_.Function = function() end
                        end
                        L_236_ = L_14_func(L_4_.RenderStepped, function()
                            local L_240_ = math.clamp(L_6_.X - L_229_.AbsolutePosition.X, 0, L_229_.AbsoluteSize.X) / L_229_.AbsoluteSize.X
                            local L_241_ = math.clamp(L_6_.Y - L_229_.AbsolutePosition.Y, 0, L_229_.AbsoluteSize.Y) / L_229_.AbsoluteSize.Y
                            L_227_.Position = UDim2.new(L_240_, 0, L_241_, 0)
                            L_224_ = L_240_
                            L_225_ = 1 - L_241_
                            L_235_func()
                        end)
                    end
                end)
                L_14_func(L_229_.InputEnded, function(L_242_arg1)
                    if (L_242_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_242_arg1.UserInputType == Enum.UserInputType.Touch) and L_236_ then
                        L_236_.Function = function() end
                    end
                end)
                local L_237_
                L_14_func(L_230_.InputBegan, function(L_243_arg1)
                    if L_243_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_243_arg1.UserInputType == Enum.UserInputType.Touch then
                        if L_237_ then
                            L_237_.Function = function() end
                        end
                        L_237_ = L_14_func(L_4_.RenderStepped, function()
                            local L_244_ = math.clamp(L_6_.Y - L_230_.AbsolutePosition.Y, 0, L_230_.AbsoluteSize.Y) / L_230_.AbsoluteSize.Y
                            L_228_.Position = UDim2.new(0.5, 0, L_244_, 0)
                            L_223_ = 1 - L_244_
                            L_235_func()
                        end)
                    end
                end)
                L_14_func(L_230_.InputEnded, function(L_245_arg1)
                    if (L_245_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_245_arg1.UserInputType == Enum.UserInputType.Touch) and L_237_ then
                        L_237_.Function = function() end
                    end
                end)
                L_226_:Set(L_226_.Value)
                if L_222_arg1.Flag then
                    L_10_.Flags[L_222_arg1.Flag] = L_226_
                end
                return L_226_
            end
            return L_153_
        end
        local L_146_ = {}
        function L_146_:AddSection(L_246_arg1)
            L_246_arg1.Name = L_246_arg1.Name or "Section"
            local L_247_ = L_20_func(L_19_func(L_18_func("TFrame"), {
                Size = UDim2.new(1, 0, 0, 26),
                Parent = L_144_
            }), {
                L_23_func(L_19_func(L_18_func("Label", L_246_arg1.Name, 14), {
                    Size = UDim2.new(1, -12, 0, 16),
                    Position = UDim2.new(0, 0, 0, 3),
                    Font = Enum.Font.GothamMedium
                }), "TextDark"),
                L_20_func(L_19_func(L_18_func("TFrame"), {
                    AnchorPoint = Vector2.new(0, 0),
                    Size = UDim2.new(1, 0, 1, -24),
                    Position = UDim2.new(0, 0, 0, 23),
                    Name = "Holder"
                }), {
                    L_18_func("List", 0, 6)
                })
            })
            L_14_func(L_247_.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                L_247_.Size = UDim2.new(1, 0, 0, L_247_.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
                L_247_.Holder.Size = UDim2.new(1, 0, 0, L_247_.Holder.UIListLayout.AbsoluteContentSize.Y)
            end)
            local L_248_ = {}
            for L_249_forvar1, L_250_forvar2 in next, L_145_func(L_247_.Holder) do
                L_248_[L_249_forvar1] = L_250_forvar2
            end
            return L_248_
        end
        for L_251_forvar1, L_252_forvar2 in next, L_145_func(L_144_) do
            L_146_[L_251_forvar1] = L_252_forvar2
        end
        return L_146_
    end
    return L_137_
end


function L_10_:Destroy()
    L_9_:AddItem(L_12_, 0)
end


return L_10_
