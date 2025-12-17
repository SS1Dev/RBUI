--[[
    UIFramework Theme Configuration
    Gamified Style Design with Multiple Themes
]]

local Theme = {}

-- ═══════════════════════════════════════════════════════════════
-- THEME PRESETS
-- ═══════════════════════════════════════════════════════════════

Theme.Presets = {
    -- ═══════════════════════════════════════
    -- DARK THEME (Default)
    -- ═══════════════════════════════════════
    Dark = {
        Name = "Dark",
        Colors = {
            -- Primary (Neon Purple - Gamified)
            Primary = Color3.fromRGB(138, 43, 226),
            PrimaryHover = Color3.fromRGB(155, 89, 232),
            PrimaryActive = Color3.fromRGB(118, 33, 196),
            PrimaryGlow = Color3.fromRGB(138, 43, 226),
            
            -- Secondary
            Secondary = Color3.fromRGB(75, 85, 99),
            SecondaryHover = Color3.fromRGB(107, 114, 128),
            
            -- Accent (Neon Cyan)
            Accent = Color3.fromRGB(0, 255, 255),
            AccentHover = Color3.fromRGB(80, 255, 255),
            
            -- Background
            Background = Color3.fromRGB(17, 17, 23),
            BackgroundSecondary = Color3.fromRGB(25, 25, 35),
            BackgroundTertiary = Color3.fromRGB(35, 35, 50),
            
            -- Surface
            Surface = Color3.fromRGB(28, 28, 40),
            SurfaceHover = Color3.fromRGB(40, 40, 55),
            SurfaceBorder = Color3.fromRGB(60, 60, 80),
            
            -- Text
            TextPrimary = Color3.fromRGB(255, 255, 255),
            TextSecondary = Color3.fromRGB(180, 180, 200),
            TextMuted = Color3.fromRGB(120, 120, 140),
            TextDisabled = Color3.fromRGB(80, 80, 100),
            
            -- Status
            Success = Color3.fromRGB(0, 255, 136),
            SuccessHover = Color3.fromRGB(50, 255, 160),
            Warning = Color3.fromRGB(255, 200, 0),
            WarningHover = Color3.fromRGB(255, 220, 50),
            Error = Color3.fromRGB(255, 71, 87),
            ErrorHover = Color3.fromRGB(255, 107, 120),
            Info = Color3.fromRGB(0, 200, 255),
            InfoHover = Color3.fromRGB(80, 220, 255),
            
            -- Components
            InputBackground = Color3.fromRGB(25, 25, 35),
            InputBorder = Color3.fromRGB(60, 60, 80),
            InputFocus = Color3.fromRGB(138, 43, 226),
            
            ToggleOff = Color3.fromRGB(60, 60, 80),
            ToggleOn = Color3.fromRGB(138, 43, 226),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(45, 45, 60),
            SliderFill = Color3.fromRGB(138, 43, 226),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(25, 25, 35),
            DropdownItemHover = Color3.fromRGB(45, 45, 65),
            
            TabActive = Color3.fromRGB(138, 43, 226),
            TabInactive = Color3.fromRGB(45, 45, 60),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(138, 43, 226),
        }
    },
    
    -- ═══════════════════════════════════════
    -- LIGHT THEME
    -- ═══════════════════════════════════════
    Light = {
        Name = "Light",
        Colors = {
            Primary = Color3.fromRGB(99, 102, 241),
            PrimaryHover = Color3.fromRGB(129, 140, 248),
            PrimaryActive = Color3.fromRGB(79, 82, 221),
            PrimaryGlow = Color3.fromRGB(99, 102, 241),
            
            Secondary = Color3.fromRGB(156, 163, 175),
            SecondaryHover = Color3.fromRGB(107, 114, 128),
            
            Accent = Color3.fromRGB(59, 130, 246),
            AccentHover = Color3.fromRGB(96, 165, 250),
            
            Background = Color3.fromRGB(249, 250, 251),
            BackgroundSecondary = Color3.fromRGB(243, 244, 246),
            BackgroundTertiary = Color3.fromRGB(229, 231, 235),
            
            Surface = Color3.fromRGB(255, 255, 255),
            SurfaceHover = Color3.fromRGB(243, 244, 246),
            SurfaceBorder = Color3.fromRGB(209, 213, 219),
            
            TextPrimary = Color3.fromRGB(17, 24, 39),
            TextSecondary = Color3.fromRGB(75, 85, 99),
            TextMuted = Color3.fromRGB(156, 163, 175),
            TextDisabled = Color3.fromRGB(209, 213, 219),
            
            Success = Color3.fromRGB(34, 197, 94),
            SuccessHover = Color3.fromRGB(74, 222, 128),
            Warning = Color3.fromRGB(234, 179, 8),
            WarningHover = Color3.fromRGB(250, 204, 21),
            Error = Color3.fromRGB(239, 68, 68),
            ErrorHover = Color3.fromRGB(248, 113, 113),
            Info = Color3.fromRGB(59, 130, 246),
            InfoHover = Color3.fromRGB(96, 165, 250),
            
            InputBackground = Color3.fromRGB(255, 255, 255),
            InputBorder = Color3.fromRGB(209, 213, 219),
            InputFocus = Color3.fromRGB(99, 102, 241),
            
            ToggleOff = Color3.fromRGB(209, 213, 219),
            ToggleOn = Color3.fromRGB(99, 102, 241),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(229, 231, 235),
            SliderFill = Color3.fromRGB(99, 102, 241),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownItemHover = Color3.fromRGB(243, 244, 246),
            
            TabActive = Color3.fromRGB(99, 102, 241),
            TabInactive = Color3.fromRGB(229, 231, 235),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(99, 102, 241),
        }
    },
    
    -- ═══════════════════════════════════════
    -- PINK THEME (Neon Pink Gamified)
    -- ═══════════════════════════════════════
    Pink = {
        Name = "Pink",
        Colors = {
            Primary = Color3.fromRGB(255, 0, 128),
            PrimaryHover = Color3.fromRGB(255, 80, 160),
            PrimaryActive = Color3.fromRGB(220, 0, 110),
            PrimaryGlow = Color3.fromRGB(255, 0, 128),
            
            Secondary = Color3.fromRGB(180, 100, 140),
            SecondaryHover = Color3.fromRGB(200, 120, 160),
            
            Accent = Color3.fromRGB(255, 150, 200),
            AccentHover = Color3.fromRGB(255, 180, 220),
            
            Background = Color3.fromRGB(25, 15, 25),
            BackgroundSecondary = Color3.fromRGB(35, 22, 35),
            BackgroundTertiary = Color3.fromRGB(50, 30, 50),
            
            Surface = Color3.fromRGB(40, 25, 40),
            SurfaceHover = Color3.fromRGB(55, 35, 55),
            SurfaceBorder = Color3.fromRGB(100, 50, 90),
            
            TextPrimary = Color3.fromRGB(255, 240, 250),
            TextSecondary = Color3.fromRGB(220, 180, 210),
            TextMuted = Color3.fromRGB(160, 120, 150),
            TextDisabled = Color3.fromRGB(100, 70, 90),
            
            Success = Color3.fromRGB(0, 255, 180),
            SuccessHover = Color3.fromRGB(50, 255, 200),
            Warning = Color3.fromRGB(255, 200, 100),
            WarningHover = Color3.fromRGB(255, 220, 140),
            Error = Color3.fromRGB(255, 80, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(200, 150, 255),
            InfoHover = Color3.fromRGB(220, 180, 255),
            
            InputBackground = Color3.fromRGB(35, 22, 35),
            InputBorder = Color3.fromRGB(100, 50, 90),
            InputFocus = Color3.fromRGB(255, 0, 128),
            
            ToggleOff = Color3.fromRGB(80, 50, 70),
            ToggleOn = Color3.fromRGB(255, 0, 128),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(60, 35, 55),
            SliderFill = Color3.fromRGB(255, 0, 128),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(35, 22, 35),
            DropdownItemHover = Color3.fromRGB(60, 35, 55),
            
            TabActive = Color3.fromRGB(255, 0, 128),
            TabInactive = Color3.fromRGB(60, 35, 55),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(255, 0, 128),
        }
    },
    
    -- ═══════════════════════════════════════
    -- BLUE THEME (Electric Blue Gamified)
    -- ═══════════════════════════════════════
    Blue = {
        Name = "Blue",
        Colors = {
            Primary = Color3.fromRGB(0, 150, 255),
            PrimaryHover = Color3.fromRGB(50, 180, 255),
            PrimaryActive = Color3.fromRGB(0, 120, 220),
            PrimaryGlow = Color3.fromRGB(0, 150, 255),
            
            Secondary = Color3.fromRGB(70, 100, 140),
            SecondaryHover = Color3.fromRGB(90, 120, 160),
            
            Accent = Color3.fromRGB(0, 255, 255),
            AccentHover = Color3.fromRGB(80, 255, 255),
            
            Background = Color3.fromRGB(12, 20, 35),
            BackgroundSecondary = Color3.fromRGB(18, 30, 50),
            BackgroundTertiary = Color3.fromRGB(25, 40, 65),
            
            Surface = Color3.fromRGB(20, 35, 55),
            SurfaceHover = Color3.fromRGB(30, 50, 75),
            SurfaceBorder = Color3.fromRGB(50, 80, 120),
            
            TextPrimary = Color3.fromRGB(230, 245, 255),
            TextSecondary = Color3.fromRGB(160, 200, 230),
            TextMuted = Color3.fromRGB(100, 140, 180),
            TextDisabled = Color3.fromRGB(60, 90, 120),
            
            Success = Color3.fromRGB(0, 255, 150),
            SuccessHover = Color3.fromRGB(50, 255, 180),
            Warning = Color3.fromRGB(255, 200, 0),
            WarningHover = Color3.fromRGB(255, 220, 50),
            Error = Color3.fromRGB(255, 80, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(100, 200, 255),
            InfoHover = Color3.fromRGB(140, 220, 255),
            
            InputBackground = Color3.fromRGB(18, 30, 50),
            InputBorder = Color3.fromRGB(50, 80, 120),
            InputFocus = Color3.fromRGB(0, 150, 255),
            
            ToggleOff = Color3.fromRGB(40, 60, 90),
            ToggleOn = Color3.fromRGB(0, 150, 255),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(35, 55, 80),
            SliderFill = Color3.fromRGB(0, 150, 255),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(18, 30, 50),
            DropdownItemHover = Color3.fromRGB(35, 55, 80),
            
            TabActive = Color3.fromRGB(0, 150, 255),
            TabInactive = Color3.fromRGB(35, 55, 80),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(0, 150, 255),
        }
    },
    
    -- ═══════════════════════════════════════
    -- GOLDEN THEME (Royal Gold Gamified)
    -- ═══════════════════════════════════════
    Golden = {
        Name = "Golden",
        Colors = {
            Primary = Color3.fromRGB(255, 200, 0),
            PrimaryHover = Color3.fromRGB(255, 215, 50),
            PrimaryActive = Color3.fromRGB(220, 170, 0),
            PrimaryGlow = Color3.fromRGB(255, 200, 0),
            
            Secondary = Color3.fromRGB(140, 110, 60),
            SecondaryHover = Color3.fromRGB(160, 130, 80),
            
            Accent = Color3.fromRGB(255, 180, 100),
            AccentHover = Color3.fromRGB(255, 200, 130),
            
            Background = Color3.fromRGB(25, 20, 12),
            BackgroundSecondary = Color3.fromRGB(35, 28, 18),
            BackgroundTertiary = Color3.fromRGB(50, 40, 25),
            
            Surface = Color3.fromRGB(40, 32, 20),
            SurfaceHover = Color3.fromRGB(55, 45, 30),
            SurfaceBorder = Color3.fromRGB(100, 80, 45),
            
            TextPrimary = Color3.fromRGB(255, 250, 230),
            TextSecondary = Color3.fromRGB(220, 200, 160),
            TextMuted = Color3.fromRGB(160, 140, 100),
            TextDisabled = Color3.fromRGB(100, 85, 55),
            
            Success = Color3.fromRGB(150, 255, 100),
            SuccessHover = Color3.fromRGB(180, 255, 130),
            Warning = Color3.fromRGB(255, 180, 50),
            WarningHover = Color3.fromRGB(255, 200, 90),
            Error = Color3.fromRGB(255, 100, 80),
            ErrorHover = Color3.fromRGB(255, 130, 110),
            Info = Color3.fromRGB(255, 220, 100),
            InfoHover = Color3.fromRGB(255, 235, 140),
            
            InputBackground = Color3.fromRGB(35, 28, 18),
            InputBorder = Color3.fromRGB(100, 80, 45),
            InputFocus = Color3.fromRGB(255, 200, 0),
            
            ToggleOff = Color3.fromRGB(70, 55, 35),
            ToggleOn = Color3.fromRGB(255, 200, 0),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(60, 48, 30),
            SliderFill = Color3.fromRGB(255, 200, 0),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(35, 28, 18),
            DropdownItemHover = Color3.fromRGB(60, 48, 30),
            
            TabActive = Color3.fromRGB(255, 200, 0),
            TabInactive = Color3.fromRGB(60, 48, 30),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(255, 200, 0),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK BLUE THEME
    -- ═══════════════════════════════════════
    DarkBlue = {
        Name = "DarkBlue",
        Colors = {
            Primary = Color3.fromRGB(66, 135, 245),
            PrimaryHover = Color3.fromRGB(100, 160, 250),
            PrimaryActive = Color3.fromRGB(45, 110, 220),
            PrimaryGlow = Color3.fromRGB(66, 135, 245),
            
            Secondary = Color3.fromRGB(55, 75, 110),
            SecondaryHover = Color3.fromRGB(75, 95, 130),
            
            Accent = Color3.fromRGB(100, 180, 255),
            AccentHover = Color3.fromRGB(130, 200, 255),
            
            Background = Color3.fromRGB(8, 15, 30),
            BackgroundSecondary = Color3.fromRGB(12, 22, 42),
            BackgroundTertiary = Color3.fromRGB(18, 32, 58),
            
            Surface = Color3.fromRGB(15, 28, 50),
            SurfaceHover = Color3.fromRGB(22, 40, 70),
            SurfaceBorder = Color3.fromRGB(40, 65, 105),
            
            TextPrimary = Color3.fromRGB(220, 235, 255),
            TextSecondary = Color3.fromRGB(150, 180, 220),
            TextMuted = Color3.fromRGB(90, 120, 165),
            TextDisabled = Color3.fromRGB(50, 75, 110),
            
            Success = Color3.fromRGB(50, 255, 150),
            SuccessHover = Color3.fromRGB(90, 255, 180),
            Warning = Color3.fromRGB(255, 190, 50),
            WarningHover = Color3.fromRGB(255, 210, 90),
            Error = Color3.fromRGB(255, 85, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(80, 170, 255),
            InfoHover = Color3.fromRGB(120, 195, 255),
            
            InputBackground = Color3.fromRGB(12, 22, 42),
            InputBorder = Color3.fromRGB(40, 65, 105),
            InputFocus = Color3.fromRGB(66, 135, 245),
            
            ToggleOff = Color3.fromRGB(35, 55, 90),
            ToggleOn = Color3.fromRGB(66, 135, 245),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(28, 45, 75),
            SliderFill = Color3.fromRGB(66, 135, 245),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(12, 22, 42),
            DropdownItemHover = Color3.fromRGB(28, 45, 75),
            
            TabActive = Color3.fromRGB(66, 135, 245),
            TabInactive = Color3.fromRGB(28, 45, 75),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(66, 135, 245),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK PINK THEME
    -- ═══════════════════════════════════════
    DarkPink = {
        Name = "DarkPink",
        Colors = {
            Primary = Color3.fromRGB(219, 39, 119),
            PrimaryHover = Color3.fromRGB(236, 72, 153),
            PrimaryActive = Color3.fromRGB(190, 24, 93),
            PrimaryGlow = Color3.fromRGB(219, 39, 119),
            
            Secondary = Color3.fromRGB(110, 55, 85),
            SecondaryHover = Color3.fromRGB(130, 75, 105),
            
            Accent = Color3.fromRGB(244, 114, 182),
            AccentHover = Color3.fromRGB(249, 168, 212),
            
            Background = Color3.fromRGB(20, 10, 18),
            BackgroundSecondary = Color3.fromRGB(30, 15, 26),
            BackgroundTertiary = Color3.fromRGB(45, 22, 38),
            
            Surface = Color3.fromRGB(35, 18, 30),
            SurfaceHover = Color3.fromRGB(50, 28, 42),
            SurfaceBorder = Color3.fromRGB(85, 45, 70),
            
            TextPrimary = Color3.fromRGB(253, 242, 248),
            TextSecondary = Color3.fromRGB(220, 180, 200),
            TextMuted = Color3.fromRGB(150, 110, 135),
            TextDisabled = Color3.fromRGB(90, 60, 78),
            
            Success = Color3.fromRGB(74, 222, 128),
            SuccessHover = Color3.fromRGB(110, 235, 158),
            Warning = Color3.fromRGB(251, 191, 36),
            WarningHover = Color3.fromRGB(252, 211, 77),
            Error = Color3.fromRGB(248, 113, 113),
            ErrorHover = Color3.fromRGB(252, 165, 165),
            Info = Color3.fromRGB(244, 114, 182),
            InfoHover = Color3.fromRGB(249, 168, 212),
            
            InputBackground = Color3.fromRGB(30, 15, 26),
            InputBorder = Color3.fromRGB(85, 45, 70),
            InputFocus = Color3.fromRGB(219, 39, 119),
            
            ToggleOff = Color3.fromRGB(65, 35, 55),
            ToggleOn = Color3.fromRGB(219, 39, 119),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(55, 28, 45),
            SliderFill = Color3.fromRGB(219, 39, 119),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(30, 15, 26),
            DropdownItemHover = Color3.fromRGB(55, 28, 45),
            
            TabActive = Color3.fromRGB(219, 39, 119),
            TabInactive = Color3.fromRGB(55, 28, 45),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(219, 39, 119),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK GOLDEN THEME
    -- ═══════════════════════════════════════
    DarkGolden = {
        Name = "DarkGolden",
        Colors = {
            Primary = Color3.fromRGB(217, 169, 52),
            PrimaryHover = Color3.fromRGB(234, 190, 85),
            PrimaryActive = Color3.fromRGB(185, 140, 30),
            PrimaryGlow = Color3.fromRGB(217, 169, 52),
            
            Secondary = Color3.fromRGB(100, 80, 45),
            SecondaryHover = Color3.fromRGB(125, 100, 60),
            
            Accent = Color3.fromRGB(251, 191, 36),
            AccentHover = Color3.fromRGB(252, 211, 77),
            
            Background = Color3.fromRGB(18, 14, 8),
            BackgroundSecondary = Color3.fromRGB(28, 22, 12),
            BackgroundTertiary = Color3.fromRGB(42, 34, 18),
            
            Surface = Color3.fromRGB(32, 26, 14),
            SurfaceHover = Color3.fromRGB(48, 40, 22),
            SurfaceBorder = Color3.fromRGB(80, 65, 35),
            
            TextPrimary = Color3.fromRGB(255, 251, 235),
            TextSecondary = Color3.fromRGB(220, 200, 150),
            TextMuted = Color3.fromRGB(150, 130, 90),
            TextDisabled = Color3.fromRGB(90, 75, 50),
            
            Success = Color3.fromRGB(134, 239, 172),
            SuccessHover = Color3.fromRGB(170, 250, 200),
            Warning = Color3.fromRGB(251, 191, 36),
            WarningHover = Color3.fromRGB(252, 211, 77),
            Error = Color3.fromRGB(248, 113, 113),
            ErrorHover = Color3.fromRGB(252, 165, 165),
            Info = Color3.fromRGB(251, 191, 36),
            InfoHover = Color3.fromRGB(252, 211, 77),
            
            InputBackground = Color3.fromRGB(28, 22, 12),
            InputBorder = Color3.fromRGB(80, 65, 35),
            InputFocus = Color3.fromRGB(217, 169, 52),
            
            ToggleOff = Color3.fromRGB(60, 50, 30),
            ToggleOn = Color3.fromRGB(217, 169, 52),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(50, 42, 25),
            SliderFill = Color3.fromRGB(217, 169, 52),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(28, 22, 12),
            DropdownItemHover = Color3.fromRGB(50, 42, 25),
            
            TabActive = Color3.fromRGB(217, 169, 52),
            TabInactive = Color3.fromRGB(50, 42, 25),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(217, 169, 52),
        }
    },
    
    -- ═══════════════════════════════════════
    -- LIGHT PINK THEME
    -- ═══════════════════════════════════════
    LightPink = {
        Name = "LightPink",
        Colors = {
            Primary = Color3.fromRGB(236, 72, 153),
            PrimaryHover = Color3.fromRGB(244, 114, 182),
            PrimaryActive = Color3.fromRGB(219, 39, 119),
            PrimaryGlow = Color3.fromRGB(236, 72, 153),
            
            Secondary = Color3.fromRGB(200, 160, 180),
            SecondaryHover = Color3.fromRGB(180, 140, 165),
            
            Accent = Color3.fromRGB(244, 114, 182),
            AccentHover = Color3.fromRGB(249, 168, 212),
            
            Background = Color3.fromRGB(253, 244, 248),
            BackgroundSecondary = Color3.fromRGB(252, 231, 243),
            BackgroundTertiary = Color3.fromRGB(251, 207, 232),
            
            Surface = Color3.fromRGB(255, 255, 255),
            SurfaceHover = Color3.fromRGB(252, 231, 243),
            SurfaceBorder = Color3.fromRGB(244, 194, 220),
            
            TextPrimary = Color3.fromRGB(80, 20, 50),
            TextSecondary = Color3.fromRGB(120, 60, 90),
            TextMuted = Color3.fromRGB(180, 130, 155),
            TextDisabled = Color3.fromRGB(220, 180, 200),
            
            Success = Color3.fromRGB(34, 197, 94),
            SuccessHover = Color3.fromRGB(74, 222, 128),
            Warning = Color3.fromRGB(234, 179, 8),
            WarningHover = Color3.fromRGB(250, 204, 21),
            Error = Color3.fromRGB(239, 68, 68),
            ErrorHover = Color3.fromRGB(248, 113, 113),
            Info = Color3.fromRGB(236, 72, 153),
            InfoHover = Color3.fromRGB(244, 114, 182),
            
            InputBackground = Color3.fromRGB(255, 255, 255),
            InputBorder = Color3.fromRGB(244, 194, 220),
            InputFocus = Color3.fromRGB(236, 72, 153),
            
            ToggleOff = Color3.fromRGB(220, 190, 205),
            ToggleOn = Color3.fromRGB(236, 72, 153),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(251, 207, 232),
            SliderFill = Color3.fromRGB(236, 72, 153),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownItemHover = Color3.fromRGB(252, 231, 243),
            
            TabActive = Color3.fromRGB(236, 72, 153),
            TabInactive = Color3.fromRGB(251, 207, 232),
            
            Shadow = Color3.fromRGB(100, 50, 75),
            Glow = Color3.fromRGB(236, 72, 153),
        }
    },
    
    -- ═══════════════════════════════════════
    -- LIGHT GOLDEN THEME
    -- ═══════════════════════════════════════
    LightGolden = {
        Name = "LightGolden",
        Colors = {
            Primary = Color3.fromRGB(202, 138, 4),
            PrimaryHover = Color3.fromRGB(217, 160, 30),
            PrimaryActive = Color3.fromRGB(161, 98, 7),
            PrimaryGlow = Color3.fromRGB(202, 138, 4),
            
            Secondary = Color3.fromRGB(180, 160, 120),
            SecondaryHover = Color3.fromRGB(160, 140, 100),
            
            Accent = Color3.fromRGB(234, 179, 8),
            AccentHover = Color3.fromRGB(250, 204, 21),
            
            Background = Color3.fromRGB(254, 252, 247),
            BackgroundSecondary = Color3.fromRGB(254, 249, 235),
            BackgroundTertiary = Color3.fromRGB(254, 240, 200),
            
            Surface = Color3.fromRGB(255, 255, 255),
            SurfaceHover = Color3.fromRGB(254, 249, 235),
            SurfaceBorder = Color3.fromRGB(240, 215, 160),
            
            TextPrimary = Color3.fromRGB(70, 50, 10),
            TextSecondary = Color3.fromRGB(115, 90, 35),
            TextMuted = Color3.fromRGB(170, 145, 90),
            TextDisabled = Color3.fromRGB(210, 190, 145),
            
            Success = Color3.fromRGB(34, 197, 94),
            SuccessHover = Color3.fromRGB(74, 222, 128),
            Warning = Color3.fromRGB(202, 138, 4),
            WarningHover = Color3.fromRGB(217, 160, 30),
            Error = Color3.fromRGB(239, 68, 68),
            ErrorHover = Color3.fromRGB(248, 113, 113),
            Info = Color3.fromRGB(202, 138, 4),
            InfoHover = Color3.fromRGB(217, 160, 30),
            
            InputBackground = Color3.fromRGB(255, 255, 255),
            InputBorder = Color3.fromRGB(240, 215, 160),
            InputFocus = Color3.fromRGB(202, 138, 4),
            
            ToggleOff = Color3.fromRGB(220, 200, 160),
            ToggleOn = Color3.fromRGB(202, 138, 4),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(254, 240, 200),
            SliderFill = Color3.fromRGB(202, 138, 4),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownItemHover = Color3.fromRGB(254, 249, 235),
            
            TabActive = Color3.fromRGB(202, 138, 4),
            TabInactive = Color3.fromRGB(254, 240, 200),
            
            Shadow = Color3.fromRGB(100, 80, 40),
            Glow = Color3.fromRGB(202, 138, 4),
        }
    },
    
    -- ═══════════════════════════════════════
    -- LIGHT BLUE THEME
    -- ═══════════════════════════════════════
    LightBlue = {
        Name = "LightBlue",
        Colors = {
            Primary = Color3.fromRGB(37, 99, 235),
            PrimaryHover = Color3.fromRGB(59, 130, 246),
            PrimaryActive = Color3.fromRGB(29, 78, 216),
            PrimaryGlow = Color3.fromRGB(37, 99, 235),
            
            Secondary = Color3.fromRGB(148, 180, 210),
            SecondaryHover = Color3.fromRGB(125, 160, 195),
            
            Accent = Color3.fromRGB(59, 130, 246),
            AccentHover = Color3.fromRGB(96, 165, 250),
            
            Background = Color3.fromRGB(240, 249, 255),
            BackgroundSecondary = Color3.fromRGB(224, 242, 254),
            BackgroundTertiary = Color3.fromRGB(186, 230, 253),
            
            Surface = Color3.fromRGB(255, 255, 255),
            SurfaceHover = Color3.fromRGB(224, 242, 254),
            SurfaceBorder = Color3.fromRGB(165, 210, 245),
            
            TextPrimary = Color3.fromRGB(15, 45, 85),
            TextSecondary = Color3.fromRGB(55, 95, 145),
            TextMuted = Color3.fromRGB(115, 155, 200),
            TextDisabled = Color3.fromRGB(175, 205, 235),
            
            Success = Color3.fromRGB(34, 197, 94),
            SuccessHover = Color3.fromRGB(74, 222, 128),
            Warning = Color3.fromRGB(234, 179, 8),
            WarningHover = Color3.fromRGB(250, 204, 21),
            Error = Color3.fromRGB(239, 68, 68),
            ErrorHover = Color3.fromRGB(248, 113, 113),
            Info = Color3.fromRGB(37, 99, 235),
            InfoHover = Color3.fromRGB(59, 130, 246),
            
            InputBackground = Color3.fromRGB(255, 255, 255),
            InputBorder = Color3.fromRGB(165, 210, 245),
            InputFocus = Color3.fromRGB(37, 99, 235),
            
            ToggleOff = Color3.fromRGB(186, 210, 235),
            ToggleOn = Color3.fromRGB(37, 99, 235),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(186, 230, 253),
            SliderFill = Color3.fromRGB(37, 99, 235),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownItemHover = Color3.fromRGB(224, 242, 254),
            
            TabActive = Color3.fromRGB(37, 99, 235),
            TabInactive = Color3.fromRGB(186, 230, 253),
            
            Shadow = Color3.fromRGB(50, 100, 150),
            Glow = Color3.fromRGB(37, 99, 235),
        }
    },
}

-- ═══════════════════════════════════════════════════════════════
-- CURRENT THEME (Default: Dark)
-- ═══════════════════════════════════════════════════════════════

Theme.CurrentTheme = "Dark"
Theme.Colors = Theme.Presets.Dark.Colors

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
-- SPACING (Compact)
-- ═══════════════════════════════════════════════════════════════

Theme.Spacing = {
    None = 0,
    XS = 2,
    SM = 4,
    MD = 8,
    LG = 12,
    XL = 16,
    XXL = 24,
}

-- ═══════════════════════════════════════════════════════════════
-- BORDER RADIUS (Modern - More Rounded)
-- ═══════════════════════════════════════════════════════════════

Theme.BorderRadius = {
    None = UDim.new(0, 0),
    XS = UDim.new(0, 4),
    SM = UDim.new(0, 6),
    MD = UDim.new(0, 8),
    LG = UDim.new(0, 12),
    XL = UDim.new(0, 16),
    XXL = UDim.new(0, 20),
    Full = UDim.new(0, 9999),
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
