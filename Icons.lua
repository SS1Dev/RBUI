--[[
    UIFramework Icons
    Font Awesome Free Icons (Unicode Characters)
    
    Usage: Icons.Get("home") or Icons["home"]
    
    Note: Roblox uses custom font rendering, so we map Font Awesome
    icon names to their unicode characters for use with FontAwesome font.
]]

local Icons = {}

-- Font Awesome Free Icons (Solid)
Icons.Map = {
    -- Navigation
    ["home"] = "\u{f015}",
    ["arrow-left"] = "\u{f060}",
    ["arrow-right"] = "\u{f061}",
    ["arrow-up"] = "\u{f062}",
    ["arrow-down"] = "\u{f063}",
    ["chevron-left"] = "\u{f053}",
    ["chevron-right"] = "\u{f054}",
    ["chevron-up"] = "\u{f077}",
    ["chevron-down"] = "\u{f078}",
    ["angles-left"] = "\u{f100}",
    ["angles-right"] = "\u{f101}",
    ["bars"] = "\u{f0c9}",
    ["xmark"] = "\u{f00d}",
    ["check"] = "\u{f00c}",
    
    -- Actions
    ["plus"] = "\u{f067}",
    ["minus"] = "\u{f068}",
    ["edit"] = "\u{f044}",
    ["trash"] = "\u{f1f8}",
    ["copy"] = "\u{f0c5}",
    ["paste"] = "\u{f0ea}",
    ["save"] = "\u{f0c7}",
    ["download"] = "\u{f019}",
    ["upload"] = "\u{f093}",
    ["refresh"] = "\u{f021}",
    ["sync"] = "\u{f2f1}",
    ["undo"] = "\u{f0e2}",
    ["redo"] = "\u{f01e}",
    
    -- User & Account
    ["user"] = "\u{f007}",
    ["users"] = "\u{f0c0}",
    ["user-plus"] = "\u{f234}",
    ["user-minus"] = "\u{f503}",
    ["user-gear"] = "\u{f4fe}",
    ["circle-user"] = "\u{f2bd}",
    
    -- Communication
    ["envelope"] = "\u{f0e0}",
    ["message"] = "\u{f27a}",
    ["comment"] = "\u{f075}",
    ["comments"] = "\u{f086}",
    ["bell"] = "\u{f0f3}",
    ["phone"] = "\u{f095}",
    
    -- Media
    ["image"] = "\u{f03e}",
    ["video"] = "\u{f03d}",
    ["music"] = "\u{f001}",
    ["play"] = "\u{f04b}",
    ["pause"] = "\u{f04c}",
    ["stop"] = "\u{f04d}",
    ["forward"] = "\u{f04e}",
    ["backward"] = "\u{f04a}",
    ["volume-high"] = "\u{f028}",
    ["volume-low"] = "\u{f027}",
    ["volume-off"] = "\u{f026}",
    ["volume-xmark"] = "\u{f6a9}",
    
    -- Files & Folders
    ["file"] = "\u{f15b}",
    ["file-lines"] = "\u{f15c}",
    ["folder"] = "\u{f07b}",
    ["folder-open"] = "\u{f07c}",
    
    -- Settings & Tools
    ["gear"] = "\u{f013}",
    ["gears"] = "\u{f085}",
    ["sliders"] = "\u{f1de}",
    ["wrench"] = "\u{f0ad}",
    ["screwdriver"] = "\u{f54a}",
    ["hammer"] = "\u{f6e3}",
    ["toolbox"] = "\u{f552}",
    
    -- Security
    ["lock"] = "\u{f023}",
    ["lock-open"] = "\u{f3c1}",
    ["key"] = "\u{f084}",
    ["shield"] = "\u{f132}",
    ["shield-halved"] = "\u{f3ed}",
    
    -- Status & Feedback
    ["circle-check"] = "\u{f058}",
    ["circle-xmark"] = "\u{f057}",
    ["circle-info"] = "\u{f05a}",
    ["circle-exclamation"] = "\u{f06a}",
    ["triangle-exclamation"] = "\u{f071}",
    ["spinner"] = "\u{f110}",
    
    -- Objects
    ["star"] = "\u{f005}",
    ["heart"] = "\u{f004}",
    ["bookmark"] = "\u{f02e}",
    ["flag"] = "\u{f024}",
    ["tag"] = "\u{f02b}",
    ["tags"] = "\u{f02c}",
    ["calendar"] = "\u{f133}",
    ["clock"] = "\u{f017}",
    ["location-dot"] = "\u{f3c5}",
    ["map"] = "\u{f279}",
    
    -- E-commerce
    ["cart-shopping"] = "\u{f07a}",
    ["bag-shopping"] = "\u{f290}",
    ["credit-card"] = "\u{f09d}",
    ["money-bill"] = "\u{f0d6}",
    ["coins"] = "\u{f51e}",
    ["gift"] = "\u{f06b}",
    
    -- Charts & Data
    ["chart-line"] = "\u{f201}",
    ["chart-bar"] = "\u{f080}",
    ["chart-pie"] = "\u{f200}",
    ["table"] = "\u{f0ce}",
    ["database"] = "\u{f1c0}",
    
    -- Social
    ["share"] = "\u{f064}",
    ["share-nodes"] = "\u{f1e0}",
    ["link"] = "\u{f0c1}",
    ["globe"] = "\u{f0ac}",
    
    -- Misc
    ["search"] = "\u{f002}",
    ["magnifying-glass"] = "\u{f002}",
    ["filter"] = "\u{f0b0}",
    ["sort"] = "\u{f0dc}",
    ["ellipsis"] = "\u{f141}",
    ["ellipsis-vertical"] = "\u{f142}",
    ["grip-vertical"] = "\u{f58e}",
    ["grip"] = "\u{f58d}",
    ["eye"] = "\u{f06e}",
    ["eye-slash"] = "\u{f070}",
    ["power-off"] = "\u{f011}",
    ["expand"] = "\u{f065}",
    ["compress"] = "\u{f066}",
    ["maximize"] = "\u{f31e}",
    ["minimize"] = "\u{f2d1}",
    
    -- Game Related
    ["gamepad"] = "\u{f11b}",
    ["trophy"] = "\u{f091}",
    ["medal"] = "\u{f5a2}",
    ["crown"] = "\u{f521}",
    ["dice"] = "\u{f522}",
    ["puzzle-piece"] = "\u{f12e}",
    ["robot"] = "\u{f544}",
    
    -- Panel Specific
    ["dashboard"] = "\u{f3fd}",
    ["list"] = "\u{f03a}",
    ["list-check"] = "\u{f0ae}",
    ["clipboard"] = "\u{f328}",
    ["clipboard-list"] = "\u{f46d}",
    ["layer-group"] = "\u{f5fd}",
    ["cubes"] = "\u{f1b3}",
    ["server"] = "\u{f233}",
    ["code"] = "\u{f121}",
    ["terminal"] = "\u{f120}",
    ["bug"] = "\u{f188}",
}

-- Get icon by name
function Icons.Get(name)
    return Icons.Map[name] or Icons.Map["circle-exclamation"]
end

-- Create icon label (returns TextLabel configured for icon)
function Icons.CreateLabel(iconName, size, color)
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, size or 16, 0, size or 16)
    icon.Font = Enum.Font.GothamMedium -- Fallback font
    icon.Text = Icons.Get(iconName)
    icon.TextColor3 = color or Color3.fromRGB(248, 250, 252)
    icon.TextSize = size or 16
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    return icon
end

-- Create ImageLabel for icon (alternative method using ImageLabels)
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

return Icons

