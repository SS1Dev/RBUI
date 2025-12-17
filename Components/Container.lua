--[[
    UIFramework Container Component
    Panel Style Container with Sidebar, Header, and Content Area
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Container = {}
Container.__index = Container

-- Import dependencies
local function GetFramework()
    return script.Parent.Parent
end

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Panel Container
    
    @param config {
        Title: string - Panel title
        Size: UDim2 - Panel size
        Position: UDim2 - Panel position
        Draggable: boolean - Allow dragging
        Closable: boolean - Show close button
        Minimizable: boolean - Show minimize button
        ShowSidebar: boolean - Show sidebar
        SidebarWidth: number - Sidebar width
        Parent: Instance - Parent instance
        OnClose: function - Close callback
        OnMinimize: function - Minimize callback
    }
]]
function Container.new(config)
    local self = setmetatable({}, Container)
    
    config = config or {}
    
    self.Title = config.Title or "Panel"
    self.Size = config.Size or UDim2.new(0, 800, 0, 600)
    self.Position = config.Position or UDim2.new(0.5, 0, 0.5, 0) -- Center of screen
    self.Draggable = config.Draggable ~= false
    self.Closable = config.Closable ~= false
    self.Minimizable = config.Minimizable ~= false
    self.ShowSidebar = config.ShowSidebar ~= false
    self.SidebarWidth = config.SidebarWidth or Theme.Sizes.SidebarWidth
    self.Parent = config.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")
    self.OnClose = config.OnClose
    self.OnMinimize = config.OnMinimize
    
    self.Tabs = {}
    self.CurrentTab = nil
    self.IsMinimized = false
    self.IsVisible = true
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

-- Build the container UI
function Container:_Build()
    -- ScreenGui
    self.ScreenGui = Utilities.Create("ScreenGui", {
        Name = "UIFramework_Container",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = self.Parent
    })
    
    -- Main Frame
    self.Frame = Utilities.Create("Frame", {
        Name = "MainFrame",
        Size = self.Size,
        Position = self.Position,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Colors.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ScreenGui
    })
    
    Utilities.ApplyCorner(self.Frame, Theme.BorderRadius.XL)
    Utilities.ApplyStroke(self.Frame, {
        Color = Theme.Colors.SurfaceBorder,
        Thickness = 1
    })
    Utilities.CreateShadow(self.Frame, 8, 24)
    
    -- Header
    self:_BuildHeader()
    
    -- Body Container
    self.BodyContainer = Utilities.Create("Frame", {
        Name = "BodyContainer",
        Size = UDim2.new(1, 0, 1, -Theme.Sizes.HeaderHeight),
        Position = UDim2.new(0, 0, 0, Theme.Sizes.HeaderHeight),
        BackgroundTransparency = 1,
        Parent = self.Frame
    })
    
    -- Sidebar
    if self.ShowSidebar then
        self:_BuildSidebar()
    end
    
    -- Content Area
    self:_BuildContentArea()
    
    -- Make draggable
    if self.Draggable then
        Utilities.MakeDraggable(self.Frame, self.Header)
    end
end

-- Build header section
function Container:_BuildHeader()
    self.Header = Utilities.Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, Theme.Sizes.HeaderHeight),
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BorderSizePixel = 0,
        Parent = self.Frame
    })
    
    -- Header bottom border
    Utilities.Create("Frame", {
        Name = "Border",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Colors.SurfaceBorder,
        BorderSizePixel = 0,
        Parent = self.Header
    })
    
    -- Logo/Icon container
    local logoContainer = Utilities.Create("Frame", {
        Name = "LogoContainer",
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, Theme.Spacing.MD, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Colors.Primary,
        Parent = self.Header
    })
    Utilities.ApplyCorner(logoContainer, Theme.BorderRadius.SM)
    
    -- Logo Icon
    Utilities.Create("TextLabel", {
        Name = "LogoIcon",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = Icons.Get("cubes"),
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = 14,
        Font = Theme.Typography.FontFamily,
        Parent = logoContainer
    })
    
    -- Title
    self.TitleLabel = Utilities.Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, Theme.Spacing.MD + 36, 0, 0),
        BackgroundTransparency = 1,
        Text = self.Title,
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Subtitle,
        Font = Theme.Typography.FontFamilyBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.Header
    })
    
    -- Window Controls Container
    local controlsContainer = Utilities.Create("Frame", {
        Name = "Controls",
        Size = UDim2.new(0, 60, 0, 24),
        Position = UDim2.new(1, -Theme.Spacing.MD, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Parent = self.Header
    })
    
    Utilities.ApplyListLayout(controlsContainer, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = Theme.Spacing.SM
    })
    
    -- Minimize Button
    if self.Minimizable then
        local minimizeBtn = self:_CreateWindowControl("minus", function()
            self:ToggleMinimize()
        end)
        minimizeBtn.Parent = controlsContainer
    end
    
    -- Close Button
    if self.Closable then
        local closeBtn = self:_CreateWindowControl("xmark", function()
            self:Close()
        end, Theme.Colors.Error)
        closeBtn.Parent = controlsContainer
    end
end

-- Create window control button
function Container:_CreateWindowControl(iconName, callback, hoverColor)
    local btn = Utilities.Create("TextButton", {
        Name = iconName .. "Button",
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundColor3 = Theme.Colors.BackgroundTertiary,
        BorderSizePixel = 0,
        Text = Icons.Get(iconName),
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = 12,
        Font = Theme.Typography.FontFamily,
        AutoButtonColor = false
    })
    
    Utilities.ApplyCorner(btn, Theme.BorderRadius.SM)
    
    btn.MouseEnter:Connect(function()
        Utilities.Tween(btn, {
            BackgroundColor3 = hoverColor or Theme.Colors.Primary,
            TextColor3 = Theme.Colors.TextPrimary
        })
    end)
    
    btn.MouseLeave:Connect(function()
        Utilities.Tween(btn, {
            BackgroundColor3 = Theme.Colors.BackgroundTertiary,
            TextColor3 = Theme.Colors.TextSecondary
        })
    end)
    
    btn.Activated:Connect(callback)
    
    return btn
end

-- Build sidebar
function Container:_BuildSidebar()
    self.Sidebar = Utilities.Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, self.SidebarWidth, 1, 0),
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BorderSizePixel = 0,
        Parent = self.BodyContainer
    })
    
    -- Sidebar right border
    Utilities.Create("Frame", {
        Name = "Border",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = Theme.Colors.SurfaceBorder,
        BorderSizePixel = 0,
        Parent = self.Sidebar
    })
    
    -- Sidebar content
    self.SidebarContent = Utilities.Create("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(1, -2, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = self.Sidebar
    })
    
    Utilities.ApplyPadding(self.SidebarContent, Theme.Spacing.MD)
    Utilities.ApplyListLayout(self.SidebarContent, {
        Padding = Theme.Spacing.XS
    })
end

-- Build content area
function Container:_BuildContentArea()
    local offsetX = self.ShowSidebar and self.SidebarWidth or 0
    
    self.ContentArea = Utilities.Create("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -offsetX, 1, 0),
        Position = UDim2.new(0, offsetX, 0, 0),
        BackgroundTransparency = 1,
        Parent = self.BodyContainer
    })
    
    -- Content scroll frame
    self.Content = Utilities.Create("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = self.ContentArea
    })
    
    Utilities.ApplyPadding(self.Content, Theme.Spacing.LG)
    Utilities.ApplyListLayout(self.Content, {
        Padding = Theme.Spacing.SM
    })
end

-- Add a tab to sidebar
function Container:AddTab(config)
    config = config or {}
    
    local tabId = config.Id or Utilities.GenerateId()
    local tabName = config.Name or "Tab"
    local tabIcon = config.Icon or "folder"
    local callback = config.Callback
    
    -- Tab Button (Compact)
    local tabButton = Utilities.Create("TextButton", {
        Name = "Tab_" .. tabId,
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.SidebarContent
    })
    
    Utilities.ApplyCorner(tabButton, Theme.BorderRadius.SM)
    
    -- Tab Icon
    local iconLabel = Utilities.Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, Theme.Spacing.SM, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = Icons.Get(tabIcon),
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = 12,
        Font = Theme.Typography.FontFamily,
        Parent = tabButton
    })
    
    -- Tab Text
    local textLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, Theme.Spacing.SM + 22, 0, 0),
        BackgroundTransparency = 1,
        Text = tabName,
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = Theme.Typography.Small,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = tabButton
    })
    
    -- Active indicator
    local indicator = Utilities.Create("Frame", {
        Name = "Indicator",
        Size = UDim2.new(0, 2, 0, 16),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Colors.Primary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = tabButton
    })
    Utilities.ApplyCorner(indicator, Theme.BorderRadius.Full)
    
    -- Content container for this tab
    local tabContent = Utilities.Create("Frame", {
        Name = "TabContent_" .. tabId,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = self.Content
    })
    
    Utilities.ApplyListLayout(tabContent, {
        Padding = Theme.Spacing.MD
    })
    
    -- Store tab data
    self.Tabs[tabId] = {
        Id = tabId,
        Name = tabName,
        Button = tabButton,
        Icon = iconLabel,
        Text = textLabel,
        Indicator = indicator,
        Content = tabContent,
        Callback = callback
    }
    
    -- Tab interactions
    tabButton.MouseEnter:Connect(function()
        if self.CurrentTab ~= tabId then
            Utilities.Tween(tabButton, { BackgroundTransparency = 0.5 })
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if self.CurrentTab ~= tabId then
            Utilities.Tween(tabButton, { BackgroundTransparency = 1 })
        end
    end)
    
    tabButton.Activated:Connect(function()
        self:SelectTab(tabId)
        if callback then
            callback(tabId)
        end
    end)
    
    -- Auto-select first tab
    if not self.CurrentTab then
        self:SelectTab(tabId)
    end
    
    return tabContent, tabId
end

-- Select a tab
function Container:SelectTab(tabId)
    -- Deselect current tab
    if self.CurrentTab and self.Tabs[self.CurrentTab] then
        local currentTab = self.Tabs[self.CurrentTab]
        Utilities.Tween(currentTab.Button, { BackgroundTransparency = 1 })
        Utilities.Tween(currentTab.Icon, { TextColor3 = Theme.Colors.TextSecondary })
        Utilities.Tween(currentTab.Text, { TextColor3 = Theme.Colors.TextSecondary })
        Utilities.Tween(currentTab.Indicator, { BackgroundTransparency = 1 })
        currentTab.Content.Visible = false
    end
    
    -- Select new tab
    if self.Tabs[tabId] then
        local newTab = self.Tabs[tabId]
        self.CurrentTab = tabId
        
        Utilities.Tween(newTab.Button, { 
            BackgroundTransparency = 0,
            BackgroundColor3 = Theme.Colors.Primary
        })
        Utilities.Tween(newTab.Icon, { TextColor3 = Theme.Colors.TextPrimary })
        Utilities.Tween(newTab.Text, { TextColor3 = Theme.Colors.TextPrimary })
        Utilities.Tween(newTab.Indicator, { BackgroundTransparency = 0 })
        newTab.Content.Visible = true
    end
end

-- Get tab content
function Container:GetTabContent(tabId)
    if self.Tabs[tabId] then
        return self.Tabs[tabId].Content
    end
    return nil
end

-- Toggle minimize
function Container:ToggleMinimize()
    self.IsMinimized = not self.IsMinimized
    
    if self.IsMinimized then
        self._OriginalSize = self.Frame.Size
        Utilities.Tween(self.Frame, {
            Size = UDim2.new(0, self.Size.X.Offset, 0, Theme.Sizes.HeaderHeight)
        })
        self.BodyContainer.Visible = false
    else
        Utilities.Tween(self.Frame, {
            Size = self._OriginalSize or self.Size
        })
        self.BodyContainer.Visible = true
    end
    
    if self.OnMinimize then
        self.OnMinimize(self.IsMinimized)
    end
end

-- Show container
function Container:Show()
    self.IsVisible = true
    self.Frame.Visible = true
    self.Frame.Size = UDim2.new(0, 0, 0, 0)
    Utilities.SpringTween(self.Frame, { Size = self.Size })
end

-- Hide container
function Container:Hide()
    self.IsVisible = false
    Utilities.Tween(self.Frame, { Size = UDim2.new(0, 0, 0, 0) }, 0.15)
    task.delay(0.15, function()
        self.Frame.Visible = false
    end)
end

-- Close container
function Container:Close()
    if self.OnClose then
        self.OnClose()
    end
    self:Hide()
    task.delay(0.2, function()
        self:Destroy()
    end)
end

-- Destroy container
function Container:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

-- Set title
function Container:SetTitle(title)
    self.Title = title
    if self.TitleLabel then
        self.TitleLabel.Text = title
    end
end

-- Apply current theme colors to all container elements
function Container:ApplyTheme()
    if not self.Frame then return end
    
    -- Main frame
    self.Frame.BackgroundColor3 = Theme.Colors.Background
    
    -- Header
    if self.Header then
        self.Header.BackgroundColor3 = Theme.Colors.BackgroundSecondary
        local border = self.Header:FindFirstChild("Border")
        if border then border.BackgroundColor3 = Theme.Colors.SurfaceBorder end
        
        local logoContainer = self.Header:FindFirstChild("LogoContainer")
        if logoContainer then
            logoContainer.BackgroundColor3 = Theme.Colors.Primary
            local icon = logoContainer:FindFirstChild("LogoIcon")
            if icon then icon.TextColor3 = Theme.Colors.TextPrimary end
        end
        
        if self.TitleLabel then
            self.TitleLabel.TextColor3 = Theme.Colors.TextPrimary
        end
    end
    
    -- Sidebar
    if self.Sidebar then
        self.Sidebar.BackgroundColor3 = Theme.Colors.BackgroundSecondary
        local border = self.Sidebar:FindFirstChild("Border")
        if border then border.BackgroundColor3 = Theme.Colors.SurfaceBorder end
    end
    
    -- Update tabs
    for tabId, tabData in pairs(self.Tabs) do
        if tabData.Button then
            local isActive = tabId == self.CurrentTab
            tabData.Button.BackgroundTransparency = isActive and 0 or 1
            tabData.Button.BackgroundColor3 = Theme.Colors.Primary
            
            local icon = tabData.Button:FindFirstChild("Icon")
            if icon then
                icon.TextColor3 = isActive and Theme.Colors.TextPrimary or Theme.Colors.TextSecondary
            end
            
            local text = tabData.Button:FindFirstChild("Text")
            if text then
                text.TextColor3 = isActive and Theme.Colors.TextPrimary or Theme.Colors.TextSecondary
            end
            
            local indicator = tabData.Button:FindFirstChild("Indicator")
            if indicator then
                indicator.BackgroundColor3 = Theme.Colors.Primary
                indicator.BackgroundTransparency = isActive and 0 or 1
            end
        end
    end
    
    -- Content area
    if self.ContentArea then
        self.ContentArea.BackgroundColor3 = Theme.Colors.Background
    end
    
    if self.Content then
        self.Content.ScrollBarImageColor3 = Theme.Colors.Primary
    end
end

-- Register for theme updates
function Container:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

return Container

