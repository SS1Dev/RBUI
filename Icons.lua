--[[
    UIFramework Icons
    Text-based icons using Symbols and Emojis
    
    Usage: 
        Icons.Get("home") -- returns emoji/symbol
        Icons.CreateLabel("home", 16, Color3.new(1,1,1)) -- returns TextLabel
]]

local Icons = {}

-- ═══════════════════════════════════════════════════════════════
-- ICON LIBRARY (Symbols & Emojis)
-- ═══════════════════════════════════════════════════════════════

Icons.Map = {
    -- Navigation
    ["home"] = "🏠",
    ["dashboard"] = "📊",
    ["menu"] = "☰",
    ["settings"] = "⚙",
    ["gear"] = "⚙",
    ["cog"] = "⚙",
    ["search"] = "🔍",
    ["filter"] = "🔍",
    
    -- Actions
    ["check"] = "✓",
    ["xmark"] = "✕",
    ["x"] = "✕",
    ["plus"] = "+",
    ["minus"] = "−",
    ["edit"] = "✎",
    ["trash"] = "🗑",
    ["delete"] = "🗑",
    ["save"] = "💾",
    ["download"] = "⬇",
    ["upload"] = "⬆",
    ["refresh"] = "↻",
    ["sync"] = "↻",
    ["copy"] = "📋",
    ["paste"] = "📋",
    ["cut"] = "✂",
    ["undo"] = "↶",
    ["redo"] = "↷",
    
    -- Arrows
    ["arrow-up"] = "↑",
    ["arrow-down"] = "↓",
    ["arrow-left"] = "←",
    ["arrow-right"] = "→",
    ["chevron-up"] = "▲",
    ["chevron-down"] = "▼",
    ["chevron-left"] = "◀",
    ["chevron-right"] = "▶",
    ["forward"] = "→",
    ["backward"] = "←",
    ["arrows-left-right"] = "⇔",
    ["external-link"] = "↗",
    
    -- Media
    ["play"] = "▶",
    ["pause"] = "⏸",
    ["stop"] = "⏹",
    ["music"] = "♪",
    ["volume-high"] = "🔊",
    ["volume-low"] = "🔈",
    ["volume-off"] = "🔇",
    ["video"] = "🎬",
    ["image"] = "🖼",
    ["camera"] = "📷",
    
    -- Communication
    ["bell"] = "🔔",
    ["envelope"] = "✉",
    ["mail"] = "✉",
    ["message"] = "💬",
    ["comments"] = "💬",
    ["phone"] = "📞",
    ["send"] = "➤",
    
    -- User
    ["user"] = "👤",
    ["users"] = "👥",
    ["user-gear"] = "👤",
    
    -- Status
    ["circle-check"] = "✓",
    ["circle-xmark"] = "✕",
    ["circle-info"] = "ℹ",
    ["triangle-exclamation"] = "⚠",
    ["warning"] = "⚠",
    ["info"] = "ℹ",
    ["success"] = "✓",
    ["error"] = "✕",
    
    -- Objects
    ["star"] = "★",
    ["heart"] = "♥",
    ["flag"] = "⚑",
    ["bookmark"] = "🔖",
    ["lock"] = "🔒",
    ["unlock"] = "🔓",
    ["key"] = "🔑",
    ["eye"] = "👁",
    ["eye-slash"] = "◌",
    ["globe"] = "🌐",
    ["bolt"] = "⚡",
    ["power"] = "⏻",
    ["zap"] = "⚡",
    ["sun"] = "☀",
    ["moon"] = "🌙",
    ["cloud"] = "☁",
    ["fire"] = "🔥",
    ["snowflake"] = "❄",
    ["water"] = "💧",
    
    -- Files
    ["file"] = "📄",
    ["folder"] = "📁",
    ["folder-open"] = "📂",
    ["clipboard"] = "📋",
    ["clipboard-list"] = "📋",
    ["list-check"] = "☑",
    
    -- Gaming
    ["gamepad"] = "🎮",
    ["trophy"] = "🏆",
    ["crown"] = "👑",
    ["swords"] = "⚔",
    ["target"] = "🎯",
    
    -- Layout
    ["grid"] = "⊞",
    ["list"] = "☰",
    ["layers"] = "▤",
    ["layer-group"] = "▤",
    ["expand"] = "⤢",
    ["minimize"] = "−",
    ["maximize"] = "□",
    
    -- Tech
    ["code"] = "</>",
    ["terminal"] = ">_",
    ["database"] = "🗃",
    ["server"] = "🖥",
    ["keyboard"] = "⌨",
    
    -- Misc
    ["palette"] = "🎨",
    ["brush"] = "🖌",
    ["gift"] = "🎁",
    ["package"] = "📦",
    ["box"] = "📦",
    ["cube"] = "📦",
    ["cubes"] = "📦",
    ["tag"] = "🏷",
    ["dollar"] = "💲",
    ["coins"] = "🪙",
    ["cart"] = "🛒",
    ["spinner"] = "◌",
    ["loading"] = "◌",
    ["ghost"] = "👻",
    ["icons"] = "🔣",
    ["sliders"] = "☰",
    ["toggle-on"] = "⊙",
    ["font"] = "A",
    ["hand-pointer"] = "👆",
    ["square-check"] = "☑",
    ["exchange"] = "⇄",
    ["map"] = "🗺",
    ["location-dot"] = "📍",
    ["chart-line"] = "📈",
    ["chart-bar"] = "📊",
    ["pie-chart"] = "📊",
    ["trending-up"] = "📈",
    ["trending-down"] = "📉",
    
    -- Default
    ["default"] = "●"
}

-- Default icon
Icons.Default = "●"

-- ═══════════════════════════════════════════════════════════════
-- ICON FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Get icon symbol/emoji by name
function Icons.Get(name)
    return Icons.Map[name] or Icons.Default
end

-- Check if icon exists
function Icons.Exists(name)
    return Icons.Map[name] ~= nil
end

-- Set/Add custom icon
function Icons.Set(name, symbol)
    Icons.Map[name] = symbol
end

-- Remove icon
function Icons.Remove(name)
    Icons.Map[name] = nil
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

-- ═══════════════════════════════════════════════════════════════
-- ICON CREATION FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Create TextLabel for icon
function Icons.CreateLabel(iconName, size, color)
    size = size or 16
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size, 0, size)
    icon.Text = Icons.Get(iconName)
    icon.TextColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.TextSize = size * 0.85
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    return icon
end

-- Create TextButton for clickable icon
function Icons.CreateButton(iconName, size, color)
    size = size or 16
    local icon = Instance.new("TextButton")
    icon.Name = "IconButton"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size, 0, size)
    icon.Text = Icons.Get(iconName)
    icon.TextColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.TextSize = size * 0.85
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    icon.AutoButtonColor = false
    return icon
end

-- ═══════════════════════════════════════════════════════════════
-- BULK OPERATIONS
-- ═══════════════════════════════════════════════════════════════

-- Load icons from a table
function Icons.LoadLibrary(iconTable)
    for name, symbol in pairs(iconTable) do
        Icons.Map[name] = symbol
    end
end

-- Set default icon
function Icons.SetDefault(symbol)
    Icons.Default = symbol
end

-- Clear all icons
function Icons.Clear()
    Icons.Map = {}
end

return Icons
