/**
 * UIFramework Build Script
 * 
 * Combines all Lua modules into a single standalone file
 * for use with Roblox executors.
 * 
 * Usage:
 *   pnpm build          - Build standalone file
 *   pnpm build --watch  - Watch for changes and rebuild
 *   pnpm clean          - Clean dist folder
 *   pnpm rebuild        - Clean and rebuild
 */

const fs = require('fs');
const path = require('path');

// Configuration
const CONFIG = {
    outputDir: 'dist',
    outputFile: 'UIFramework.lua',
    minifiedFile: 'UIFramework.min.lua',
    
    // Module order (dependencies first)
    modules: [
        { name: 'Theme', path: 'Theme.lua' },
        { name: 'Icons', path: 'Icons.lua' },
        { name: 'Utilities', path: 'Utilities.lua' },
        { name: 'Label', path: 'Components/Label.lua' },
        { name: 'Input', path: 'Components/Input.lua' },
        { name: 'Button', path: 'Components/Button.lua' },
        { name: 'Toggle', path: 'Components/Toggle.lua' },
        { name: 'Slider', path: 'Components/Slider.lua' },
        { name: 'Checkbox', path: 'Components/Checkbox.lua' },
        { name: 'Dropdown', path: 'Components/Dropdown.lua' },
        { name: 'Tab', path: 'Components/Tab.lua' },
        { name: 'Container', path: 'Components/Container.lua' }
    ]
};

// ANSI colors for console output
const colors = {
    reset: '\x1b[0m',
    bright: '\x1b[1m',
    dim: '\x1b[2m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    cyan: '\x1b[36m',
    red: '\x1b[31m'
};

function log(message, color = 'reset') {
    console.log(`${colors[color]}${message}${colors.reset}`);
}

function logStep(step, message) {
    console.log(`${colors.dim}  [${step}]${colors.reset} ${message}`);
}

/**
 * Read a Lua module file and clean it for bundling
 */
function readAndCleanModule(modulePath, moduleName) {
    const fullPath = path.join(__dirname, modulePath);
    
    if (!fs.existsSync(fullPath)) {
        throw new Error(`Module not found: ${fullPath}`);
    }
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Remove require statements (they'll be resolved by bundling)
    content = content.replace(/local\s+Theme\s*=\s*require\([^)]+\)\s*/g, '');
    content = content.replace(/local\s+Utilities\s*=\s*require\([^)]+\)\s*/g, '');
    content = content.replace(/local\s+Icons\s*=\s*require\([^)]+\)\s*/g, '');
    
    // Remove the final return statement at the end of file (last line only)
    content = content.replace(/\nreturn\s+\w+\s*$/, '');
    
    // Remove GetFramework function if present
    content = content.replace(/local\s+function\s+GetFramework\(\)\s*\n\s*return\s+script\.Parent\.Parent\s*\n\s*end\s*/g, '');
    
    return content.trim();
}

/**
 * Generate the standalone Lua file
 */
function generateStandalone() {
    const header = `--[[
    ╔═══════════════════════════════════════════════════════════════╗
    ║                     UIFramework for Roblox                     ║
    ║                      Standalone Build v1.0.0                   ║
    ║                                                                 ║
    ║  A modern, customizable UI Framework with Panel design         ║
    ║  Built for use with Roblox Executors                          ║
    ╚═══════════════════════════════════════════════════════════════╝
    
    Usage:
    
    local UIFramework = loadstring(game:HttpGet("YOUR_RAW_URL"))()
    
    -- Create Panel
    local panel = UIFramework.CreatePanel({
        Title = "My Panel"
    })
    
    -- Add tabs
    local settingsTab = panel:AddTab({
        Name = "Settings",
        Icon = "gear"
    })
    
    -- Add components
    UIFramework.Toggle.new({
        Text = "Enable Feature",
        Icon = "star",
        Value = true,
        Parent = settingsTab,
        OnChange = function(value)
            print("Toggle:", value)
        end
    })
    
    Components:
    - Container (Panel with sidebar)
    - Label, Input, Button, Toggle
    - Slider, Checkbox, Dropdown (Single/Multiple)
    - Tab Navigation
    
    Built: ${new Date().toISOString()}
]]

`;

    const services = `-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Main Framework Table
local UIFramework = {}
UIFramework.Version = "1.0.0"
UIFramework.BuildDate = "${new Date().toISOString()}"

`;

    let output = header + services;
    
    // Add each module
    for (const module of CONFIG.modules) {
        logStep(CONFIG.modules.indexOf(module) + 1, `Adding ${module.name}...`);
        
        const separator = `
-- ═══════════════════════════════════════════════════════════════
-- ${module.name.toUpperCase()} ${module.path.includes('Components') ? 'COMPONENT' : 'MODULE'}
-- ═══════════════════════════════════════════════════════════════

`;
        const content = readAndCleanModule(module.path, module.name);
        output += separator + content + '\n';
    }
    
    // Add framework exports and helper functions
    output += `

-- ═══════════════════════════════════════════════════════════════
-- FRAMEWORK EXPORTS & HELPERS
-- ═══════════════════════════════════════════════════════════════

-- Export all modules
UIFramework.Theme = Theme
UIFramework.Icons = Icons
UIFramework.Utilities = Utilities

-- Theme helper functions
function UIFramework.SetTheme(themeName)
    return Theme.SetTheme(themeName)
end

function UIFramework.GetCurrentTheme()
    return Theme.GetCurrentTheme()
end

function UIFramework.GetAvailableThemes()
    return Theme.GetAvailableThemes()
end
UIFramework.Label = Label
UIFramework.Input = Input
UIFramework.Button = Button
UIFramework.Toggle = Toggle
UIFramework.Slider = Slider
UIFramework.Checkbox = Checkbox
UIFramework.Dropdown = Dropdown
UIFramework.Tab = Tab
UIFramework.Container = Container

-- Quick create Panel
function UIFramework.CreatePanel(config)
    config = config or {}
    
    -- Set theme before creating panel if specified
    if config.Theme then
        Theme.SetTheme(config.Theme)
    end
    
    return Container.new({
        Title = config.Title or "Panel",
        Size = config.Size or UDim2.new(0, 700, 0, 500),
        Position = config.Position,
        Draggable = config.Draggable ~= false,
        Closable = config.Closable ~= false,
        Minimizable = config.Minimizable ~= false,
        Resizable = config.Resizable ~= false,
        ShowSidebar = config.ShowSidebar ~= false,
        SidebarWidth = config.SidebarWidth,
        MinWidth = config.MinWidth,
        MinHeight = config.MinHeight,
        Transparency = config.Transparency,
        HeaderTransparency = config.HeaderTransparency,
        SidebarTransparency = config.SidebarTransparency,
        ContentTransparency = config.ContentTransparency,
        BlurEnabled = config.BlurEnabled or false,
        BlurSize = config.BlurSize,
        Parent = config.Parent,
        OnClose = config.OnClose,
        OnMinimize = config.OnMinimize,
        OnResize = config.OnResize
    })
end

-- Alias for backward compatibility
UIFramework.CreateAdminPanel = UIFramework.CreatePanel

-- Create section header
function UIFramework.CreateSection(config)
    config = config or {}
    return Label.new({
        Text = config.Text or "Section",
        Icon = config.Icon,
        Size = UDim2.new(1, 0, 0, 32),
        TextSize = Theme.Typography.Subtitle,
        TextColor = config.Color or Theme.Colors.TextPrimary,
        Font = Theme.Typography.FontFamilyBold,
        Parent = config.Parent
    })
end

-- Create divider (responds to theme changes)
function UIFramework.CreateDivider(config)
    config = config or {}
    local divider = Utilities.Create("Frame", {
        Name = "Divider",
        Size = config.Size or UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = config.Color or Theme.Colors.SurfaceBorder,
        BorderSizePixel = 0,
        Parent = config.Parent
    })
    
    -- Register for theme updates (only if no custom color specified)
    if not config.Color then
        Theme.RegisterComponent(divider, {
            BackgroundColor3 = "SurfaceBorder"
        })
    end
    
    return divider
end

-- Create spacer
function UIFramework.CreateSpacer(config)
    config = config or {}
    return Utilities.Create("Frame", {
        Name = "Spacer",
        Size = config.Size or UDim2.new(1, 0, 0, config.Height or 16),
        BackgroundTransparency = 1,
        Parent = config.Parent
    })
end

-- Create card container (Bento Design style)
function UIFramework.CreateCard(config)
    config = config or {}
    
    -- Bento Design: Support for colSpan and rowSpan
    local colSpan = config.ColSpan or 1
    local rowSpan = config.RowSpan or 1
    
    -- Calculate size based on grid if in Bento Grid
    local size = config.Size
    if config._BentoGrid and not size then
        local cellWidth = config._BentoGrid.CellWidth
        local cellHeight = config._BentoGrid.CellHeight
        local gap = config._BentoGrid.Gap
        
        size = UDim2.new(
            0, (cellWidth * colSpan) + (gap * (colSpan - 1)),
            0, (cellHeight * rowSpan) + (gap * (rowSpan - 1))
        )
    end
    
    local card = Utilities.Create("Frame", {
        Name = config.Name or "Card",
        Size = size or UDim2.new(1, 0, 0, 100),
        BackgroundColor3 = config.Color or Theme.Colors.Surface,
        BorderSizePixel = 0,
        Parent = config.Parent
    })
    
    -- Bento Design: Enhanced rounded corners
    Utilities.ApplyCorner(card, config.CornerRadius or Theme.BorderRadius.MD)
    
    -- Bento Design: Subtle border
    Utilities.ApplyStroke(card, {
        Color = config.BorderColor or Theme.Colors.SurfaceBorder,
        Thickness = config.BorderThickness or 1,
        Transparency = config.BorderTransparency or 0.5
    })
    
    -- Bento Design: Padding
    if config.Padding ~= false then
        Utilities.ApplyPadding(card, config.Padding or Theme.Spacing.MD)
    end
    
    -- Auto layout for content
    if config.AutoLayout ~= false then
        Utilities.ApplyListLayout(card, {
            Direction = config.LayoutDirection or Enum.FillDirection.Vertical,
            Padding = config.LayoutPadding or Theme.Spacing.SM
        })
    end
    
    -- Store Bento metadata
    if config._BentoGrid then
        card:SetAttribute("BentoColSpan", colSpan)
        card:SetAttribute("BentoRowSpan", rowSpan)
        card:SetAttribute("BentoGridId", config._BentoGrid.Id)
    end
    
    return card
end

-- Create a Bento Grid Layout (Bento Design style)
function UIFramework.CreateBentoGrid(config)
    config = config or {}
    
    local columns = config.Columns or 4
    local gap = config.Gap or Theme.Spacing.MD
    local cellHeight = config.CellHeight or 120
    
    -- Create grid container
    local grid = Utilities.Create("Frame", {
        Name = config.Name or "BentoGrid",
        Size = config.Size or UDim2.new(1, 0, 0, 0),
        AutomaticSize = config.AutomaticSize ~= false and Enum.AutomaticSize.Y or nil,
        BackgroundTransparency = 1,
        Parent = config.Parent
    })
    
    -- Store grid configuration
    local gridId = tostring(tick())
    grid:SetAttribute("BentoColumns", columns)
    grid:SetAttribute("BentoGap", gap)
    grid:SetAttribute("BentoCellHeight", cellHeight)
    grid:SetAttribute("BentoGridId", gridId)
    
    -- Track grid items
    local gridItems = {}
    local gridLayout = {} -- 2D array to track occupied cells
    
    -- Function to calculate and position items
    local function updateLayout()
        if not grid.Parent then return end
        
        local parentWidth = grid.AbsoluteSize.X
        if parentWidth <= 0 then return end
        
        -- Calculate cell width dynamically
        local actualCellWidth = math.floor((parentWidth - (gap * (columns - 1))) / columns)
        
        -- Reset grid layout
        gridLayout = {}
        local currentRow = 0
        local rowHeights = {} -- Track height of each row
        
        -- Sort items by layout order
        table.sort(gridItems, function(a, b)
            return (a.LayoutOrder or 0) < (b.LayoutOrder or 0)
        end)
        
        -- Place items in grid
        for _, item in ipairs(gridItems) do
            if not item.Parent then continue end
            
            local colSpan = item:GetAttribute("BentoColSpan") or 1
            local rowSpan = item:GetAttribute("BentoRowSpan") or 1
            
            -- Find available position
            local placed = false
            local startRow = currentRow
            local startCol = 0
            
            while not placed do
                -- Check if position is available
                local canPlace = true
                
                -- Check bounds
                if startCol + colSpan > columns then
                    startCol = 0
                    startRow = startRow + 1
                    continue
                end
                
                -- Check if cells are occupied
                for r = startRow, startRow + rowSpan - 1 do
                    if not gridLayout[r] then
                        gridLayout[r] = {}
                    end
                    for c = startCol, startCol + colSpan - 1 do
                        if gridLayout[r][c] then
                            canPlace = false
                            break
                        end
                    end
                    if not canPlace then break end
                end
                
                if canPlace then
                    -- Mark cells as occupied
                    for r = startRow, startRow + rowSpan - 1 do
                        for c = startCol, startCol + colSpan - 1 do
                            gridLayout[r][c] = item
                        end
                    end
                    
                    -- Calculate position
                    local x = startCol * (actualCellWidth + gap)
                    local y = 0
                    for row = 0, startRow - 1 do
                        y = y + (rowHeights[row] or cellHeight) + gap
                    end
                    
                    -- Set item size and position
                    item.Size = UDim2.new(
                        0, (actualCellWidth * colSpan) + (gap * (colSpan - 1)),
                        0, (cellHeight * rowSpan) + (gap * (rowSpan - 1))
                    )
                    item.Position = UDim2.new(0, x, 0, y)
                    
                    -- Update row heights
                    local itemHeight = (cellHeight * rowSpan) + (gap * (rowSpan - 1))
                    for r = startRow, startRow + rowSpan - 1 do
                        rowHeights[r] = math.max(rowHeights[r] or 0, itemHeight)
                    end
                    
                    placed = true
                    currentRow = startRow
                else
                    -- Try next column
                    startCol = startCol + 1
                    if startCol >= columns then
                        startCol = 0
                        startRow = startRow + 1
                    end
                end
            end
        end
    end
    
    -- Update layout when size changes
    local sizeConnection
    sizeConnection = grid:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        updateLayout()
    end)
    
    -- Clean up connection when grid is destroyed
    grid.AncestryChanged:Connect(function()
        if not grid.Parent then
            if sizeConnection then
                sizeConnection:Disconnect()
            end
        end
    end)
    
    -- Method to add item to grid
    function grid:AddItem(item, colSpan, rowSpan, layoutOrder)
        colSpan = colSpan or 1
        rowSpan = rowSpan or 1
        
        item:SetAttribute("BentoColSpan", colSpan)
        item:SetAttribute("BentoRowSpan", rowSpan)
        item:SetAttribute("BentoGridId", gridId)
        if layoutOrder then
            item.LayoutOrder = layoutOrder
        end
        
        item.Parent = grid
        table.insert(gridItems, item)
        
        -- Update layout
        task.spawn(function()
            task.wait()
            updateLayout()
        end)
    end
    
    -- Helper method to create card in grid
    function grid:CreateCard(cardConfig)
        cardConfig = cardConfig or {}
        cardConfig.Parent = grid
        cardConfig._BentoGrid = {
            Id = gridId,
            Columns = columns,
            Gap = gap,
            CellHeight = cellHeight
        }
        
        local card = UIFramework.CreateCard(cardConfig)
        self:AddItem(card, cardConfig.ColSpan or 1, cardConfig.RowSpan or 1, cardConfig.LayoutOrder)
        return card
    end
    
    -- Initial layout update
    task.spawn(function()
        task.wait(0.1)
        updateLayout()
    end)
    
    return grid
end

-- Create button group (horizontal buttons)
function UIFramework.CreateButtonGroup(config)
    config = config or {}
    local group = Utilities.Create("Frame", {
        Name = "ButtonGroup",
        Size = config.Size or UDim2.new(1, 0, 0, Theme.Sizes.ButtonHeight),
        BackgroundTransparency = 1,
        Parent = config.Parent
    })
    Utilities.ApplyListLayout(group, {
        Direction = Enum.FillDirection.Horizontal,
        HorizontalAlignment = config.Alignment or Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = config.Spacing or Theme.Spacing.SM
    })
    return group
end

-- Notification system
function UIFramework.Notify(config)
    config = config or {}
    local player = Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return end
    
    local screenGui = playerGui:FindFirstChild("UIFramework_Notifications")
    
    if not screenGui then
        screenGui = Utilities.Create("ScreenGui", {
            Name = "UIFramework_Notifications",
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            Parent = playerGui
        })
        local container = Utilities.Create("Frame", {
            Name = "Container",
            Size = UDim2.new(0, 350, 1, 0),
            Position = UDim2.new(1, -20, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Parent = screenGui
        })
        Utilities.ApplyPadding(container, Theme.Spacing.LG)
        Utilities.ApplyListLayout(container, {
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = Theme.Spacing.SM
        })
    end
    
    local container = screenGui:FindFirstChild("Container")
    if not container then return end
    
    local typeColors = {
        success = Theme.Colors.Success,
        warning = Theme.Colors.Warning,
        error = Theme.Colors.Error,
        info = Theme.Colors.Info
    }
    local typeIcons = {
        success = "circle-check",
        warning = "triangle-exclamation",
        error = "circle-xmark",
        info = "circle-info"
    }
    
    local notifType = config.Type or "info"
    local color = typeColors[notifType] or Theme.Colors.Info
    local icon = config.Icon or typeIcons[notifType]
    
    local notif = Utilities.Create("Frame", {
        Name = "Notification",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Theme.Colors.Surface,
        BorderSizePixel = 0,
        Parent = container
    })
    
    Utilities.ApplyCorner(notif, Theme.BorderRadius.MD)
    Utilities.ApplyStroke(notif, { Color = color, Thickness = 1 })
    
    -- Accent bar
    Utilities.Create("Frame", {
        Name = "Accent",
        Size = UDim2.new(0, 4, 1, 0),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Parent = notif
    })
    
    -- Content
    local content = Utilities.Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -8, 0, 0),
        Position = UDim2.new(0, 8, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Parent = notif
    })
    
    Utilities.ApplyPadding(content, Theme.Spacing.MD)
    Utilities.ApplyListLayout(content, {
        Direction = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = Theme.Spacing.SM
    })
    
    -- Icon
    Utilities.Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = Icons.Get(icon),
        TextColor3 = color,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        LayoutOrder = 1,
        Parent = content
    })
    
    -- Text container
    local textContainer = Utilities.Create("Frame", {
        Name = "TextContainer",
        Size = UDim2.new(1, -30, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Parent = content
    })
    
    Utilities.ApplyListLayout(textContainer, { Padding = 4 })
    
    -- Title
    if config.Title then
        Utilities.Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = config.Title,
            TextColor3 = Theme.Colors.TextPrimary,
            TextSize = Theme.Typography.Body,
            Font = Theme.Typography.FontFamilyBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 1,
            Parent = textContainer
        })
    end
    
    -- Message
    Utilities.Create("TextLabel", {
        Name = "Message",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Text = config.Message or "Notification",
        TextColor3 = Theme.Colors.TextSecondary,
        TextSize = Theme.Typography.Small,
        Font = Theme.Typography.FontFamily,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 2,
        Parent = textContainer
    })
    
    -- Animate in
    notif.Position = UDim2.new(1, 0, 0, 0)
    Utilities.SpringTween(notif, { Position = UDim2.new(0, 0, 0, 0) })
    
    -- Auto dismiss
    local duration = config.Duration or 5
    task.delay(duration, function()
        if notif and notif.Parent then
            Utilities.Tween(notif, { Position = UDim2.new(1, 0, 0, 0) }, 0.3)
            task.wait(0.3)
            if notif then notif:Destroy() end
        end
    end)
    
    return notif
end

-- Return the framework
return UIFramework
`;

    return output;
}

/**
 * Simple minification (removes comments and extra whitespace)
 */
function minify(content) {
    // Remove multi-line comments
    content = content.replace(/--\[\[[\s\S]*?\]\]/g, '');
    
    // Remove single-line comments (but keep string content)
    content = content.replace(/--(?!\[\[).*$/gm, '');
    
    // Remove empty lines
    content = content.replace(/^\s*\n/gm, '');
    
    // Reduce multiple spaces to single space (careful with strings)
    content = content.replace(/[ \t]+/g, ' ');
    
    // Remove spaces around operators (basic)
    content = content.replace(/\s*([=+\-*/<>~,{}()])\s*/g, '$1');
    
    // Restore necessary spaces
    content = content.replace(/local(\w)/g, 'local $1');
    content = content.replace(/return(\w)/g, 'return $1');
    content = content.replace(/function(\w)/g, 'function $1');
    content = content.replace(/end(\w)/g, 'end $1');
    content = content.replace(/then(\w)/g, 'then $1');
    content = content.replace(/else(\w)/g, 'else $1');
    content = content.replace(/do(\w)/g, 'do $1');
    content = content.replace(/and(\w)/g, 'and $1');
    content = content.replace(/or(\w)/g, 'or $1');
    content = content.replace(/not(\w)/g, 'not $1');
    content = content.replace(/in(\w)/g, 'in $1');
    
    return content.trim();
}

/**
 * Main build function
 */
function build() {
    console.log('');
    log('╔═══════════════════════════════════════════════════════════╗', 'cyan');
    log('║           UIFramework Build System v1.0.0                 ║', 'cyan');
    log('╚═══════════════════════════════════════════════════════════╝', 'cyan');
    console.log('');
    
    const startTime = Date.now();
    
    try {
        // Create output directory
        const distPath = path.join(__dirname, CONFIG.outputDir);
        if (!fs.existsSync(distPath)) {
            fs.mkdirSync(distPath, { recursive: true });
        }
        
        log('Building standalone file...', 'yellow');
        console.log('');
        
        // Generate standalone
        const standalone = generateStandalone();
        
        // Write standalone file
        const outputPath = path.join(distPath, CONFIG.outputFile);
        fs.writeFileSync(outputPath, standalone, 'utf8');
        
        const stats = fs.statSync(outputPath);
        const sizeKB = (stats.size / 1024).toFixed(2);
        const lines = standalone.split('\n').length;
        
        console.log('');
        log('Build complete!', 'green');
        console.log('');
        log(`  Output: ${outputPath}`, 'dim');
        log(`  Size: ${sizeKB} KB (${lines} lines)`, 'dim');
        log(`  Time: ${Date.now() - startTime}ms`, 'dim');
        console.log('');
        
        log('Usage with executor:', 'yellow');
        console.log('');
        log('  -- From URL:', 'dim');
        log('  local UIFramework = loadstring(game:HttpGet("YOUR_URL"))()', 'bright');
        console.log('');
        log('  -- From local file:', 'dim');
        log('  local UIFramework = loadstring(readfile("UIFramework.lua"))()', 'bright');
        console.log('');
        
    } catch (error) {
        log(`Build failed: ${error.message}`, 'red');
        console.error(error);
        process.exit(1);
    }
}

/**
 * Watch mode
 */
function watch() {
    log('Watch mode enabled. Watching for changes...', 'cyan');
    
    // Initial build
    build();
    
    try {
        const chokidar = require('chokidar');
        
        const watcher = chokidar.watch([
            path.join(__dirname, '*.lua'),
            path.join(__dirname, 'Components', '*.lua')
        ], {
            ignored: /node_modules|dist/,
            persistent: true
        });
        
        watcher.on('change', (filePath) => {
            log(`\nFile changed: ${path.basename(filePath)}`, 'yellow');
            build();
        });
        
    } catch (e) {
        log('chokidar not installed. Run: pnpm install', 'red');
        log('Falling back to manual rebuild...', 'yellow');
    }
}

// Main entry point
const args = process.argv.slice(2);

if (args.includes('--watch') || args.includes('-w')) {
    watch();
} else {
    build();
}

