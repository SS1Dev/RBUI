--[[
    UIFramework Checkbox Component
    Checkbox with icon support and callbacks
]]

local Checkbox = {}
Checkbox.__index = Checkbox

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Checkbox
    
    @param config {
        Text: string - Checkbox label text
        Icon: string - Font Awesome icon name
        Value: boolean - Initial checked state
        Size: UDim2 - Container size
        Disabled: boolean - Disable checkbox
        Parent: Instance - Parent instance
        OnChange: function(value) - Value change callback
    }
]]
function Checkbox.new(config)
    local self = setmetatable({}, Checkbox)
    
    config = config or {}
    
    self.Text = config.Text or "Checkbox"
    self.Icon = config.Icon
    self.Value = config.Value or false
    self.Size = config.Size or UDim2.new(1, 0, 0, 28)
    self.Disabled = config.Disabled or false
    self.Parent = config.Parent
    
    -- Callbacks
    self.OnChange = config.OnChange
    
    self:_Build()
    
    return self
end

function Checkbox:_Build()
    -- Container
    self.Frame = Utilities.Create("TextButton", {
        Name = "Checkbox",
        Size = self.Size,
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = self.Parent
    })
    
    -- Content layout
    Utilities.ApplyListLayout(self.Frame, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Checkbox box
    self.Box = Utilities.Create("Frame", {
        Name = "Box",
        Size = UDim2.new(0, Theme.Sizes.CheckboxSize, 0, Theme.Sizes.CheckboxSize),
        BackgroundColor3 = self.Value and Theme.Colors.Primary or Theme.Colors.InputBackground,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Parent = self.Frame
    })
    
    Utilities.ApplyCorner(self.Box, Theme.BorderRadius.SM)
    self.BoxStroke = Utilities.ApplyStroke(self.Box, {
        Color = self.Value and Theme.Colors.Primary or Theme.Colors.InputBorder,
        Thickness = 2
    })
    
    -- Checkmark
    self.Checkmark = Utilities.Create("TextLabel", {
        Name = "Checkmark",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = Icons.Get("check"),
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = 12,
        Font = Theme.Typography.FontFamily,
        TextTransparency = self.Value and 0 or 1,
        Parent = self.Box
    })
    
    -- Icon
    if self.Icon then
        self.IconLabel = Utilities.Create("TextLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Text = Icons.Get(self.Icon),
            TextColor3 = Theme.Colors.TextSecondary,
            TextSize = 14,
            Font = Theme.Typography.FontFamily,
            LayoutOrder = 2,
            Parent = self.Frame
        })
    end
    
    -- Text
    self.TextLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -(Theme.Sizes.CheckboxSize + Theme.Spacing.SM + (self.Icon and 26 or 0)), 1, 0),
        BackgroundTransparency = 1,
        Text = self.Text,
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = 3,
        Parent = self.Frame
    })
    
    -- Events
    self.Frame.Activated:Connect(function()
        if not self.Disabled then
            self:Toggle()
        end
    end)
    
    self.Frame.MouseEnter:Connect(function()
        if not self.Disabled then
            Utilities.Tween(self.BoxStroke, { 
                Color = Theme.Colors.Primary 
            })
        end
    end)
    
    self.Frame.MouseLeave:Connect(function()
        if not self.Disabled then
            Utilities.Tween(self.BoxStroke, { 
                Color = self.Value and Theme.Colors.Primary or Theme.Colors.InputBorder 
            })
        end
    end)
    
    -- Apply disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
end

-- Toggle value
function Checkbox:Toggle()
    self:SetValue(not self.Value)
end

-- Set value
function Checkbox:SetValue(value)
    self.Value = value
    
    if value then
        Utilities.Tween(self.Box, { BackgroundColor3 = Theme.Colors.Primary })
        Utilities.Tween(self.BoxStroke, { Color = Theme.Colors.Primary })
        Utilities.Tween(self.Checkmark, { TextTransparency = 0 })
        Utilities.SpringTween(self.Box, { Size = UDim2.new(0, Theme.Sizes.CheckboxSize + 2, 0, Theme.Sizes.CheckboxSize + 2) }, 0.15)
        task.delay(0.15, function()
            if self.Box then
                Utilities.SpringTween(self.Box, { Size = UDim2.new(0, Theme.Sizes.CheckboxSize, 0, Theme.Sizes.CheckboxSize) })
            end
        end)
    else
        Utilities.Tween(self.Box, { BackgroundColor3 = Theme.Colors.InputBackground })
        Utilities.Tween(self.BoxStroke, { Color = Theme.Colors.InputBorder })
        Utilities.Tween(self.Checkmark, { TextTransparency = 1 })
    end
    
    if self.OnChange then
        self.OnChange(value)
    end
end

-- Get value
function Checkbox:GetValue()
    return self.Value
end

-- Set text
function Checkbox:SetText(text)
    self.Text = text
    self.TextLabel.Text = text
end

-- Set disabled
function Checkbox:SetDisabled(disabled)
    self.Disabled = disabled
    
    if disabled then
        self.Box.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.BoxStroke.Color = Theme.Colors.BackgroundTertiary
        self.Checkmark.TextColor3 = Theme.Colors.TextMuted
        self.TextLabel.TextColor3 = Theme.Colors.TextDisabled
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextDisabled
        end
    else
        self.Box.BackgroundColor3 = self.Value and Theme.Colors.Primary or Theme.Colors.InputBackground
        self.BoxStroke.Color = self.Value and Theme.Colors.Primary or Theme.Colors.InputBorder
        self.Checkmark.TextColor3 = Theme.Colors.TextPrimary
        self.TextLabel.TextColor3 = Theme.Colors.TextPrimary
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextSecondary
        end
    end
end

-- Get frame
function Checkbox:GetFrame()
    return self.Frame
end

-- Destroy
function Checkbox:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Checkbox

