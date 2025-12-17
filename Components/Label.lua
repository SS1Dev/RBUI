--[[
    UIFramework Label Component
    Text display with optional icon support
]]

local Label = {}
Label.__index = Label

local Theme = require(script.Parent.Parent.Theme)
local Utilities = require(script.Parent.Parent.Utilities)
local Icons = require(script.Parent.Parent.Icons)

--[[
    Create a new Label
    
    @param config {
        Text: string - Label text
        Icon: string - Font Awesome icon name
        Size: UDim2 - Label size
        TextSize: number - Font size
        TextColor: Color3 - Text color
        Font: Enum.Font - Font
        TextXAlignment: Enum.TextXAlignment
        TextYAlignment: Enum.TextYAlignment
        RichText: boolean - Enable rich text
        Parent: Instance - Parent instance
        OnClick: function - Click callback
    }
]]
function Label.new(config)
    local self = setmetatable({}, Label)
    
    config = config or {}
    
    self.Text = config.Text or "Label"
    self.Icon = config.Icon
    self.Size = config.Size or UDim2.new(1, 0, 0, 24)
    self.TextSize = config.TextSize or Theme.Typography.Body
    self.TextColor = config.TextColor or Theme.Colors.TextPrimary
    self.Font = config.Font or Theme.Typography.FontFamily
    self.TextXAlignment = config.TextXAlignment or Enum.TextXAlignment.Left
    self.TextYAlignment = config.TextYAlignment or Enum.TextYAlignment.Center
    self.RichText = config.RichText or false
    self.Parent = config.Parent
    self.OnClick = config.OnClick
    
    self:_Build()
    self:_RegisterThemeListener()
    
    return self
end

function Label:_Build()
    -- Container
    self.Frame = Utilities.Create("Frame", {
        Name = "Label",
        Size = self.Size,
        BackgroundTransparency = 1,
        Parent = self.Parent
    })
    
    Utilities.ApplyListLayout(self.Frame, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon
    if self.Icon then
        self.IconLabel = Icons.CreateLabel(self.Icon, self.TextSize, self.TextColor)
        self.IconLabel.LayoutOrder = 1
        self.IconLabel.Parent = self.Frame
    end
    
    -- Text
    self.TextLabel = Utilities.Create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, self.Icon and -(self.TextSize + Theme.Spacing.SM) or 0, 1, 0),
        BackgroundTransparency = 1,
        Text = self.Text,
        TextColor3 = self.TextColor,
        TextSize = self.TextSize,
        Font = self.Font,
        TextXAlignment = self.TextXAlignment,
        TextYAlignment = self.TextYAlignment,
        TextWrapped = true,
        RichText = self.RichText,
        LayoutOrder = 2,
        Parent = self.Frame
    })
    
    -- Click functionality
    if self.OnClick then
        local clickDetector = Utilities.Create("TextButton", {
            Name = "ClickDetector",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            Parent = self.Frame
        })
        
        clickDetector.Activated:Connect(function()
            if self.OnClick then
                self.OnClick(self.Text)
            end
        end)
    end
end

-- Set text
function Label:SetText(text)
    self.Text = text
    self.TextLabel.Text = text
end

-- Set icon
function Label:SetIcon(iconName)
    self.Icon = iconName
    if self.IconLabel then
        self.IconLabel.Text = Icons.Get(iconName)
    end
end

-- Set color
function Label:SetColor(color)
    self.TextColor = color
    self.TextLabel.TextColor3 = color
    if self.IconLabel then
        self.IconLabel.TextColor3 = color
    end
end

-- Get frame
function Label:GetFrame()
    return self.Frame
end

-- Apply theme
function Label:ApplyTheme()
    if self.TextLabel then
        Utilities.Tween(self.TextLabel, { TextColor3 = self.TextColor or Theme.Colors.TextPrimary }, 0.2)
    end
    if self.IconLabel then
        Utilities.Tween(self.IconLabel, { TextColor3 = self.TextColor or Theme.Colors.TextPrimary }, 0.2)
    end
end

-- Register for theme updates
function Label:_RegisterThemeListener()
    self._themeListenerId = Theme.OnThemeChange(function()
        self:ApplyTheme()
    end)
end

-- Destroy
function Label:Destroy()
    if self.Frame then
        self.Frame:Destroy()
    end
end

return Label

