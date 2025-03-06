
--if not game:IsLoaded() then game.Loaded:Wait() end


local Services = setmetatable({}, {__index = function(Self, Index)
    return game:GetService(Index)
    end})
    
    
    local Players = Services.Players;
    local UserInputService = Services.UserInputService;
    local RunService = Services.RunService;
    local ts = Services.TweenService;
    local HtppService = Services.HttpService;
    
    local localPlayer = Players.LocalPlayer;
    local camera = workspace.CurrentCamera;
    local Mouse = localPlayer:GetMouse();
    local INew = Instance.new;
    local color3RGB =  Color3.fromRGB;
    local V2new = Vector2.new;
    local UDim2new = UDim2.new;
    local UDimnew = UDim.new;
    Library, Utility = {
    Connections = {},
    Subtabs = {},
    sections = {},
    short_keybind_names = {
    ["MouseButton1"] = "MB1",
    ["MouseButton2"] = "MB2",
    ["MouseButton3"] = "MB3",
    ["Insert"] = "INS",
    ["LeftAlt"] = "LALT",
    ["LeftControl"] = "LC",
    ["LeftShift"] = "LS",
    ["RightAlt"] = "RALT",
    ["RightControl"] = "RC",
    ["RightShift"] = "RS",
    ["CapsLock"] = "CAPS",
    ["Return"] = "RET",
    ["Backspace"] = "BSP",
    ["BackSlash"] = "BS"
    },
    Elementsopened = {},
    InstanceStorage = {},
    WhitelistedMouse = {
    Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3
    },
    BlacklistedKeys = {
    Enum.KeyCode.Unknown, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S,
    Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Down,
    Enum.KeyCode.Right, Enum.KeyCode.Slash, Enum.KeyCode.Tab,
    Enum.KeyCode.Backspace, Enum.KeyCode.Escape
    },
    Flags = {},
    Tabs = {},
    Elements = {},
    Folder = "draco/",
    Font = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    FontSize = 14,
    TextStrokeTransparency = 0.4,
    }, {
    
    MakeDraggable = function(Dragger, Object, OnChange, OnEnd)
    local Position, StartPosition = nil, nil
    
    Library.Connections[#Library.Connections + 1] = Dragger.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
    Position = UserInputService:GetMouseLocation()
    StartPosition = Object.AbsolutePosition
    end
    end)
    Library.Connections[#Library.Connections + 1] = UserInputService.InputChanged:Connect(function(Input)
    if StartPosition and Input.UserInputType ==
    Enum.UserInputType.MouseMovement then
    local Mouse = UserInputService:GetMouseLocation()
    local Delta = Mouse - Position
    Position = Mouse
    
    Delta = Object.Position + UDim2.fromOffset(Delta.X, Delta.Y)
    if OnChange then OnChange(Delta) end
    end
    end)
    Library.Connections[#Library.Connections + 1] = Dragger.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
    if OnEnd then
    OnEnd(Object.Position, StartPosition)
    end
    Position, StartPosition = nil, nil
    end
    end)
    end,
    
    ripple = function(button, x, y)
    if button ~= nil then
    button.ClipsDescendants = true
    
    local Circle = Instance.new("ImageLabel")
    Circle.ScaleType = Enum.ScaleType.Stretch
    Circle.Parent = button
    Circle.BackgroundColor3 = color3RGB(255, 255, 255)
    Circle.BackgroundTransparency = 1.000
    Circle.ZIndex = 10
    Circle.Image = "rbxassetid://266543268"
    Circle.ImageColor3 = color3RGB(210, 210, 210)
    Circle.ImageTransparency = 0.4
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDimnew(0, 4)
    uiCorner.Parent = Circle
    
    local new_x = x - Circle.AbsolutePosition.X
    local new_y = y - Circle.AbsolutePosition.Y
    Circle.Position = UDim2new(0, new_x, 0, new_y)
    
    local size = 0
    if button.AbsoluteSize.X > button.AbsoluteSize.Y then
    size = button.AbsoluteSize.X * 1.5
    elseif button.AbsoluteSize.X < button.AbsoluteSize.Y then
    size = button.AbsoluteSize.Y * 1.5
    elseif button.AbsoluteSize.X == button.AbsoluteSize.Y then
    size = button.AbsoluteSize.X * 1.5
    end
    
    Circle:TweenSizeAndPosition(UDim2new(0, size, 0, size), UDim2new(
    0.5, -size / 2, 0.5, -size / 2),
    "Out", "Quad", 0.5, false, nil)
    ts:Create(Circle, TweenInfo.new(0.6, Enum.EasingStyle.Linear,
    Enum.EasingDirection.InOut),
    {ImageTransparency = 1}):Play()
    wait(0.6)
    Circle:Destroy()
    end
    end,
    TableToColor = function(Table)
    if type(Table) ~= "table" then return Table end
    return Color3.fromHSV(Table[1], Table[2], Table[3])
    end,
    Proxify = function(Table)
    local Proxy, Events = {}, {}
    local ChangedEvent = Instance.new("BindableEvent")
    Table.Changed = ChangedEvent.Event
    Proxy.Internal = Table
    function Table:GetPropertyChangedSignal(Property)
    local PropertyEvent = Instance.new("BindableEvent")
    
    Events[Property] = Events[Property] or {}
    table.insert(Events[Property], PropertyEvent)
    
    return PropertyEvent.Event
    end
    
    setmetatable(Proxy, {
    __index = function(Self, Key) return Table[Key] end,
    __newindex = function(Self, Key, Value)
    local OldValue = Table[Key]
    Table[Key] = Value
    
    ChangedEvent:Fire(Key, Value, OldValue)
    if Events[Key] then
    for Index, Event in ipairs(Events[Key]) do
    Event:Fire(Value, OldValue)
    end
    end
    end
    })
    
    return Proxy
    end,
    
    GetType = function(Self, Object, Default, Type, UseProxify)
    if typeof(Object) == Type then
    return UseProxify and Self.Proxify(Object) or Object
    end
    return UseProxify and Self.Proxify(Default) or Default
    end,
    
    Theme = {
    Accent = color3RGB(229, 134, 224),
    Background = color3RGB(29, 29, 29),
    Tab_Background = color3RGB(45, 43, 49),
    DarkContrast = color3RGB(15, 14, 19),
    ComponentBackground = color3RGB(47, 40, 48),
    Text_light = color3RGB(255,255,255),
    Text_dark = color3RGB(199,199,199),
    Tab_unselected = color3RGB(255,255,255),
    Slider_circle = color3RGB(148, 150, 149),
    White = color3RGB(255,255,255),
    Colorpicker_outline = color3RGB(35, 35, 35),
    }
    }
    
    
    function Utility:Signal(Event, thread)
    local Connection;
    local Passed, Statement = pcall(function()
    Connection = Event:Connect(thread);
    end)
    if Passed then
    table.insert(Library.Connections, Connection);
    return Connection;
    else
    warn(Event, Statement);
    return nil;
    end
    end
    function Utility:UpdateObject(Object, Property, Value)
    if not Library.InstanceStorage[Object] then
    Library.InstanceStorage[Object] = {[Property] = Value}
    else
    Library.InstanceStorage[Object][Property] = Value
    end
    end
    
    
    function Utility:MakeEffect(Object,Material)
    
    local MTREL = Material -- Glass. Neon
    local binds = {}
    local root = Instance.new('Folder', camera)
    root.Name = 'Folder'
    
    local gTokenMH = 99999999
    local gToken = math.random(1, gTokenMH)
    
    local DepthOfField = Instance.new('DepthOfFieldEffect', game:GetService('Lighting'))
    DepthOfField.FarIntensity = 0
    DepthOfField.FocusDistance = 51.6
    DepthOfField.InFocusRadius = 50
    DepthOfField.NearIntensity = 1
    DepthOfField.Name = "DPT_"..gToken
    
    local frame = Instance.new('Frame')
    frame.Parent = Object
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundTransparency = 1
    
    local GenUid; do -- Generate unique names for RenderStepped bindings
    local id = 0
    function GenUid()
    id = id + 1
    return 'neon::'..tostring(id)
    end
    end
    
    do
    local function IsNotNaN(x)
    return x == x
    end
    local continue = IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x)
    while not continue do
    RunService.RenderStepped:wait()
    continue = IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x)
    end
    end
    
    local DrawQuad; do
    local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
    local sz = 0.2
    
    local function DrawTriangle(v1, v2, v3, p0, p1) -- I think Stravant wrote this function
    local s1 = (v1 - v2).magnitude
    local s2 = (v2 - v3).magnitude
    local s3 = (v3 - v1).magnitude
    local smax = max(s1, s2, s3)
    local A, B, C
    if s1 == smax then
    A, B, C = v1, v2, v3
    elseif s2 == smax then
    A, B, C = v2, v3, v1
    elseif s3 == smax then
    A, B, C = v3, v1, v2
    end
    
    local para = ( (B-A).x*(C-A).x + (B-A).y*(C-A).y + (B-A).z*(C-A).z ) / (A-B).magnitude
    local perp = sqrt((C-A).magnitude^2 - para*para)
    local dif_para = (A - B).magnitude - para
    
    local st = CFrame.new(B, A)
    local za = CFrame.Angles(pi/2,0,0)
    
    local cf0 = st
    
    local Top_Look = (cf0 * za).lookVector
    local Mid_Point = A + CFrame.new(A, B).lookVector * para
    local Needed_Look = CFrame.new(Mid_Point, C).lookVector
    local dot = Top_Look.x*Needed_Look.x + Top_Look.y*Needed_Look.y + Top_Look.z*Needed_Look.z
    
    local ac = CFrame.Angles(0, 0, acos(dot))
    
    cf0 = cf0 * ac
    if ((cf0 * za).lookVector - Needed_Look).magnitude > 0.01 then
    cf0 = cf0 * CFrame.Angles(0, 0, -2*acos(dot))
    end
    cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))
    
    local cf1 = st * ac * CFrame.Angles(0, pi, 0)
    if ((cf1 * za).lookVector - Needed_Look).magnitude > 0.01 then
    cf1 = cf1 * CFrame.Angles(0, 0, 2*acos(dot))
    end
    cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)
    
    if not p0 then
    p0 = Instance.new('Part')
    p0.FormFactor = 'Custom'
    p0.TopSurface = 0
    p0.BottomSurface = 0
    p0.Anchored = true
    p0.CanCollide = false
    p0.CastShadow = false
    p0.Material = MTREL
    p0.Size = Vector3.new(sz, sz, sz)
    local mesh = Instance.new('SpecialMesh', p0)
    mesh.MeshType = 2
    mesh.Name = 'WedgeMesh'
    end
    p0.WedgeMesh.Scale = Vector3.new(0, perp/sz, para/sz)
    p0.CFrame = cf0
    
    if not p1 then
    p1 = p0:clone()
    end
    p1.WedgeMesh.Scale = Vector3.new(0, perp/sz, dif_para/sz)
    p1.CFrame = cf1
    
    return p0, p1
    end
    
    function DrawQuad(v1, v2, v3, v4, parts)
    parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
    parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
    end
    end
    
    if binds[frame] then
    return binds[frame].parts
    end
    
    local uid = GenUid()
    local parts = {}
    local f = Instance.new('Folder', root)
    f.Name = frame.Name
    
    local parents = {}
    do
    local function add(child)
    if child:IsA'GuiObject' then
    parents[#parents + 1] = child
    add(child.Parent)
    end
    end
    add(frame)
    end
    
    local function UpdateOrientation(fetchProps)
    local properties = {
    Transparency = 0.98;
    BrickColor = BrickColor.new('Institutional white');
    }
    local zIndex = 1 - 0.05*frame.ZIndex
    
    local tl, br = frame.AbsolutePosition, frame.AbsolutePosition + frame.AbsoluteSize
    local tr, bl = Vector2.new(br.x, tl.y), Vector2.new(tl.x, br.y)
    do
    local rot = 0;
    for _, v in ipairs(parents) do
    rot = rot + v.Rotation
    end
    if rot ~= 0 and rot%180 ~= 0 then
    local mid = tl:lerp(br, 0.5)
    local s, c = math.sin(math.rad(rot)), math.cos(math.rad(rot))
    local vec = tl
    tl = Vector2.new(c*(tl.x - mid.x) - s*(tl.y - mid.y), s*(tl.x - mid.x) + c*(tl.y - mid.y)) + mid
    tr = Vector2.new(c*(tr.x - mid.x) - s*(tr.y - mid.y), s*(tr.x - mid.x) + c*(tr.y - mid.y)) + mid
    bl = Vector2.new(c*(bl.x - mid.x) - s*(bl.y - mid.y), s*(bl.x - mid.x) + c*(bl.y - mid.y)) + mid
    br = Vector2.new(c*(br.x - mid.x) - s*(br.y - mid.y), s*(br.x - mid.x) + c*(br.y - mid.y)) + mid
    end
    end
    DrawQuad(
    camera:ScreenPointToRay(tl.x, tl.y, zIndex).Origin, 
    camera:ScreenPointToRay(tr.x, tr.y, zIndex).Origin, 
    camera:ScreenPointToRay(bl.x, bl.y, zIndex).Origin, 
    camera:ScreenPointToRay(br.x, br.y, zIndex).Origin, 
    parts
    )
    if fetchProps then
    for _, pt in pairs(parts) do
    pt.Parent = f
    end
    for propName, propValue in pairs(properties) do
    for _, pt in pairs(parts) do
    pt[propName] = propValue
    end
    end
    end
    end
    
    UpdateOrientation(true)
    RunService:BindToRenderStep(uid, 2000, UpdateOrientation)
    
    end
    
    
    function Utility:Render(ObjectType, Properties, Children)
    local Passed, Statement = pcall(function()
    local Object = INew(ObjectType)
    
    for Property, Value in pairs(Properties) do
    if string.find(Property, "Color") and typeof(Value) == "string" and
    ObjectType ~= "UIGradient" then
    local Theme = self.Theme[Value]
    Utility:UpdateObject(Object, Property, Value)
    Object[Property] = Theme
    else
    Object[Property] = Value
    end
    
    end
    if Children then
    for Index, Child in pairs(Children) do
    Child.Parent = Object
    end
    end
    return Object
    end)
    
    if Passed then
    return Statement
    else
    warn("Failed to render object: " .. tostring(ObjectType),
    tostring(Statement))
    return nil
    end
    end
    
    function Utility:SetTheme(Theme, Color)
    if Utility.Theme[Theme] ~= Color then
    Utility.Theme[Theme] = Color
    --
    for Index, Value in pairs(Library.InstanceStorage) do
    for Index2, Value2 in pairs(Value) do
    if Value2 == Theme then Index[Index2] = Color end
    end
    end
    end
    end
    
    
    function Utility:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.Elementsopened do
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
    
    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >=
    AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then return true end
    end
    end
    
    local Tabs = Library.Tabs;
    local Sections = Library.sections;
    
    Tabs.__index = Library.Tabs
    Sections.__index = Library.sections
    
    function Library:Menu(properties)
    local properties = properties or {}
    local window = Utility:GetType(properties, {}, "table",false)
    window.Title = Utility:GetType(window.Title, ".gg/Dracohub", "string")
    window.Tabs = Utility:GetType(window.Tabs, {}, "table")
    
    local dacroui = Utility:Render("ScreenGui",{
    Name = "dacroui",
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Parent = gethui()
    })
    local MainFrame = Utility:Render("Frame",{
    Name = "MainFrame",
    BackgroundTransparency = 0.3499999940395355,
    Position = UDim2.new(0.09341466426849365, 0, 0.004557493142783642, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    BackgroundColor3 = "Background",
    Parent = dacroui
    })
    Utility:MakeEffect(MainFrame,"Glass")
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 1.3833332061767578,
    Parent = MainFrame
    })
    local UISizeConstraint = Utility:Render("UISizeConstraint",{
    MaxSize = Vector2.new(830, 600),
    Parent = MainFrame
    })
    local Topbar = Utility:Render("Frame",{
    BackgroundTransparency = 1,
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0.09333333373069763, 0),
    BorderSizePixel = 0,
    Parent = MainFrame
    })
    Utility.MakeDraggable(Topbar, MainFrame, function(Pos)
    MainFrame.Position = Pos
    end)
    local MenuLogo = Utility:Render("ImageLabel",{
    ImageColor3 = "Accent",
    AnchorPoint = Vector2.new(0, 0.5),
    Image = "rbxassetid://118954804939011",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.01204819418489933, 0, 0.5, 0),
    Name = "MenuLogo",
    Size = UDim2.new(0.03132530674338341, 0, 0.4642857015132904, 0),
    BorderSizePixel = 0,
    Parent = Topbar
    })
    local MenulogoGlow = Utility:Render("ImageLabel",{
    ImageColor3 = "Accent",
    ImageTransparency = 0.8199999928474426,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Image = "rbxassetid://15488281448",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Name = "MenulogoGlow",
    Size = UDim2.new(1.25, 0, 1.25, 0),
    SliceCenter = Rect.new(Vector2.new(20, 20), Vector2.new(108, 108)),
    Parent = MenuLogo
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    Parent = MenuLogo
    })
    
    local Accentline = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(0, 1),
    Name = "Accentline",
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 3),
    BorderSizePixel = 0,
    BackgroundColor3 = "Accent",
    Parent = Topbar
    })
    local MenuTitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    TextColor3 = "Text_light",
    Text = window.Title,
    BackgroundTransparency = 1,
    Name = "MenuTitle",
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = Topbar
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 14.821426391601562,
    Parent = Topbar
    })
    local Sidebar = Utility:Render("Frame",{
    Name = "Sidebar",
    BackgroundTransparency = 0.20000000298023224,
    Position = UDim2.new(0, 0, 0.09333333373069763, 0),
    Size = UDim2.new(0.22530123591423035, 0, 0.9066666960716248, 0),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = MainFrame
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 12),
    Parent = Sidebar
    })
    tabholders = Utility:Render("ScrollingFrame",{
    Active = true,
    ScrollBarThickness = 0,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0.036764707416296005, 0),
    Name = "tabholders",
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    Parent = Sidebar
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    Padding = UDim.new(0.00922191608697176, 0),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = tabholders
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 0.34375,
    Parent = tabholders
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 0.34375,
    Parent = Sidebar
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 12),
    Parent = MainFrame
    })
    PageHolders = Utility:Render("ScrollingFrame",{
    Active = true,
    ScrollBarThickness = 0,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.22530123591423035, 0, 0.12666666507720947, 0),
    Name = "PageHolders",
    Size = UDim2.new(0.7746987342834473, 0, 0.878333330154419, 0),
    BorderSizePixel = 0,
    Parent = MainFrame
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 1.2201136350631714,
    Parent = PageHolders
    })
    local backgroundFrame = Utility:Render("Frame",{
    Name = "BackgroundFrame",
    Size = UDim2.new(0, 60, 0, 60),
    Position = UDim2.new(1, -70, 0.5, -30),
    BackgroundColor3 = "DarkContrast",
    BorderSizePixel = 0,
    Transparency = 1,
    Parent = dacroui
    })
    local OpenButton = Utility:Render("ImageButton",{
    Name = "OpenButton",
    Image = "rbxassetid://104832225542320",
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.5, -25, 0.5, -25),
    BackgroundTransparency = 1,
    Parent = backgroundFrame
    })
    Utility.MakeDraggable(OpenButton, backgroundFrame, function(Pos)
        backgroundFrame.Position = Pos
        end)
        Utility:Signal(OpenButton.MouseButton1Click,function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    local enablelogoanimation = true
    task.spawn(function()
    while enablelogoanimation do task.wait(0.1)
    ts:Create(MenuLogo,TweenInfo.new(0.4, Enum.EasingStyle.Linear), {ImageColor3 = Utility.Theme.Accent}):Play()
    ts:Create(MenulogoGlow,TweenInfo.new(0.4, Enum.EasingStyle.Linear), {ImageColor3 = Utility.Theme.Accent}):Play()
    task.wait(0.6)
    ts:Create(MenuLogo,TweenInfo.new(0.4, Enum.EasingStyle.Linear), {ImageColor3 = Utility.Theme.White}):Play()
    ts:Create(MenulogoGlow,TweenInfo.new(0.4, Enum.EasingStyle.Linear), {ImageColor3 = Utility.Theme.White}):Play()
    task.wait(1.8)
    end
    end)
    function window:Unload()
    for i, v in ipairs(self.Connections) do
    v:Disconnect()
    end
    dacroui:Destroy()
    enablelogoanimation = false
    Library = nil
    end
    
    
    return setmetatable(window,Library)
    end
    firsttab = true
    function Library:Tab(properties)
    local properties = properties or {}
    local Tab = Utility:GetType(properties, {}, "table", false)
    Tab.Selected = Utility:GetType(Tab.Selected, false, "boolean")
    Tab.Title = Utility:GetType(Tab.Title, "Tab", "string")
    Tab.sections = Utility:GetType(Tab.sections, {}, "table")
    Tab.Icon = Utility:GetType(Tab.Icon, "rbxassetid://", "string")
    Tab.window = self
    local tabFrame = Utility:Render("TextButton",{
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    Text = "",
    AutoButtonColor = false,
    BackgroundTransparency = 1,
    Name = "Tab",
    Size = UDim2.new(1, -10, 0, 40),
    BorderSizePixel = 0,
    TextSize = 14,
    BackgroundColor3 = "Tab_Background",
    Parent = tabholders
    })
    Utility:Render("UICorner",{
    Parent = tabFrame
    })
    Utility:Render("UIListLayout",{
    VerticalAlignment = Enum.VerticalAlignment.Center,
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0.09125383198261261, 0),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = tabFrame
    })
    Utility:Render("UIPadding",{
    PaddingLeft = UDim.new(0, 12),
    Parent = tabFrame
    })
    local Tabicon = Utility:Render("ImageLabel",{
    Image = Tab.Icon, -- "rbxassetid://15230695042",
    BackgroundTransparency = 1,
    Visible = Tab.Icon == "rbxassetid://" and false or true,
    Size = UDim2.new(0.12121212482452393, 0, 0.5, 0),
    BorderSizePixel = 0,
    Parent = tabFrame
    })
    Utility:Render("UIAspectRatioConstraint",{
    Parent = Tabicon
    })
    local Tabtitle = Utility:Render("TextLabel",{
    TextWrapped = true,
    TextColor3 = "Text_dark",
    Text = Tab.Title,
    Size = UDim2.new(0.8727272748947144, 0, 0.3499999940395355, 0),
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextSize = 14,
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextScaled = true,
    Parent = tabFrame
    })
    
    local Page = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0, 0),
    Name = "Page",
    Visible = false,
    Size = UDim2.new(1, -22, 1, 0),
    BorderSizePixel = 0,
    Parent = PageHolders
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
    Padding = UDim.new(0.016158834099769592, 0),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = Page
    })
    local Left = Utility:Render("Frame",{
    BackgroundTransparency = 1,
    Name = "Left",
    Size = UDim2.new(0.4911434054374695, 0, 1, 0),
    BorderSizePixel = 0,
    Parent = Page
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
    Padding = UDim.new(0.004181097261607647, 0),
    Parent = Left
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 0.2541666626930237,
    Parent = Left
    })
    local Right = Utility:Render("Frame",{
    BackgroundTransparency = 1,
    Name = "Right",
    Size = UDim2.new(0.4911434054374695, 0, 1, 0),
    BorderSizePixel = 0,
    Parent = Page
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
    Padding = UDim.new(0.004181097261607647, 0),
    Parent = Right
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 0.2541666626930237,
    Parent = Right
    })
    function Tab:Open(value)
    task.spawn(function()
    Tab.Selected = value
    ts:Create(tabFrame,TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = value and 0.4 or 1}):Play()
    ts:Create(Tabicon,TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageColor3 = value and Utility.Theme.Accent or Utility.Theme.Tab_unselected}):Play()
    ts:Create(Tabtitle, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextColor3 = value and Utility.Theme.Text_light or Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(Tabicon, "BackgroundColor3",value and "Accent" or "tab_unselected")
    Utility:UpdateObject(Tabtitle, "TextColor3",value and "Text_light" or "Text_dark")
    
    Page.Visible = value
    
    end)
    end
    if firsttab then
    firsttab = false
    Tab:Open(true)
    
    end
    
    Utility:Signal(tabFrame.MouseButton1Down, function()
    if not Tab.Selected then
    Tab:Open(true)
    for _, Tabs in pairs(self.Tabs) do
    if Tabs.Selected and Tabs ~= Tab then
    Tabs:Open(false)
    end;
    end;
    end;
    end)
    Tab.Side = {Left = Left,Right=Right} 
    self.Tabs[#self.Tabs + 1] = Tab
    return setmetatable(Tab, Library.Tabs)
    end
    function Tabs:Keybind(side,properties)
    local properties = properties or {}
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local Keybind = Utility:GetType(properties, {}, "table", true)
    Keybind.Mode = Utility:GetType(Keybind.Mode, "Toggle", "string")
    Keybind.Title = Utility:GetType(Keybind.Title, "Keybind", "string")
    Keybind.Flag = Utility:GetType(Keybind.Flag, Keybind.Title, "string")
    Keybind.Default = Utility:GetType(Keybind.Default, "Q", "string")
    Keybind.Value = Utility:GetType(Keybind.Value, false, "boolean")
    Keybind.Callback = Utility:GetType(Keybind.Callback, function() end,"function")
    local window = self.window
    local Keybinding, Holding, keybindValue = false, false, Keybind.Value
    local holdmode = Keybind.Mode == "Hold" and true or false
    local togglemode = Keybind.Mode == "Toggle" and true or false
    local Buttonmode = Keybind.Mode == "Button" and true or false 
    
    local keybindcontainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "keybindcontainer",
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = keybindcontainer
    })
    local keybindtitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Keybind.Title,
    Name = "keybindtitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = keybindcontainer
    })
    local Keybindvalue = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Name = "Keybindvalue",
    AnchorPoint = Vector2.new(1, 0),
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Right,
    Position = UDim2.new(0.9539999961853027, 0, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = keybindcontainer
    })
    local KeybindDetector = Utility:Render("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = keybindcontainer
    })
    function Keybind:CheckKey(tab, key)
    for i, v in next, tab do 
    if v == key then
    return true
    end 
    end
    end
    Utility:Signal(KeybindDetector.MouseButton1Click, function()
    if Keybinding ~= true then
    Keybinding = true
    Keybindvalue.Text = "..."
    end
    end)
    
    Utility:Signal(UserInputService.InputBegan, function(Input)
    if (Input.KeyCode.Name == Keybind.Default or Input.UserInputType.Name == Keybind.Default) and not Keybinding then
    if holdmode then
    Holding = true
    Keybind.Value = Holding
    Keybind.Callback(Holding)
    elseif not Keybinding and togglemode then
    keybindValue = not keybindValue
    Keybind.Value = keybindValue
    Keybind.Callback(keybindValue)
    end
    elseif Keybinding then
    
    if not Keybind:CheckKey(Library.BlacklistedKeys, Input.KeyCode)  then
    Keybind.Default = Input.KeyCode.Name
    
    
    end
    if Keybind:CheckKey(Library.WhitelistedMouse, Input.UserInputType)  then
    Keybind.Default = Input.UserInputType.Name
    
    end
    end
    end)
    
    Utility:Signal(UserInputService.InputEnded, function(Input)
    if Input.KeyCode.Name == Keybind.Default or Input.UserInputType.Name == Keybind.Default then
    if holdmode and Holding then
    Holding = false
    Keybind.Value = Holding
    Keybind.Callback(Holding)
    end
    end
    end)
    Utility:Signal(Keybind:GetPropertyChangedSignal("Default"),function(NewKey)
    Keybinding = false
    Library.Flags[Keybind.Flag] = NewKey
    local keybind_default_text = tostring(NewKey) or tostring(Keybind.Default)
    Keybindvalue.Text = (Library.short_keybind_names[keybind_default_text] or keybind_default_text:upper())
    
    
    end)
    Keybind.Default = Keybind.Default
    Library.Elements[#Library.Elements + 1] = Keybind
    return Keybind
    end
    function Tabs:Slider(side,properties)
    local properties = properties or {}
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local Slider = Utility:GetType(properties, {}, "table", true)
    Slider.Title = Utility:GetType(Slider.Title, "slider", "string")
    Slider.Suffix = Utility:GetType(Slider.Suffix, "", "string")		
    Slider.Max = Utility:GetType(Slider.Max, 100, "number")
    Slider.Flag = Utility:GetType(Slider.Flag, Slider.Title, "string")
    Slider.Min = Utility:GetType(Slider.Min, 0, "number")
    Slider.Default = Utility:GetType(Slider.Default, 1, "number")
    Slider.Increment = Utility:GetType(Slider.Increment, 1, "number")
    Slider.Callback = Utility:GetType(Slider.Callback,function()end,"function")
    local window = self.window
    
    local Increment = 1 / Slider.Increment
    local slidercontainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "slidercontainer",
    Size = UDim2.new(1, 0, 0, 60),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = slidercontainer
    })
    local sliderbar = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 1),
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.9540983438491821, 0, 0.75, 0),
    Name = "sliderbar",
    Size = UDim2.new(0.911475419998169, 0, 0.0833333358168602, 0),
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = slidercontainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 4),
    Parent = sliderbar
    })
    local sliderindicator = Utility:Render("Frame",{
    Name = "slider",
    Size = UDim2.new(0, 100, 1, 0),
    BorderSizePixel = 0,
    BackgroundColor3 = "Accent",
    Parent = sliderbar
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 4),
    Parent = sliderindicator
    })
    local sliderglow = Utility:Render("ImageLabel",{
    ImageColor3 = "Accent",
    ScaleType = Enum.ScaleType.Slice,
    ImageTransparency = 0.7599999904632568,
    Name = "sliderglow",
    Size = UDim2.new(1.06, 0, 4, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Image = "rbxassetid://80991254347944",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    SliceScale = 2,
    BorderSizePixel = 0,
    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79)),
    Parent = sliderindicator
    })
    local slidercircl = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    Name = "slidercircl",
    Position = UDim2.new(1, 0, 0.5, 0),
    Size = UDim2.new(0, 6, 0, 6),
    BorderSizePixel = 0,
    BackgroundColor3 = "Slider_circle",
    Parent = sliderindicator
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(1, 0),
    Parent = slidercircl
    })
    local UIStroke = Utility:Render("UIStroke",{
    Thickness = 2,
    Color = "White",
    Parent = slidercircl
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 55.599998474121094,
    Parent = sliderbar
    })
    local slidertitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Slider.Title,
    Name = "slidertitle",
    Size = UDim2.new(0.43278688192367554, 0, 0, 14),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 15),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = slidercontainer
    })
    local slidertextframe = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0),
    Name = "slidertextframe",
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.9540983438491821, 0, 0.10000000149011612, 0),
    Size = UDim2.new(0.09836065769195557, 0, 0.4333333373069763, 0),
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundColor3 = "ComponentBackground",
    Parent = slidercontainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 4),
    Parent = slidertextframe
    })
    local slidervaluetext = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_light",
    Name = "slidervaluetex",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.X,
    TextSize = 14,
    Parent = slidertextframe
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 1.1538461446762085,
    Parent = slidertextframe
    })
    local SliderDetector = Utility:Render("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = slidercontainer
    })
    Utility:Signal(Slider:GetPropertyChangedSignal("Default"),function(val)
    Library.Flags[Slider.Flag] = val
    local Value = math.clamp(math.round(val * Increment) / Increment, Slider.Min, Slider.Max)
    slidervaluetext.Text = tostring(val) .. Slider.Suffix
    local percent = 1 - (Slider.Max - val) / (Slider.Max - Slider.Min)
    ts:Create(sliderindicator, TweenInfo.new(0.2, Enum.EasingStyle.Sine,Enum.EasingDirection.Out), {Size = UDim2new(percent, 0, 1, 0)}):Play()
    Slider.Callback(Value)
    
    end)
    Slider.Default = Slider.Default
    
    function Slider:Move()
    local percent = math.clamp(Mouse.X - sliderindicator.AbsolutePosition.X, 0, sliderbar.AbsoluteSize.X) / sliderbar.AbsoluteSize.X
    local Svalue = math.floor((Slider.Min + (Slider.Max - Slider.Min) * percent) * Increment) / Increment
    Svalue = math.clamp(Svalue, Slider.Min, Slider.Max)
    Slider.Default = Svalue
    
    end
    
    Utility:Signal(SliderDetector.MouseButton1Down,function()
    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
    task.wait()
    Slider:Move()
    end
    end)
    Library.Elements[#Library.Elements + 1] = Slider
    return Slider
    end
    function Tabs:Dropdown(side,properties)
    local properties = properties or {}
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local Dropdown = Utility:GetType(properties, {}, "table", true)
    Dropdown.Title = Utility:GetType(Dropdown.Title, "Dropdown", "string")
    Dropdown.Opened = Utility:GetType(Dropdown.Opened, false, "boolean")
    Dropdown.Flag = Utility:GetType(Dropdown.Flag, Dropdown.Title, "string")
    Dropdown.Options = Utility:GetType(Dropdown.Options, {}, "table")
    Dropdown.Default = Utility:GetType(Dropdown.Default, Dropdown.Options[1],"string")
    Dropdown.Callback = Utility:GetType(Dropdown.Callback, function() end,"function")
    local window = self.window
    
    local DropdownContainer = Utility:Render("Frame",{
    Name = "DropdownContainer",
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.013114754110574722, 0, 0.12669552862644196, 0),
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = DropdownContainer
    })
    local dropdownframe = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.9540983438491821, 0, 0.5, 0),
    Name = "dropdownframe",
    Size = UDim2.new(0, 180, 0, 24),
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = DropdownContainer
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 3.6,
    Parent = dropdownframe
    })
    local dropdownvalue = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = "Head",
    Name = "dropdownvalue",
    Size = UDim2.new(0, 32, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.SplitWord,
    AutomaticSize = Enum.AutomaticSize.X,
    TextSize = 14,
    Parent = dropdownframe
    })
    local arrow = Utility:Render("TextButton",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    Active = false,
    Text = "▼",
    Name = "arrow",
    Size = UDim2.new(0, 21, 0, 16),
    AnchorPoint = Vector2.new(1, 0.5),
    Interactable = false,
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(1, -4, 0.5, 0),
    BorderSizePixel = 0,
    TextColor3 = "Text_light",
    TextSize = 12,
    BackgroundColor3 = "DarkContrast",
    Parent = dropdownframe
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = arrow
    })
    local noclickdetector = Utility:Render("TextButton",{
    Visible = false,
    Text = "",
    AutoButtonColor = false,
    Name = "noclickdetector",
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 100),
    ZIndex = 9,
    Parent = dropdownframe
    })
    local dropdowncontainerback = Utility:Render("Frame",{
    Name = "dropdowncontainerback",
    BackgroundTransparency = 0.4000000059604645,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 10,
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = noclickdetector
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = dropdowncontainerback
    })
    local optionContainer = Utility:Render("ScrollingFrame",{
    Active = true,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 0,
    Name = "dropdownoptioncontainer",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ZIndex = 10,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    Parent = dropdowncontainerback
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = optionContainer
    })
    
    local UIPadding = Utility:Render("UIPadding",{
    PaddingTop = UDim.new(0, 4),
    Parent = optionContainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = optionContainer
    })
    local dropdowntitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Dropdown.Title,
    Name = "dropdowntitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = DropdownContainer
    })
    local dropdowndetector = Utility:Render("TextButton",{
    Text = "",
    Name = "toggledetector",
    Size = UDim2new(1,0,1,0),
    BackgroundTransparency = 1,
    Position = UDim2new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = DropdownContainer
    })
    function Dropdown:AddOption(Options)
    if type(Options) ~= "table" then return end
    for _, v in pairs(Options) do
    
    local Option = Utility:Render("TextButton",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = v,
    Name = v,
    Active = false,
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundTransparency = 1,
    Selectable = false,
    BorderSizePixel = 0,
    ZIndex = 10,
    TextSize = 14,
    Parent = optionContainer
    })
    
    Utility:Signal(Option.MouseButton1Down,function()
    Dropdown.Default = v
    
    end)
    end  
    end
    function Dropdown:Clear()
    for Index, Option in pairs(optionContainer:GetChildren()) do
    if Option:IsA("TextButton") then Option:Destroy() end
    end
    table.clear(Dropdown.Options)
    Dropdown.Default = ""
    end
    
    Utility:Signal(Dropdown:GetPropertyChangedSignal("Default"),function(option)
    task.spawn(function()
    Library.Flags[Dropdown.Flag] = option
    
    dropdownvalue.Text = tostring(option)
    Dropdown.Callback(option)
    for i, v in pairs(optionContainer:GetChildren()) do
    if v.Name == option and v:IsA("TextButton") then
    ts:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Accent}):Play()
    Utility:UpdateObject(v, "TextColor3", "Accent")
    
    end
    if v.Name ~= option and v:IsA("TextButton") then
    ts:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(v, "TextColor3", "Text_dark")
    end
    end
    end)
    
    end)
    local waitclick
    
    function Dropdown:Open()
    if waitclick then return end 
    waitclick = true 
    if not noclickdetector.Visible then 
    waitclick = false 
    arrow.Rotation = 180;
    ts:Create(dropdowntitle, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_light}):Play()
    Utility:UpdateObject(dropdowntitle, "TextColor3", "Text_light")
    noclickdetector.Visible = true;
    ts:Create(noclickdetector,TweenInfo.new(0.8,Enum.EasingStyle.Exponential), {Size =  UDim2.new(1, 0, 0, 80) }):Play()
    
    Library.Elementsopened[noclickdetector] = true;
    else
    arrow.Rotation = 0;
    ts:Create(dropdowntitle, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(dropdowntitle, "TextColor3", "Text_dark")
    ts:Create(noclickdetector,TweenInfo.new(0.8,Enum.EasingStyle.Exponential), {Size =  UDim2.new(1, 0, 0, 0) }):Play()
    Library.Elementsopened[noclickdetector] = nil;
    task.delay(0.9,function()
    noclickdetector.Visible = false
    waitclick = false 
    end)
    
    end
    end
    Utility:Signal(dropdowndetector.MouseButton1Down, function()
    if not Utility:MouseIsOverOpenedFrame() then
    Dropdown:Open()
    end
    end)
    
    Utility:Signal(UserInputService.InputBegan,function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
    local AbsPos, AbsSize = noclickdetector.AbsolutePosition, noclickdetector.AbsoluteSize;
    
    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X or Mouse.Y <
    (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
    
    Dropdown.Opened = false
    end
    end
    end);
    
    
    Dropdown:AddOption(Dropdown.Options)
    Dropdown.Default = Dropdown.Default
    Library.Elements[#Library.Elements + 1] = Dropdown
    return Dropdown
    end
    function Tabs:MultiDropdown(side,properties)
    local properties = properties or {}
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local MultiDropdown = Utility:GetType(properties, {}, "table", true)
    MultiDropdown.Title = Utility:GetType(MultiDropdown.Title, "MultiDropdown","string")
    MultiDropdown.Opened = Utility:GetType(MultiDropdown.Opened, false,"boolean")
    MultiDropdown.Flag = Utility:GetType(MultiDropdown.Flag,MultiDropdown.Title, "string")
    MultiDropdown.Options = Utility:GetType(MultiDropdown.Options, {}, "table")
    MultiDropdown.Startvalue = Utility:GetType(MultiDropdown.Startvalue, {}, "table")
    MultiDropdown.Default = Utility:GetType(MultiDropdown.Default, {}, "table")
    MultiDropdown.Callback = Utility:GetType(MultiDropdown.Callback,function() end, "function")
    MultiDropdown.Value = {}
    MultiDropdown.Ismultidropdown = true
    local window = self.window
    
    local DropdownContainer = Utility:Render("Frame",{
    Name = "DropdownContainer",
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.013114754110574722, 0, 0.12669552862644196, 0),
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = DropdownContainer
    })
    local dropdownframe = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.9540983438491821, 0, 0.5, 0),
    Name = "dropdownframe",
    Size = UDim2.new(0, 180, 0, 24),
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = DropdownContainer
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 3.6,
    Parent = dropdownframe
    })
    local dropdownvalue = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = "Head",
    Name = "dropdownvalue",
    Size = UDim2.new(0, 32, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.SplitWord,
    AutomaticSize = Enum.AutomaticSize.X,
    TextSize = 14,
    Parent = dropdownframe
    })
    local arrow = Utility:Render("TextButton",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    Active = false,
    Text = "▼",
    Name = "arrow",
    Size = UDim2.new(0, 21, 0, 16),
    AnchorPoint = Vector2.new(1, 0.5),
    Interactable = false,
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(1, -4, 0.5, 0),
    BorderSizePixel = 0,
    TextColor3 = "Text_light",
    TextSize = 12,
    BackgroundColor3 = "DarkContrast",
    Parent = dropdownframe
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = arrow
    })
    local noclickdetector = Utility:Render("TextButton",{
    Visible = false,
    Text = "",
    AutoButtonColor = false,
    Name = "noclickdetector",
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 100),
    ZIndex = 9,
    Parent = dropdownframe
    })
    local dropdowncontainerback = Utility:Render("Frame",{
    Name = "dropdowncontainerback",
    BackgroundTransparency = 0.4000000059604645,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 10,
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = noclickdetector
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = dropdowncontainerback
    })
    local optionContainer = Utility:Render("ScrollingFrame",{
    Active = true,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 0,
    Name = "dropdownoptioncontainer",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ZIndex = 10,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    Parent = dropdowncontainerback
    })
    local UIListLayout = Utility:Render("UIListLayout",{
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = optionContainer
    })
    
    local UIPadding = Utility:Render("UIPadding",{
    PaddingTop = UDim.new(0, 4),
    Parent = optionContainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = optionContainer
    })
    local dropdowntitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = MultiDropdown.Title,
    Name = "dropdowntitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = DropdownContainer
    })
    local dropdowndetector = Utility:Render("TextButton",{
    Text = "",
    Name = "toggledetector",
    Size = UDim2new(1,0,1,0),
    BackgroundTransparency = 1,
    Position = UDim2new(0, 0, 0, 0),
    BorderSizePixel = 0,
    Parent = DropdownContainer
    })
    function MultiDropdown:AddOption(Options)
    if type(Options) ~= "table" then return end
    for _, v in pairs(Options) do
    
    local Option = Utility:Render("TextButton",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = v,
    Name = v,
    Active = false,
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundTransparency = 1,
    Selectable = false,
    BorderSizePixel = 0,
    ZIndex = 10,
    TextSize = 14,
    Parent = optionContainer
    })
    
    Utility:Signal(Option.MouseButton1Down,function()
    MultiDropdown.Value = v
    
    end)
    end  
    end
    function MultiDropdown:Clear()
    for Index, Option in pairs(optionContainer:GetChildren()) do
    if Option:IsA("TextButton") then Option:Destroy() end
    end
    table.clear(MultiDropdown.Options)
    MultiDropdown.Value = ""
    end
    
    Utility:Signal(MultiDropdown:GetPropertyChangedSignal("Value"),function(option)
    task.spawn(function()
    if table.find(MultiDropdown.Default, option) then
    table.remove(MultiDropdown.Default,table.find(MultiDropdown.Default, option))
    dropdownvalue.Text = table.concat(MultiDropdown.Default, ", ")
    MultiDropdown.Callback(MultiDropdown.Default)
    else
    table.insert(MultiDropdown.Default, option)
    dropdownvalue.Text = table.concat(MultiDropdown.Default, ", ")
    MultiDropdown.Callback(MultiDropdown.Default)
    
    end
    Library.Flags[MultiDropdown.Flag] = MultiDropdown.Default
    
    
    for i, v in pairs(optionContainer:GetChildren()) do
    if table.find(MultiDropdown.Default,v.Name) and v:IsA("TextButton") then
    ts:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Accent}):Play()
    Utility:UpdateObject(v, "TextColor3", "Accent")
    
    
    elseif not table.find(MultiDropdown.Default,v.Name) and v:IsA("TextButton") then
    ts:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(v, "TextColor3", "Text_dark")
    end
    end
    end)
    end)
    local waitclick
    
    function MultiDropdown:Open()
    if waitclick then return end 
    waitclick = true 
    if not noclickdetector.Visible then 
    waitclick = false 
    arrow.Rotation = 180;
    ts:Create(dropdowntitle, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_light}):Play()
    Utility:UpdateObject(dropdowntitle, "TextColor3", "Text_light")
    noclickdetector.Visible = true;
    ts:Create(noclickdetector,TweenInfo.new(0.8,Enum.EasingStyle.Exponential), {Size =  UDim2.new(1, 0, 0, 80) }):Play()
    
    Library.Elementsopened[noclickdetector] = true;
    else
    arrow.Rotation = 0;
    ts:Create(dropdowntitle, TweenInfo.new(0.8, Enum.EasingStyle.Exponential),{TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(dropdowntitle, "TextColor3", "Text_dark")
    ts:Create(noclickdetector,TweenInfo.new(0.8,Enum.EasingStyle.Exponential), {Size =  UDim2.new(1, 0, 0, 0) }):Play()
    Library.Elementsopened[noclickdetector] = nil;
    task.delay(0.9,function()
    noclickdetector.Visible = false
    waitclick = false 
    end)
    
    end
    end
    Utility:Signal(dropdowndetector.MouseButton1Down, function()
    if not Utility:MouseIsOverOpenedFrame() then
    MultiDropdown:Open()
    end
    end)
    
    Utility:Signal(UserInputService.InputBegan,function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
    local AbsPos, AbsSize = noclickdetector.AbsolutePosition, noclickdetector.AbsoluteSize;
    
    if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X or Mouse.Y <
    (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then
    
    MultiDropdown.Opened = false
    end
    end
    end);
    
    
    MultiDropdown:AddOption(MultiDropdown.Options)
    
    for _,v in ipairs(MultiDropdown.Startvalue) do MultiDropdown.Value = v  end
    Library.Elements[#Library.Elements + 1] = MultiDropdown
    return MultiDropdown
    end
    function Tabs:Colorpicker(side,properties)
    local side = side == "Left" and self.Side.Left or self.Side.Right
    
    local properties = properties or {}
    local Colorpicker = Utility:GetType(properties, {}, "table", true)
    Colorpicker.IsColorpicker = true
    Colorpicker.Default = Utility:GetType(Colorpicker.Default,color3RGB(144, 244, 244),"Color3")
    Colorpicker.Callback = Utility:GetType(Colorpicker.Callback, function() end,"function")
    Colorpicker.Title = Utility:GetType(Colorpicker.Title,"Colorpicker","string")
    Colorpicker.Flag = Utility:GetType(Colorpicker.Flag,Colorpicker.Title,"string")
    local window = self.window
    
    local Colorpickercontainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "Colorpickercontainer",
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = Colorpickercontainer
    })
    local colorpickerindicator = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    Name = "colorpickerindicator",
    Position = UDim2.new(0.9540983438491821, 0, 0.5, 0),
    Size = UDim2.new(0, 31, 0, 18),
    BorderSizePixel = 0,
    Parent = Colorpickercontainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 4),
    Parent = colorpickerindicator
    })
    local UIAspectRatioConstraint = Utility:Render("UIAspectRatioConstraint",{
    AspectRatio = 1.7222222089767456,
    Parent = colorpickerindicator
    })
    local colorpickertitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Colorpicker.Title,
    Name = "colorpickertitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = Colorpickercontainer
    })
    local noclickdetector = Utility:Render("TextButton", {
    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
    Text = "",
    TextSize = 14,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
    Position = UDim2.new(0, 0, 1.0869567394256592, 0),
    Size = UDim2.new(1, 0, 0, 205),
    ZIndex = 4,
    Parent = Colorpickercontainer
    })
    local ColorpickerPallete = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "colorpickerframe",
    Size = UDim2.new(1, 0, 1,0),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = noclickdetector,
    ZIndex = 5,
    })
    local UIStroke = Utility:Render("UIStroke",{
    Color = "Colorpicker_outline",
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = ColorpickerPallete
    })
    local UICorner = Utility:Render("UICorner",{
    Parent = ColorpickerPallete
    })
    local SvSelection = Utility:Render("ImageButton",{
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0),
    ZIndex = 5,
    Image = "rbxassetid://11970108040",
    Name = "SvSelection",
    Position = UDim2.new(0.5, 0, 0, 14),
    Size = UDim2.new(0, 280, 0, 160),
    BorderSizePixel = 0,
    Parent = ColorpickerPallete
    })
    local svcircle = Utility:Render("Frame",{
    Name = "svcircle",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 80, 0, 0),
    ZIndex = 5,
    
    Size = UDim2.new(0, 6, 0, 6),
    BorderSizePixel = 0,
    Parent = SvSelection
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(1, 0),
    Parent = svcircle
    })
    local UIStroke = Utility:Render("UIStroke",{
    Color = "White",
    Parent = svcircle
    })
    local UICorner = Utility:Render("UICorner",{
    Parent = SvSelection
    })
    local Hueselection = Utility:Render("ImageButton",{
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Name = "Hueselection",
    ZIndex = 5,
    
    Position = UDim2.new(0.5, 0, 0, 184),
    Size = UDim2.new(0.9090909361839294, 0, 0.03875968977808952, 0),
    BorderSizePixel = 0,
    Parent = ColorpickerPallete
    })
    local hcircle = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 80, 0.5, 0),
    Name = "hcircle",
    ZIndex = 5,
    
    Size = UDim2.new(0, 6, 0, 6),
    BorderSizePixel = 0,
    Parent = Hueselection
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(1, 0),
    Parent = hcircle
    })
    local UIStroke = Utility:Render("UIStroke",{
    Color = "White",
    Parent = hcircle
    })
    local UICorner = Utility:Render("UICorner",{
    Parent = Hueselection
    })
    local Gradient = Utility:Render("UIGradient",{
    Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    },
    Name = "Gradient",
    Parent = Hueselection
    })
    
    local ColorpickerDetector = Utility:Render("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = Colorpickercontainer
    })
    function Colorpicker:Show()
    for Frame, Val in next, Library.Elementsopened do
    Frame.Visible = false;
    Library.Elementsopened[Frame] = nil;
    
    end
    
    noclickdetector.Visible = true;
    Library.Elementsopened[noclickdetector] = true;
    end
    
    function Colorpicker:Hide()
    noclickdetector.Visible = false;
    Library.Elementsopened[noclickdetector] = nil;
    
    end
    Utility:Signal(ColorpickerDetector.MouseButton1Click, function()
    if not Utility:MouseIsOverOpenedFrame() then
    if not noclickdetector.Visible then
    Colorpicker:Show()
    else
    Colorpicker:Hide()
    end
    end
    end)
    
    local ColorH = 1 - (math.clamp(hcircle.AbsolutePosition.X -Hueselection.AbsolutePosition.X, 0,Hueselection.AbsolutePosition.X) / Hueselection.AbsolutePosition.X)
    local ColorS = (math.clamp(svcircle.AbsolutePosition.X - SvSelection.AbsolutePosition.X, 0,	SvSelection.AbsoluteSize.X) / SvSelection.AbsoluteSize.X)
    local ColorV = 1 - (math.clamp(svcircle.AbsolutePosition.Y - SvSelection.AbsolutePosition.Y, 0,SvSelection.AbsoluteSize.Y) / SvSelection.AbsoluteSize.Y)
    
    function Colorpicker:UpdateColorPicker()
    colorpickerindicator.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
    SvSelection.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
    svcircle.Position = UDim2new(ColorS, 0, 1 - ColorV, 0)
    hcircle.Position = UDim2new(1 - ColorH, 0, 0.5, 0)
    local result = ("rgb(%s,%s,%s)"):format(ColorH, ColorS, ColorV)
    Library.Flags[Colorpicker.Flag] = result
    
    Colorpicker.Callback(colorpickerindicator.BackgroundColor3)
    end
    
    function Colorpicker:SetHue()
    
    local HueY = (math.clamp(Mouse.X - Hueselection.AbsolutePosition.X, 0,
    Hueselection.AbsoluteSize.X) /
    Hueselection.AbsoluteSize.X)
    
    ColorH = 1 - HueY
    Colorpicker:UpdateColorPicker()
    
    end
    function Colorpicker:SetSaturation()
    local ColorX = (math.clamp(Mouse.X - SvSelection.AbsolutePosition.X, 0,
    SvSelection.AbsoluteSize.X) /
    SvSelection.AbsoluteSize.X)
    local ColorY = (math.clamp(Mouse.Y - SvSelection.AbsolutePosition.Y, 0,
    SvSelection.AbsoluteSize.Y) /
    SvSelection.AbsoluteSize.Y)
    ColorS = ColorX
    ColorV = 1 - ColorY
    Colorpicker:UpdateColorPicker()
    
    end
    function Colorpicker:SetValue(H, S, V)
    
    ColorH = H
    ColorS = S
    ColorV = V
    
    Colorpicker:UpdateColorPicker()
    
    end
    
    Utility:Signal(Colorpicker:GetPropertyChangedSignal("Default"),function(val)
    if typeof(val) == "Color3" then
    
    task.spawn(function()
    local colorh, colors, colorv = val:ToHSV()
    hcircle.Position = UDim2new(1- ColorH, 0, 0.5, 0)
    colorpickerindicator.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
    SvSelection.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
    svcircle.Position = UDim2new(ColorS, 0, 1 - ColorV, 0)
    local result = ("rgb(%s,%s,%s)"):format(colorh, colors, colorv)
    Library.Flags[Colorpicker.Flag] = result
    Colorpicker.Callback(colorpickerindicator.BackgroundColor3)
    
    end)
    
    
    end
    
    end)
    
    Utility:Signal(SvSelection.MouseButton1Down, function()
    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
    task.wait()
    Colorpicker:SetSaturation()
    end
    end)
    
    Utility:Signal(Hueselection.MouseButton1Down, function()
    while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
    task.wait()
    Colorpicker:SetHue()
    end
    end)
    Colorpicker.Default = Colorpicker.Default
    Library.Elements[#Library.Elements + 1] = Colorpicker
    return Colorpicker
    end
    function Tabs:Toggle(side,properties)
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local properties = properties or {}
    local Toggle = Utility:GetType(properties, {}, "table", true)
    Toggle.Title = Utility:GetType(Toggle.Title, "Toggle", "string")
    Toggle.Flag = Utility:GetType(Toggle.Flag, Toggle.Title, "string")
    Toggle.Default = Utility:GetType(Toggle.Default, false, "boolean")
    Toggle.Callback = Utility:GetType(Toggle.Callback, function() end,"function")
    local window = self.window
    
    local ToggleContainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "ToggleContainer",
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = ToggleContainer
    })
    local toggleswitch = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundTransparency = 0.4000000059604645,
    Position = UDim2.new(0.9540983438491821, 0, 0.5, 0),
    Name = "toggleswitch",
    Size = UDim2.new(0, 31, 0, 18),
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = ToggleContainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(1, 0),
    Parent = toggleswitch
    })
    local toggledot = Utility:Render("Frame",{
    AnchorPoint = Vector2.new(1, 0.5),
    Name = "toggledot",
    Position = UDim2.new(0, 16, 0.5, 0),
    Size = UDim2.new(0, 11, 0, 11),
    BorderSizePixel = 0,
    BackgroundColor3 = "ComponentBackground",
    Parent = toggleswitch
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(1, 0),
    Parent = toggledot
    })
    local toggleglow = Utility:Render("ImageLabel",{
    ImageColor3 = "Accent",
    ImageTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Image = "rbxassetid://15488281448",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Name = "toggleglow",
    Size = UDim2.new(2.200000047683716, 0, 3.5, 0),
    SliceCenter = Rect.new(Vector2.new(20, 20), Vector2.new(108, 108)),
    Parent = toggleswitch
    })
    local toggletitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Toggle.Title,
    Name = "toggletitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = ToggleContainer
    })
    local toggledetector = Utility:Render("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = ToggleContainer
    })
    Utility:Signal(Toggle:GetPropertyChangedSignal("Default"),function(value)
    task.spawn(function()
    Library.Flags[Toggle.Flag] = value
    ts:Create(toggleglow, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {ImageTransparency = value and 0.76 or 1}):Play()
    
    ts:Create(toggledot, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {Position = value and UDim2new(1, -3,0.5,0) or UDim2new(0, 16,0.5,0)}):Play()
    ts:Create(toggleswitch, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = value and Utility.Theme.Accent or Utility.Theme.ComponentBackground}):Play()
    ts:Create(toggledot, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = value and Utility.Theme.Accent or Utility.Theme.ComponentBackground}):Play()
    ts:Create(toggletitle, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {TextColor3 = value and Utility.Theme.Text_light or Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(toggleswitch, "BackgroundColor3",value and "Accent" or "ComponentBackground")
    Utility:UpdateObject(toggledot, "BackgroundColor3",value and "Accent" or "ComponentBackground")
    
    Toggle.Callback(value)
    
    end)
    end)
    
    Utility:Signal(toggledetector.MouseButton1Down,function() 
    Toggle.Default = not Toggle.Default
    
    end)
    
    Toggle.Default = Toggle.Default
    Library.Elements[#Library.Elements + 1] = Toggle
    return Toggle
    end
    
    function Tabs:Button(side,properties)
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local properties = properties or {}
    local Button = Utility:GetType(properties, {}, "table", true)
    Button.Title = Utility:GetType(Button.Title, "Toggle", "string")
    Button.Default = Utility:GetType(Button.Default, false, "boolean")
    Button.Callback = Utility:GetType(Button.Callback, function() end,"function")
    local window = self.window
    
    local ButtonContainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "ButtonContainer",
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent = side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = ButtonContainer
    })
    
    local ButtonTitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = Button.Title,
    Name = "toggletitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = ButtonContainer
    })
    local buttondetector = Utility:Render("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Parent = ButtonContainer
    })
    
    
    Utility:Signal(buttondetector.MouseButton1Down,function() Utility.ripple(ButtonContainer,ButtonContainer.Position.X,ButtonContainer.Position.Y)
     Button.Callback()
    
    end)
    
    
    Library.Elements[#Library.Elements + 1] = Button
    return Button
    end
    
    function Tabs:Input(side,properties)
    local side = side == "Left" and self.Side.Left or self.Side.Right
    local properties = properties or {}
    local Input = Utility:GetType(properties, {}, "table", true)
    Input.Title = Utility:GetType(Input.Title, "Input", "string")
    Input.Placeholdertext = Utility:GetType(Input.Placeholdertext,"Input here!", "string")
    Input.Flag = Utility:GetType(Input.Flag, Input.Title, "string")
    Input.Default = Utility:GetType(Input.Default, "", "string")
    Input.Callback = Utility:GetType(Input.Callback, function() end, "function")
    local window = self.window
    
    local Inputcontainer = Utility:Render("Frame",{
    BackgroundTransparency = 0.4000000059604645,
    Name = "Inputcontainer",
    Size = UDim2.new(1, 0, 0, 46),
    BorderSizePixel = 0,
    BackgroundColor3 = "DarkContrast",
    Parent =side
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 9),
    Parent = Inputcontainer
    })
    local inputtitle = Utility:Render("TextLabel",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    TextColor3 = "Text_dark",
    Text = "Text input",
    Name = "inputtitle",
    Size = UDim2.new(0.43278688192367554, 0, 1, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    Position = UDim2.new(0, 13, 0, 0),
    BorderSizePixel = 0,
    TextSize = 14,
    Parent = Inputcontainer
    })
    local textinputbox = Utility:Render("TextBox",{
    FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    Selectable = false,
    AnchorPoint = Vector2.new(1, 0.5),
    TextTruncate = Enum.TextTruncate.SplitWord,
    TextSize = 14,
    Size = UDim2.new(0, 123, 0, 24),
    TextColor3 = "Text_dark",
    Text = "",
    Name = "inputbox",
    Position = UDim2.new(0.9539999961853027, 0, 0.5, 0),
    CursorPosition = -1,
    BorderSizePixel = 0,
    BackgroundTransparency = 0.4000000059604645,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextWrapped = true,
    ClearTextOnFocus = false,
    PlaceholderColor3 = "Text_dark",
    BackgroundColor3 = "ComponentBackground",
    Parent = Inputcontainer
    })
    local UICorner = Utility:Render("UICorner",{
    CornerRadius = UDim.new(0, 6),
    Parent = textinputbox
    })
    Utility:Signal(Input:GetPropertyChangedSignal("Default"),function(value)
    Input.Callback(value)
    Library.Flags[Input.Flag] = value
    textinputbox.Text = value
    
    end)
    Utility:Signal(textinputbox.Focused, function()
    ts:Create(textinputbox,TweenInfo.new(0.5,Enum.EasingStyle.Exponential), {TextColor3 = Utility.Theme.Text_light}):Play()
    ts:Create(inputtitle,TweenInfo.new(0.5,Enum.EasingStyle.Exponential), {TextColor3 = Utility.Theme.Text_light}):Play()
    Utility:UpdateObject(textinputbox, "TextColor3","Text_light")
    Utility:UpdateObject(inputtitle, "TextColor3","Text_light")
    end)
    
    Utility:Signal(textinputbox.FocusLost, function()
    ts:Create(textinputbox,TweenInfo.new(0.5,Enum.EasingStyle.Exponential), {TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(textinputbox, "TextColor3","Text_dark")
    ts:Create(inputtitle,TweenInfo.new(0.5,Enum.EasingStyle.Exponential), {TextColor3 = Utility.Theme.Text_dark}):Play()
    Utility:UpdateObject(inputtitle, "TextColor3","Text_dark")
    Input.Default = textinputbox.Text
    
    end)
    
    Library.Elements[#Library.Elements + 1] = Input
    Input.Default = Input.Default
    return Input
    end
    
    return Library
