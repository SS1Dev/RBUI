--[[
    UIFramework Container Component
    Panel Style Container with Sidebar, Header, and Content Area
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

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
    self.Resizable = config.Resizable ~= false -- Enable resize by default
    self.ShowSidebar = config.ShowSidebar ~= false
    self.SidebarWidth = config.SidebarWidth or Theme.Sizes.SidebarWidth
    self.MinWidth = config.MinWidth or Theme.Sizes.MinPanelWidth
    self.MinHeight = config.MinHeight or Theme.Sizes.MinPanelHeight
    self.Parent = config.Parent or Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Transparency settings
    self.Transparency = config.Transparency or 0 -- Main panel transparency (0-1)
    self.HeaderTransparency = config.HeaderTransparency or 0
    self.SidebarTransparency = config.SidebarTransparency or 0
    self.ContentTransparency = config.ContentTransparency or 0
    
    -- Blur effect settings
    self.BlurEnabled = config.BlurEnabled or false
    self.BlurSize = config.BlurSize or 10
    
    -- Callbacks
    self.OnClose = config.OnClose
    self.OnMinimize = config.OnMinimize
    self.OnResize = config.OnResize
    
    self.Tabs = {}
    self.CurrentTab = nil
    self.IsMinimized = false
    self.IsVisible = true
    self.BlurEffect = nil
    
    self:_Build()
    self:_RegisterThemeListener()
    
    -- Apply blur if enabled
    if self.BlurEnabled then
        self:_CreateBlurEffect()
    end
    
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
    
    -- Main Frame (Modern - Supports Transparency)
    self.Frame = Utilities.Create("Frame", {
        Name = "MainFrame",
        Size = self.Size,
        Position = self.Position,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Colors.Background,
        BackgroundTransparency = self.Transparency,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ScreenGui
    })
    
    Utilities.ApplyCorner(self.Frame, Theme.BorderRadius.LG)
    
    -- Resize Handle (Bottom-Right Corner)
    if self.Resizable then
        self:_BuildResizeHandle()
    end
    
    -- Header
    self:_BuildHeader()
    
    -- Body Container
    self.BodyContainer = Utilities.Create("Frame", {
        Name = "BodyContainer",
        Size = UDim2.new(1, 0, 1, -Theme.Sizes.HeaderHeight),
        Position = UDim2.new(0, 0, 0, Theme.Sizes.HeaderHeight),
        BackgroundTransparency = 1,
        ClipsDescendants = true, -- Prevent content overflow
        Parent = self.Frame
    })
    
    -- Apply corner radius for bottom corners
    Utilities.ApplyCorner(self.BodyContainer, Theme.BorderRadius.LG)
    
    -- Sidebar
    if self.ShowSidebar then
        self:_BuildSidebar()
    end
    
    -- Content Area
    self:_BuildContentArea()
    
    -- Make draggable (from anywhere on the panel)
    if self.Draggable then
        Utilities.MakeDraggable(self.Frame, self.Frame)
    end
end

-- Build header section
function Container:_BuildHeader()
    self.Header = Utilities.Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, Theme.Sizes.HeaderHeight),
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BackgroundTransparency = self.HeaderTransparency,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.Frame
    })
    
    -- Apply corner radius to match main frame (for top corners)
    Utilities.ApplyCorner(self.Header, Theme.BorderRadius.LG)
    
    -- Header bottom border (subtle)
    Utilities.Create("Frame", {
        Name = "Border",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Colors.SurfaceBorder,
        BackgroundTransparency = 0.6,
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
    Utilities.ApplyCorner(logoContainer, Theme.BorderRadius.MD)
    
    -- Logo Icon
    local logoIcon = Icons.CreateLabel("box", 18, Theme.Colors.TextPrimary)
    logoIcon.Name = "LogoIcon"
    logoIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    logoIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    logoIcon.Parent = logoContainer
    
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
    
    -- Window Controls Container (macOS style)
    local controlsContainer = Utilities.Create("Frame", {
        Name = "Controls",
        Size = UDim2.new(0, 50, 0, 16),
        Position = UDim2.new(1, -Theme.Spacing.MD, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Parent = self.Header
    })
    
    Utilities.ApplyListLayout(controlsContainer, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Minimize Button (White circle)
    if self.Minimizable then
        self.MinimizeBtn = self:_CreateCircleButton(
            Color3.fromRGB(255, 255, 255), -- White
            function() self:ToggleMinimize() end
        )
        self.MinimizeBtn.Name = "MinimizeButton"
        self.MinimizeBtn.LayoutOrder = 1
        self.MinimizeBtn.Parent = controlsContainer
    end
    
    -- Close Button (Red circle)
    if self.Closable then
        self.CloseBtn = self:_CreateCircleButton(
            Color3.fromRGB(255, 95, 87), -- Red
            function() self:Close() end
        )
        self.CloseBtn.Name = "CloseButton"
        self.CloseBtn.LayoutOrder = 2
        self.CloseBtn.Parent = controlsContainer
    end
end

-- Create circular window control button (macOS style)
function Container:_CreateCircleButton(color, callback)
    local size = 14
    
    local btn = Utilities.Create("TextButton", {
        Size = UDim2.new(0, size, 0, size),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    })
    
    Utilities.ApplyCorner(btn, Theme.BorderRadius.Full)
    
    -- Subtle border
    Utilities.ApplyStroke(btn, {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 1,
        Transparency = 0.8
    })
    
    btn.MouseEnter:Connect(function()
        Utilities.Tween(btn, { BackgroundTransparency = 0.2 }, 0.1)
    end)
    
    btn.MouseLeave:Connect(function()
        Utilities.Tween(btn, { BackgroundTransparency = 0 }, 0.1)
    end)
    
    btn.Activated:Connect(callback)
    
    return btn
end

-- Build resize handle (invisible, just for resizing)
function Container:_BuildResizeHandle()
    local UserInputService = game:GetService("UserInputService")
    
    self.ResizeHandle = Utilities.Create("TextButton", {
        Name = "ResizeHandle",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 100,
        Parent = self.Frame
    })
    
    local isResizing = false
    local startPos = nil
    local startSize = nil
    
    self.ResizeHandle.MouseButton1Down:Connect(function()
        isResizing = true
        startPos = UserInputService:GetMouseLocation()
        startSize = self.Frame.Size
        
        local moveConnection
        local releaseConnection
        
        moveConnection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local currentPos = UserInputService:GetMouseLocation()
                local delta = currentPos - startPos
                
                local newWidth = math.max(self.MinWidth, startSize.X.Offset + delta.X)
                local newHeight = math.max(self.MinHeight, startSize.Y.Offset + delta.Y)
                
                self.Frame.Size = UDim2.new(0, newWidth, 0, newHeight)
                self.Size = self.Frame.Size
                
                if self.OnResize then
                    self.OnResize(newWidth, newHeight)
                end
            end
        end)
        
        releaseConnection = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isResizing = false
                
                if moveConnection then moveConnection:Disconnect() end
                if releaseConnection then releaseConnection:Disconnect() end
            end
        end)
    end)
end

-- Build sidebar (auto-fit width to menu content)
function Container:_BuildSidebar()
    self.Sidebar = Utilities.Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 0, 1, 0), -- Height 100%, Width auto
        AutomaticSize = Enum.AutomaticSize.X, -- Auto width based on content
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BackgroundTransparency = self.SidebarTransparency,
        BorderSizePixel = 0,
        ClipsDescendants = true, -- Prevent content overflow
        Parent = self.BodyContainer
    })
    
    -- Min/Max width constraint
    Utilities.Create("UISizeConstraint", {
        MinSize = Vector2.new(100, 0), -- Minimum 100px width
        MaxSize = Vector2.new(200, math.huge), -- Maximum 200px width
        Parent = self.Sidebar
    })
    
    -- Apply corner radius for bottom-left corner
    Utilities.ApplyCorner(self.Sidebar, Theme.BorderRadius.LG)
    
    -- Sidebar right border (subtle)
    Utilities.Create("Frame", {
        Name = "Border",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = Theme.Colors.SurfaceBorder,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = self.Sidebar
    })
    
    -- Sidebar content (auto scrollbar)
    self.SidebarContent = Utilities.Create("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(0, 0, 1, 0), -- Height 100%, Width auto
        AutomaticSize = Enum.AutomaticSize.X, -- Auto width
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        ScrollBarImageTransparency = 0.5,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ClipsDescendants = true, -- Prevent content overflow
        Parent = self.Sidebar
    })
    
    Utilities.ApplyPadding(self.SidebarContent, Theme.Spacing.SM)
    Utilities.ApplyListLayout(self.SidebarContent, {
        Padding = Theme.Spacing.XS
    })
end

-- Build content area (positioned next to auto-sized sidebar)
function Container:_BuildContentArea()
    -- Initial offset (will be updated when sidebar size changes)
    local initialOffset = self.ShowSidebar and 100 or 0 -- Min sidebar width
    
    self.ContentArea = Utilities.Create("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -initialOffset, 1, 0),
        Position = UDim2.new(0, initialOffset, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true, -- Prevent content overflow
        Parent = self.BodyContainer
    })
    
    -- Update content area position when sidebar size changes
    if self.ShowSidebar and self.Sidebar then
        self.Sidebar:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            local sidebarWidth = self.Sidebar.AbsoluteSize.X
            self.ContentArea.Size = UDim2.new(1, -sidebarWidth, 1, 0)
            self.ContentArea.Position = UDim2.new(0, sidebarWidth, 0, 0)
        end)
        
        -- Initial update
        task.defer(function()
            local sidebarWidth = self.Sidebar.AbsoluteSize.X
            self.ContentArea.Size = UDim2.new(1, -sidebarWidth, 1, 0)
            self.ContentArea.Position = UDim2.new(0, sidebarWidth, 0, 0)
        end)
    end
    
    -- Apply corner radius for bottom-right corner (when no sidebar, also bottom-left)
    Utilities.ApplyCorner(self.ContentArea, Theme.BorderRadius.LG)
    
    -- Content scroll frame (auto scrollbar)
    self.Content = Utilities.Create("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        ScrollBarImageTransparency = 0.3,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
        HorizontalScrollBarInset = Enum.ScrollBarInset.None,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
        ClipsDescendants = true, -- Prevent content overflow
        Parent = self.ContentArea
    })
    
    -- Padding inside scroll area
    Utilities.Create("UIPadding", {
        PaddingTop = UDim.new(0, Theme.Spacing.MD),
        PaddingBottom = UDim.new(0, Theme.Spacing.XL),
        PaddingLeft = UDim.new(0, Theme.Spacing.LG),
        PaddingRight = UDim.new(0, Theme.Spacing.LG),
        Parent = self.Content
    })
    -- Note: No UIListLayout here - tabs are shown one at a time, not stacked
end

-- Add a tab to sidebar
function Container:AddTab(config)
    config = config or {}
    
    local tabId = config.Id or Utilities.GenerateId()
    local tabName = config.Name or "Tab"
    local tabIcon = config.Icon or "folder"
    local callback = config.Callback
    
    -- Tab Button (Auto width to fit content)
    local tabButton = Utilities.Create("TextButton", {
        Name = "Tab_" .. tabId,
        Size = UDim2.new(0, 0, 0, 28), -- Height fixed, Width auto
        AutomaticSize = Enum.AutomaticSize.X, -- Auto width based on content
        BackgroundColor3 = Theme.Colors.BackgroundSecondary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.SidebarContent
    })
    
    Utilities.ApplyCorner(tabButton, Theme.BorderRadius.MD)
    
    -- Horizontal layout for icon + text
    Utilities.Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabButton
    })
    
    -- Padding inside tab button
    Utilities.Create("UIPadding", {
        PaddingLeft = UDim.new(0, Theme.Spacing.SM),
        PaddingRight = UDim.new(0, Theme.Spacing.SM),
        Parent = tabButton
    })
    
    -- Tab Icon
    local iconLabel = Icons.CreateLabel(tabIcon, 16, Theme.Colors.TextSecondary)
    iconLabel.Size = UDim2.new(0, 16, 0, 16)
    iconLabel.LayoutOrder = 1
    iconLabel.Parent = tabButton
    
    -- Tab Text (auto width)
    local textLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(0, 0, 0, 28),
        AutomaticSize = Enum.AutomaticSize.X, -- Auto width based on text
        BackgroundTransparency = 1,
        Text = tabName,
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = Theme.Typography.Small,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,
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
    
    -- Content container for this tab (auto-size for scrolling)
    local tabContent = Utilities.Create("Frame", {
        Name = "TabContent_" .. tabId,
        Size = UDim2.new(1, 0, 0, 0), -- Width 100%, Height auto
        AutomaticSize = Enum.AutomaticSize.Y, -- Auto height based on content
        BackgroundTransparency = 1,
        Visible = false,
        Parent = self.Content
    })
    
    -- List layout for tab content - items stack vertically
    local listLayout = Utilities.Create("UIListLayout", {
        Padding = UDim.new(0, Theme.Spacing.SM),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabContent
    })
    
    -- Update canvas size when content changes
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if tabContent.Visible then
            local padding = Theme.Spacing.MD + Theme.Spacing.XL -- Top + Bottom padding
            self.Content.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + padding)
        end
    end)
    
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
    -- Use white text on active tab (dark Primary background)
    local activeTextColor = Color3.fromRGB(255, 255, 255)
    
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
        Utilities.Tween(newTab.Icon, { TextColor3 = activeTextColor })
        Utilities.Tween(newTab.Text, { TextColor3 = activeTextColor })
        Utilities.Tween(newTab.Indicator, { BackgroundTransparency = 0 })
        newTab.Content.Visible = true
        
        -- Reset scroll position when switching tabs
        self.Content.CanvasPosition = Vector2.new(0, 0)
        
        -- Recalculate canvas size for new tab
        local listLayout = newTab.Content:FindFirstChildOfClass("UIListLayout")
        if listLayout then
            local padding = Theme.Spacing.MD + Theme.Spacing.XL
            self.Content.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + padding)
        end
    end
end

-- Get tab content
function Container:GetTabContent(tabId)
    if self.Tabs[tabId] then
        return self.Tabs[tabId].Content
    end
    return nil
end

-- Toggle minimize (instant, no animation)
function Container:ToggleMinimize()
    self.IsMinimized = not self.IsMinimized
    
    if self.IsMinimized then
        self._OriginalSize = self.Frame.Size
        self.Frame.Size = UDim2.new(0, self.Size.X.Offset, 0, Theme.Sizes.HeaderHeight)
        self.BodyContainer.Visible = false
    else
        self.Frame.Size = self._OriginalSize or self.Size
        self.BodyContainer.Visible = true
    end
    
    if self.OnMinimize then
        self.OnMinimize(self.IsMinimized)
    end
end

-- Show container (instant, no animation)
function Container:Show()
    self.IsVisible = true
    self.Frame.Visible = true
    self.Frame.Size = self.Size
    
    -- Show blur if enabled
    if self.BlurEnabled then
        self:_CreateBlurEffect()
    end
end

-- Hide container (instant, no animation)
function Container:Hide()
    self.IsVisible = false
    self.Frame.Visible = false
    
    -- Hide blur
    self:_RemoveBlurEffect()
end

-- Close container (instant, no animation)
function Container:Close()
    if self.OnClose then
        self.OnClose()
    end
    self:Hide()
    self:Destroy()
end

-- Destroy container
function Container:Destroy()
    -- Remove blur effect
    if self.BlurEffect then
        self.BlurEffect:Destroy()
        self.BlurEffect = nil
    end
    
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

-- Set transparency for all panel elements
function Container:SetTransparency(transparency)
    self.Transparency = transparency
    if self.Frame then
        Utilities.Tween(self.Frame, { BackgroundTransparency = transparency }, 0.2)
    end
    if self.Header then
        Utilities.Tween(self.Header, { BackgroundTransparency = transparency }, 0.2)
    end
    if self.Sidebar then
        Utilities.Tween(self.Sidebar, { BackgroundTransparency = transparency }, 0.2)
    end
end

-- Set individual transparency values
function Container:SetHeaderTransparency(transparency)
    self.HeaderTransparency = transparency
    if self.Header then
        Utilities.Tween(self.Header, { BackgroundTransparency = transparency }, 0.2)
    end
end

function Container:SetSidebarTransparency(transparency)
    self.SidebarTransparency = transparency
    if self.Sidebar then
        Utilities.Tween(self.Sidebar, { BackgroundTransparency = transparency }, 0.2)
    end
end

-- Apply current theme colors to all container elements
function Container:ApplyTheme()
    if not self.Frame then return end
    
    -- Main frame
    Utilities.Tween(self.Frame, { BackgroundColor3 = Theme.Colors.Background }, 0.2)
    
    -- Header
    if self.Header then
        Utilities.Tween(self.Header, { BackgroundColor3 = Theme.Colors.BackgroundSecondary }, 0.2)
        
        local border = self.Header:FindFirstChild("Border")
        if border then 
            Utilities.Tween(border, { BackgroundColor3 = Theme.Colors.SurfaceBorder }, 0.2)
        end
        
        local logoContainer = self.Header:FindFirstChild("LogoContainer")
        if logoContainer then
            Utilities.Tween(logoContainer, { BackgroundColor3 = Theme.Colors.Primary }, 0.2)
            local icon = logoContainer:FindFirstChild("LogoIcon")
            if icon then 
                Utilities.Tween(icon, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
            end
        end
        
        if self.TitleLabel then
            Utilities.Tween(self.TitleLabel, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
        end
        
        -- Window controls (circular buttons don't change with theme)
    end
    
    -- Sidebar
    if self.Sidebar then
        Utilities.Tween(self.Sidebar, { BackgroundColor3 = Theme.Colors.BackgroundSecondary }, 0.2)
        
        local border = self.Sidebar:FindFirstChild("Border")
        if border then 
            Utilities.Tween(border, { BackgroundColor3 = Theme.Colors.SurfaceBorder }, 0.2)
        end
        
        -- Sidebar title
        if self.SidebarContent then
            local title = self.Sidebar:FindFirstChild("SidebarTitle")
            if title then
                Utilities.Tween(title, { TextColor3 = Theme.Colors.TextMuted }, 0.2)
            end
        end
    end
    
    -- Update tabs (use white text on active tab for visibility)
    local activeTextColor = Color3.fromRGB(255, 255, 255)
    for tabId, tabData in pairs(self.Tabs) do
        if tabData.Button then
            local isActive = tabId == self.CurrentTab
            
            Utilities.Tween(tabData.Button, {
                BackgroundTransparency = isActive and 0 or 1,
                BackgroundColor3 = Theme.Colors.Primary
            }, 0.2)
            
            local icon = tabData.Button:FindFirstChild("Icon")
            if icon then
                Utilities.Tween(icon, {
                    TextColor3 = isActive and activeTextColor or Theme.Colors.TextSecondary
                }, 0.2)
            end
            
            local text = tabData.Button:FindFirstChild("Text")
            if text then
                Utilities.Tween(text, {
                    TextColor3 = isActive and activeTextColor or Theme.Colors.TextSecondary
                }, 0.2)
            end
            
            local indicator = tabData.Button:FindFirstChild("Indicator")
            if indicator then
                Utilities.Tween(indicator, {
                    BackgroundColor3 = Theme.Colors.Primary,
                    BackgroundTransparency = isActive and 0 or 1
                }, 0.2)
            end
        end
    end
    
    -- Content area
    if self.ContentArea then
        Utilities.Tween(self.ContentArea, { BackgroundColor3 = Theme.Colors.Background }, 0.2)
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

-- Create blur effect
function Container:_CreateBlurEffect()
    if self.BlurEffect then return end
    
    self.BlurEffect = Instance.new("BlurEffect")
    self.BlurEffect.Name = "UIFramework_PanelBlur"
    self.BlurEffect.Size = 0
    self.BlurEffect.Parent = Lighting
    
    -- Animate blur in
    Utilities.Tween(self.BlurEffect, { Size = self.BlurSize }, 0.3)
end

-- Remove blur effect
function Container:_RemoveBlurEffect()
    if not self.BlurEffect then return end
    
    -- Animate blur out
    Utilities.Tween(self.BlurEffect, { Size = 0 }, 0.2)
    
    task.delay(0.2, function()
        if self.BlurEffect then
            self.BlurEffect:Destroy()
            self.BlurEffect = nil
        end
    end)
end

-- Set blur enabled
function Container:SetBlurEnabled(enabled)
    self.BlurEnabled = enabled
    
    if enabled and self.IsVisible then
        self:_CreateBlurEffect()
    else
        self:_RemoveBlurEffect()
    end
end

-- Set blur size
function Container:SetBlurSize(size)
    self.BlurSize = size
    
    if self.BlurEffect then
        Utilities.Tween(self.BlurEffect, { Size = size }, 0.2)
    end
end

return Container

