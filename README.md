# UIFramework for Roblox

A modern, customizable UI Framework for Roblox with Panel design, featuring rich components with callback events and Font Awesome icon support.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Platform](https://img.shields.io/badge/platform-Roblox-red)

## ✨ Features

- 🎨 **Panel Design** - Clean, modern dark theme optimized for gaming
- 📦 **Rich Component Library** - Label, Input, Button, Toggle, Slider, Checkbox, Dropdown, Tab
- 🔔 **Callback Events** - Every component supports callbacks for user interaction
- 🎯 **Font Awesome Icons** - 100+ built-in icons from Font Awesome Free
- ✨ **Smooth Animations** - Polished transitions and hover effects
- 📱 **Responsive Design** - Works on all screen sizes
- 🔧 **Easy to Customize** - Theming support via Theme.lua

## 📁 Project Structure

```
UIFramework/
├── init.lua              # Main module entry point
├── Theme.lua             # Colors, typography, spacing
├── Utilities.lua         # Helper functions
├── Icons.lua             # Font Awesome icon mappings
├── Example.lua           # Demo script
├── Components/
│   ├── Container.lua     # Admin panel container
│   ├── Label.lua         # Text display
│   ├── Input.lua         # Text input
│   ├── Button.lua        # Clickable button
│   ├── Toggle.lua        # On/Off switch
│   ├── Slider.lua        # Range slider
│   ├── Checkbox.lua      # Checkbox
│   ├── Dropdown.lua      # Single/Multiple dropdown
│   └── Tab.lua           # Tab navigation
└── README.md
```

## 🚀 Installation

1. Download or copy the `UIFramework` folder
2. Place it in `ReplicatedStorage` in your Roblox game
3. Require the module in your LocalScript:

```lua
local UIFramework = require(game.ReplicatedStorage.UIFramework)
```

## 📖 Quick Start

### Creating a Panel

```lua
local UIFramework = require(game.ReplicatedStorage.UIFramework)

-- Create the main panel
local panel = UIFramework.CreateAdminPanel({
    Title = "My Panel",
    Size = UDim2.new(0, 800, 0, 600),
    Draggable = true,
    Closable = true,
    OnClose = function()
        print("Panel closed!")
    end
})

-- Add tabs to the sidebar
local settingsTab = panel:AddTab({
    Name = "Settings",
    Icon = "gear"
})

local playersTab = panel:AddTab({
    Name = "Players",
    Icon = "users"
})
```

## 🧩 Components

### Label

```lua
UIFramework.Label.new({
    Text = "Hello World",
    Icon = "star",
    TextColor = Color3.fromRGB(255, 255, 255),
    Parent = container,
    OnClick = function(text)
        print("Clicked:", text)
    end
})
```

### Input

```lua
UIFramework.Input.new({
    Placeholder = "Enter username...",
    Icon = "user",
    MaxLength = 20,
    Parent = container,
    OnChange = function(text)
        print("Text changed:", text)
    end,
    OnSubmit = function(text)
        print("Submitted:", text)
    end
})
```

### Button

```lua
UIFramework.Button.new({
    Text = "Click Me",
    Icon = "check",
    Variant = "primary", -- primary, secondary, success, warning, error, ghost
    Parent = container,
    OnClick = function()
        print("Button clicked!")
    end
})
```

### Toggle

```lua
UIFramework.Toggle.new({
    Text = "Enable Feature",
    Icon = "bell",
    Value = true,
    Parent = container,
    OnChange = function(value)
        print("Toggle:", value)
    end
})
```

### Slider

```lua
UIFramework.Slider.new({
    Text = "Volume",
    Icon = "volume-high",
    Value = 50,
    Min = 0,
    Max = 100,
    Step = 5,
    Parent = container,
    OnChange = function(value)
        print("Volume:", value)
    end
})
```

### Checkbox

```lua
UIFramework.Checkbox.new({
    Text = "Accept Terms",
    Icon = "file-lines",
    Value = false,
    Parent = container,
    OnChange = function(value)
        print("Accepted:", value)
    end
})
```

### Dropdown (Single Selection)

```lua
UIFramework.Dropdown.new({
    Text = "Select Team",
    Icon = "users",
    Options = {
        { Text = "Red Team", Value = "red", Icon = "flag" },
        { Text = "Blue Team", Value = "blue", Icon = "flag" },
        { Text = "Green Team", Value = "green", Icon = "flag" }
    },
    Parent = container,
    OnChange = function(value)
        print("Selected:", value)
    end
})
```

### Dropdown (Multiple Selection)

```lua
UIFramework.Dropdown.new({
    Text = "Select Abilities",
    Icon = "star",
    Multiple = true,
    Searchable = true,
    Options = {
        { Text = "Super Speed", Value = "speed" },
        { Text = "Super Jump", Value = "jump" },
        { Text = "Invisibility", Value = "invis" }
    },
    Parent = container,
    OnChange = function(values)
        print("Selected:", table.concat(values, ", "))
    end
})
```

### Tab

```lua
local tabs = UIFramework.Tab.new({
    Tabs = {
        { Id = "general", Text = "General", Icon = "gear" },
        { Id = "audio", Text = "Audio", Icon = "volume-high" },
        { Id = "video", Text = "Video", Icon = "video" }
    },
    Orientation = "horizontal", -- or "vertical"
    Parent = container,
    OnChange = function(tabId)
        print("Tab:", tabId)
    end
})

-- Add content to tabs
local generalTab = tabs:GetTabContent("general")
```

## 🔔 Notifications

```lua
UIFramework.Notify({
    Type = "success", -- success, warning, error, info
    Title = "Success!",
    Message = "Operation completed.",
    Duration = 5
})
```

## 🎨 Available Icons

The framework includes 100+ Font Awesome icons. Common icons:

| Category | Icons |
|----------|-------|
| Navigation | `home`, `arrow-left`, `arrow-right`, `chevron-down`, `bars`, `xmark` |
| Actions | `plus`, `minus`, `edit`, `trash`, `save`, `download`, `upload`, `refresh` |
| User | `user`, `users`, `user-plus`, `user-gear` |
| Media | `play`, `pause`, `stop`, `forward`, `backward`, `volume-high` |
| Status | `check`, `circle-check`, `circle-xmark`, `circle-info`, `triangle-exclamation` |
| Objects | `star`, `heart`, `bookmark`, `flag`, `calendar`, `clock` |
| Settings | `gear`, `sliders`, `wrench`, `key`, `lock` |
| Game | `gamepad`, `trophy`, `crown`, `dice` |

See `Icons.lua` for the complete list.

## 🎨 Theming

Customize colors in `Theme.lua`:

```lua
Theme.Colors = {
    Primary = Color3.fromRGB(99, 102, 241),
    Background = Color3.fromRGB(15, 23, 42),
    TextPrimary = Color3.fromRGB(248, 250, 252),
    -- ... more colors
}
```

## 🛠️ Utilities

Helper functions available in `UIFramework.Utilities`:

```lua
-- Create instance with properties
local frame = UIFramework.Utilities.Create("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Color3.new(1, 1, 1)
})

-- Apply corner radius
UIFramework.Utilities.ApplyCorner(frame, UDim.new(0, 8))

-- Apply padding
UIFramework.Utilities.ApplyPadding(frame, 16)

-- Apply list layout
UIFramework.Utilities.ApplyListLayout(frame, {
    Direction = Enum.FillDirection.Vertical,
    Padding = 8
})

-- Animate with tween
UIFramework.Utilities.Tween(frame, { BackgroundTransparency = 0.5 }, 0.3)
```

## 📄 License

This UIFramework is free to use in your Roblox projects.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

