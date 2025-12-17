--[[
    UIFramework Example Script
    
    This script demonstrates all components of the UIFramework.
    
    Features:
    - Container with sidebar navigation
    - Multiple themes (Dark, Light, Pink, Blue, Golden, etc.)
    - Resizable panel with min/max constraints
    - Transparency settings
    - Auto scrollbar when content overflows
    - All components: Label, Input, Button, Toggle, Slider, Checkbox, Dropdown, Tab
    
    Usage with Executor:
    1. Host UIFramework.lua on a raw URL (GitHub, Pastebin, etc.)
    2. Replace YOUR_URL_HERE with the actual URL
    3. Execute this script
    
    Usage in Roblox Studio:
    1. Place the UIFramework folder in ReplicatedStorage
    2. Comment out the loadstring line and uncomment the require line
]]

-- Wait for player to load
local Players = game:GetService("Players")

local player = Players.LocalPlayer
repeat task.wait() until player:IsDescendantOf(Players)

-- Load UIFramework from built standalone file (for executors)
local UIFramework = loadstring(game:HttpGet("https://github.com/SS1Dev/RBUI/releases/download/v1.0.0/main.lua"))()

-- Alternative: Load from ReplicatedStorage (for Roblox Studio)
-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local UIFramework = require(ReplicatedStorage:WaitForChild("UIFramework"))

-- ═══════════════════════════════════════════════════════════════
-- CREATE MAIN PANEL
-- ═══════════════════════════════════════════════════════════════

local Panel = UIFramework.CreatePanel({
    Title = "🎮 Game Panel",
    Size = UDim2.new(0, 700, 0, 450),
    Theme = "DarkPink", -- Set default theme: Dark, Light, Pink, Blue, Golden, DarkBlue, DarkPink, DarkGolden, LightPink, LightGolden, LightBlue
    Resizable = true, -- Enable resize (drag bottom-right corner)
    MinWidth = 500,   -- Minimum panel width
    MinHeight = 350,  -- Minimum panel height
    Transparency = 0, -- Main panel transparency (0 = opaque, 1 = fully transparent)
    -- HeaderTransparency = 0.1,  -- Optional: separate header transparency
    -- SidebarTransparency = 0.1, -- Optional: separate sidebar transparency
    OnClose = function()
        print("Panel closed!")
    end,
    OnMinimize = function(minimized)
        print("Panel minimized:", minimized)
    end,
    OnResize = function(width, height)
        print("Panel resized to:", width, "x", height)
    end
})

-- Show notification on load
task.delay(1, function()
    UIFramework.Notify({
        Type = "success",
        Title = "Welcome!",
        Message = "Panel loaded successfully.",
        Duration = 4
    })
end)

-- ═══════════════════════════════════════════════════════════════
-- TAB 1: DASHBOARD
-- ═══════════════════════════════════════════════════════════════

local dashboardTab = Panel:AddTab({
    Name = "Dashboard",
    Icon = "dashboard",
    Callback = function(tabId)
        print("Switched to Dashboard tab")
    end
})

-- Welcome section
UIFramework.CreateSection({
    Text = "Welcome to UIFramework",
    Icon = "star",
    Parent = dashboardTab
})

UIFramework.Label.new({
    Text = "This is a demonstration of all available components in the UIFramework. Navigate through the tabs to see different features.",
    Icon = "circle-info",
    TextColor = UIFramework.Theme.Colors.TextSecondary,
    Parent = dashboardTab
})

UIFramework.CreateSpacer({ Parent = dashboardTab })

-- Stats cards
local statsContainer = UIFramework.Utilities.Create("Frame", {
    Name = "StatsContainer",
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundTransparency = 1,
    Parent = dashboardTab
})

UIFramework.Utilities.ApplyListLayout(statsContainer, {
    Direction = Enum.FillDirection.Horizontal,
    Padding = UIFramework.Theme.Spacing.MD
})

local function createStatCard(name, value, icon, color)
    local card = UIFramework.CreateCard({
        Size = UDim2.new(0, 180, 0, 70),
        Parent = statsContainer,
        AutoLayout = false
    })
    
    UIFramework.Utilities.Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 12, 0, 12),
        BackgroundTransparency = 1,
        Text = UIFramework.Icons.Get(icon),
        TextColor3 = color,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = card
    })
    
    UIFramework.Utilities.Create("TextLabel", {
        Name = "Value",
        Size = UDim2.new(1, -60, 0, 24),
        Position = UDim2.new(0, 52, 0, 10),
        BackgroundTransparency = 1,
        Text = tostring(value),
        TextColor3 = UIFramework.Theme.Colors.TextPrimary,
        TextSize = 20,
        Font = UIFramework.Theme.Typography.FontFamilyBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card
    })
    
    UIFramework.Utilities.Create("TextLabel", {
        Name = "Name",
        Size = UDim2.new(1, -60, 0, 16),
        Position = UDim2.new(0, 52, 0, 36),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = UIFramework.Theme.Colors.TextSecondary,
        TextSize = 12,
        Font = UIFramework.Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card
    })
    
    return card
end

createStatCard("Players Online", "1,234", "users", UIFramework.Theme.Colors.Primary)
createStatCard("Total Revenue", "$5,678", "coins", UIFramework.Theme.Colors.Success)
createStatCard("Active Games", "89", "gamepad", UIFramework.Theme.Colors.Warning)
createStatCard("Server Status", "Online", "server", UIFramework.Theme.Colors.Info)

-- ═══════════════════════════════════════════════════════════════
-- TAB 2: PLAYER SETTINGS
-- ═══════════════════════════════════════════════════════════════

local settingsTab = Panel:AddTab({
    Name = "Settings",
    Icon = "gear"
})

UIFramework.CreateSection({
    Text = "Theme Settings",
    Icon = "palette",
    Parent = settingsTab
})

-- Theme selector
local themeOptions = {}
for _, themeName in ipairs(UIFramework.GetAvailableThemes()) do
    local icons = {
        Dark = "moon",
        Light = "sun",
        Pink = "heart",
        Blue = "water",
        Golden = "crown",
        Rose = "heart",
        DarkBlue = "moon",
        DarkPink = "moon",
        DarkGolden = "moon",
        DarkRose = "moon",
        LightPink = "sun",
        LightGolden = "sun",
        LightBlue = "sun",
        LightRose = "sun"
    }
    table.insert(themeOptions, {
        Text = themeName,
        Value = themeName,
        Icon = icons[themeName] or "palette"
    })
end

UIFramework.Dropdown.new({
    Text = "Select Theme",
    Icon = "palette",
    Value = UIFramework.GetCurrentTheme(),
    Options = themeOptions,
    Parent = settingsTab,
    OnChange = function(value)
        UIFramework.SetTheme(value)
        UIFramework.Notify({
            Type = "success",
            Title = "Theme Changed!",
            Message = "Theme set to: " .. value,
            Duration = 2
        })
    end
})

-- Panel transparency slider
UIFramework.Slider.new({
    Text = "Panel Transparency",
    Icon = "eye",
    Value = 0,
    Min = 0,
    Max = 0.8,
    Step = 0.1,
    Decimals = 1,
    Parent = settingsTab,
    OnChange = function(value)
        Panel:SetTransparency(value)
    end
})

UIFramework.CreateDivider({ Parent = settingsTab })

UIFramework.CreateSection({
    Text = "Player Settings",
    Icon = "user-gear",
    Parent = settingsTab
})

-- Toggle examples
UIFramework.Toggle.new({
    Text = "Enable Notifications",
    Icon = "bell",
    Value = true,
    Parent = settingsTab,
    OnChange = function(value)
        UIFramework.Notify({
            Type = value and "success" or "info",
            Message = "Notifications " .. (value and "enabled" or "disabled")
        })
    end
})

UIFramework.Toggle.new({
    Text = "Show Player Names",
    Icon = "eye",
    Value = true,
    Parent = settingsTab,
    OnChange = function(value)
        print("Show names:", value)
    end
})

UIFramework.Toggle.new({
    Text = "Enable Sound Effects",
    Icon = "volume-high",
    Value = false,
    Parent = settingsTab,
    OnChange = function(value)
        print("Sound effects:", value)
    end
})

UIFramework.CreateDivider({ Parent = settingsTab })

UIFramework.CreateSection({
    Text = "Audio Settings",
    Icon = "music",
    Parent = settingsTab
})

-- Slider examples
UIFramework.Slider.new({
    Text = "Master Volume",
    Icon = "volume-high",
    Value = 75,
    Min = 0,
    Max = 100,
    Step = 5,
    Parent = settingsTab,
    OnChange = function(value)
        print("Volume:", value)
    end
})

UIFramework.Slider.new({
    Text = "Music Volume",
    Icon = "music",
    Value = 50,
    Min = 0,
    Max = 100,
    Parent = settingsTab,
    OnChange = function(value)
        print("Music:", value)
    end
})

UIFramework.Slider.new({
    Text = "Mouse Sensitivity",
    Icon = "sliders",
    Value = 1.5,
    Min = 0.1,
    Max = 5,
    Step = 0.1,
    Decimals = 1,
    Parent = settingsTab,
    OnChange = function(value)
        print("Sensitivity:", value)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 3: FORMS & INPUTS
-- ═══════════════════════════════════════════════════════════════

local formsTab = Panel:AddTab({
    Name = "Forms",
    Icon = "clipboard-list"
})

UIFramework.CreateSection({
    Text = "Input with Label",
    Icon = "edit",
    Parent = formsTab
})

-- Input with Label examples (Label on left, Input on right)
UIFramework.Input.new({
    Label = "Username",
    LabelIcon = "user",
    Placeholder = "Enter username...",
    InputWidth = UDim.new(0.55, 0),
    Parent = formsTab,
    OnChange = function(text)
        print("Username:", text)
    end,
    OnSubmit = function(text)
        UIFramework.Notify({
            Type = "info",
            Title = "Input Submitted",
            Message = "Username: " .. text
        })
    end
})

UIFramework.Input.new({
    Label = "Email",
    LabelIcon = "envelope",
    Placeholder = "Enter email...",
    InputWidth = UDim.new(0.55, 0),
    Parent = formsTab,
    OnChange = function(text)
        print("Email:", text)
    end
})

UIFramework.Input.new({
    Label = "Password",
    LabelIcon = "lock",
    Placeholder = "Enter password...",
    Password = true,
    InputWidth = UDim.new(0.55, 0),
    Parent = formsTab
})

UIFramework.CreateDivider({ Parent = formsTab })

UIFramework.CreateSection({
    Text = "Input without Label",
    Icon = "keyboard",
    Parent = formsTab
})

-- Input without Label (full width)
UIFramework.Input.new({
    Placeholder = "Search players...",
    Icon = "search",
    Parent = formsTab,
    OnChange = function(text)
        print("Searching:", text)
    end
})

UIFramework.Input.new({
    Placeholder = "Type a message...",
    Icon = "comments",
    Parent = formsTab
})

UIFramework.CreateDivider({ Parent = formsTab })

UIFramework.CreateSection({
    Text = "Dropdown Components",
    Icon = "chevron-down",
    Parent = formsTab
})

-- Single selection dropdown
UIFramework.Dropdown.new({
    Text = "Select Team",
    Icon = "users",
    Options = {
        { Text = "Red Team", Value = "red", Icon = "flag" },
        { Text = "Blue Team", Value = "blue", Icon = "flag" },
        { Text = "Green Team", Value = "green", Icon = "flag" },
        { Text = "Yellow Team", Value = "yellow", Icon = "flag" }
    },
    Parent = formsTab,
    OnChange = function(value)
        UIFramework.Notify({
            Type = "info",
            Message = "Selected team: " .. tostring(value)
        })
    end
})

-- Multiple selection dropdown
UIFramework.Dropdown.new({
    Text = "Select Abilities",
    Icon = "star",
    Multiple = true,
    Searchable = true,
    Options = {
        { Text = "Super Speed", Value = "speed", Icon = "forward" },
        { Text = "Super Jump", Value = "jump", Icon = "arrow-up" },
        { Text = "Invisibility", Value = "invis", Icon = "eye-slash" },
        { Text = "Fire Power", Value = "fire", Icon = "bolt" },
        { Text = "Ice Power", Value = "ice", Icon = "snowflake" },
        { Text = "Teleport", Value = "teleport", Icon = "location-dot" }
    },
    Parent = formsTab,
    OnChange = function(values)
        print("Selected abilities:", table.concat(values, ", "))
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 4: BUTTONS & ACTIONS
-- ═══════════════════════════════════════════════════════════════

local actionsTab = Panel:AddTab({
    Name = "Actions",
    Icon = "bolt"
})

UIFramework.CreateSection({
    Text = "Button Variants",
    Icon = "palette",
    Parent = actionsTab
})

-- Button group
local buttonGroup1 = UIFramework.CreateButtonGroup({
    Parent = actionsTab
})

UIFramework.Button.new({
    Text = "Primary",
    Icon = "check",
    Variant = "primary",
    Parent = buttonGroup1,
    OnClick = function()
        UIFramework.Notify({ Type = "info", Message = "Primary button clicked!" })
    end
})

UIFramework.Button.new({
    Text = "Secondary",
    Icon = "star",
    Variant = "secondary",
    Parent = buttonGroup1,
    OnClick = function()
        UIFramework.Notify({ Type = "info", Message = "Secondary button clicked!" })
    end
})

UIFramework.Button.new({
    Text = "Success",
    Icon = "circle-check",
    Variant = "success",
    Parent = buttonGroup1,
    OnClick = function()
        UIFramework.Notify({ Type = "success", Message = "Success button clicked!" })
    end
})

local buttonGroup2 = UIFramework.CreateButtonGroup({
    Parent = actionsTab
})

UIFramework.Button.new({
    Text = "Warning",
    Icon = "triangle-exclamation",
    Variant = "warning",
    Parent = buttonGroup2,
    OnClick = function()
        UIFramework.Notify({ Type = "warning", Message = "Warning button clicked!" })
    end
})

UIFramework.Button.new({
    Text = "Error",
    Icon = "circle-xmark",
    Variant = "error",
    Parent = buttonGroup2,
    OnClick = function()
        UIFramework.Notify({ Type = "error", Message = "Error button clicked!" })
    end
})

UIFramework.Button.new({
    Text = "Ghost",
    Icon = "ghost",
    Variant = "ghost",
    Parent = buttonGroup2,
    OnClick = function()
        UIFramework.Notify({ Type = "info", Message = "Ghost button clicked!" })
    end
})

UIFramework.CreateDivider({ Parent = actionsTab })

UIFramework.CreateSection({
    Text = "Icon Buttons",
    Icon = "icons",
    Parent = actionsTab
})

local iconButtonGroup = UIFramework.CreateButtonGroup({
    Parent = actionsTab
})

local iconButtons = {"play", "pause", "stop", "forward", "backward", "refresh", "download", "upload"}
for _, iconName in ipairs(iconButtons) do
    UIFramework.Button.new({
        Text = "",
        Icon = iconName,
        Size = UDim2.new(0, 44, 0, 40),
        Variant = "secondary",
        Parent = iconButtonGroup,
        OnClick = function()
            print("Icon button clicked:", iconName)
        end
    })
end

UIFramework.CreateDivider({ Parent = actionsTab })

UIFramework.CreateSection({
    Text = "Loading State",
    Icon = "spinner",
    Parent = actionsTab
})

local loadingButtonGroup = UIFramework.CreateButtonGroup({
    Parent = actionsTab
})

local loadingBtn
loadingBtn = UIFramework.Button.new({
    Text = "Click to Load",
    Icon = "download",
    Variant = "primary",
    Parent = loadingButtonGroup,
    OnClick = function()
        loadingBtn:SetLoading(true)
        task.delay(3, function()
            loadingBtn:SetLoading(false)
            UIFramework.Notify({
                Type = "success",
                Title = "Complete!",
                Message = "Loading finished successfully."
            })
        end)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 5: CHECKBOXES
-- ═══════════════════════════════════════════════════════════════

local checkboxTab = Panel:AddTab({
    Name = "Checkboxes",
    Icon = "list-check"
})

UIFramework.CreateSection({
    Text = "Game Features",
    Icon = "gamepad",
    Parent = checkboxTab
})

local checkboxes = {
    { text = "Enable PvP", icon = "swords", value = true },
    { text = "Show Leaderboard", icon = "trophy", value = true },
    { text = "Allow Trading", icon = "exchange", value = false },
    { text = "Enable Chat", icon = "comments", value = true },
    { text = "Show Player List", icon = "users", value = true },
    { text = "Enable Spectator Mode", icon = "eye", value = false },
    { text = "Auto-Save Progress", icon = "save", value = true },
    { text = "Show Minimap", icon = "map", value = true },
    { text = "Enable Particles", icon = "star", value = false },
    { text = "Show Damage Numbers", icon = "bolt", value = true },
    { text = "Enable Controller Support", icon = "gamepad", value = false },
    { text = "Show FPS Counter", icon = "chart-line", value = false },
    { text = "Show Health Bar", icon = "heart", value = true },
    { text = "Enable Auto-Run", icon = "forward", value = false },
    { text = "Show Quest Tracker", icon = "list-check", value = true },
}

for _, cb in ipairs(checkboxes) do
    UIFramework.Checkbox.new({
        Text = cb.text,
        Icon = cb.icon,
        Value = cb.value,
        Parent = checkboxTab,
        OnChange = function(value)
            print(cb.text .. ":", value)
        end
    })
end

UIFramework.CreateDivider({ Parent = checkboxTab })

UIFramework.CreateSection({
    Text = "Graphics Settings",
    Icon = "video",
    Parent = checkboxTab
})

local graphicsCheckboxes = {
    { text = "Enable Shadows", icon = "sun", value = true },
    { text = "Motion Blur", icon = "forward", value = false },
    { text = "Anti-Aliasing", icon = "expand", value = true },
    { text = "V-Sync", icon = "sync", value = false },
    { text = "High Quality Textures", icon = "image", value = true },
}

for _, cb in ipairs(graphicsCheckboxes) do
    UIFramework.Checkbox.new({
        Text = cb.text,
        Icon = cb.icon,
        Value = cb.value,
        Parent = checkboxTab,
        OnChange = function(value)
            print(cb.text .. ":", value)
        end
    })
end

-- ═══════════════════════════════════════════════════════════════
-- TAB 6: TABS DEMO
-- ═══════════════════════════════════════════════════════════════

local tabsTab = Panel:AddTab({
    Name = "Nested Tabs",
    Icon = "layer-group"
})

UIFramework.CreateSection({
    Text = "Horizontal Tabs",
    Icon = "arrows-left-right",
    Parent = tabsTab
})

local horizontalTabs = UIFramework.Tab.new({
    Tabs = {
        { Id = "general", Text = "General", Icon = "gear" },
        { Id = "audio", Text = "Audio", Icon = "volume-high" },
        { Id = "video", Text = "Video", Icon = "video" },
        { Id = "controls", Text = "Controls", Icon = "gamepad" }
    },
    Orientation = "horizontal",
    Size = UDim2.new(1, 0, 0, 200),
    Parent = tabsTab,
    OnChange = function(tabId)
        print("Horizontal tab changed:", tabId)
    end
})

-- Add content to horizontal tabs
local generalContent = horizontalTabs:GetTabContent("general")
UIFramework.Label.new({
    Text = "General settings go here",
    Icon = "circle-info",
    Parent = generalContent
})

local audioContent = horizontalTabs:GetTabContent("audio")
UIFramework.Slider.new({
    Text = "Volume",
    Value = 50,
    Parent = audioContent
})

local videoContent = horizontalTabs:GetTabContent("video")
UIFramework.Toggle.new({
    Text = "VSync",
    Value = true,
    Parent = videoContent
})

local controlsContent = horizontalTabs:GetTabContent("controls")
UIFramework.Label.new({
    Text = "Keybind settings would go here",
    Icon = "keyboard",
    Parent = controlsContent
})

-- ═══════════════════════════════════════════════════════════════
-- TAB 7: ABOUT
-- ═══════════════════════════════════════════════════════════════

local aboutTab = Panel:AddTab({
    Name = "About",
    Icon = "circle-info"
})

UIFramework.CreateSection({
    Text = "UIFramework v" .. UIFramework.Version,
    Icon = "code",
    Parent = aboutTab
})

UIFramework.Label.new({
    Text = "A modern, customizable UI Framework for Roblox with Panel design.",
    TextColor = UIFramework.Theme.Colors.TextSecondary,
    Parent = aboutTab
})

UIFramework.Label.new({
    Text = "⬇ Scroll down to see more features (auto scrollbar)",
    Icon = "chevron-down",
    TextColor = UIFramework.Theme.Colors.TextMuted,
    Parent = aboutTab
})

UIFramework.CreateSpacer({ Parent = aboutTab })

local features = {
    { icon = "cube", text = "Container - Panel with sidebar navigation" },
    { icon = "font", text = "Label - Text display with icon support" },
    { icon = "keyboard", text = "Input - Text input with label support" },
    { icon = "hand-pointer", text = "Button - Multiple variants and states" },
    { icon = "toggle-on", text = "Toggle - On/Off switches" },
    { icon = "sliders", text = "Slider - Range selection" },
    { icon = "square-check", text = "Checkbox - Checkbox on right side" },
    { icon = "list", text = "Dropdown - Single and multiple selection" },
    { icon = "folder", text = "Tab - Navigation component" },
    { icon = "minus", text = "Divider - Separator that changes with theme" },
    { icon = "expand", text = "Resizable - Drag corner to resize panel" },
    { icon = "move", text = "Draggable - Move panel from anywhere" },
    { icon = "eye", text = "Transparency - Configurable panel transparency" },
    { icon = "palette", text = "Themes - 14 built-in color themes" },
    { icon = "circle", text = "macOS Style - Circular minimize/close buttons" }
}

UIFramework.CreateSection({
    Text = "Components",
    Icon = "cubes",
    Parent = aboutTab
})

for _, feature in ipairs(features) do
    UIFramework.Label.new({
        Text = feature.text,
        Icon = feature.icon,
        TextColor = UIFramework.Theme.Colors.TextSecondary,
        Parent = aboutTab
    })
end

UIFramework.CreateSpacer({ Parent = aboutTab })

local notifyButtonGroup = UIFramework.CreateButtonGroup({
    Parent = aboutTab,
    Alignment = Enum.HorizontalAlignment.Center
})

UIFramework.Button.new({
    Text = "Success",
    Icon = "check",
    Variant = "success",
    Size = UDim2.new(0, 100, 0, 36),
    Parent = notifyButtonGroup,
    OnClick = function()
        UIFramework.Notify({
            Type = "success",
            Title = "Success!",
            Message = "Operation completed successfully."
        })
    end
})

UIFramework.Button.new({
    Text = "Warning",
    Icon = "triangle-exclamation",
    Variant = "warning",
    Size = UDim2.new(0, 100, 0, 36),
    Parent = notifyButtonGroup,
    OnClick = function()
        UIFramework.Notify({
            Type = "warning",
            Title = "Warning",
            Message = "Please check your settings."
        })
    end
})

UIFramework.Button.new({
    Text = "Error",
    Icon = "xmark",
    Variant = "error",
    Size = UDim2.new(0, 100, 0, 36),
    Parent = notifyButtonGroup,
    OnClick = function()
        UIFramework.Notify({
            Type = "error",
            Title = "Error",
            Message = "Something went wrong!"
        })
    end
})

UIFramework.Button.new({
    Text = "Info",
    Icon = "info",
    Variant = "primary",
    Size = UDim2.new(0, 100, 0, 36),
    Parent = notifyButtonGroup,
    OnClick = function()
        UIFramework.Notify({
            Type = "info",
            Title = "Information",
            Message = "Here's some useful information."
        })
    end
})

UIFramework.CreateSpacer({ Parent = aboutTab })

UIFramework.CreateSection({
    Text = "Tips & Tricks",
    Icon = "bolt",
    Parent = aboutTab
})

local tips = {
    "🎨 Change themes from the Settings tab",
    "🖱️ Drag from anywhere on the panel to move it",
    "📐 Drag the bottom-right corner to resize the panel",
    "⚪ White circle = Minimize, 🔴 Red circle = Close",
    "🔍 Use searchable dropdowns for large option lists",
    "⌨️ Press Enter to submit input fields",
    "📜 Scroll bar appears automatically when content overflows",
    "💾 All settings can have callbacks for real-time updates",
    "🔔 Use notifications to provide user feedback",
    "👁 Adjust panel transparency in Settings tab",
    "➖ Dividers automatically change color with theme",
}

for _, tip in ipairs(tips) do
    UIFramework.Label.new({
        Text = tip,
        TextColor = UIFramework.Theme.Colors.TextSecondary,
        Parent = aboutTab
    })
end

UIFramework.CreateSpacer({ Parent = aboutTab })

UIFramework.Label.new({
    Text = "Made with ❤️ for the Roblox community",
    TextColor = UIFramework.Theme.Colors.TextMuted,
    Parent = aboutTab
})

-- Done!
print("✅ UIFramework Example loaded successfully!")
print("📦 Version:", UIFramework.Version)

