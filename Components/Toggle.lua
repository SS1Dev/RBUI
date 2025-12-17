--[[
    UIFramework Toggle Component
    On/Off switch with icon support and callbacks
]]

local Toggle = {}
Toggle.__index = Toggle

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Toggle
    
    @param config {
        Text: string - Toggle label text
        Icon: string - Font Awesome icon name
        Value: boolean - Initial value
        Size: UDim2 - Container size
        Disabled: boolean - Disable toggle
        Parent: Instance - Parent instance
        OnChange: function(value) - Value change callback
    }
]]
function Toggle.new(config)
    local self = setmetatable({}, Toggle)
    
    config = config or {}
    
    self.Text = config.Text or "Toggle"
    self.Icon = config.Icon
    self.Value = config.Value or false
    self.Size = config.Size or UDim2.new(1, 0, 0, 32)
    self.Disabled = config.Disabled or false
    self.Parent = config.Parent
    
    -- Callbacks
    self.OnChange = config.OnChange
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Toggle:_Build()
    -- Container
    self.Frame = Utilities.Create("Frame", {
        Name = "Toggle",
        Size = self.Size,
        BackgroundTransparency = 1,
        Parent = self.Parent
    })
    
    -- Left side (icon + text)
    self.LeftContainer = Utilities.Create("Frame", {
        Name = "Left",
        Size = UDim2.new(1, -Theme.Sizes.ToggleWidth - Theme.Spacing.MD, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.Frame
    })
    
    Utilities.ApplyListLayout(self.LeftContainer, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon (ImageLabel)
    if self.Icon then
        self.IconLabel = Utilities.Create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Image = Icons.Get(self.Icon),
            ImageColor3 = Theme.Colors.TextSecondary,
            ScaleType = Enum.ScaleType.Fit,
            LayoutOrder = 1,
            Parent = self.LeftContainer
        })
    end
    
    -- Text
    self.TextLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, self.Icon and -28 or 0, 1, 0),
        BackgroundTransparency = 1,
        Text = self.Text,
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,
        Parent = self.LeftContainer
    })
    
    -- Toggle switch
    self.Switch = Utilities.Create("TextButton", {
        Name = "Switch",
        Size = UDim2.new(0, Theme.Sizes.ToggleWidth, 0, Theme.Sizes.ToggleHeight),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = self.Value and Theme.Colors.ToggleOn or Theme.Colors.ToggleOff,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.Frame
    })
    
    Utilities.ApplyCorner(self.Switch, Theme.BorderRadius.Full)
    
    -- Toggle knob
    self.Knob = Utilities.Create("Frame", {
        Name = "Knob",
        Size = UDim2.new(0, Theme.Sizes.ToggleHeight - 4, 0, Theme.Sizes.ToggleHeight - 4),
        Position = self.Value and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = self.Value and Vector2.new(1, 0.5) or Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Colors.ToggleKnob,
        BorderSizePixel = 0,
        Parent = self.Switch
    })
    
    Utilities.ApplyCorner(self.Knob, Theme.BorderRadius.Full)
    
    -- Events
    self.Switch.Activated:Connect(function()
        if not self.Disabled then
            self:Toggle()
        end
    end)
    
    self.Switch.MouseEnter:Connect(function()
        if not self.Disabled then
            Utilities.SpringTween(self.Knob, { 
                Size = UDim2.new(0, Theme.Sizes.ToggleHeight - 2, 0, Theme.Sizes.ToggleHeight - 4)
            }, 0.2)
        end
    end)
    
    self.Switch.MouseLeave:Connect(function()
        Utilities.SpringTween(self.Knob, { 
            Size = UDim2.new(0, Theme.Sizes.ToggleHeight - 4, 0, Theme.Sizes.ToggleHeight - 4)
        }, 0.2)
    end)
    
    -- Apply disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
end

-- Toggle value
function Toggle:Toggle()
    self:SetValue(not self.Value)
end

-- Set value
function Toggle:SetValue(value)
    self.Value = value
    
    -- Animate
    if value then
        Utilities.Tween(self.Switch, { BackgroundColor3 = Theme.Colors.ToggleOn })
        Utilities.SpringTween(self.Knob, { 
            Position = UDim2.new(1, -2, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5)
        })
    else
        Utilities.Tween(self.Switch, { BackgroundColor3 = Theme.Colors.ToggleOff })
        Utilities.SpringTween(self.Knob, { 
            Position = UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5)
        })
    end
    
    if self.OnChange then
        self.OnChange(value)
    end
end

-- Get value
function Toggle:GetValue()
    return self.Value
end

-- Set text
function Toggle:SetText(text)
    self.Text = text
    self.TextLabel.Text = text
end

-- Set disabled
function Toggle:SetDisabled(disabled)
    self.Disabled = disabled
    
    if disabled then
        self.Switch.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.Knob.BackgroundColor3 = Theme.Colors.TextMuted
        self.TextLabel.TextColor3 = Theme.Colors.TextDisabled
        if self.IconLabel then
            self.IconLabel.ImageColor3 = Theme.Colors.TextDisabled
        end
    else
        self.Switch.BackgroundColor3 = self.Value and Theme.Colors.ToggleOn or Theme.Colors.ToggleOff
        self.Knob.BackgroundColor3 = Theme.Colors.ToggleKnob
        self.TextLabel.TextColor3 = Theme.Colors.TextPrimary
        if self.IconLabel then
            self.IconLabel.ImageColor3 = Theme.Colors.TextSecondary
        end
    end
end

-- Get frame
function Toggle:GetFrame()
    return self.Frame
end

-- Apply theme
function Toggle:ApplyTheme()
    if not self.Disabled then
        Utilities.Tween(self.Switch, { 
            BackgroundColor3 = self.Value and Theme.Colors.ToggleOn or Theme.Colors.ToggleOff 
        }, 0.2)
        Utilities.Tween(self.Knob, { BackgroundColor3 = Theme.Colors.ToggleKnob }, 0.2)
        Utilities.Tween(self.TextLabel, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { ImageColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
    end
end

-- Register for theme updates
function Toggle:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Toggle:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Toggle

