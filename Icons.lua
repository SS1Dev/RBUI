--[[
    UIFramework Icons
    Image-based icons for Roblox UI (Lucide-style)
    
    Usage: 
        Icons.Get("home") -- returns asset ID
        Icons.CreateImage("home", 16, Color3.new(1,1,1)) -- returns ImageLabel
    
    Note: Uses Roblox Image Assets. You can upload Lucide icons to Roblox
    and add them using Icons.Set("name", "rbxassetid://...")
    
    Lucide Icons: https://lucide.dev/icons/
]]

local Icons = {}

-- ═══════════════════════════════════════════════════════════════
-- ICON ASSET LIBRARY (Roblox Asset IDs)
-- Upload Lucide icons to Roblox and replace these IDs
-- ═══════════════════════════════════════════════════════════════

Icons.Assets = {
    -- Navigation
    ["home"] = "rbxassetid://7733960981",
    ["arrow-left"] = "rbxassetid://7733715533",
    ["arrow-right"] = "rbxassetid://7733717555",
    ["arrow-up"] = "rbxassetid://7733718324",
    ["arrow-down"] = "rbxassetid://7733715017",
    ["chevron-left"] = "rbxassetid://7733770905",
    ["chevron-right"] = "rbxassetid://7733771136",
    ["chevron-up"] = "rbxassetid://7733771360",
    ["chevron-down"] = "rbxassetid://7733770678",
    ["menu"] = "rbxassetid://7733985004",
    ["x"] = "rbxassetid://7734158475",
    ["check"] = "rbxassetid://7733769256",
    
    -- Actions
    ["plus"] = "rbxassetid://7734024986",
    ["minus"] = "rbxassetid://7733988158",
    ["pencil"] = "rbxassetid://7734019595",
    ["trash"] = "rbxassetid://7734115313",
    ["trash-2"] = "rbxassetid://7734115476",
    ["copy"] = "rbxassetid://7733784220",
    ["clipboard"] = "rbxassetid://7733776200",
    ["save"] = "rbxassetid://7734048706",
    ["download"] = "rbxassetid://7733800489",
    ["upload"] = "rbxassetid://7734126126",
    ["refresh-cw"] = "rbxassetid://7734037040",
    ["rotate-cw"] = "rbxassetid://7734045149",
    ["undo"] = "rbxassetid://7734120867",
    ["redo"] = "rbxassetid://7734036195",
    ["external-link"] = "rbxassetid://7733819098",
    
    -- User & Account
    ["user"] = "rbxassetid://7734126869",
    ["users"] = "rbxassetid://7734127624",
    ["user-plus"] = "rbxassetid://7734127224",
    ["user-minus"] = "rbxassetid://7734127067",
    ["user-x"] = "rbxassetid://7734127394",
    ["user-check"] = "rbxassetid://7734126995",
    ["circle-user"] = "rbxassetid://7733774940",
    
    -- Communication
    ["mail"] = "rbxassetid://7733983017",
    ["message-square"] = "rbxassetid://7733987023",
    ["message-circle"] = "rbxassetid://7733986707",
    ["bell"] = "rbxassetid://7733756094",
    ["bell-off"] = "rbxassetid://7733755886",
    ["phone"] = "rbxassetid://7734021395",
    ["send"] = "rbxassetid://7734050684",
    
    -- Media
    ["image"] = "rbxassetid://7733964174",
    ["video"] = "rbxassetid://7734130082",
    ["music"] = "rbxassetid://7733993186",
    ["play"] = "rbxassetid://7734024005",
    ["pause"] = "rbxassetid://7734016877",
    ["square"] = "rbxassetid://7734086697",
    ["skip-forward"] = "rbxassetid://7734068168",
    ["skip-back"] = "rbxassetid://7734067973",
    ["volume-2"] = "rbxassetid://7734134339",
    ["volume-1"] = "rbxassetid://7734134154",
    ["volume-x"] = "rbxassetid://7734134557",
    ["mic"] = "rbxassetid://7733987416",
    ["mic-off"] = "rbxassetid://7733987257",
    
    -- Files & Folders
    ["file"] = "rbxassetid://7733827619",
    ["file-text"] = "rbxassetid://7733830089",
    ["folder"] = "rbxassetid://7733848215",
    ["folder-open"] = "rbxassetid://7733848025",
    ["folder-plus"] = "rbxassetid://7733848082",
    
    -- Settings & Tools
    ["settings"] = "rbxassetid://7734052533",
    ["sliders"] = "rbxassetid://7734070467",
    ["wrench"] = "rbxassetid://7734157609",
    ["tool"] = "rbxassetid://7734109612",
    ["hammer"] = "rbxassetid://7733955548",
    ["palette"] = "rbxassetid://7734012330",
    ["cog"] = "rbxassetid://7734052533",
    
    -- Security
    ["lock"] = "rbxassetid://7733981020",
    ["unlock"] = "rbxassetid://7734121543",
    ["key"] = "rbxassetid://7733970958",
    ["shield"] = "rbxassetid://7734059419",
    ["shield-check"] = "rbxassetid://7734059254",
    ["shield-off"] = "rbxassetid://7734059347",
    
    -- Status & Feedback
    ["check-circle"] = "rbxassetid://7733769090",
    ["x-circle"] = "rbxassetid://7734158299",
    ["info"] = "rbxassetid://7733967106",
    ["alert-circle"] = "rbxassetid://7733712282",
    ["alert-triangle"] = "rbxassetid://7733712507",
    ["loader"] = "rbxassetid://7733979600",
    ["loader-2"] = "rbxassetid://7733979737",
    
    -- Objects
    ["star"] = "rbxassetid://7734088009",
    ["heart"] = "rbxassetid://7733958466",
    ["bookmark"] = "rbxassetid://7733758900",
    ["flag"] = "rbxassetid://7733838702",
    ["tag"] = "rbxassetid://7734100458",
    ["calendar"] = "rbxassetid://7733764018",
    ["clock"] = "rbxassetid://7733777116",
    ["map-pin"] = "rbxassetid://7733984151",
    ["map"] = "rbxassetid://7733983935",
    ["compass"] = "rbxassetid://7733781867",
    
    -- E-commerce
    ["shopping-cart"] = "rbxassetid://7734062988",
    ["shopping-bag"] = "rbxassetid://7734062755",
    ["credit-card"] = "rbxassetid://7733787466",
    ["dollar-sign"] = "rbxassetid://7733797979",
    ["gift"] = "rbxassetid://7733937948",
    ["package"] = "rbxassetid://7734010178",
    
    -- Charts & Data
    ["bar-chart"] = "rbxassetid://7733751116",
    ["bar-chart-2"] = "rbxassetid://7733751247",
    ["pie-chart"] = "rbxassetid://7734022280",
    ["trending-up"] = "rbxassetid://7734115789",
    ["trending-down"] = "rbxassetid://7734115640",
    ["activity"] = "rbxassetid://7733706827",
    ["database"] = "rbxassetid://7733791316",
    ["server"] = "rbxassetid://7734052871",
    
    -- Social
    ["share"] = "rbxassetid://7734054359",
    ["share-2"] = "rbxassetid://7734054516",
    ["link"] = "rbxassetid://7733975971",
    ["link-2"] = "rbxassetid://7733976181",
    ["globe"] = "rbxassetid://7733946632",
    
    -- Layout
    ["layout-grid"] = "rbxassetid://7733972761",
    ["layout-list"] = "rbxassetid://7733972873",
    ["grid"] = "rbxassetid://7733950704",
    ["list"] = "rbxassetid://7733978115",
    ["columns"] = "rbxassetid://7733780475",
    ["rows"] = "rbxassetid://7734046227",
    ["sidebar"] = "rbxassetid://7734064155",
    ["panel-left"] = "rbxassetid://7734012771",
    ["panel-right"] = "rbxassetid://7734013000",
    
    -- Misc
    ["search"] = "rbxassetid://7734049657",
    ["filter"] = "rbxassetid://7733837422",
    ["sort-asc"] = "rbxassetid://7734078424",
    ["sort-desc"] = "rbxassetid://7734078569",
    ["more-horizontal"] = "rbxassetid://7733990636",
    ["more-vertical"] = "rbxassetid://7733990855",
    ["grip-vertical"] = "rbxassetid://7733953092",
    ["move"] = "rbxassetid://7733992107",
    ["eye"] = "rbxassetid://7733823304",
    ["eye-off"] = "rbxassetid://7733823138",
    ["power"] = "rbxassetid://7734026377",
    ["maximize"] = "rbxassetid://7733985587",
    ["minimize"] = "rbxassetid://7733988022",
    ["maximize-2"] = "rbxassetid://7733985774",
    ["minimize-2"] = "rbxassetid://7733988346",
    
    -- Game Related
    ["gamepad"] = "rbxassetid://7733932108",
    ["gamepad-2"] = "rbxassetid://7733932286",
    ["trophy"] = "rbxassetid://7734116008",
    ["award"] = "rbxassetid://7733745179",
    ["crown"] = "rbxassetid://7733788203",
    ["target"] = "rbxassetid://7734100757",
    ["crosshair"] = "rbxassetid://7733787876",
    ["zap"] = "rbxassetid://7734159155",
    ["flame"] = "rbxassetid://7733838451",
    ["snowflake"] = "rbxassetid://7734072127",
    ["droplet"] = "rbxassetid://7733801397",
    ["sun"] = "rbxassetid://7734095209",
    ["moon"] = "rbxassetid://7733989644",
    ["cloud"] = "rbxassetid://7733778524",
    ["wind"] = "rbxassetid://7734152188",
    ["ghost"] = "rbxassetid://7733936939",
    ["skull"] = "rbxassetid://7734069170",
    ["sword"] = "rbxassetid://7734098377",
    ["swords"] = "rbxassetid://7734098639",
    ["keyboard"] = "rbxassetid://7733971258",
    ["mouse"] = "rbxassetid://7733991356",
    
    -- Development
    ["code"] = "rbxassetid://7733779096",
    ["code-2"] = "rbxassetid://7733779204",
    ["terminal"] = "rbxassetid://7734103666",
    ["bug"] = "rbxassetid://7733759937",
    ["git-branch"] = "rbxassetid://7733938739",
    ["git-commit"] = "rbxassetid://7733938885",
    ["git-merge"] = "rbxassetid://7733939045",
    ["box"] = "rbxassetid://7733759308",
    ["layers"] = "rbxassetid://7733972186",
    ["component"] = "rbxassetid://7733781387",
    ["puzzle"] = "rbxassetid://7734031888",
    
    -- Arrows & Direction
    ["arrow-up-right"] = "rbxassetid://7733718112",
    ["arrow-down-left"] = "rbxassetid://7733715247",
    ["arrow-up-left"] = "rbxassetid://7733717935",
    ["arrow-down-right"] = "rbxassetid://7733715411",
    ["corner-up-left"] = "rbxassetid://7733786123",
    ["corner-up-right"] = "rbxassetid://7733786270",
    ["corner-down-left"] = "rbxassetid://7733785776",
    ["corner-down-right"] = "rbxassetid://7733785928",
    ["move-horizontal"] = "rbxassetid://7733992262",
    ["move-vertical"] = "rbxassetid://7733992471",
    
    -- Toggle/Switch
    ["toggle-left"] = "rbxassetid://7734108355",
    ["toggle-right"] = "rbxassetid://7734108478",
    ["circle"] = "rbxassetid://7733774677",
    ["circle-dot"] = "rbxassetid://7733774800",
    ["square-check"] = "rbxassetid://7734086541", -- For checkbox checked
    ["square"] = "rbxassetid://7734086697", -- For checkbox unchecked
    
    -- Window Controls
    ["x-small"] = "rbxassetid://7734158475",
    ["minus-small"] = "rbxassetid://7733988158",
    ["maximize-small"] = "rbxassetid://7733985587",
    
    -- Misc UI
    ["grip"] = "rbxassetid://7733952907",
    ["separator-horizontal"] = "rbxassetid://7734051781",
    ["separator-vertical"] = "rbxassetid://7734051941",
    ["corner-down-right-resize"] = "rbxassetid://7733785928",
    ["sparkles"] = "rbxassetid://7734080889",
    ["wand"] = "rbxassetid://7734136785",
    ["wand-2"] = "rbxassetid://7734137039",
}

-- Default/Fallback icon
Icons.Default = "rbxassetid://7733967106" -- info icon

-- ═══════════════════════════════════════════════════════════════
-- ICON FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Get icon asset ID by name
function Icons.Get(name)
    return Icons.Assets[name] or Icons.Default
end

-- Check if icon exists
function Icons.Exists(name)
    return Icons.Assets[name] ~= nil
end

-- Set/Add custom icon
function Icons.Set(name, assetId)
    Icons.Assets[name] = assetId
end

-- Remove icon
function Icons.Remove(name)
    Icons.Assets[name] = nil
end

-- Get all icon names
function Icons.GetAll()
    local names = {}
    for name, _ in pairs(Icons.Assets) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

-- ═══════════════════════════════════════════════════════════════
-- ICON CREATION FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Create ImageLabel for icon
function Icons.CreateImage(iconName, size, color)
    local assetId = type(iconName) == "string" and Icons.Get(iconName) or iconName
    
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size or 16, 0, size or 16)
    icon.Image = assetId
    icon.ImageColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.ScaleType = Enum.ScaleType.Fit
    return icon
end

-- Create ImageButton for clickable icon
function Icons.CreateButton(iconName, size, color)
    local assetId = type(iconName) == "string" and Icons.Get(iconName) or iconName
    
    local icon = Instance.new("ImageButton")
    icon.Name = "IconButton"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size or 16, 0, size or 16)
    icon.Image = assetId
    icon.ImageColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.ScaleType = Enum.ScaleType.Fit
    icon.AutoButtonColor = false
    return icon
end

-- ═══════════════════════════════════════════════════════════════
-- BULK OPERATIONS
-- ═══════════════════════════════════════════════════════════════

-- Load icons from a table
function Icons.LoadLibrary(iconTable)
    for name, assetId in pairs(iconTable) do
        Icons.Assets[name] = assetId
    end
end

-- Set default icon
function Icons.SetDefault(assetId)
    Icons.Default = assetId
end

-- Clear all icons
function Icons.Clear()
    Icons.Assets = {}
end

return Icons
