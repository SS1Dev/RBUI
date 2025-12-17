--[[
    UIFramework Icons
    Simple text-based icons for Roblox UI
    
    Usage: Icons.Get("home") or Icons["home"]
    
    Note: Uses simple text symbols and emojis that work in Roblox.
    For custom icons, use Icons.CreateImage() with Roblox Asset IDs.
]]

local Icons = {}

-- Simple Text Icons (works in Roblox)
Icons.Map = {
    -- Navigation
    ["home"] = "🏠",
    ["arrow-left"] = "←",
    ["arrow-right"] = "→",
    ["arrow-up"] = "↑",
    ["arrow-down"] = "↓",
    ["chevron-left"] = "‹",
    ["chevron-right"] = "›",
    ["chevron-up"] = "^",
    ["chevron-down"] = "v",
    ["angles-left"] = "«",
    ["angles-right"] = "»",
    ["bars"] = "☰",
    ["xmark"] = "✕",
    ["check"] = "✓",
    
    -- Actions
    ["plus"] = "+",
    ["minus"] = "−",
    ["edit"] = "✎",
    ["trash"] = "🗑",
    ["copy"] = "📋",
    ["paste"] = "📄",
    ["save"] = "💾",
    ["download"] = "⬇",
    ["upload"] = "⬆",
    ["refresh"] = "↻",
    ["sync"] = "⟳",
    ["undo"] = "↩",
    ["redo"] = "↪",
    
    -- User & Account
    ["user"] = "👤",
    ["users"] = "👥",
    ["user-plus"] = "👤+",
    ["user-minus"] = "👤-",
    ["user-gear"] = "👤⚙",
    ["circle-user"] = "◉",
    
    -- Communication
    ["envelope"] = "✉",
    ["message"] = "💬",
    ["comment"] = "💭",
    ["comments"] = "🗨",
    ["bell"] = "🔔",
    ["phone"] = "📞",
    
    -- Media
    ["image"] = "🖼",
    ["video"] = "🎬",
    ["music"] = "♫",
    ["play"] = "▶",
    ["pause"] = "⏸",
    ["stop"] = "■",
    ["forward"] = "⏩",
    ["backward"] = "⏪",
    ["volume-high"] = "🔊",
    ["volume-low"] = "🔉",
    ["volume-off"] = "🔈",
    ["volume-xmark"] = "🔇",
    
    -- Files & Folders
    ["file"] = "📄",
    ["file-lines"] = "📝",
    ["folder"] = "📁",
    ["folder-open"] = "📂",
    
    -- Settings & Tools
    ["gear"] = "⚙",
    ["gears"] = "⚙⚙",
    ["sliders"] = "☰",
    ["wrench"] = "🔧",
    ["screwdriver"] = "🔧",
    ["hammer"] = "🔨",
    ["toolbox"] = "🧰",
    ["palette"] = "🎨",
    
    -- Security
    ["lock"] = "🔒",
    ["lock-open"] = "🔓",
    ["key"] = "🔑",
    ["shield"] = "🛡",
    ["shield-halved"] = "🛡",
    
    -- Status & Feedback
    ["circle-check"] = "✅",
    ["circle-xmark"] = "❌",
    ["circle-info"] = "ℹ",
    ["circle-exclamation"] = "⚠",
    ["triangle-exclamation"] = "⚠",
    ["spinner"] = "◌",
    
    -- Objects
    ["star"] = "★",
    ["heart"] = "♥",
    ["bookmark"] = "🔖",
    ["flag"] = "🚩",
    ["tag"] = "🏷",
    ["tags"] = "🏷",
    ["calendar"] = "📅",
    ["clock"] = "🕐",
    ["location-dot"] = "📍",
    ["map"] = "🗺",
    
    -- E-commerce
    ["cart-shopping"] = "🛒",
    ["bag-shopping"] = "🛍",
    ["credit-card"] = "💳",
    ["money-bill"] = "💵",
    ["coins"] = "🪙",
    ["gift"] = "🎁",
    
    -- Charts & Data
    ["chart-line"] = "📈",
    ["chart-bar"] = "📊",
    ["chart-pie"] = "📉",
    ["table"] = "▦",
    ["database"] = "🗄",
    
    -- Social
    ["share"] = "↗",
    ["share-nodes"] = "🔗",
    ["link"] = "🔗",
    ["globe"] = "🌐",
    
    -- Misc
    ["search"] = "🔍",
    ["magnifying-glass"] = "🔍",
    ["filter"] = "⧩",
    ["sort"] = "⇅",
    ["ellipsis"] = "···",
    ["ellipsis-vertical"] = "⋮",
    ["grip-vertical"] = "⋮⋮",
    ["grip"] = "⋮⋮",
    ["eye"] = "👁",
    ["eye-slash"] = "👁‍🗨",
    ["power-off"] = "⏻",
    ["expand"] = "⤢",
    ["compress"] = "⤡",
    ["maximize"] = "□",
    ["minimize"] = "─",
    ["arrows-left-right"] = "↔",
    
    -- Game Related
    ["gamepad"] = "🎮",
    ["trophy"] = "🏆",
    ["medal"] = "🏅",
    ["crown"] = "👑",
    ["dice"] = "🎲",
    ["puzzle-piece"] = "🧩",
    ["robot"] = "🤖",
    ["swords"] = "⚔",
    ["bolt"] = "⚡",
    ["snowflake"] = "❄",
    ["water"] = "💧",
    ["sun"] = "☀",
    ["moon"] = "🌙",
    ["ghost"] = "👻",
    ["keyboard"] = "⌨",
    ["exchange"] = "⇄",
    
    -- Panel Specific
    ["dashboard"] = "📊",
    ["list"] = "☰",
    ["list-check"] = "☑",
    ["clipboard"] = "📋",
    ["clipboard-list"] = "📋",
    ["layer-group"] = "☷",
    ["cubes"] = "▣",
    ["server"] = "🖥",
    ["code"] = "</>",
    ["terminal"] = ">_",
    ["bug"] = "🐛",
    ["info"] = "ℹ",
    ["icons"] = "◈",
}

-- Get icon by name
function Icons.Get(name)
    return Icons.Map[name] or Icons.Map["circle-exclamation"] or "?"
end

-- Check if icon exists
function Icons.Exists(name)
    return Icons.Map[name] ~= nil
end

-- Create icon label (returns TextLabel configured for icon)
function Icons.CreateLabel(iconName, size, color)
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size or 16, 0, size or 16)
    icon.Font = Enum.Font.GothamMedium
    icon.Text = Icons.Get(iconName)
    icon.TextColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.TextSize = size or 16
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    return icon
end

-- Create ImageLabel for icon (use Roblox Asset IDs)
-- Example: Icons.CreateImage("rbxassetid://1234567890", 16, Color3.new(1,1,1))
function Icons.CreateImage(imageId, size, color)
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size or 16, 0, size or 16)
    icon.Image = imageId
    icon.ImageColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.ScaleType = Enum.ScaleType.Fit
    return icon
end

-- Add custom icon
function Icons.Add(name, symbol)
    Icons.Map[name] = symbol
end

-- Get all icon names
function Icons.GetAll()
    local names = {}
    for name, _ in pairs(Icons.Map) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

return Icons
