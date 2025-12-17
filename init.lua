--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                     UIFramework for Roblox                     ║
    ║                                                                 ║
    ║  A modern, customizable UI Framework with Panel design         ║
    ║  Features:                                                      ║
    ║  • Container with Sidebar navigation                           ║
    ║  • Rich component library with callbacks                       ║
    ║  • Font Awesome icon support                                   ║
    ║  • Smooth animations and transitions                           ║
    ║  • Dark theme optimized for gaming                             ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    Usage:
    
    local UIFramework = require(path.to.UIFramework)
    
    -- Create container (Panel)
    local panel = UIFramework.Container.new({
        Title = "My Panel",
        Size = UDim2.new(0, 800, 0, 600),
        Draggable = true,
        Closable = true
    })
    
    -- Add tabs
    local settingsTab = panel:AddTab({
        Name = "Settings",
        Icon = "gear"
    })
    
    -- Add components to tab
    UIFramework.Toggle.new({
        Text = "Enable Feature",
        Icon = "star",
        Value = true,
        Parent = settingsTab,
        OnChange = function(value)
            print("Toggle changed:", value)
        end
    })
    
    -- Available Components:
    -- • Container - Admin panel container with sidebar
    -- • Label - Text display with icon
    -- • Input - Text input field
    -- • Button - Clickable button with variants
    -- • Toggle - On/Off switch
    -- • Slider - Range slider
    -- • Checkbox - Checkbox
    -- • Dropdown - Single/Multiple selection dropdown
    -- • Tab - Tab navigation
    
    -- Available Icons: See Icons.lua for full list
    -- Examples: "home", "gear", "user", "star", "check", "xmark", etc.
]]

local UIFramework = {}

-- Version info
UIFramework.Version = "1.0.0"
UIFramework.Author = "UIFramework"

-- Core modules
UIFramework.Theme = require(script.Theme)
UIFramework.Utilities = require(script.Utilities)
UIFramework.Icons = require(script.Icons)

-- Components
UIFramework.Container = require(script.Components.Container)
UIFramework.Label = require(script.Components.Label)
UIFramework.Input = require(script.Components.Input)
UIFramework.Button = require(script.Components.Button)
UIFramework.Toggle = require(script.Components.Toggle)
UIFramework.Slider = require(script.Components.Slider)
UIFramework.Checkbox = require(script.Components.Checkbox)
UIFramework.Dropdown = require(script.Components.Dropdown)
UIFramework.Tab = require(script.Components.Tab)

--[[
    Theme Functions
]]

-- Set theme by name
function UIFramework.SetTheme(themeName)
    return UIFramework.Theme.SetTheme(themeName)
end

-- Get current theme name
function UIFramework.GetCurrentTheme()
    return UIFramework.Theme.GetCurrentTheme()
end

-- Get all available themes
function UIFramework.GetAvailableThemes()
    return UIFramework.Theme.GetAvailableThemes()
end

--[[
    Quick create functions for convenience
]]

-- Create a full panel with common setup
function UIFramework.CreatePanel(config)
    config = config or {}
    
    -- Set theme before creating panel if specified
    if config.Theme then
        UIFramework.SetTheme(config.Theme)
    end
    
    local panel = UIFramework.Container.new({
        Title = config.Title or "Panel",
        Size = config.Size or UDim2.new(0, 700, 0, 500),
        Position = config.Position,
        Draggable = config.Draggable ~= false,
        Closable = config.Closable ~= false,
        Minimizable = config.Minimizable ~= false,
        Resizable = config.Resizable ~= false,
        ShowSidebar = config.ShowSidebar ~= false,
        SidebarWidth = config.SidebarWidth,
        MinWidth = config.MinWidth,
        MinHeight = config.MinHeight,
        
        -- Transparency settings
        Transparency = config.Transparency,
        HeaderTransparency = config.HeaderTransparency,
        SidebarTransparency = config.SidebarTransparency,
        ContentTransparency = config.ContentTransparency,
        
        Parent = config.Parent,
        OnClose = config.OnClose,
        OnMinimize = config.OnMinimize,
        OnResize = config.OnResize
    })
    
    return panel
end

-- Alias for backward compatibility
UIFramework.CreateAdminPanel = UIFramework.CreatePanel

-- Create a section header (styled label)
function UIFramework.CreateSection(config)
    config = config or {}
    
    local section = UIFramework.Label.new({
        Text = config.Text or "Section",
        Icon = config.Icon,
        Size = UDim2.new(1, 0, 0, 32),
        TextSize = UIFramework.Theme.Typography.Subtitle,
        TextColor = config.Color or UIFramework.Theme.Colors.TextPrimary,
        Font = UIFramework.Theme.Typography.FontFamilyBold,
        Parent = config.Parent
    })
    
    return section
end

-- Create a divider
function UIFramework.CreateDivider(config)
    config = config or {}
    
    local divider = UIFramework.Utilities.Create("Frame", {
        Name = "Divider",
        Size = config.Size or UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = config.Color or UIFramework.Theme.Colors.SurfaceBorder,
        BorderSizePixel = 0,
        Parent = config.Parent
    })
    
    return divider
end

-- Create a spacer
function UIFramework.CreateSpacer(config)
    config = config or {}
    
    local spacer = UIFramework.Utilities.Create("Frame", {
        Name = "Spacer",
        Size = config.Size or UDim2.new(1, 0, 0, config.Height or 16),
        BackgroundTransparency = 1,
        Parent = config.Parent
    })
    
    return spacer
end

-- Create a card container
function UIFramework.CreateCard(config)
    config = config or {}
    
    local card = UIFramework.Utilities.Create("Frame", {
        Name = config.Name or "Card",
        Size = config.Size or UDim2.new(1, 0, 0, 100),
        BackgroundColor3 = config.Color or UIFramework.Theme.Colors.Surface,
        BorderSizePixel = 0,
        Parent = config.Parent
    })
    
    UIFramework.Utilities.ApplyCorner(card, UIFramework.Theme.BorderRadius.LG)
    UIFramework.Utilities.ApplyStroke(card, {
        Color = UIFramework.Theme.Colors.SurfaceBorder,
        Thickness = 1
    })
    
    if config.Padding ~= false then
        UIFramework.Utilities.ApplyPadding(card, config.Padding or UIFramework.Theme.Spacing.MD)
    end
    
    if config.AutoLayout ~= false then
        UIFramework.Utilities.ApplyListLayout(card, {
            Padding = config.LayoutPadding or UIFramework.Theme.Spacing.SM
        })
    end
    
    return card
end

-- Create a button group (horizontal buttons)
function UIFramework.CreateButtonGroup(config)
    config = config or {}
    
    local group = UIFramework.Utilities.Create("Frame", {
        Name = "ButtonGroup",
        Size = config.Size or UDim2.new(1, 0, 0, UIFramework.Theme.Sizes.ButtonHeight),
        BackgroundTransparency = 1,
        Parent = config.Parent
    })
    
    UIFramework.Utilities.ApplyListLayout(group, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = config.Alignment or Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = config.Spacing or UIFramework.Theme.Spacing.SM
    })
    
    return group
end

-- Notification helper
function UIFramework.Notify(config)
    config = config or {}
    
    local player = game:GetService("Players").LocalPlayer
    local screenGui = player:FindFirstChild("PlayerGui"):FindFirstChild("UIFramework_Notifications")
    
    if not screenGui then
        screenGui = UIFramework.Utilities.Create("ScreenGui", {
            Name = "UIFramework_Notifications",
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            Parent = player:FindFirstChild("PlayerGui")
        })
        
        local container = UIFramework.Utilities.Create("Frame", {
            Name = "Container",
            Size = UDim2.new(0, 350, 1, 0),
            Position = UDim2.new(1, -20, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Parent = screenGui
        })
        
        UIFramework.Utilities.ApplyPadding(container, UIFramework.Theme.Spacing.LG)
        UIFramework.Utilities.ApplyListLayout(container, {
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UIFramework.Theme.Spacing.SM
        })
    end
    
    local container = screenGui:FindFirstChild("Container")
    
    -- Notification types
    local typeColors = {
        success = UIFramework.Theme.Colors.Success,
        warning = UIFramework.Theme.Colors.Warning,
        error = UIFramework.Theme.Colors.Error,
        info = UIFramework.Theme.Colors.Info
    }
    
    local typeIcons = {
        success = "circle-check",
        warning = "triangle-exclamation",
        error = "circle-xmark",
        info = "circle-info"
    }
    
    local notifType = config.Type or "info"
    local color = typeColors[notifType] or UIFramework.Theme.Colors.Info
    local icon = config.Icon or typeIcons[notifType]
    
    -- Create notification
    local notif = UIFramework.Utilities.Create("Frame", {
        Name = "Notification",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = UIFramework.Theme.Colors.Surface,
        BorderSizePixel = 0,
        Parent = container
    })
    
    UIFramework.Utilities.ApplyCorner(notif, UIFramework.Theme.BorderRadius.MD)
    UIFramework.Utilities.ApplyStroke(notif, { Color = color, Thickness = 1 })
    
    -- Accent bar
    UIFramework.Utilities.Create("Frame", {
        Name = "Accent",
        Size = UDim2.new(0, 4, 1, 0),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Parent = notif
    })
    
    -- Content
    local content = UIFramework.Utilities.Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -8, 0, 0),
        Position = UDim2.new(0, 8, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = notif
    })
    
    UIFramework.Utilities.ApplyPadding(content, UIFramework.Theme.Spacing.MD)
    UIFramework.Utilities.ApplyListLayout(content, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UIFramework.Theme.Spacing.SM
    })
    
    -- Icon
    UIFramework.Utilities.Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = UIFramework.Icons.Get(icon),
        TextColor3 = color,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        LayoutOrder = 1,
        Parent = content
    })
    
    -- Text container
    local textContainer = UIFramework.Utilities.Create("Frame", {
        Name = "TextContainer",
        Size = UDim2.new(1, -30, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Parent = content
    })
    
    UIFramework.Utilities.ApplyListLayout(textContainer, {
        Padding = 4
    })
    
    -- Title
    if config.Title then
        UIFramework.Utilities.Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = config.Title,
            TextColor3 = UIFramework.Theme.Colors.TextPrimary,
            TextSize = UIFramework.Theme.Typography.Body,
            Font = UIFramework.Theme.Typography.FontFamilyBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,
            Parent = textContainer
        })
    end
    
    -- Message
    UIFramework.Utilities.Create("TextLabel", {
        Name = "Message",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = config.Message or "Notification",
        TextColor3 = UIFramework.Theme.Colors.TextSecondary,
        TextSize = UIFramework.Theme.Typography.Small,
        Font = UIFramework.Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 2,
        Parent = textContainer
    })
    
    -- Animate in
    notif.Position = UDim2.new(1, 0, 0, 0)
    UIFramework.Utilities.SpringTween(notif, { Position = UDim2.new(0, 0, 0, 0) })
    
    -- Auto dismiss
    local duration = config.Duration or 5
    task.delay(duration, function()
        if notif and notif.Parent then
            UIFramework.Utilities.Tween(notif, { Position = UDim2.new(1, 0, 0, 0) }, 0.3)
            task.wait(0.3)
            if notif then
                notif:Destroy()
            end
        end
    end)
    
    return notif
end

return UIFramework

