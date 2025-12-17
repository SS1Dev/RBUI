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
        Placeholder: string - Placeholder text
        Text: string - Initial text
        Icon: string - Font Awesome icon name
        Size: UDim2 - Input size
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
    
    self.Placeholder = config.Placeholder or "Enter text..."
    self.Text = config.Text or ""
    self.Icon = config.Icon
    self.Size = config.Size or UDim2.new(1, 0, 0, Theme.Sizes.InputHeight)
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
    -- Container (Modern - Subtle Border)
    self.Frame = Utilities.Create("Frame", {
        Name = "Input",
        Size = self.Size,
        BackgroundColor3 = Theme.Colors.InputBackground,
        BorderSizePixel = 0,
        Parent = self.Parent
    })
    
    Utilities.ApplyCorner(self.Frame, Theme.BorderRadius.LG)
    self.Stroke = Utilities.ApplyStroke(self.Frame, {
        Color = Theme.Colors.InputBorder,
        Thickness = 1,
        Transparency = 0.5
    })
    
    -- Content container
    local contentPadding = Theme.Spacing.MD
    local iconOffset = self.Icon and (20 + Theme.Spacing.SM) or 0
    local clearOffset = self.ClearButton and (24 + Theme.Spacing.SM) or 0
    
    -- Icon (ImageLabel)
    if self.Icon then
        self.IconLabel = Utilities.Create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(0, contentPadding, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = Icons.Get(self.Icon),
            ImageColor3 = Theme.Colors.TextSecondary,
            ScaleType = Enum.ScaleType.Fit,
            Parent = self.Frame
        })
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
        Parent = self.Frame
    })
    
    -- Clear button
    if self.ClearButton then
        self.ClearBtn = Utilities.Create("ImageButton", {
            Name = "ClearButton",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -contentPadding - 20, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Colors.BackgroundTertiary,
            BorderSizePixel = 0,
            Image = Icons.Get("x"),
            ImageColor3 = Theme.Colors.TextSecondary,
            ScaleType = Enum.ScaleType.Fit,
            AutoButtonColor = false,
            Visible = #self.Text > 0,
            Parent = self.Frame
        })
        Utilities.ApplyPadding(self.ClearBtn, 4)
        
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
        Utilities.Tween(self.IconLabel, { ImageColor3 = Theme.Colors.Primary })
    end
    
    if self.OnFocus then
        self.OnFocus()
    end
end

function Input:_OnFocusLost(enterPressed)
    Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder })
    
    if self.IconLabel then
        Utilities.Tween(self.IconLabel, { ImageColor3 = Theme.Colors.TextSecondary })
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
        self.Frame.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        self.TextBox.TextColor3 = Theme.Colors.TextDisabled
    else
        self.Frame.BackgroundColor3 = Theme.Colors.InputBackground
        self.TextBox.TextColor3 = Theme.Colors.TextPrimary
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
        Utilities.Tween(self.Frame, { BackgroundColor3 = Theme.Colors.InputBackground }, 0.2)
        Utilities.Tween(self.Stroke, { Color = Theme.Colors.InputBorder }, 0.2)
        if self.TextBox then
            Utilities.Tween(self.TextBox, { TextColor3 = Theme.Colors.TextPrimary }, 0.2)
            self.TextBox.PlaceholderColor3 = Theme.Colors.TextMuted
        end
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { ImageColor3 = Theme.Colors.TextSecondary }, 0.2)
        end
        if self.ClearBtn then
            Utilities.Tween(self.ClearBtn, { 
                BackgroundColor3 = Theme.Colors.BackgroundTertiary,
                ImageColor3 = Theme.Colors.TextSecondary
            }, 0.2)
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

