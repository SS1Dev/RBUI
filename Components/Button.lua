--[[
    UIFramework Button Component
    Clickable button with icon support and variants
]]

local Button = {}
Button.__index = Button

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Button
    
    @param config {
        Text: string - Button text
        Icon: string - Font Awesome icon name
        IconPosition: string - "left" or "right"
        Size: UDim2 - Button size
        Variant: string - "primary", "secondary", "success", "warning", "error", "ghost"
        Disabled: boolean - Disable button
        Loading: boolean - Show loading state
        Parent: Instance - Parent instance
        OnClick: function() - Click callback
        OnHover: function(hovering) - Hover callback
    }
]]
function Button.new(config)
    local self = setmetatable({}, Button)
    
    config = config or {}
    
    self.Text = config.Text or "Button"
    self.Icon = config.Icon
    self.IconPosition = config.IconPosition or "left"
    self.Size = config.Size or UDim2.new(0, 120, 0, Theme.Sizes.ButtonHeight)
    self.Variant = config.Variant or "primary"
    self.Disabled = config.Disabled or false
    self.Loading = config.Loading or false
    self.Parent = config.Parent
    
    -- Callbacks
    self.OnClick = config.OnClick
    self.OnHover = config.OnHover
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

-- Get colors based on variant
function Button:_GetVariantColors()
    local variants = {
        primary = {
            Background = Theme.Colors.Primary,
            BackgroundHover = Theme.Colors.PrimaryHover,
            Text = Theme.Colors.TextPrimary
        },
        secondary = {
            Background = Theme.Colors.Secondary,
            BackgroundHover = Theme.Colors.SecondaryHover,
            Text = Theme.Colors.TextPrimary
        },
        success = {
            Background = Theme.Colors.Success,
            BackgroundHover = Theme.Colors.SuccessHover,
            Text = Theme.Colors.TextPrimary
        },
        warning = {
            Background = Theme.Colors.Warning,
            BackgroundHover = Theme.Colors.WarningHover,
            Text = Theme.Colors.Background
        },
        error = {
            Background = Theme.Colors.Error,
            BackgroundHover = Theme.Colors.ErrorHover,
            Text = Theme.Colors.TextPrimary
        },
        ghost = {
            Background = Color3.fromRGB(0, 0, 0),
            BackgroundHover = Theme.Colors.BackgroundTertiary,
            Text = Theme.Colors.TextPrimary,
            Transparent = true
        }
    }
    
    return variants[self.Variant] or variants.primary
end

function Button:_Build()
    local colors = self:_GetVariantColors()
    
    -- Button
    self.Btn = Utilities.Create("TextButton", {
        Name = "Button",
        Size = self.Size,
        BackgroundColor3 = colors.Background,
        BackgroundTransparency = colors.Transparent and 1 or 0,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.Parent
    })
    
    Utilities.ApplyCorner(self.Btn, Theme.BorderRadius.LG)
    
    if colors.Transparent then
        Utilities.ApplyStroke(self.Btn, {
            Color = Theme.Colors.SurfaceBorder,
            Thickness = 1,
            Transparency = 0.5
        })
    end
    
    -- Content container
    self.ContentContainer = Utilities.Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.Btn
    })
    
    Utilities.ApplyListLayout(self.ContentContainer, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon (left)
    if self.Icon and self.IconPosition == "left" then
        self.IconLabel = Icons.CreateLabel(self.Icon, 16, colors.Text)
        self.IconLabel.LayoutOrder = 1
        self.IconLabel.Parent = self.ContentContainer
    end
    
    -- Text
    if self.Text and self.Text ~= "" then
        self.TextLabel = Utilities.Create("TextLabel", {
            Name = "Text",
            Size = UDim2.new(0, 0, 0, 20),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            Text = self.Text,
            TextColor3 = colors.Text,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamilyBold,
            LayoutOrder = 2,
            Parent = self.ContentContainer
        })
    end
    
    -- Icon (right)
    if self.Icon and self.IconPosition == "right" then
        self.IconLabel = Icons.CreateLabel(self.Icon, 16, colors.Text)
        self.IconLabel.LayoutOrder = 3
        self.IconLabel.Parent = self.ContentContainer
    end
    
    -- Loading spinner
    self.LoadingSpinner = Icons.CreateLabel("spinner", 16, colors.Text)
    self.LoadingSpinner.Name = "LoadingSpinner"
    self.LoadingSpinner.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.LoadingSpinner.AnchorPoint = Vector2.new(0.5, 0.5)
    self.LoadingSpinner.Visible = false
    self.LoadingSpinner.Parent = self.Btn
    
    -- Events
    self.Btn.MouseEnter:Connect(function()
        if not self.Disabled and not self.Loading then
            self:_OnHover(true)
        end
    end)
    
    self.Btn.MouseLeave:Connect(function()
        if not self.Disabled and not self.Loading then
            self:_OnHover(false)
        end
    end)
    
    self.Btn.MouseButton1Down:Connect(function()
        if not self.Disabled and not self.Loading then
            Utilities.Tween(self.Btn, { Size = self.Size - UDim2.new(0, 4, 0, 2) }, 0.1)
        end
    end)
    
    self.Btn.MouseButton1Up:Connect(function()
        if not self.Disabled and not self.Loading then
            Utilities.Tween(self.Btn, { Size = self.Size }, 0.1)
        end
    end)
    
    self.Btn.Activated:Connect(function()
        if not self.Disabled and not self.Loading and self.OnClick then
            self.OnClick()
        end
    end)
    
    -- Apply disabled state
    if self.Disabled then
        self:SetDisabled(true)
    end
    
    -- Apply loading state
    if self.Loading then
        self:SetLoading(true)
    end
end

function Button:_OnHover(hovering)
    local colors = self:_GetVariantColors()
    
    if hovering then
        Utilities.Tween(self.Btn, { 
            BackgroundColor3 = colors.BackgroundHover,
            BackgroundTransparency = colors.Transparent and 0 or 0
        })
    else
        Utilities.Tween(self.Btn, { 
            BackgroundColor3 = colors.Background,
            BackgroundTransparency = colors.Transparent and 1 or 0
        })
    end
    
    if self.OnHover then
        self.OnHover(hovering)
    end
end

-- Set text
function Button:SetText(text)
    self.Text = text
    if self.TextLabel then
        self.TextLabel.Text = text
    end
end

-- Set icon
function Button:SetIcon(iconName)
    self.Icon = iconName
    if self.IconLabel then
        self.IconLabel.Image = Icons.Get(iconName)
    end
end

-- Set disabled
function Button:SetDisabled(disabled)
    self.Disabled = disabled
    
    if disabled then
        self.Btn.BackgroundColor3 = Theme.Colors.BackgroundTertiary
        if self.TextLabel then
            self.TextLabel.TextColor3 = Theme.Colors.TextDisabled
        end
        if self.IconLabel then
            self.IconLabel.TextColor3 = Theme.Colors.TextDisabled
        end
    else
        local colors = self:_GetVariantColors()
        self.Btn.BackgroundColor3 = colors.Background
        if self.TextLabel then
            self.TextLabel.TextColor3 = colors.Text
        end
        if self.IconLabel then
            self.IconLabel.TextColor3 = colors.Text
        end
    end
end

-- Set loading
function Button:SetLoading(loading)
    self.Loading = loading
    
    self.ContentContainer.Visible = not loading
    self.LoadingSpinner.Visible = loading
    
    if loading then
        -- Rotate spinner
        task.spawn(function()
            while self.Loading and self.LoadingSpinner do
                for i = 0, 360, 30 do
                    if not self.Loading then break end
                    self.LoadingSpinner.Rotation = i
                    task.wait(0.05)
                end
            end
        end)
    end
end

-- Set variant
function Button:SetVariant(variant)
    self.Variant = variant
    local colors = self:_GetVariantColors()
    
    self.Btn.BackgroundColor3 = colors.Background
    self.Btn.BackgroundTransparency = colors.Transparent and 1 or 0
    
    if self.TextLabel then
        self.TextLabel.TextColor3 = colors.Text
    end
    if self.IconLabel then
        self.IconLabel.TextColor3 = colors.Text
    end
end

-- Get button instance
function Button:GetButton()
    return self.Btn
end

-- Apply theme
function Button:ApplyTheme()
    local colors = self:_GetVariantColors()
    if not self.Disabled then
        Utilities.Tween(self.Btn, { BackgroundColor3 = colors.Background }, 0.2)
        if self.TextLabel then
            Utilities.Tween(self.TextLabel, { TextColor3 = colors.Text }, 0.2)
        end
        if self.IconLabel then
            Utilities.Tween(self.IconLabel, { TextColor3 = colors.Text }, 0.2)
        end
    end
end

-- Register for theme updates
function Button:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Button:Destroy()
    if self.Btn then
        self.Btn:Destroy()
    end
end

return Button

