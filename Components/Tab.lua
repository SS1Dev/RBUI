--[[
    UIFramework Tab Component
    Tab navigation with icon support and content switching
]]

local Tab = {}
Tab.__index = Tab

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Tab Group
    
    @param config {
        Tabs: table - Array of tab configs {Id, Text, Icon, Content}
        ActiveTab: string - Initial active tab ID
        Orientation: string - "horizontal" or "vertical"
        Size: UDim2 - Container size
        TabSize: UDim2 - Individual tab button size
        Parent: Instance - Parent instance
        OnChange: function(tabId) - Tab change callback
    }
]]
function Tab.new(config)
    local self = setmetatable({}, Tab)
    
    config = config or {}
    
    self.Tabs = config.Tabs or {}
    self.ActiveTab = config.ActiveTab
    self.Orientation = config.Orientation or "horizontal"
    self.Size = config.Size or UDim2.new(1, 0, 0, 400)
    self.TabSize = config.TabSize
    self.Parent = config.Parent
    
    -- Callbacks
    self.OnChange = config.OnChange
    
    self.TabButtons = {}
    self.TabContents = {}
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Tab:_Build()
    -- Container
    self.Frame = Utilities.Create("Frame", {
        Name = "TabGroup",
        Size = self.Size,
        BackgroundTransparency = 1,
        Parent = self.Parent
    })
    
    -- Tab header
    local headerHeight = self.Orientation == "horizontal" and 44 or self.Size.Y.Offset
    local headerWidth = self.Orientation == "horizontal" and self.Size.X.Offset or 180
    
    self.Header = Utilities.Create("Frame", {
        Name = "Header",
        Size = self.Orientation == "horizontal" 
            and UDim2.new(1, 0, 0, headerHeight)
            or UDim2.new(0, headerWidth, 1, 0),
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BorderSizePixel = 0,
        Parent = self.Frame
    })
    
    if self.Orientation == "horizontal" then
        -- Bottom border
        Utilities.Create("Frame", {
            Name = "Border",
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, -1),
            BackgroundColor3 = Theme.Colors.SurfaceBorder,
            BorderSizePixel = 0,
            Parent = self.Header
        })
    else
        -- Right border
        Utilities.Create("Frame", {
            Name = "Border",
            Size = UDim2.new(0, 1, 1, 0),
            Position = UDim2.new(1, -1, 0, 0),
            BackgroundColor3 = Theme.Colors.SurfaceBorder,
            BorderSizePixel = 0,
            Parent = self.Header
        })
    end
    
    -- Tab buttons container
    self.TabButtonsContainer = Utilities.Create("Frame", {
        Name = "TabButtons",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.Header
    })
    
    Utilities.ApplyPadding(self.TabButtonsContainer, Theme.Spacing.SM)
    Utilities.ApplyListLayout(self.TabButtonsContainer, {
        Direction = self.Orientation == "horizontal" 
            and Enum.FillDirection.Horizontal 
            or Enum.FillDirection.Vertical,
        HorizontalAlignment = self.Orientation == "horizontal" 
            and Enum.HorizontalAlignment.Left 
            or Enum.HorizontalAlignment.Center,
        VerticalAlignment = self.Orientation == "horizontal" 
            and Enum.VerticalAlignment.Center 
            or Enum.VerticalAlignment.Top,
        Padding = Theme.Spacing.XS
    })
    
    -- Content area
    self.ContentArea = Utilities.Create("Frame", {
        Name = "ContentArea",
        Size = self.Orientation == "horizontal"
            and UDim2.new(1, 0, 1, -headerHeight)
            or UDim2.new(1, -headerWidth, 1, 0),
        Position = self.Orientation == "horizontal"
            and UDim2.new(0, 0, 0, headerHeight)
            or UDim2.new(0, headerWidth, 0, 0),
        BackgroundTransparency = 1,
        Parent = self.Frame
    })
    
    -- Build tabs
    for i, tabConfig in ipairs(self.Tabs) do
        self:_BuildTab(tabConfig, i)
    end
    
    -- Set initial active tab
    if not self.ActiveTab and #self.Tabs > 0 then
        self.ActiveTab = self.Tabs[1].Id or "tab_1"
    end
    
    if self.ActiveTab then
        self:SelectTab(self.ActiveTab)
    end
end

function Tab:_BuildTab(tabConfig, index)
    local tabId = tabConfig.Id or "tab_" .. index
    local tabText = tabConfig.Text or "Tab " .. index
    local tabIcon = tabConfig.Icon
    
    -- Calculate tab size
    local tabButtonSize
    if self.TabSize then
        tabButtonSize = self.TabSize
    elseif self.Orientation == "horizontal" then
        tabButtonSize = UDim2.new(0, 120, 0, 32)
    else
        tabButtonSize = UDim2.new(1, -Theme.Spacing.SM * 2, 0, 40)
    end
    
    -- Tab button
    local tabBtn = Utilities.Create("TextButton", {
        Name = "Tab_" .. tabId,
        Size = tabButtonSize,
        BackgroundColor3 = Theme.Colors.TabInactive,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = index,
        Parent = self.TabButtonsContainer
    })
    
    Utilities.ApplyCorner(tabBtn, Theme.BorderRadius.MD)
    
    -- Button content
    local contentContainer = Utilities.Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = tabBtn
    })
    
    Utilities.ApplyListLayout(contentContainer, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon (ImageLabel)
    local iconLabel
    if tabIcon then
        iconLabel = Utilities.Create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Image = Icons.Get(tabIcon),
            ImageColor3 = Theme.Colors.TextSecondary,
            ScaleType = Enum.ScaleType.Fit,
            LayoutOrder = 1,
            Parent = contentContainer
        })
    end
    
    -- Text
    local textLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = tabText,
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        LayoutOrder = 2,
        Parent = contentContainer
    })
    
    -- Active indicator (bottom line for horizontal, left line for vertical)
    local indicator
    if self.Orientation == "horizontal" then
        indicator = Utilities.Create("Frame", {
            Name = "Indicator",
            Size = UDim2.new(0.6, 0, 0, 2),
            Position = UDim2.new(0.5, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 1),
            BackgroundColor3 = Theme.Colors.Primary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabBtn
        })
    else
        indicator = Utilities.Create("Frame", {
            Name = "Indicator",
            Size = UDim2.new(0, 3, 0.6, 0),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Colors.Primary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabBtn
        })
    end
    Utilities.ApplyCorner(indicator, Theme.BorderRadius.Full)
    
    -- Tab content
    local tabContent = Utilities.Create("ScrollingFrame", {
        Name = "Content_" .. tabId,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = self.ContentArea
    })
    
    Utilities.ApplyPadding(tabContent, Theme.Spacing.MD)
    Utilities.ApplyListLayout(tabContent, {
        Padding = Theme.Spacing.MD
    })
    
    -- Store references
    self.TabButtons[tabId] = {
        Button = tabBtn,
        Icon = iconLabel,
        Text = textLabel,
        Indicator = indicator
    }
    self.TabContents[tabId] = tabContent
    
    -- Events
    tabBtn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tabId then
            Utilities.Tween(tabBtn, { BackgroundTransparency = 0.5 })
        end
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tabId then
            Utilities.Tween(tabBtn, { BackgroundTransparency = 1 })
        end
    end)
    
    tabBtn.Activated:Connect(function()
        self:SelectTab(tabId)
    end)
    
    return tabContent, tabId
end

-- Select tab
function Tab:SelectTab(tabId)
    -- Deselect current tab
    if self.ActiveTab and self.TabButtons[self.ActiveTab] then
        local currentTab = self.TabButtons[self.ActiveTab]
        Utilities.Tween(currentTab.Button, { 
            BackgroundTransparency = 1,
            BackgroundColor3 = Theme.Colors.TabInactive
        })
        if currentTab.Icon then
            Utilities.Tween(currentTab.Icon, { ImageColor3 = Theme.Colors.TextSecondary })
        end
        Utilities.Tween(currentTab.Text, { TextColor3 = Theme.Colors.TextSecondary })
        Utilities.Tween(currentTab.Indicator, { BackgroundTransparency = 1 })
        
        if self.TabContents[self.ActiveTab] then
            self.TabContents[self.ActiveTab].Visible = false
        end
    end
    
    -- Select new tab
    if self.TabButtons[tabId] then
        self.ActiveTab = tabId
        local newTab = self.TabButtons[tabId]
        
        Utilities.Tween(newTab.Button, { 
            BackgroundTransparency = 0,
            BackgroundColor3 = Theme.Colors.TabActive
        })
        if newTab.Icon then
            Utilities.Tween(newTab.Icon, { ImageColor3 = Theme.Colors.TextPrimary })
        end
        Utilities.Tween(newTab.Text, { TextColor3 = Theme.Colors.TextPrimary })
        Utilities.Tween(newTab.Indicator, { BackgroundTransparency = 0 })
        
        if self.TabContents[tabId] then
            self.TabContents[tabId].Visible = true
        end
        
        if self.OnChange then
            self.OnChange(tabId)
        end
    end
end

-- Get tab content
function Tab:GetTabContent(tabId)
    return self.TabContents[tabId]
end

-- Add tab
function Tab:AddTab(tabConfig)
    local index = #self.Tabs + 1
    table.insert(self.Tabs, tabConfig)
    return self:_BuildTab(tabConfig, index)
end

-- Remove tab
function Tab:RemoveTab(tabId)
    if self.TabButtons[tabId] then
        self.TabButtons[tabId].Button:Destroy()
        self.TabButtons[tabId] = nil
    end
    
    if self.TabContents[tabId] then
        self.TabContents[tabId]:Destroy()
        self.TabContents[tabId] = nil
    end
    
    for i, tab in ipairs(self.Tabs) do
        if tab.Id == tabId then
            table.remove(self.Tabs, i)
            break
        end
    end
    
    -- Select first available tab if current was removed
    if self.ActiveTab == tabId then
        self.ActiveTab = nil
        if #self.Tabs > 0 then
            self:SelectTab(self.Tabs[1].Id)
        end
    end
end

-- Get active tab
function Tab:GetActiveTab()
    return self.ActiveTab
end

-- Get frame
function Tab:GetFrame()
    return self.Frame
end

-- Apply theme
function Tab:ApplyTheme()
    -- Update tab bar background
    if self.TabBar then
        Utilities.Tween(self.TabBar, { BackgroundColor3 = Theme.Colors.BackgroundSecondary }, 0.2)
    end
    
    -- Update content area
    if self.ContentArea then
        Utilities.Tween(self.ContentArea, { BackgroundColor3 = Theme.Colors.Background }, 0.2)
    end
    
    -- Update all tabs
    for tabId, tabData in pairs(self.TabButtons) do
        local isActive = tabId == self.ActiveTab
        
        Utilities.Tween(tabData.Button, {
            BackgroundTransparency = isActive and 0 or 1,
            BackgroundColor3 = isActive and Theme.Colors.TabActive or Theme.Colors.TabInactive
        }, 0.2)
        
        if tabData.Icon then
            Utilities.Tween(tabData.Icon, {
                ImageColor3 = isActive and Theme.Colors.TextPrimary or Theme.Colors.TextSecondary
            }, 0.2)
        end
        
        Utilities.Tween(tabData.Text, {
            TextColor3 = isActive and Theme.Colors.TextPrimary or Theme.Colors.TextSecondary
        }, 0.2)
        
        Utilities.Tween(tabData.Indicator, {
            BackgroundColor3 = Theme.Colors.TabActive,
            BackgroundTransparency = isActive and 0 or 1
        }, 0.2)
    end
end

-- Register for theme updates
function Tab:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Tab:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Tab

