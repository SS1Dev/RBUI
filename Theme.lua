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
    -- DARK THEME (Default) - Deeper Black
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
            Secondary = Color3.fromRGB(55, 52, 53),
            SecondaryHover = Color3.fromRGB(85, 82, 83),
            
            -- Accent (Neon Cyan)
            Accent = Color3.fromRGB(0, 255, 255),
            AccentHover = Color3.fromRGB(80, 255, 255),
            
            -- Background (Deeper)
            Background = Color3.fromRGB(18, 16, 17),
            BackgroundSecondary = Color3.fromRGB(26, 24, 25),
            BackgroundTertiary = Color3.fromRGB(35, 33, 34),
            
            -- Surface
            Surface = Color3.fromRGB(30, 28, 29),
            SurfaceHover = Color3.fromRGB(42, 40, 41),
            SurfaceBorder = Color3.fromRGB(55, 53, 54),
            
            -- Text
            TextPrimary = Color3.fromRGB(255, 255, 255),
            TextSecondary = Color3.fromRGB(200, 197, 198),
            TextMuted = Color3.fromRGB(130, 127, 128),
            TextDisabled = Color3.fromRGB(85, 82, 83),
            
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
            InputBackground = Color3.fromRGB(26, 24, 25),
            InputBorder = Color3.fromRGB(55, 53, 54),
            InputFocus = Color3.fromRGB(138, 43, 226),
            
            ToggleOff = Color3.fromRGB(55, 53, 54),
            ToggleOn = Color3.fromRGB(138, 43, 226),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(35, 33, 34),
            SliderFill = Color3.fromRGB(138, 43, 226),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(26, 24, 25),
            DropdownItemHover = Color3.fromRGB(42, 40, 41),
            
            TabActive = Color3.fromRGB(138, 43, 226),
            TabInactive = Color3.fromRGB(35, 33, 34),
            
            Shadow = Color3.fromRGB(5, 4, 5),
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
    -- PINK THEME (Neon Pink Gamified) - Deeper
    -- ═══════════════════════════════════════
    Pink = {
        Name = "Pink",
        Colors = {
            Primary = Color3.fromRGB(255, 0, 128),
            PrimaryHover = Color3.fromRGB(255, 80, 160),
            PrimaryActive = Color3.fromRGB(220, 0, 110),
            PrimaryGlow = Color3.fromRGB(255, 0, 128),
            
            Secondary = Color3.fromRGB(120, 60, 90),
            SecondaryHover = Color3.fromRGB(150, 85, 115),
            
            Accent = Color3.fromRGB(255, 150, 200),
            AccentHover = Color3.fromRGB(255, 180, 220),
            
            Background = Color3.fromRGB(12, 6, 12),
            BackgroundSecondary = Color3.fromRGB(20, 12, 20),
            BackgroundTertiary = Color3.fromRGB(32, 18, 30),
            
            Surface = Color3.fromRGB(25, 14, 24),
            SurfaceHover = Color3.fromRGB(38, 22, 36),
            SurfaceBorder = Color3.fromRGB(70, 35, 60),
            
            TextPrimary = Color3.fromRGB(255, 240, 250),
            TextSecondary = Color3.fromRGB(220, 180, 210),
            TextMuted = Color3.fromRGB(140, 100, 130),
            TextDisabled = Color3.fromRGB(80, 55, 70),
            
            Success = Color3.fromRGB(0, 255, 180),
            SuccessHover = Color3.fromRGB(50, 255, 200),
            Warning = Color3.fromRGB(255, 200, 100),
            WarningHover = Color3.fromRGB(255, 220, 140),
            Error = Color3.fromRGB(255, 80, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(200, 150, 255),
            InfoHover = Color3.fromRGB(220, 180, 255),
            
            InputBackground = Color3.fromRGB(20, 12, 20),
            InputBorder = Color3.fromRGB(70, 35, 60),
            InputFocus = Color3.fromRGB(255, 0, 128),
            
            ToggleOff = Color3.fromRGB(55, 32, 48),
            ToggleOn = Color3.fromRGB(255, 0, 128),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(38, 22, 36),
            SliderFill = Color3.fromRGB(255, 0, 128),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(20, 12, 20),
            DropdownItemHover = Color3.fromRGB(38, 22, 36),
            
            TabActive = Color3.fromRGB(255, 0, 128),
            TabInactive = Color3.fromRGB(38, 22, 36),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(255, 0, 128),
        }
    },
    
    -- ═══════════════════════════════════════
    -- BLUE THEME (Electric Blue Gamified) - Deeper
    -- ═══════════════════════════════════════
    Blue = {
        Name = "Blue",
        Colors = {
            Primary = Color3.fromRGB(0, 150, 255),
            PrimaryHover = Color3.fromRGB(50, 180, 255),
            PrimaryActive = Color3.fromRGB(0, 120, 220),
            PrimaryGlow = Color3.fromRGB(0, 150, 255),
            
            Secondary = Color3.fromRGB(45, 70, 100),
            SecondaryHover = Color3.fromRGB(65, 90, 120),
            
            Accent = Color3.fromRGB(0, 255, 255),
            AccentHover = Color3.fromRGB(80, 255, 255),
            
            Background = Color3.fromRGB(6, 12, 22),
            BackgroundSecondary = Color3.fromRGB(10, 18, 32),
            BackgroundTertiary = Color3.fromRGB(16, 28, 45),
            
            Surface = Color3.fromRGB(12, 22, 38),
            SurfaceHover = Color3.fromRGB(20, 35, 55),
            SurfaceBorder = Color3.fromRGB(35, 58, 90),
            
            TextPrimary = Color3.fromRGB(230, 245, 255),
            TextSecondary = Color3.fromRGB(160, 200, 230),
            TextMuted = Color3.fromRGB(90, 125, 160),
            TextDisabled = Color3.fromRGB(50, 70, 95),
            
            Success = Color3.fromRGB(0, 255, 150),
            SuccessHover = Color3.fromRGB(50, 255, 180),
            Warning = Color3.fromRGB(255, 200, 0),
            WarningHover = Color3.fromRGB(255, 220, 50),
            Error = Color3.fromRGB(255, 80, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(100, 200, 255),
            InfoHover = Color3.fromRGB(140, 220, 255),
            
            InputBackground = Color3.fromRGB(10, 18, 32),
            InputBorder = Color3.fromRGB(35, 58, 90),
            InputFocus = Color3.fromRGB(0, 150, 255),
            
            ToggleOff = Color3.fromRGB(28, 45, 70),
            ToggleOn = Color3.fromRGB(0, 150, 255),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(20, 35, 55),
            SliderFill = Color3.fromRGB(0, 150, 255),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(10, 18, 32),
            DropdownItemHover = Color3.fromRGB(20, 35, 55),
            
            TabActive = Color3.fromRGB(0, 150, 255),
            TabInactive = Color3.fromRGB(20, 35, 55),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(0, 150, 255),
        }
    },
    
    -- ═══════════════════════════════════════
    -- GOLDEN THEME (Royal Gold Gamified) - Deeper
    -- ═══════════════════════════════════════
    Golden = {
        Name = "Golden",
        Colors = {
            Primary = Color3.fromRGB(255, 200, 0),
            PrimaryHover = Color3.fromRGB(255, 215, 50),
            PrimaryActive = Color3.fromRGB(220, 170, 0),
            PrimaryGlow = Color3.fromRGB(255, 200, 0),
            
            Secondary = Color3.fromRGB(95, 75, 40),
            SecondaryHover = Color3.fromRGB(120, 95, 55),
            
            Accent = Color3.fromRGB(255, 180, 100),
            AccentHover = Color3.fromRGB(255, 200, 130),
            
            Background = Color3.fromRGB(12, 10, 5),
            BackgroundSecondary = Color3.fromRGB(20, 16, 10),
            BackgroundTertiary = Color3.fromRGB(32, 26, 16),
            
            Surface = Color3.fromRGB(25, 20, 12),
            SurfaceHover = Color3.fromRGB(38, 32, 20),
            SurfaceBorder = Color3.fromRGB(70, 58, 35),
            
            TextPrimary = Color3.fromRGB(255, 250, 230),
            TextSecondary = Color3.fromRGB(220, 200, 160),
            TextMuted = Color3.fromRGB(140, 120, 85),
            TextDisabled = Color3.fromRGB(80, 68, 45),
            
            Success = Color3.fromRGB(150, 255, 100),
            SuccessHover = Color3.fromRGB(180, 255, 130),
            Warning = Color3.fromRGB(255, 180, 50),
            WarningHover = Color3.fromRGB(255, 200, 90),
            Error = Color3.fromRGB(255, 100, 80),
            ErrorHover = Color3.fromRGB(255, 130, 110),
            Info = Color3.fromRGB(255, 220, 100),
            InfoHover = Color3.fromRGB(255, 235, 140),
            
            InputBackground = Color3.fromRGB(20, 16, 10),
            InputBorder = Color3.fromRGB(70, 58, 35),
            InputFocus = Color3.fromRGB(255, 200, 0),
            
            ToggleOff = Color3.fromRGB(48, 40, 25),
            ToggleOn = Color3.fromRGB(255, 200, 0),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(38, 32, 20),
            SliderFill = Color3.fromRGB(255, 200, 0),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(20, 16, 10),
            DropdownItemHover = Color3.fromRGB(38, 32, 20),
            
            TabActive = Color3.fromRGB(255, 200, 0),
            TabInactive = Color3.fromRGB(38, 32, 20),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(255, 200, 0),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK BLUE THEME - Deeper
    -- ═══════════════════════════════════════
    DarkBlue = {
        Name = "DarkBlue",
        Colors = {
            Primary = Color3.fromRGB(66, 135, 245),
            PrimaryHover = Color3.fromRGB(100, 160, 250),
            PrimaryActive = Color3.fromRGB(45, 110, 220),
            PrimaryGlow = Color3.fromRGB(66, 135, 245),
            
            Secondary = Color3.fromRGB(38, 55, 80),
            SecondaryHover = Color3.fromRGB(55, 72, 98),
            
            Accent = Color3.fromRGB(100, 180, 255),
            AccentHover = Color3.fromRGB(130, 200, 255),
            
            Background = Color3.fromRGB(4, 8, 16),
            BackgroundSecondary = Color3.fromRGB(8, 14, 26),
            BackgroundTertiary = Color3.fromRGB(12, 22, 38),
            
            Surface = Color3.fromRGB(10, 18, 32),
            SurfaceHover = Color3.fromRGB(16, 28, 48),
            SurfaceBorder = Color3.fromRGB(30, 48, 78),
            
            TextPrimary = Color3.fromRGB(220, 235, 255),
            TextSecondary = Color3.fromRGB(150, 180, 220),
            TextMuted = Color3.fromRGB(75, 100, 140),
            TextDisabled = Color3.fromRGB(40, 58, 85),
            
            Success = Color3.fromRGB(50, 255, 150),
            SuccessHover = Color3.fromRGB(90, 255, 180),
            Warning = Color3.fromRGB(255, 190, 50),
            WarningHover = Color3.fromRGB(255, 210, 90),
            Error = Color3.fromRGB(255, 85, 100),
            ErrorHover = Color3.fromRGB(255, 120, 130),
            Info = Color3.fromRGB(80, 170, 255),
            InfoHover = Color3.fromRGB(120, 195, 255),
            
            InputBackground = Color3.fromRGB(8, 14, 26),
            InputBorder = Color3.fromRGB(30, 48, 78),
            InputFocus = Color3.fromRGB(66, 135, 245),
            
            ToggleOff = Color3.fromRGB(22, 38, 62),
            ToggleOn = Color3.fromRGB(66, 135, 245),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(16, 28, 48),
            SliderFill = Color3.fromRGB(66, 135, 245),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(8, 14, 26),
            DropdownItemHover = Color3.fromRGB(16, 28, 48),
            
            TabActive = Color3.fromRGB(66, 135, 245),
            TabInactive = Color3.fromRGB(16, 28, 48),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(66, 135, 245),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK PINK THEME - Deeper
    -- ═══════════════════════════════════════
    DarkPink = {
        Name = "DarkPink",
        Colors = {
            Primary = Color3.fromRGB(219, 39, 119),
            PrimaryHover = Color3.fromRGB(236, 72, 153),
            PrimaryActive = Color3.fromRGB(190, 24, 93),
            PrimaryGlow = Color3.fromRGB(219, 39, 119),
            
            Secondary = Color3.fromRGB(75, 38, 58),
            SecondaryHover = Color3.fromRGB(95, 55, 75),
            
            Accent = Color3.fromRGB(244, 114, 182),
            AccentHover = Color3.fromRGB(249, 168, 212),
            
            Background = Color3.fromRGB(10, 5, 9),
            BackgroundSecondary = Color3.fromRGB(18, 9, 16),
            BackgroundTertiary = Color3.fromRGB(28, 14, 24),
            
            Surface = Color3.fromRGB(22, 11, 19),
            SurfaceHover = Color3.fromRGB(35, 18, 30),
            SurfaceBorder = Color3.fromRGB(60, 32, 50),
            
            TextPrimary = Color3.fromRGB(253, 242, 248),
            TextSecondary = Color3.fromRGB(220, 180, 200),
            TextMuted = Color3.fromRGB(125, 90, 110),
            TextDisabled = Color3.fromRGB(70, 48, 60),
            
            Success = Color3.fromRGB(74, 222, 128),
            SuccessHover = Color3.fromRGB(110, 235, 158),
            Warning = Color3.fromRGB(251, 191, 36),
            WarningHover = Color3.fromRGB(252, 211, 77),
            Error = Color3.fromRGB(248, 113, 113),
            ErrorHover = Color3.fromRGB(252, 165, 165),
            Info = Color3.fromRGB(244, 114, 182),
            InfoHover = Color3.fromRGB(249, 168, 212),
            
            InputBackground = Color3.fromRGB(18, 9, 16),
            InputBorder = Color3.fromRGB(60, 32, 50),
            InputFocus = Color3.fromRGB(219, 39, 119),
            
            ToggleOff = Color3.fromRGB(42, 22, 35),
            ToggleOn = Color3.fromRGB(219, 39, 119),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(35, 18, 30),
            SliderFill = Color3.fromRGB(219, 39, 119),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(18, 9, 16),
            DropdownItemHover = Color3.fromRGB(35, 18, 30),
            
            TabActive = Color3.fromRGB(219, 39, 119),
            TabInactive = Color3.fromRGB(35, 18, 30),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(219, 39, 119),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK GOLDEN THEME - Deeper
    -- ═══════════════════════════════════════
    DarkGolden = {
        Name = "DarkGolden",
        Colors = {
            Primary = Color3.fromRGB(217, 169, 52),
            PrimaryHover = Color3.fromRGB(234, 190, 85),
            PrimaryActive = Color3.fromRGB(185, 140, 30),
            PrimaryGlow = Color3.fromRGB(217, 169, 52),
            
            Secondary = Color3.fromRGB(70, 58, 32),
            SecondaryHover = Color3.fromRGB(90, 75, 45),
            
            Accent = Color3.fromRGB(251, 191, 36),
            AccentHover = Color3.fromRGB(252, 211, 77),
            
            Background = Color3.fromRGB(9, 7, 4),
            BackgroundSecondary = Color3.fromRGB(16, 13, 7),
            BackgroundTertiary = Color3.fromRGB(26, 22, 12),
            
            Surface = Color3.fromRGB(20, 16, 9),
            SurfaceHover = Color3.fromRGB(32, 26, 15),
            SurfaceBorder = Color3.fromRGB(55, 46, 26),
            
            TextPrimary = Color3.fromRGB(255, 251, 235),
            TextSecondary = Color3.fromRGB(220, 200, 150),
            TextMuted = Color3.fromRGB(125, 108, 75),
            TextDisabled = Color3.fromRGB(70, 60, 40),
            
            Success = Color3.fromRGB(134, 239, 172),
            SuccessHover = Color3.fromRGB(170, 250, 200),
            Warning = Color3.fromRGB(251, 191, 36),
            WarningHover = Color3.fromRGB(252, 211, 77),
            Error = Color3.fromRGB(248, 113, 113),
            ErrorHover = Color3.fromRGB(252, 165, 165),
            Info = Color3.fromRGB(251, 191, 36),
            InfoHover = Color3.fromRGB(252, 211, 77),
            
            InputBackground = Color3.fromRGB(16, 13, 7),
            InputBorder = Color3.fromRGB(55, 46, 26),
            InputFocus = Color3.fromRGB(217, 169, 52),
            
            ToggleOff = Color3.fromRGB(38, 32, 18),
            ToggleOn = Color3.fromRGB(217, 169, 52),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(32, 26, 15),
            SliderFill = Color3.fromRGB(217, 169, 52),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(16, 13, 7),
            DropdownItemHover = Color3.fromRGB(32, 26, 15),
            
            TabActive = Color3.fromRGB(217, 169, 52),
            TabInactive = Color3.fromRGB(32, 26, 15),
            
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
    
    -- ═══════════════════════════════════════
    -- ROSE THEME (Dark Rose - Elegant) - Deeper
    -- ═══════════════════════════════════════
    Rose = {
        Name = "Rose",
        Colors = {
            Primary = Color3.fromRGB(225, 59, 148),
            PrimaryHover = Color3.fromRGB(240, 100, 170),
            PrimaryActive = Color3.fromRGB(190, 40, 120),
            PrimaryGlow = Color3.fromRGB(225, 59, 148),
            
            Secondary = Color3.fromRGB(90, 55, 72),
            SecondaryHover = Color3.fromRGB(115, 75, 95),
            
            Accent = Color3.fromRGB(255, 130, 180),
            AccentHover = Color3.fromRGB(255, 160, 200),
            
            Background = Color3.fromRGB(14, 9, 12),
            BackgroundSecondary = Color3.fromRGB(22, 15, 19),
            BackgroundTertiary = Color3.fromRGB(32, 22, 28),
            
            Surface = Color3.fromRGB(26, 18, 22),
            SurfaceHover = Color3.fromRGB(38, 26, 32),
            SurfaceBorder = Color3.fromRGB(65, 42, 55),
            
            TextPrimary = Color3.fromRGB(255, 245, 250),
            TextSecondary = Color3.fromRGB(220, 190, 205),
            TextMuted = Color3.fromRGB(135, 108, 122),
            TextDisabled = Color3.fromRGB(78, 58, 68),
            
            Success = Color3.fromRGB(80, 230, 150),
            SuccessHover = Color3.fromRGB(110, 245, 175),
            Warning = Color3.fromRGB(255, 195, 80),
            WarningHover = Color3.fromRGB(255, 215, 120),
            Error = Color3.fromRGB(255, 90, 110),
            ErrorHover = Color3.fromRGB(255, 130, 145),
            Info = Color3.fromRGB(200, 140, 220),
            InfoHover = Color3.fromRGB(220, 170, 240),
            
            InputBackground = Color3.fromRGB(22, 15, 19),
            InputBorder = Color3.fromRGB(65, 42, 55),
            InputFocus = Color3.fromRGB(225, 59, 148),
            
            ToggleOff = Color3.fromRGB(48, 32, 40),
            ToggleOn = Color3.fromRGB(225, 59, 148),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(38, 26, 32),
            SliderFill = Color3.fromRGB(225, 59, 148),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(22, 15, 19),
            DropdownItemHover = Color3.fromRGB(38, 26, 32),
            
            TabActive = Color3.fromRGB(225, 59, 148),
            TabInactive = Color3.fromRGB(38, 26, 32),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(225, 59, 148),
        }
    },
    
    -- ═══════════════════════════════════════
    -- DARK ROSE THEME - Deeper
    -- ═══════════════════════════════════════
    DarkRose = {
        Name = "DarkRose",
        Colors = {
            Primary = Color3.fromRGB(190, 50, 120),
            PrimaryHover = Color3.fromRGB(210, 80, 145),
            PrimaryActive = Color3.fromRGB(160, 35, 95),
            PrimaryGlow = Color3.fromRGB(190, 50, 120),
            
            Secondary = Color3.fromRGB(75, 45, 60),
            SecondaryHover = Color3.fromRGB(98, 62, 80),
            
            Accent = Color3.fromRGB(230, 110, 160),
            AccentHover = Color3.fromRGB(240, 145, 185),
            
            Background = Color3.fromRGB(11, 7, 9),
            BackgroundSecondary = Color3.fromRGB(18, 11, 15),
            BackgroundTertiary = Color3.fromRGB(28, 18, 23),
            
            Surface = Color3.fromRGB(22, 14, 18),
            SurfaceHover = Color3.fromRGB(34, 22, 28),
            SurfaceBorder = Color3.fromRGB(55, 36, 46),
            
            TextPrimary = Color3.fromRGB(252, 240, 246),
            TextSecondary = Color3.fromRGB(210, 180, 195),
            TextMuted = Color3.fromRGB(125, 98, 112),
            TextDisabled = Color3.fromRGB(72, 55, 64),
            
            Success = Color3.fromRGB(74, 222, 128),
            SuccessHover = Color3.fromRGB(110, 235, 158),
            Warning = Color3.fromRGB(251, 191, 36),
            WarningHover = Color3.fromRGB(252, 211, 77),
            Error = Color3.fromRGB(248, 113, 113),
            ErrorHover = Color3.fromRGB(252, 165, 165),
            Info = Color3.fromRGB(190, 130, 170),
            InfoHover = Color3.fromRGB(210, 160, 190),
            
            InputBackground = Color3.fromRGB(18, 11, 15),
            InputBorder = Color3.fromRGB(55, 36, 46),
            InputFocus = Color3.fromRGB(190, 50, 120),
            
            ToggleOff = Color3.fromRGB(40, 26, 33),
            ToggleOn = Color3.fromRGB(190, 50, 120),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(34, 22, 28),
            SliderFill = Color3.fromRGB(190, 50, 120),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(18, 11, 15),
            DropdownItemHover = Color3.fromRGB(34, 22, 28),
            
            TabActive = Color3.fromRGB(190, 50, 120),
            TabInactive = Color3.fromRGB(34, 22, 28),
            
            Shadow = Color3.fromRGB(0, 0, 0),
            Glow = Color3.fromRGB(190, 50, 120),
        }
    },
    
    -- ═══════════════════════════════════════
    -- LIGHT ROSE THEME
    -- ═══════════════════════════════════════
    LightRose = {
        Name = "LightRose",
        Colors = {
            Primary = Color3.fromRGB(225, 59, 148),
            PrimaryHover = Color3.fromRGB(240, 100, 170),
            PrimaryActive = Color3.fromRGB(190, 40, 120),
            PrimaryGlow = Color3.fromRGB(225, 59, 148),
            
            Secondary = Color3.fromRGB(195, 165, 180),
            SecondaryHover = Color3.fromRGB(175, 140, 160),
            
            Accent = Color3.fromRGB(240, 100, 170),
            AccentHover = Color3.fromRGB(250, 150, 200),
            
            Background = Color3.fromRGB(255, 248, 252),
            BackgroundSecondary = Color3.fromRGB(255, 238, 246),
            BackgroundTertiary = Color3.fromRGB(255, 220, 238),
            
            Surface = Color3.fromRGB(255, 255, 255),
            SurfaceHover = Color3.fromRGB(255, 238, 246),
            SurfaceBorder = Color3.fromRGB(245, 200, 225),
            
            TextPrimary = Color3.fromRGB(75, 25, 50),
            TextSecondary = Color3.fromRGB(115, 65, 90),
            TextMuted = Color3.fromRGB(175, 125, 150),
            TextDisabled = Color3.fromRGB(215, 175, 195),
            
            Success = Color3.fromRGB(34, 197, 94),
            SuccessHover = Color3.fromRGB(74, 222, 128),
            Warning = Color3.fromRGB(234, 179, 8),
            WarningHover = Color3.fromRGB(250, 204, 21),
            Error = Color3.fromRGB(239, 68, 68),
            ErrorHover = Color3.fromRGB(248, 113, 113),
            Info = Color3.fromRGB(225, 59, 148),
            InfoHover = Color3.fromRGB(240, 100, 170),
            
            InputBackground = Color3.fromRGB(255, 255, 255),
            InputBorder = Color3.fromRGB(245, 200, 225),
            InputFocus = Color3.fromRGB(225, 59, 148),
            
            ToggleOff = Color3.fromRGB(225, 195, 210),
            ToggleOn = Color3.fromRGB(225, 59, 148),
            ToggleKnob = Color3.fromRGB(255, 255, 255),
            
            SliderTrack = Color3.fromRGB(255, 220, 238),
            SliderFill = Color3.fromRGB(225, 59, 148),
            SliderKnob = Color3.fromRGB(255, 255, 255),
            
            DropdownBackground = Color3.fromRGB(255, 255, 255),
            DropdownItemHover = Color3.fromRGB(255, 238, 246),
            
            TabActive = Color3.fromRGB(225, 59, 148),
            TabInactive = Color3.fromRGB(255, 220, 238),
            
            Shadow = Color3.fromRGB(100, 50, 75),
            Glow = Color3.fromRGB(225, 59, 148),
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
