--[[
    UIFramework Input Component
    Text input field with icon support and callbacks
]]

local Input = {}
Input.__index = Input

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Input
    
    @param config {
        Label: string - Label text (displayed on left side)
        LabelIcon: string - Icon for label
        Placeholder: string - Placeholder text
        Text: string - Initial text
        Icon: string - Font Awesome icon name (inside input)
        Size: UDim2 - Input size
        InputWidth: UDim - Width of input field (default: 0.5 scale)
        Password: boolean - Password mode
        MaxLength: number - Maximum characters
        ClearButton: boolean - Show clear button
        Disabled: boolean - Disable input
        Parent: Instance - Parent instance
        OnChange: function(text) - Text change callback
        OnFocus: function() - Focus callback
        OnFocusLost: function(text, enterPressed) - Focus lost callback
        OnSubmit: function(text) - Enter pressed callback
    }
]]
function Input.new(config)
    local self = setmetatable({}, Input)
    
    config = config or {}
    
    self.Label = config.Label
    self.LabelIcon = config.LabelIcon
    self.Placeholder = config.Placeholder or "Enter text..."
    self.Text = config.Text or ""
    self.Icon = config.Icon
    self.Size = config.Size or UDim2.new(1, 0, 0, Theme.Sizes.InputHeight)
    self.InputWidth = config.InputWidth or UDim.new(0.5, 0)
    self.Password = config.Password or false
    self.MaxLength = config.MaxLength or 999
    self.ClearButton = config.ClearButton ~= false
    self.Disabled = config.Disabled or false
    self.Parent = config.Parent
    
    -- Callbacks
    self.OnChange = config.OnChange
    self.OnFocus = config.OnFocus
    self.OnFocusLost = config.OnFocusLost
    self.OnSubmit = config.OnSubmit
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Input:_Build()
    -- Main container (for label + input layout)
    self.Frame = Utilities.Create("Frame", {
        Name = "Input",
        Size = self.Size,
        BackgroundTransparency = 1,
        Parent = self.Parent
    })
    
    -- Calculate input width based on whether label exists
    local inputWidth = self.Label and self.InputWidth or UDim.new(1, 0)
    
    -- Left side (Label + Icon) - only if Label is provided
    if self.Label then
        self.LeftContainer = Utilities.Create("Frame", {
            Name = "Left",
            Size = UDim2.new(1 - inputWidth.Scale, -inputWidth.Offset - Theme.Spacing.MD, 1, 0),
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
        
        -- Label Text
        self.LabelText = Utilities.Create("TextLabel", {
            Name = "Label",
            Size = UDim2.new(1, self.LabelIcon and -26 or 0, 1, 0),
            BackgroundTransparency = 1,
            Text = self.Label,
            TextColor3 = Theme.Colors.TextPrimary,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamily,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            LayoutOrder = 2,
            Parent = self.LeftContainer
        })
    end
    
    -- Input container (positioned on right if label exists)
    self.InputFrame = Utilities.Create("Frame", {
        Name = "InputFrame",
        Size = UDim2.new(inputWidth.Scale, inputWidth.Offset, 1, 0),
        Position = self.Label and UDim2.new(1, 0, 0, 0) or UDim2.new(0, 0, 0, 0),
        AnchorPoint = self.Label and Vector2.new(1, 0) or Vector2.new(0, 0),
        BackgroundColor3 = Theme.Colors.InputBackground,
        BorderSizePixel = 0,
        Parent = self.Frame
    })
    
    Utilities.ApplyCorner(self.InputFrame, Theme.BorderRadius.LG)
    self.Stroke = Utilities.ApplyStroke(self.InputFrame, {
        Color = Theme.Colors.InputBorder,
        Thickness = 1,
        Transparency = 0.5
    })
    
    -- Content container
    local contentPadding = Theme.Spacing.MD
    local iconOffset = self.Icon and (20 + Theme.Spacing.SM) or 0
    local clearOffset = self.ClearButton and (24 + Theme.Spacing.SM) or 0
    
    -- Icon (inside input)
    if self.Icon then
        self.IconLabel = Icons.CreateLabel(self.Icon, 18, Theme.Colors.TextSecondary)
        self.IconLabel.Position = UDim2.new(0, contentPadding, 0.5, 0)
        self.IconLabel.AnchorPoint = Vector2.new(0, 0.5)
        self.IconLabel.Parent = self.InputFrame
    end
    
    -- TextBox
    self.TextBox = Utilities.Create("TextBox", {
        Name = "TextBox",
        Size = UDim2.new(1, -(contentPadding * 2 + iconOffset + clearOffset), 1, 0),
        Position = UDim2.new(0, contentPadding + iconOffset, 0, 0),
        BackgroundTransparency = 1,
        Text = self.Text,
        PlaceholderText = self.Placeholder,
        PlaceholderColor3 = Theme.Colors.TextMuted,
        TextColor3 = Theme.Colors.TextPrimary,
        TextSize = Theme.Typography.Body,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        TextEditable = not self.Disabled,
        Parent = self.InputFrame
    })
    
    -- Clear button
    if self.ClearButton then
        self.ClearBtn = Utilities.Create("TextButton", {
            Name = "ClearButton",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -contentPadding - 20, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Colors.BackgroundTertiary,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Visible = #self.Text > 0,
            Parent = self.InputFrame
        })
        
        local clearIcon = Icons.CreateLabel("x", 12, Theme.Colors.TextSecondary)
        clearIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        clearIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        clearIcon.Parent = self.ClearBtn
        
        Utilities.ApplyCorner(self.ClearBtn, Theme.BorderRadius.SM)
        
        self.ClearBtn.Activated:Connect(function()
            self:SetText("")
            self.TextBox:CaptureFocus()
        end)
        
        self.ClearBtn.MouseEnter:Connect(function()
            Utilities.Tween(self.ClearBtn, { BackgroundColor3 = Theme.Colors.Error })
        end)
        
        self.ClearBtn.MouseLeave:Connect(function()
            Utilities.Tween(self.ClearBtn, { BackgroundColor3 = Theme.Colors.BackgroundTertiary })
        end)
    end
    
    -- Events
    self.TextBox.Focused:Connect(function()
        self:_OnFocus()
    end)
    
    self.TextBox.FocusLost:Connect(function(enterPressed)
        self:_OnFocusLost(enterPressed)
    end)
    
    self.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:_OnTextChanged()
    end)
    
    -- Disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
end

function Input:_OnFocus()
    Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputFocus })
    
    if self.IconLabel then
        Utilities.Tween(self.IconLabel, { TextColor3 = Theme.Colors.Primary })
    end
    
    if self.OnFocus then
        self.OnFocus()
    end
end

function Input:_OnFocusLost(enterPressed)
    Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder })
    
    if self.IconLabel then
        Utilities.Tween(self.IconLabel, { TextColor3 = Theme.Colors.TextSecondary })
    end
    
    if enterPressed and self.OnSubmit then
        self.OnSubmit(self.TextBox.Text)
    end
    
    if self.OnFocusLost then
        self.OnFocusLost(self.TextBox.Text, enterPressed)
    end
end

function Input:_OnTextChanged()
    local text = self.TextBox.Text
    
    -- Enforce max length
    if #text > self.MaxLength then
        text = string.sub(text, 1, self.MaxLength)
        self.TextBox.Text = text
    end
    
    self.Text = text
    
    -- Update clear button visibility
    if self.ClearBtn then
        self.ClearBtn.Visible = #text > 0
    end
    
    if self.OnChange then
        self.OnChange(text)
    end
end

-- Set text
function Input:SetText(text)
    self.Text = text
    self.TextBox.Text = text
end

-- Get text
function Input:GetText()
    return self.TextBox.Text
end

-- Set placeholder
function Input:SetPlaceholder(text)
    self.Placeholder = text
    self.TextBox.PlaceholderText = text
end

-- Set disabled
function Input:SetDisabled(disabled)
    self.Disabled = disabled
    self.TextBox.TextEditable = not disabled
    
    if disabled then
        self.InputFrame.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.TextBox.TextColor3 = Theme.Colors.TextDisabled
        if self.LabelText then
            self.LabelText.TextColor3 = Theme.Colors.TextDisabled
        end
        if self.LabelIconElement then
            self.LabelIconElement.TextColor3 = Theme.Colors.TextDisabled
        end
    else
        self.InputFrame.BackgroundColor3 = Theme.Colors.InputBackground
        self.TextBox.TextColor3 = Theme.Colors.TextPrimary
        if self.LabelText then
            self.LabelText.TextColor3 = Theme.Colors.TextPrimary
        end
        if self.LabelIconElement then
            self.LabelIconElement.TextColor3 = Theme.Colors.TextSecondary
        end
    end
end

-- Set label text
function Input:SetLabel(text)
    self.Label = text
    if self.LabelText then
        self.LabelText.Text = text
    end
end

-- Focus
function Input:Focus()
    self.TextBox:CaptureFocus()
end

-- Get frame
function Input:GetFrame()
    return self.Frame
end

-- Apply theme
function Input:ApplyTheme()
    if not self.Disabled then
        Utilities.Tween(self.InputFrame, { BackgroundColor3 = Theme.Colors.InputBackground }, 0.2)
        Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder }, 0.2)
        if self.TextBox then
            Utilities.Tween(self.TextBox, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
            self.TextBox.PlaceholderColor3 = Theme.Colors.TextMuted
        end
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { TextColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
        if self.ClearBtn then
            Utilities.Tween(self.ClearBtn, { 
                BackgroundColor3 = Theme.Colors.BackgroundTertiary,
                TextColor3 = Theme.Colors.TextSecondary
            }, 0.2)
        end
        -- Label elements
        if self.LabelText then
            Utilities.Tween(self.LabelText, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
        end
        if self.LabelIconElement then
            Utilities.Tween(self.LabelIconElement, { TextColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
    end
end

-- Register for theme updates
function Input:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Input:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Input

