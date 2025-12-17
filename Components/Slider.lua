--[[
    UIFramework Slider Component
    Range slider with icon support and callbacks
]]

local UserInputService = game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Slider
    
    @param config {
        Text: string - Slider label text
        Icon: string - Font Awesome icon name
        Value: number - Initial value
        Min: number - Minimum value
        Max: number - Maximum value
        Step: number - Step increment
        Decimals: number - Decimal places for display
        ShowValue: boolean - Show current value
        Size: UDim2 - Container size
        Disabled: boolean - Disable slider
        Parent: Instance - Parent instance
        OnChange: function(value) - Value change callback
        OnDragStart: function() - Drag start callback
        OnDragEnd: function(value) - Drag end callback
    }
]]
function Slider.new(config)
    local self = setmetatable({}, Slider)
    
    config = config or {}
    
    self.Text = config.Text or "Slider"
    self.Icon = config.Icon
    self.Min = config.Min or 0
    self.Max = config.Max or 100
    self.Step = config.Step or 1
    self.Decimals = config.Decimals or 0
    self.ShowValue = config.ShowValue ~= false
    self.Size = config.Size or UDim2.new(1, 0, 0, 50)
    self.Disabled = config.Disabled or false
    self.Parent = config.Parent
    
    -- Clamp initial value
    self.Value = Utilities.Clamp(config.Value or self.Min, self.Min, self.Max)
    
    -- Callbacks
    self.OnChange = config.OnChange
    self.OnDragStart = config.OnDragStart
    self.OnDragEnd = config.OnDragEnd
    
    self.IsDragging = false
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Slider:_Build()
    -- Container
    self.Frame = Utilities.Create("Frame", {
        Name = "Slider",
        Size = self.Size,
        BackgroundTransparency = 1,
        Parent = self.Parent
    })
    
    -- Header row (icon + text + value)
    self.HeaderRow = Utilities.Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Parent = self.Frame
    })
    
    -- Left container
    local leftContainer = Utilities.Create("Frame", {
        Name = "Left",
        Size = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.HeaderRow
    })
    
    Utilities.ApplyListLayout(leftContainer, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon
    if self.Icon then
        self.IconLabel = Utilities.Create("TextLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Text = Icons.Get(self.Icon),
            TextColor3 = Theme.Colors.TextSecondary,
            TextSize = 14,
            Font = Enum.Font.GothamMedium,
            LayoutOrder = 1,
            Parent = leftContainer
        })
    end
    
    -- Text
    self.TextLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = self.Text,
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,
        Parent = leftContainer
    })
    
    -- Value display
    if self.ShowValue then
        self.ValueLabel = Utilities.Create("TextLabel", {
            Name = "Value",
            Size = UDim2.new(0.3, 0, 1, 0),
            Position = UDim2.new(0.7, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = tostring(Utilities.Round(self.Value, self.Decimals)),
            TextColor3 = Theme.Colors.Primary,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamilyBold,
            TextXAlignment = Enum.TextXAlignment.Right,
            Parent = self.HeaderRow
        })
    end
    
    -- Slider track
    self.Track = Utilities.Create("Frame", {
        Name = "Track",
        Size = UDim2.new(1, 0, 0, Theme.Sizes.SliderHeight),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Theme.Colors.SliderTrack,
        BorderSizePixel = 0,
        Parent = self.Frame
    })
    
    Utilities.ApplyCorner(self.Track, Theme.BorderRadius.Full)
    
    -- Fill
    local fillPercent = (self.Value - self.Min) / (self.Max - self.Min)
    self.Fill = Utilities.Create("Frame", {
        Name = "Fill",
        Size = UDim2.new(fillPercent, 0, 1, 0),
        BackgroundColor3 = Theme.Colors.SliderFill,
        BorderSizePixel = 0,
        Parent = self.Track
    })
    
    Utilities.ApplyCorner(self.Fill, Theme.BorderRadius.Full)
    
    -- Knob
    self.Knob = Utilities.Create("TextButton", {
        Name = "Knob",
        Size = UDim2.new(0, Theme.Sizes.SliderKnobSize, 0, Theme.Sizes.SliderKnobSize),
        Position = UDim2.new(fillPercent, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Colors.SliderKnob,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.Track
    })
    
    Utilities.ApplyCorner(self.Knob, Theme.BorderRadius.Full)
    
    -- Click area for track
    self.ClickArea = Utilities.Create("TextButton", {
        Name = "ClickArea",
        Size = UDim2.new(1, 0, 1, 20),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = "",
        Parent = self.Track
    })
    
    -- Events
    self.Knob.MouseButton1Down:Connect(function()
        self:_StartDrag()
    end)
    
    self.ClickArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            self:_HandleClick(input)
            self:_StartDrag()
        end
    end)
    
    self.Knob.MouseEnter:Connect(function()
        if not self.Disabled then
            Utilities.SpringTween(self.Knob, {
                Size = UDim2.new(0, Theme.Sizes.SliderKnobSize + 4, 0, Theme.Sizes.SliderKnobSize + 4)
            })
        end
    end)
    
    self.Knob.MouseLeave:Connect(function()
        if not self.IsDragging then
            Utilities.SpringTween(self.Knob, {
                Size = UDim2.new(0, Theme.Sizes.SliderKnobSize, 0, Theme.Sizes.SliderKnobSize)
            })
        end
    end)
    
    -- Apply disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
end

function Slider:_StartDrag()
    if self.Disabled then return end
    
    self.IsDragging = true
    
    if self.OnDragStart then
        self.OnDragStart()
    end
    
    local inputConnection
    local endConnection
    
    inputConnection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            self:_HandleDrag(input)
        end
    end)
    
    endConnection = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            self.IsDragging = false
            
            Utilities.SpringTween(self.Knob, {
                Size = UDim2.new(0, Theme.Sizes.SliderKnobSize, 0, Theme.Sizes.SliderKnobSize)
            })
            
            if self.OnDragEnd then
                self.OnDragEnd(self.Value)
            end
            
            if inputConnection then
                inputConnection:Disconnect()
            end
            if endConnection then
                endConnection:Disconnect()
            end
        end
    end)
end

function Slider:_HandleClick(input)
    if self.Disabled then return end
    
    local trackAbsPos = self.Track.AbsolutePosition.X
    local trackAbsSize = self.Track.AbsoluteSize.X
    local mouseX = input.Position.X
    
    local percent = Utilities.Clamp((mouseX - trackAbsPos) / trackAbsSize, 0, 1)
    local newValue = self.Min + (self.Max - self.Min) * percent
    
    -- Apply step
    newValue = math.floor(newValue / self.Step + 0.5) * self.Step
    newValue = Utilities.Clamp(newValue, self.Min, self.Max)
    
    self:SetValue(newValue)
end

function Slider:_HandleDrag(input)
    if self.Disabled or not self.IsDragging then return end
    
    local trackAbsPos = self.Track.AbsolutePosition.X
    local trackAbsSize = self.Track.AbsoluteSize.X
    local mouseX = input.Position.X
    
    local percent = Utilities.Clamp((mouseX - trackAbsPos) / trackAbsSize, 0, 1)
    local newValue = self.Min + (self.Max - self.Min) * percent
    
    -- Apply step
    newValue = math.floor(newValue / self.Step + 0.5) * self.Step
    newValue = Utilities.Clamp(newValue, self.Min, self.Max)
    
    self:SetValue(newValue)
end

-- Set value
function Slider:SetValue(value)
    value = Utilities.Clamp(value, self.Min, self.Max)
    
    -- Apply step
    value = math.floor(value / self.Step + 0.5) * self.Step
    
    if value ~= self.Value then
        self.Value = value
        
        local percent = (value - self.Min) / (self.Max - self.Min)
        
        -- Update UI
        Utilities.Tween(self.Fill, { Size = UDim2.new(percent, 0, 1, 0) }, 0.1)
        Utilities.Tween(self.Knob, { Position = UDim2.new(percent, 0, 0.5, 0) }, 0.1)
        
        if self.ValueLabel then
            self.ValueLabel.Text = tostring(Utilities.Round(value, self.Decimals))
        end
        
        if self.OnChange then
            self.OnChange(value)
        end
    end
end

-- Get value
function Slider:GetValue()
    return self.Value
end

-- Set text
function Slider:SetText(text)
    self.Text = text
    self.TextLabel.Text = text
end

-- Set range
function Slider:SetRange(min, max)
    self.Min = min
    self.Max = max
    self:SetValue(Utilities.Clamp(self.Value, min, max))
end

-- Set disabled
function Slider:SetDisabled(disabled)
    self.Disabled = disabled
    
    if disabled then
        self.Track.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.Fill.BackgroundColor3 = Theme.Colors.TextMuted
        self.Knob.BackgroundColor3 = Theme.Colors.TextMuted
        self.TextLabel.TextColor3 = Theme.Colors.TextDisabled
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextDisabled
        end
        if self.ValueLabel then
            self.ValueLabel.TextColor3 = Theme.Colors.TextDisabled
        end
    else
        self.Track.BackgroundColor3 = Theme.Colors.SliderTrack
        self.Fill.BackgroundColor3 = Theme.Colors.SliderFill
        self.Knob.BackgroundColor3 = Theme.Colors.SliderKnob
        self.TextLabel.TextColor3 = Theme.Colors.TextPrimary
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextSecondary
        end
        if self.ValueLabel then
            self.ValueLabel.TextColor3 = Theme.Colors.Primary
        end
    end
end

-- Get frame
function Slider:GetFrame()
    return self.Frame
end

-- Apply theme
function Slider:ApplyTheme()
    if not self.Disabled then
        Utilities.Tween(self.Track, { BackgroundColor3 = Theme.Colors.SliderTrack }, 0.2)
        Utilities.Tween(self.Fill, { BackgroundColor3 = Theme.Colors.SliderFill }, 0.2)
        Utilities.Tween(self.Knob, { BackgroundColor3 = Theme.Colors.SliderKnob }, 0.2)
        Utilities.Tween(self.TextLabel, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { TextColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
        if self.ValueLabel then
            Utilities.Tween(self.ValueLabel, { TextColor3 = Theme.Colors.Primary }, 0.2)
        end
    end
end

-- Register for theme updates
function Slider:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Slider:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Slider

