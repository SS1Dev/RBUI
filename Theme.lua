--[[
    UIFramework Theme Configuration
    Modern Design with Multiple Themes
]]

local Theme = {}

-- ═══════════════════════════════════════════════════════════════
-- THEME PRESETS
-- ═══════════════════════════════════════════════════════════════

Theme.Presets = {
    -- ═══════════════════════════════════════
    -- PLATINUM GRAY (Default)
    -- ═══════════════════════════════════════
    PlatinumGray = {
        Name = "PlatinumGray",
        Colors = {
            -- Primary (Platinum Silver)
            Primary = Color3.fromRGB(180, 180, 185),
            PrimaryHover = Color3.fromRGB(200, 200, 205),
            PrimaryActive = Color3.fromRGB(160, 160, 165),
            PrimaryGlow = Color3.fromRGB(180, 180, 185),
            
            -- Secondary
            Secondary = Color3.fromRGB(120, 120, 125),
            SecondaryHover = Color3.fromRGB(140, 140, 145),
            
            -- Accent (Cool Gray)
            Accent = Color3.fromRGB(150, 155, 165),
            AccentHover = Color3.fromRGB(170, 175, 185),
            
            -- Background (Dark Gray)
            Background = Color3.fromRGB(25, 25, 28),
            BackgroundSecondary = Color3.fromRGB(35, 35, 38),
            BackgroundTertiary = Color3.fromRGB(45, 45, 48),
            
            -- Surface
            Surface = Color3.fromRGB(32, 32, 35),
            SurfaceHover = Color3.fromRGB(42, 42, 45),
            SurfaceBorder = Color3.fromRGB(60, 60, 65),
            
            -- Text
            TextPrimary = Color3.fromRGB(240, 240, 245),
            TextSecondary = Color3.fromRGB(180, 180, 185),
            TextMuted = Color3.fromRGB(120, 120, 125),
            TextDisabled = Color3.fromRGB(80, 80, 85),
            
            -- Status
            Success = Color3.fromRGB(100, 200, 120),
            SuccessHover = Color3.fromRGB(120, 220, 140),
            Warning = Color3.fromRGB(255, 200, 100),
            WarningHover = Color3.fromRGB(255, 220, 130),
            Error = Color3.fromRGB(255, 100, 100),
            ErrorHover = Color3.fromRGB(255, 130, 130),
            Info = Color3.fromRGB(120, 170, 220),
            InfoHover = Color3.fromRGB(140, 190, 240),
            
            -- Components
            InputBackground = Color3.fromRGB(35, 35, 38),
            InputBorder = Color3.fromRGB(60, 60, 65),
            InputFocus = Color3.fromRGB(180, 180, 185),
            
            ToggleOff = Color3.fromRGB(60, 60, 65),
            ToggleOn = Color3.fromRGB(180, 180, 185),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(45, 45, 48),
            SliderFill = Color3.fromRGB(180, 180, 185),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(35, 35, 38),
            DropdownItemHover = Color3.fromRGB(42, 42, 45),
            
            TabActive = Color3.fromRGB(180, 180, 185),
            TabInactive = Color3.fromRGB(45, 45, 48),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(180, 180, 185),
        }
    },
    
    -- ═══════════════════════════════════════
    -- TYPOGRAPHY CONTRAST
    -- ═══════════════════════════════════════
    TypographyContrast = {
        Name = "TypographyContrast",
        Colors = {
            -- Primary (High Contrast)
            Primary = Color3.fromRGB(255, 255, 255),
            PrimaryHover = Color3.fromRGB(240, 240, 240),
            PrimaryActive = Color3.fromRGB(220, 220, 220),
            PrimaryGlow = Color3.fromRGB(255, 255, 255),
            
            -- Secondary
            Secondary = Color3.fromRGB(100, 100, 100),
            SecondaryHover = Color3.fromRGB(120, 120, 120),
            
            -- Accent (Bold Black)
            Accent = Color3.fromRGB(0, 0, 0),
            AccentHover = Color3.fromRGB(30, 30, 30),
            
            -- Background (Pure Black)
            Background = Color3.fromRGB(0, 0, 0),
            BackgroundSecondary = Color3.fromRGB(10, 10, 10),
            BackgroundTertiary = Color3.fromRGB(20, 20, 20),
            
            -- Surface
            Surface = Color3.fromRGB(15, 15, 15),
            SurfaceHover = Color3.fromRGB(25, 25, 25),
            SurfaceBorder = Color3.fromRGB(50, 50, 50),
            
            -- Text (Maximum Contrast)
            TextPrimary = Color3.fromRGB(255, 255, 255),
            TextSecondary = Color3.fromRGB(200, 200, 200),
            TextMuted = Color3.fromRGB(120, 120, 120),
            TextDisabled = Color3.fromRGB(70, 70, 70),
            
            -- Status (Vibrant for visibility)
            Success = Color3.fromRGB(0, 255, 100),
            SuccessHover = Color3.fromRGB(50, 255, 130),
            Warning = Color3.fromRGB(255, 255, 0),
            WarningHover = Color3.fromRGB(255, 255, 80),
            Error = Color3.fromRGB(255, 0, 0),
            ErrorHover = Color3.fromRGB(255, 50, 50),
            Info = Color3.fromRGB(0, 150, 255),
            InfoHover = Color3.fromRGB(50, 180, 255),
            
            -- Components
            InputBackground = Color3.fromRGB(10, 10, 10),
            InputBorder = Color3.fromRGB(50, 50, 50),
            InputFocus = Color3.fromRGB(255, 255, 255),
            
            ToggleOff = Color3.fromRGB(50, 50, 50),
            ToggleOn = Color3.fromRGB(255, 255, 255),
            ToggleKnob = Color3.fromRGB(0, 0, 0),
            
            SliderTrack = Color3.fromRGB(20, 20, 20),
            SliderFill = Color3.fromRGB(255, 255, 255),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(10, 10, 10),
            DropdownItemHover = Color3.fromRGB(25, 25, 25),
            
            TabActive = Color3.fromRGB(255, 255, 255),
            TabInactive = Color3.fromRGB(20, 20, 20),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(255, 255, 255),
        }
    },
    
    -- ═══════════════════════════════════════
    -- VIBRANT ACCENTS
    -- ═══════════════════════════════════════
    VibrantAccents = {
        Name = "VibrantAccents",
        Colors = {
            -- Primary (Vibrant Purple)
            Primary = Color3.fromRGB(138, 43, 226),
            PrimaryHover = Color3.fromRGB(155, 89, 232),
            PrimaryActive = Color3.fromRGB(118, 33, 196),
            PrimaryGlow = Color3.fromRGB(138, 43, 226),
            
            -- Secondary
            Secondary = Color3.fromRGB(80, 60, 100),
            SecondaryHover = Color3.fromRGB(100, 80, 120),
            
            -- Accent (Vibrant Cyan)
            Accent = Color3.fromRGB(0, 255, 255),
            AccentHover = Color3.fromRGB(80, 255, 255),
            
            -- Background (Dark)
            Background = Color3.fromRGB(18, 16, 20),
            BackgroundSecondary = Color3.fromRGB(26, 24, 30),
            BackgroundTertiary = Color3.fromRGB(35, 32, 40),
            
            -- Surface
            Surface = Color3.fromRGB(30, 28, 35),
            SurfaceHover = Color3.fromRGB(42, 40, 48),
            SurfaceBorder = Color3.fromRGB(60, 55, 70),
            
            -- Text
            TextPrimary = Color3.fromRGB(255, 255, 255),
            TextSecondary = Color3.fromRGB(200, 195, 210),
            TextMuted = Color3.fromRGB(130, 125, 140),
            TextDisabled = Color3.fromRGB(85, 80, 95),
            
            -- Status (Vibrant Colors)
            Success = Color3.fromRGB(0, 255, 136),
            SuccessHover = Color3.fromRGB(50, 255, 160),
            Warning = Color3.fromRGB(255, 200, 0),
            WarningHover = Color3.fromRGB(255, 220, 50),
            Error = Color3.fromRGB(255, 71, 87),
            ErrorHover = Color3.fromRGB(255, 107, 120),
            Info = Color3.fromRGB(0, 200, 255),
            InfoHover = Color3.fromRGB(80, 220, 255),
            
            -- Components
            InputBackground = Color3.fromRGB(26, 24, 30),
            InputBorder = Color3.fromRGB(60, 55, 70),
            InputFocus = Color3.fromRGB(138, 43, 226),
            
            ToggleOff = Color3.fromRGB(60, 55, 70),
            ToggleOn = Color3.fromRGB(138, 43, 226),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(35, 32, 40),
            SliderFill = Color3.fromRGB(138, 43, 226),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(26, 24, 30),
            DropdownItemHover = Color3.fromRGB(42, 40, 48),
            
            TabActive = Color3.fromRGB(138, 43, 226),
            TabInactive = Color3.fromRGB(35, 32, 40),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(138, 43, 226),
        }
    },
    
    -- ═══════════════════════════════════════
    -- FUTURISTIC
    -- ═══════════════════════════════════════
    Futuristic = {
        Name = "Futuristic",
        Colors = {
            -- Primary (Neon Cyan)
            Primary = Color3.fromRGB(0, 255, 255),
            PrimaryHover = Color3.fromRGB(80, 255, 255),
            PrimaryActive = Color3.fromRGB(0, 220, 220),
            PrimaryGlow = Color3.fromRGB(0, 255, 255),
            
            -- Secondary
            Secondary = Color3.fromRGB(0, 150, 150),
            SecondaryHover = Color3.fromRGB(0, 180, 180),
            
            -- Accent (Neon Green)
            Accent = Color3.fromRGB(0, 255, 150),
            AccentHover = Color3.fromRGB(50, 255, 180),
            
            -- Background (Deep Blue-Black)
            Background = Color3.fromRGB(5, 10, 20),
            BackgroundSecondary = Color3.fromRGB(10, 18, 32),
            BackgroundTertiary = Color3.fromRGB(15, 28, 45),
            
            -- Surface
            Surface = Color3.fromRGB(12, 22, 38),
            SurfaceHover = Color3.fromRGB(20, 35, 55),
            SurfaceBorder = Color3.fromRGB(0, 150, 200),
            
            -- Text
            TextPrimary = Color3.fromRGB(200, 255, 255),
            TextSecondary = Color3.fromRGB(100, 200, 220),
            TextMuted = Color3.fromRGB(50, 120, 150),
            TextDisabled = Color3.fromRGB(30, 80, 100),
            
            -- Status (Neon Colors)
            Success = Color3.fromRGB(0, 255, 150),
            SuccessHover = Color3.fromRGB(50, 255, 180),
            Warning = Color3.fromRGB(255, 200, 0),
            WarningHover = Color3.fromRGB(255, 220, 50),
            Error = Color3.fromRGB(255, 50, 100),
            ErrorHover = Color3.fromRGB(255, 80, 130),
            Info = Color3.fromRGB(0, 200, 255),
            InfoHover = Color3.fromRGB(50, 220, 255),
            
            -- Components
            InputBackground = Color3.fromRGB(10, 18, 32),
            InputBorder = Color3.fromRGB(0, 150, 200),
            InputFocus = Color3.fromRGB(0, 255, 255),
            
            ToggleOff = Color3.fromRGB(15, 35, 55),
            ToggleOn = Color3.fromRGB(0, 255, 255),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(20, 35, 55),
            SliderFill = Color3.fromRGB(0, 255, 255),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(10, 18, 32),
            DropdownItemHover = Color3.fromRGB(20, 35, 55),
            
            TabActive = Color3.fromRGB(0, 255, 255),
            TabInactive = Color3.fromRGB(20, 35, 55),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(0, 255, 255),
        }
    },
}

-- ═══════════════════════════════════════════════════════════════
-- CURRENT THEME (Default: PlatinumGray)
-- ═══════════════════════════════════════════════════════════════

Theme.CurrentTheme = "PlatinumGray"
Theme.Colors = Theme.Presets.PlatinumGray.Colors

-- ═══════════════════════════════════════════════════════════════
-- TYPOGRAPHY (Compact Style)
-- ═══════════════════════════════════════════════════════════════

Theme.Typography = {
    FontFamily = Enum.Font.GothamMedium,
    FontFamilyBold = Enum.Font.GothamBold,
    FontFamilyLight = Enum.Font.Gotham,
    
    -- Font Sizes (Compact)
    Title = 18,
    Subtitle = 14,
    Body = 12,
    Small = 11,
    Tiny = 10,
    
    LineHeight = 1.4,
}

-- ═══════════════════════════════════════════════════════════════
-- SPACING
-- ═══════════════════════════════════════════════════════════════

Theme.Spacing = {
    None = 0,
    XS = 4,
    SM = 6,
    MD = 10,
    LG = 14,
    XL = 18,
    XXL = 24,
}

-- ═══════════════════════════════════════════════════════════════
-- BORDER RADIUS (4px-6px for panel)
-- ═══════════════════════════════════════════════════════════════

Theme.BorderRadius = {
    None = UDim.new(0, 0),
    XS = UDim.new(0, 2),   -- Smallest elements
    SM = UDim.new(0, 3),   -- Small elements
    MD = UDim.new(0, 4),   -- Medium elements
    LG = UDim.new(0, 6),   -- Large elements, main panel
    XL = UDim.new(0, 6),   -- Extra large
    XXL = UDim.new(0, 6),  -- Main panel
    Full = UDim.new(0, 9999), -- Pill shape (toggle knob)
}

-- ═══════════════════════════════════════════════════════════════
-- SIZES
-- ═══════════════════════════════════════════════════════════════

Theme.Sizes = {
    -- Component Heights (Compact)
    InputHeight = 32,
    ButtonHeight = 32,
    ToggleHeight = 20,
    ToggleWidth = 40,
    CheckboxSize = 18,
    SliderHeight = 6,
    SliderKnobSize = 16,
    
    -- Layout (Compact)
    SidebarWidth = 180,
    HeaderHeight = 44,
    
    -- Icons (Compact)
    IconSmall = 12,
    IconMedium = 14,
    IconLarge = 16,
    
    -- Resize Handle
    ResizeHandleSize = 16,
    MinPanelWidth = 400,
    MinPanelHeight = 300,
}

-- ═══════════════════════════════════════════════════════════════
-- BORDER SETTINGS (Modern - Subtle)
-- ═══════════════════════════════════════════════════════════════

Theme.Border = {
    Thickness = 1,
    Opacity = 0.3, -- Subtle borders
}

-- ═══════════════════════════════════════════════════════════════
-- ANIMATION
-- ═══════════════════════════════════════════════════════════════

Theme.Animation = {
    Duration = 0.25,
    EasingStyle = Enum.EasingStyle.Quint,
    EasingDirection = Enum.EasingDirection.Out,
}

-- ═══════════════════════════════════════════════════════════════
-- THEME CHANGE EVENT SYSTEM
-- ═══════════════════════════════════════════════════════════════

Theme._listeners = {}
Theme._componentRegistry = {}

-- Register a callback to be called when theme changes
function Theme.OnThemeChange(callback)
    table.insert(Theme._listeners, callback)
    return #Theme._listeners -- Return listener ID for removal
end

-- Remove a theme change listener
function Theme.RemoveListener(listenerId)
    Theme._listeners[listenerId] = nil
end

-- Register a UI component for automatic theme updates
function Theme.RegisterComponent(instance, propertyMap)
    -- propertyMap = { BackgroundColor3 = "Background", TextColor3 = "TextPrimary", ... }
    table.insert(Theme._componentRegistry, {
        Instance = instance,
        PropertyMap = propertyMap
    })
end

-- Trigger all theme change callbacks
function Theme._notifyListeners()
    for _, callback in pairs(Theme._listeners) do
        if type(callback) == "function" then
            pcall(callback, Theme.CurrentTheme, Theme.Colors)
        end
    end
    
    -- Update registered components
    for i = #Theme._componentRegistry, 1, -1 do
        local entry = Theme._componentRegistry[i]
        if entry.Instance and entry.Instance.Parent then
            for property, colorKey in pairs(entry.PropertyMap) do
                if Theme.Colors[colorKey] then
                    pcall(function()
                        entry.Instance[property] = Theme.Colors[colorKey]
                    end)
                end
            end
        else
            -- Remove destroyed instances
            table.remove(Theme._componentRegistry, i)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
-- THEME FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Set theme by name
function Theme.SetTheme(themeName)
    if Theme.Presets[themeName] then
        Theme.CurrentTheme = themeName
        Theme.Colors = Theme.Presets[themeName].Colors
        Theme._notifyListeners()
        return true
    end
    return false
end

-- Get current theme name
function Theme.GetCurrentTheme()
    return Theme.CurrentTheme
end

-- Get all available themes
function Theme.GetAvailableThemes()
    local themes = {}
    for name, _ in pairs(Theme.Presets) do
        table.insert(themes, name)
    end
    table.sort(themes)
    return themes
end

-- Get TweenInfo helper
function Theme.GetTweenInfo(duration)
    return TweenInfo.new(
        duration or Theme.Animation.Duration,
        Theme.Animation.EasingStyle,
        Theme.Animation.EasingDirection
    )
end

-- Check if theme is dark
function Theme.IsDarkTheme()
    local bg = Theme.Colors.Background
    local brightness = (bg.R + bg.G + bg.B) / 3
    return brightness < 0.5
end

return Theme
