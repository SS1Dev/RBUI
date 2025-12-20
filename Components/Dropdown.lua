--[[
    UIFramework Dropdown Component
    Single and Multiple selection dropdown with icon support
]]

local Dropdown = {}
Dropdown.__index = Dropdown

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Dropdown
    
    @param config {
        Label: string - Label text (displayed on left side)
        LabelIcon: string - Icon for label
        Text: string - Dropdown placeholder
        Icon: string - Font Awesome icon name (inside dropdown)
        Options: table - Array of options {Text, Value, Icon}
        Value: any - Initial selected value (single) or table (multiple)
        Multiple: boolean - Allow multiple selection
        MaxHeight: number - Maximum dropdown height
        Searchable: boolean - Enable search
        Size: UDim2 - Dropdown size
        DropdownWidth: UDim - Width of dropdown field (default: 0.5 scale)
        Disabled: boolean - Disable dropdown
        Parent: Instance - Parent instance
        OnChange: function(value) - Selection change callback
        OnOpen: function() - Dropdown open callback
        OnClose: function() - Dropdown close callback
    }
]]
function Dropdown.new(config)
    local self = setmetatable({}, Dropdown)
    
    config = config or {}
    
    self.Label = config.Label
    self.LabelIcon = config.LabelIcon
    self.Text = config.Text or "Select..."
    self.Icon = config.Icon
    self.Options = config.Options or {}
    self.Multiple = config.Multiple or false
    self.MaxHeight = config.MaxHeight or 200
    self.Searchable = config.Searchable or false
    self.Size = config.Size or UDim2.new(1, 0, 0, Theme.Sizes.InputHeight)
    self.DropdownWidth = config.DropdownWidth or UDim.new(0.5, 0)
    self.Disabled = config.Disabled or false
    self.Parent = config.Parent
    
    -- Initialize value
    if self.Multiple then
        self.Value = config.Value or {}
    else
        self.Value = config.Value
    end
    
    -- Callbacks
    self.OnChange = config.OnChange
    self.OnOpen = config.OnOpen
    self.OnClose = config.OnClose
    
    self.IsOpen = false
    self.OptionButtons = {}
    self.FilteredOptions = {} -- Will be initialized with all options in _Build
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Dropdown:_Build()
    -- Main container (for label + dropdown layout)
    self.Frame = Utilities.Create("Frame", {
        Name = "Dropdown",
        Size = self.Size,
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        ZIndex = 10,
        Parent = self.Parent
    })
    
    -- Calculate dropdown width (always show label, so always use DropdownWidth)
    local dropdownWidth = self.DropdownWidth
    
    -- Left side (Label + Icon) - always show label
    self.LeftContainer = Utilities.Create("Frame", {
        Name = "Left",
        Size = UDim2.new(1 - dropdownWidth.Scale, -dropdownWidth.Offset - Theme.Spacing.MD, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Parent = self.Frame
    })
    
    Utilities.ApplyListLayout(self.LeftContainer, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Label Icon
    if self.LabelIcon then
        self.LabelIconElement = Icons.CreateLabel(self.LabelIcon, 16, Theme.Colors.TextSecondary)
        self.LabelIconElement.LayoutOrder = 1
        self.LabelIconElement.Parent = self.LeftContainer
    end
    
    -- Label Text (always show)
    self.LabelText = Utilities.Create("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, self.LabelIcon and -26 or 0, 1, 0),
        BackgroundTransparency = 1,
        Text = self.Label or "Dropdown",
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 2,
        Parent = self.LeftContainer
    })
    
    -- Dropdown button container
    self.DropdownContainer = Utilities.Create("Frame", {
        Name = "DropdownContainer",
        Size = UDim2.new(dropdownWidth.Scale, dropdownWidth.Offset, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        Parent = self.Frame
    })
    
    -- Main button
    self.MainButton = Utilities.Create("TextButton", {
        Name = "MainButton",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Colors.InputBackground,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.DropdownContainer
    })
    
    Utilities.ApplyCorner(self.MainButton, Theme.BorderRadius.LG)
    self.Stroke = Utilities.ApplyStroke(self.MainButton, {
        Color = Theme.Colors.InputBorder,
        Thickness = 1,
        Transparency = 0.5
    })
    
    -- Content container
    local contentPadding = Theme.Spacing.MD
    
    -- Icon
    if self.Icon then
        self.IconLabel = Icons.CreateLabel(self.Icon, 18, Theme.Colors.TextSecondary)
        self.IconLabel.Position = UDim2.new(0, contentPadding, 0.5, 0)
        self.IconLabel.AnchorPoint = Vector2.new(0, 0.5)
        self.IconLabel.Parent = self.MainButton
    end
    
    -- Selected text
    local iconOffset = self.Icon and 32 or 0
    self.SelectedText = Utilities.Create("TextLabel", {
        Name = "SelectedText",
        Size = UDim2.new(1, -(contentPadding * 2 + iconOffset + 24), 1, 0),
        Position = UDim2.new(0, contentPadding + iconOffset, 0, 0),
        BackgroundTransparency = 1,
        Text = self:_GetDisplayText(),
        TextColor3 = self:_HasValue() and Theme.Colors.TextPrimary or Theme.Colors.TextMuted,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = self.MainButton
    })
    
    -- Arrow icon
    self.Arrow = Icons.CreateLabel("chevron-down", 16, Theme.Colors.TextSecondary)
    self.Arrow.Name = "Arrow"
    self.Arrow.Position = UDim2.new(1, -contentPadding - 16, 0.5, 0)
    self.Arrow.AnchorPoint = Vector2.new(0, 0.5)
    self.Arrow.Parent = self.MainButton
    
    -- Get ScreenGui for overlay
    local Players = game:GetService("Players")
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create or get dropdown overlay ScreenGui
    self.OverlayGui = playerGui:FindFirstChild("UIFramework_DropdownOverlay")
    if not self.OverlayGui then
        self.OverlayGui = Utilities.Create("ScreenGui", {
            Name = "UIFramework_DropdownOverlay",
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 1000, -- Above other UIs
            Parent = playerGui
        })
    end
    
    -- Dropdown panel (rendered in overlay for proper display)
    self.Panel = Utilities.Create("Frame", {
        Name = "DropdownPanel",
        Size = UDim2.new(0, self.Size.X.Offset > 0 and self.Size.X.Offset or 200, 0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Colors.DropdownBackground,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false,
        Parent = self.OverlayGui
    })
    
    Utilities.ApplyCorner(self.Panel, Theme.BorderRadius.MD)
    Utilities.ApplyStroke(self.Panel, {
        Color = Theme.Colors.SurfaceBorder,
        Thickness = 1
    })
    
    -- Search box (if searchable)
    local searchHeight = 0
    if self.Searchable then
        searchHeight = Theme.Sizes.InputHeight + Theme.Spacing.SM
        
        self.SearchContainer = Utilities.Create("Frame", {
            Name = "SearchContainer",
            Size = UDim2.new(1, 0, 0, Theme.Sizes.InputHeight),
            BackgroundTransparency = 1,
            ZIndex = 101,
            Parent = self.Panel
        })
        
        Utilities.ApplyPadding(self.SearchContainer, {
            Top = Theme.Spacing.SM,
            Left = Theme.Spacing.SM,
            Right = Theme.Spacing.SM
        })
        
        self.SearchBox = Utilities.Create("TextBox", {
            Name = "SearchBox",
            Size = UDim2.new(1, 0, 0, Theme.Sizes.InputHeight - Theme.Spacing.SM),
            BackgroundColor3 = Theme.Colors.BackgroundTertiary,
            BorderSizePixel = 0,
            Text = "",
            PlaceholderText = "Search...",
            PlaceholderColor3 = Theme.Colors.TextMuted,
            TextColor3 = Theme.Colors.TextPrimary,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamily,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
            ZIndex = 101,
            Parent = self.SearchContainer
        })
        
        Utilities.ApplyCorner(self.SearchBox, Theme.BorderRadius.SM)
        Utilities.ApplyPadding(self.SearchBox, Theme.Spacing.SM)
        
        self.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            self:_FilterOptions(self.SearchBox.Text)
        end)
    end
    
    -- Options scroll frame (auto scrollbar)
    self.OptionsContainer = Utilities.Create("ScrollingFrame", {
        Name = "Options",
        Size = UDim2.new(1, 0, 1, -searchHeight),
        Position = UDim2.new(0, 0, 0, searchHeight),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Colors.Primary,
        ScrollBarImageTransparency = 0.3,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 101,
        Parent = self.Panel
    })
    
    Utilities.ApplyPadding(self.OptionsContainer, Theme.Spacing.XS)
    Utilities.ApplyListLayout(self.OptionsContainer, {
        Padding = 2
    })
    
    -- Initialize FilteredOptions with all options and build
    for _, option in ipairs(self.Options) do
        table.insert(self.FilteredOptions, option)
    end
    self:_BuildOptions()
    
    -- Events
    self.MainButton.Activated:Connect(function()
        if not self.Disabled then
            self:Toggle()
        end
    end)
    
    self.MainButton.MouseEnter:Connect(function()
        if not self.Disabled then
            Utilities.Tween(self.Stroke, { Color = Theme.Colors.Primary })
        end
    end)
    
    self.MainButton.MouseLeave:Connect(function()
        if not self.Disabled and not self.IsOpen then
            Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder })
        end
    end)
    
    -- Click outside to close
    local UserInputService = game:GetService("UserInputService")
    local GuiService = game:GetService("GuiService")
    self._clickConnection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if self.IsOpen then
                -- Check if click is outside dropdown
                -- GetMouseLocation includes GuiInset, AbsolutePosition doesn't - need to compensate
                local guiInset = GuiService:GetGuiInset()
                local mousePos = UserInputService:GetMouseLocation() - guiInset
                local buttonPos = self.MainButton.AbsolutePosition
                local buttonSize = self.MainButton.AbsoluteSize
                local panelPos = self.Panel.AbsolutePosition
                local panelSize = self.Panel.AbsoluteSize
                
                local inButton = mousePos.X >= buttonPos.X and mousePos.X <= buttonPos.X + buttonSize.X
                    and mousePos.Y >= buttonPos.Y and mousePos.Y <= buttonPos.Y + buttonSize.Y
                local inPanel = mousePos.X >= panelPos.X and mousePos.X <= panelPos.X + panelSize.X
                    and mousePos.Y >= panelPos.Y and mousePos.Y <= panelPos.Y + panelSize.Y
                
                if not inButton and not inPanel then
                    self:Close()
                end
            end
        end
    end)
    
    -- Cleanup panel when frame is destroyed
    self.Frame.Destroying:Connect(function()
        if self.Panel then
            self.Panel:Destroy()
        end
        if self._clickConnection then
            self._clickConnection:Disconnect()
        end
    end)
    
    -- Apply disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
end

function Dropdown:_BuildOptions()
    -- Clear existing
    for _, btn in pairs(self.OptionButtons) do
        btn:Destroy()
    end
    self.OptionButtons = {}
    
    -- Remove existing "No results" message
    local noResultsMsg = self.OptionsContainer:FindFirstChild("NoResults")
    if noResultsMsg then
        noResultsMsg:Destroy()
    end
    
    -- Use FilteredOptions (will be empty array if search found nothing)
    local options = self.FilteredOptions
    
    -- Show "No results" message if search returned nothing
    if #options == 0 and self.Searchable and self.SearchBox and self.SearchBox.Text ~= "" then
        Utilities.Create("TextLabel", {
            Name = "NoResults",
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            Text = "No results found",
            TextColor3 = Theme.Colors.TextMuted,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamily,
            ZIndex = 102,
            Parent = self.OptionsContainer
        })
        return
    end
    
    for i, option in ipairs(options) do
        local optionText = type(option) == "table" and option.Text or tostring(option)
        local optionValue = type(option) == "table" and option.Value or option
        local optionIcon = type(option) == "table" and option.Icon or nil
        
        local optBtn = Utilities.Create("TextButton", {
            Name = "Option_" .. i,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Theme.Colors.DropdownItemHover,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = i,
            ZIndex = 102,
            Parent = self.OptionsContainer
        })
        
        Utilities.ApplyCorner(optBtn, Theme.BorderRadius.SM)
        
        -- Checkbox for multiple selection
        local leftOffset = Theme.Spacing.SM
        if self.Multiple then
            local checkbox = Utilities.Create("Frame", {
                Name = "Checkbox",
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, Theme.Spacing.SM, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = self:_IsSelected(optionValue) and Theme.Colors.Primary or Theme.Colors.InputBackground,
                BorderSizePixel = 0,
                ZIndex = 103,
                Parent = optBtn
            })
            
            Utilities.ApplyCorner(checkbox, Theme.BorderRadius.SM)
            Utilities.ApplyStroke(checkbox, {
                Color = self:_IsSelected(optionValue) and Theme.Colors.Primary or Theme.Colors.InputBorder,
                Thickness = 1
            })
            
            Utilities.Create("TextLabel", {
                Name = "Check",
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Text = Icons.Get("check"),
                TextColor3 = Theme.Colors.TextPrimary,
                TextTransparency = self:_IsSelected(optionValue) and 0 or 1,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                ZIndex = 104,
                Parent = checkbox
            })
            
            leftOffset = Theme.Spacing.SM + 24
        end
        
        -- Option icon
        if optionIcon then
            local optIcon = Icons.CreateLabel(optionIcon, 16, Theme.Colors.TextSecondary)
            optIcon.Position = UDim2.new(0, leftOffset, 0.5, 0)
            optIcon.AnchorPoint = Vector2.new(0, 0.5)
            optIcon.ZIndex = 103
            optIcon.Parent = optBtn
            leftOffset = leftOffset + 24
        end
        
        -- Option text
        Utilities.Create("TextLabel", {
            Name = "Text",
            Size = UDim2.new(1, -(leftOffset + Theme.Spacing.SM), 1, 0),
            Position = UDim2.new(0, leftOffset, 0, 0),
            BackgroundTransparency = 1,
            Text = optionText,
            TextColor3 = Theme.Colors.TextPrimary,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamily,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 103,
            Parent = optBtn
        })
        
        -- Selected indicator (single selection)
        if not self.Multiple and self:_IsSelected(optionValue) then
            local selectedIcon = Icons.CreateLabel("check", 16, Theme.Colors.Primary)
            selectedIcon.Name = "Selected"
            selectedIcon.Position = UDim2.new(1, -Theme.Spacing.SM - 16, 0.5, 0)
            selectedIcon.AnchorPoint = Vector2.new(0, 0.5)
            selectedIcon.ZIndex = 103
            selectedIcon.Parent = optBtn
        end
        
        -- Hover effect
        optBtn.MouseEnter:Connect(function()
            Utilities.Tween(optBtn, { BackgroundTransparency = 0 })
        end)
        
        optBtn.MouseLeave:Connect(function()
            Utilities.Tween(optBtn, { BackgroundTransparency = 1 })
        end)
        
        -- Click handler
        optBtn.Activated:Connect(function()
            self:_SelectOption(optionValue, optionText)
        end)
        
        table.insert(self.OptionButtons, optBtn)
    end
end

function Dropdown:_FilterOptions(searchText)
    searchText = string.lower(searchText)
    self.FilteredOptions = {}
    
    if searchText == "" then
        -- Empty search = show all options
        for _, option in ipairs(self.Options) do
            table.insert(self.FilteredOptions, option)
        end
    else
        -- Filter by search text
        for _, option in ipairs(self.Options) do
            local optionText = type(option) == "table" and option.Text or tostring(option)
            if string.find(string.lower(optionText), searchText, 1, true) then
                table.insert(self.FilteredOptions, option)
            end
        end
        -- If no results, FilteredOptions stays empty = will show "No results" message
    end
    
    self:_BuildOptions()
end

function Dropdown:_SelectOption(value, text)
    if self.Multiple then
        -- Toggle selection
        local index = table.find(self.Value, value)
        if index then
            table.remove(self.Value, index)
        else
            table.insert(self.Value, value)
        end
        self:_BuildOptions()
    else
        self.Value = value
        self:Close()
    end
    
    -- Update display
    self.SelectedText.Text = self:_GetDisplayText()
    self.SelectedText.TextColor3 = self:_HasValue() and Theme.Colors.TextPrimary or Theme.Colors.TextMuted
    
    if self.OnChange then
        self.OnChange(self.Value)
    end
end

function Dropdown:_UpdateLabelTheme()
    if self.LabelText then
        self.LabelText.TextColor3 = Theme.Colors.TextPrimary
    end
    if self.LabelIconElement then
        self.LabelIconElement.TextColor3 = Theme.Colors.TextSecondary
    end
end

function Dropdown:_IsSelected(value)
    if self.Multiple then
        return table.find(self.Value, value) ~= nil
    else
        return self.Value == value
    end
end

function Dropdown:_HasValue()
    if self.Multiple then
        return #self.Value > 0
    else
        return self.Value ~= nil
    end
end

function Dropdown:_GetDisplayText()
    if self.Multiple then
        if #self.Value == 0 then
            return self.Text
        elseif #self.Value == 1 then
            -- Find text for value
            for _, option in ipairs(self.Options) do
                local optionValue = type(option) == "table" and option.Value or option
                if optionValue == self.Value[1] then
                    return type(option) == "table" and option.Text or tostring(option)
                end
            end
            return tostring(self.Value[1])
        else
            return #self.Value .. " selected"
        end
    else
        if self.Value == nil then
            return self.Text
        end
        -- Find text for value
        for _, option in ipairs(self.Options) do
            local optionValue = type(option) == "table" and option.Value or option
            if optionValue == self.Value then
                return type(option) == "table" and option.Text or tostring(option)
            end
        end
        return tostring(self.Value)
    end
end

-- Toggle dropdown
function Dropdown:Toggle()
    if self.IsOpen then
        self:Close()
    else
        self:Open()
    end
end

-- Open dropdown
function Dropdown:Open()
    if self.IsOpen or self.Disabled then return end
    
    self.IsOpen = true
    self.Panel.Visible = true
    
    -- Calculate height
    local optionCount = #self.Options
    local optionHeight = 36 + 2 -- height + padding
    local searchHeight = self.Searchable and (Theme.Sizes.InputHeight + Theme.Spacing.SM) or 0
    local totalHeight = math.min(
        optionCount * optionHeight + Theme.Spacing.XS * 2 + searchHeight,
        self.MaxHeight
    )
    
    -- Position panel below the dropdown button (using absolute position)
    -- AbsolutePosition and ScreenGui with IgnoreGuiInset = false use the same coordinate system
    -- So we don't need to subtract the inset
    local buttonPos = self.MainButton.AbsolutePosition
    local buttonSize = self.MainButton.AbsoluteSize
    local panelX = buttonPos.X
    local panelY = buttonPos.Y + buttonSize.Y + Theme.Spacing.XS
    local panelWidth = buttonSize.X
    
    self.Panel.Position = UDim2.new(0, panelX, 0, panelY)
    Utilities.Tween(self.Panel, { Size = UDim2.new(0, panelWidth, 0, totalHeight) })
    Utilities.Tween(self.Arrow, { Rotation = 180 })
    Utilities.Tween(self.Stroke, { Color = Theme.Colors.Primary })
    
    if self.Searchable and self.SearchBox then
        self.SearchBox.Text = ""
        -- Reset FilteredOptions to all options
        self.FilteredOptions = {}
        for _, option in ipairs(self.Options) do
            table.insert(self.FilteredOptions, option)
        end
        self:_BuildOptions()
        task.delay(0.1, function()
            if self.SearchBox then
                self.SearchBox:CaptureFocus()
            end
        end)
    end
    
    if self.OnOpen then
        self.OnOpen()
    end
end

-- Close dropdown
function Dropdown:Close()
    if not self.IsOpen then return end
    
    self.IsOpen = false
    
    -- Collapse panel
    local currentWidth = self.Panel.Size.X.Offset
    Utilities.Tween(self.Panel, { Size = UDim2.new(0, currentWidth, 0, 0) })
    Utilities.Tween(self.Arrow, { Rotation = 0 })
    Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder })
    
    task.delay(0.2, function()
        if self.Panel then
            self.Panel.Visible = false
        end
    end)
    
    if self.OnClose then
        self.OnClose()
    end
end

-- Set value
function Dropdown:SetValue(value)
    if self.Multiple then
        self.Value = type(value) == "table" and value or {}
    else
        self.Value = value
    end
    
    self.SelectedText.Text = self:_GetDisplayText()
    self.SelectedText.TextColor3 = self:_HasValue() and Theme.Colors.TextPrimary or Theme.Colors.TextMuted
    self:_BuildOptions()
end

-- Get value
function Dropdown:GetValue()
    return self.Value
end

-- Set options
function Dropdown:SetOptions(options)
    self.Options = options
    -- Reset FilteredOptions to all new options
    self.FilteredOptions = {}
    for _, option in ipairs(options) do
        table.insert(self.FilteredOptions, option)
    end
    self:_BuildOptions()
end

-- Add option
function Dropdown:AddOption(option)
    table.insert(self.Options, option)
    self:_BuildOptions()
end

-- Remove option
function Dropdown:RemoveOption(value)
    for i, option in ipairs(self.Options) do
        local optionValue = type(option) == "table" and option.Value or option
        if optionValue == value then
            table.remove(self.Options, i)
            break
        end
    end
    self:_BuildOptions()
end

-- Clear selection
function Dropdown:Clear()
    if self.Multiple then
        self.Value = {}
    else
        self.Value = nil
    end
    
    self.SelectedText.Text = self.Text
    self.SelectedText.TextColor3 = Theme.Colors.TextMuted
    self:_BuildOptions()
end

-- Set disabled
function Dropdown:SetDisabled(disabled)
    self.Disabled = disabled
    
    if disabled then
        self:Close()
        self.MainButton.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.SelectedText.TextColor3 = Theme.Colors.TextDisabled
        self.Arrow.TextColor3 = Theme.Colors.TextDisabled
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextDisabled
        end
        if self.LabelText then
            self.LabelText.TextColor3 = Theme.Colors.TextDisabled
        end
        if self.LabelIconElement then
            self.LabelIconElement.TextColor3 = Theme.Colors.TextDisabled
        end
    else
        self.MainButton.BackgroundColor3 = Theme.Colors.InputBackground
        self.SelectedText.TextColor3 = self:_HasValue() and Theme.Colors.TextPrimary or Theme.Colors.TextMuted
        self.Arrow.TextColor3 = Theme.Colors.TextSecondary
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextSecondary
        end
        if self.LabelText then
            self.LabelText.TextColor3 = Theme.Colors.TextPrimary
        end
        if self.LabelIconElement then
            self.LabelIconElement.TextColor3 = Theme.Colors.TextSecondary
        end
    end
end

-- Get frame
function Dropdown:GetFrame()
    return self.Frame
end

-- Apply theme
function Dropdown:ApplyTheme()
    -- Update label theme
    self:_UpdateLabelTheme()
    
    if not self.Disabled then
        -- Main button
        Utilities.Tween(self.MainButton, { BackgroundColor3 = Theme.Colors.InputBackground }, 0.2)
        Utilities.Tween(self.Stroke, { Color = self.IsOpen and Theme.Colors.Primary or Theme.Colors.InputBorder }, 0.2)
        Utilities.Tween(self.SelectedText, { 
            TextColor3 = self:_HasValue() and Theme.Colors.TextPrimary or Theme.Colors.TextMuted 
        }, 0.2)
        Utilities.Tween(self.Arrow, { TextColor3 = Theme.Colors.TextSecondary }, 0.2)
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { TextColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
        
        -- Panel
        if self.Panel then
            Utilities.Tween(self.Panel, { BackgroundColor3 = Theme.Colors.DropdownBackground }, 0.2)
            
            -- Panel stroke
            local panelStroke = self.Panel:FindFirstChildOfClass("UIStroke")
            if panelStroke then
                Utilities.Tween(panelStroke, { Color = Theme.Colors.SurfaceBorder }, 0.2)
            end
        end
        
        -- Search box
        if self.SearchBox then
            Utilities.Tween(self.SearchBox, { 
                BackgroundColor3 = Theme.Colors.BackgroundTertiary,
                TextColor3 = Theme.Colors.TextPrimary
            }, 0.2)
            self.SearchBox.PlaceholderColor3 = Theme.Colors.TextMuted
        end
        
        -- Options container scrollbar
        if self.OptionsContainer then
            self.OptionsContainer.ScrollBarImageColor3 = Theme.Colors.Primary
        end
        
        -- Rebuild options to update all colors
        self:_BuildOptions()
    end
end

-- Register for theme updates
function Dropdown:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Dropdown:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Dropdown

