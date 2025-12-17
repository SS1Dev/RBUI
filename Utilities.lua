--[[
    UIFramework Utilities
    Helper functions for UI creation and management
]]

local TweenService = game:GetService("TweenService")

local Utilities = {}

-- Create a new Instance with properties
function Utilities.Create(className, properties)
    local instance = Instance.new(className)
    
    for property, value in pairs(properties or {}) do
        if property ~= "Parent" and property ~= "Children" then
            instance[property] = value
        end
    end
    
    -- Add children
    if properties and properties.Children then
        for _, child in ipairs(properties.Children) do
            child.Parent = instance
        end
    end
    
    -- Set parent last
    if properties and properties.Parent then
        instance.Parent = properties.Parent
    end
    
    return instance
end

-- Apply corner radius
function Utilities.ApplyCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius
    corner.Parent = instance
    return corner
end

-- Apply padding
function Utilities.ApplyPadding(instance, padding)
    local uiPadding = Instance.new("UIPadding")
    
    if type(padding) == "number" then
        uiPadding.PaddingTop = UDim.new(0, padding)
        uiPadding.PaddingBottom = UDim.new(0, padding)
        uiPadding.PaddingLeft = UDim.new(0, padding)
        uiPadding.PaddingRight = UDim.new(0, padding)
    else
        uiPadding.PaddingTop = UDim.new(0, padding.Top or 0)
        uiPadding.PaddingBottom = UDim.new(0, padding.Bottom or 0)
        uiPadding.PaddingLeft = UDim.new(0, padding.Left or 0)
        uiPadding.PaddingRight = UDim.new(0, padding.Right or 0)
    end
    
    uiPadding.Parent = instance
    return uiPadding
end

-- Apply list layout
function Utilities.ApplyListLayout(instance, config)
    config = config or {}
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = config.Direction or Enum.FillDirection.Vertical
    layout.HorizontalAlignment = config.HorizontalAlignment or Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = config.VerticalAlignment or Enum.VerticalAlignment.Top
    layout.SortOrder = config.SortOrder or Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, config.Padding or 8)
    layout.Parent = instance
    
    return layout
end

-- Apply grid layout
function Utilities.ApplyGridLayout(instance, config)
    config = config or {}
    
    local layout = Instance.new("UIGridLayout")
    layout.CellSize = config.CellSize or UDim2.new(0, 100, 0, 100)
    layout.CellPadding = config.CellPadding or UDim2.new(0, 8, 0, 8)
    layout.FillDirection = config.Direction or Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = config.HorizontalAlignment or Enum.HorizontalAlignment.Left
    layout.VerticalAlignment = config.VerticalAlignment or Enum.VerticalAlignment.Top
    layout.SortOrder = config.SortOrder or Enum.SortOrder.LayoutOrder
    layout.Parent = instance
    
    return layout
end

-- Apply stroke
function Utilities.ApplyStroke(instance, config)
    config = config or {}
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = config.Color or Color3.fromRGB(71, 85, 105)
    stroke.Thickness = config.Thickness or 1
    stroke.Transparency = config.Transparency or 0
    stroke.ApplyStrokeMode = config.Mode or Enum.ApplyStrokeMode.Border
    stroke.Parent = instance
    
    return stroke
end

-- Apply gradient
function Utilities.ApplyGradient(instance, config)
    config = config or {}
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = config.Color or ColorSequence.new(Color3.fromRGB(255, 255, 255))
    gradient.Rotation = config.Rotation or 0
    gradient.Transparency = config.Transparency or NumberSequence.new(0)
    gradient.Parent = instance
    
    return gradient
end

-- Apply aspect ratio
function Utilities.ApplyAspectRatio(instance, ratio)
    local aspect = Instance.new("UIAspectRatioConstraint")
    aspect.AspectRatio = ratio or 1
    aspect.Parent = instance
    return aspect
end

-- Apply size constraint
function Utilities.ApplySizeConstraint(instance, minSize, maxSize)
    local constraint = Instance.new("UISizeConstraint")
    if minSize then
        constraint.MinSize = minSize
    end
    if maxSize then
        constraint.MaxSize = maxSize
    end
    constraint.Parent = instance
    return constraint
end

-- Tween function
function Utilities.Tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.2,
        easingStyle or Enum.EasingStyle.Quint,
        easingDirection or Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Spring tween (using sine for smoother feel)
function Utilities.SpringTween(instance, properties, duration)
    return Utilities.Tween(instance, properties, duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- Generate unique ID
local idCounter = 0
function Utilities.GenerateId()
    idCounter = idCounter + 1
    return "UI_" .. tostring(idCounter) .. "_" .. tostring(tick())
end

-- Clamp value between min and max
function Utilities.Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

-- Lerp between two values
function Utilities.Lerp(a, b, t)
    return a + (b - a) * t
end

-- Map value from one range to another
function Utilities.Map(value, inMin, inMax, outMin, outMax)
    return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin)
end

-- Round to decimal places
function Utilities.Round(value, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(value * mult + 0.5) / mult
end

-- Debounce function
function Utilities.Debounce(callback, delay)
    local lastCall = 0
    
    return function(...)
        local now = tick()
        if now - lastCall >= delay then
            lastCall = now
            return callback(...)
        end
    end
end

-- Deep copy table
function Utilities.DeepCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        if type(value) == "table" then
            copy[key] = Utilities.DeepCopy(value)
        else
            copy[key] = value
        end
    end
    return copy
end

-- Merge tables
function Utilities.Merge(base, override)
    local result = Utilities.DeepCopy(base)
    for key, value in pairs(override or {}) do
        if type(value) == "table" and type(result[key]) == "table" then
            result[key] = Utilities.Merge(result[key], value)
        else
            result[key] = value
        end
    end
    return result
end

-- Wait for child with timeout
function Utilities.WaitForChild(parent, childName, timeout)
    timeout = timeout or 5
    local child = parent:WaitForChild(childName, timeout)
    return child
end

-- Safe destroy
function Utilities.Destroy(instance)
    if instance and instance.Parent then
        instance:Destroy()
    end
end

-- Make draggable (Smooth version using UserInputService)
function Utilities.MakeDraggable(frame, handle)
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    
    handle = handle or frame
    
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local startPos = UDim2.new(0, 0, 0, 0)
    local targetPos = UDim2.new(0, 0, 0, 0)
    local currentPos = UDim2.new(0, 0, 0, 0)
    local smoothness = 0.15 -- Lower = smoother, higher = more responsive
    local renderConnection = nil
    
    -- Smooth interpolation for position
    local function lerpUDim2(a, b, t)
        return UDim2.new(
            a.X.Scale + (b.X.Scale - a.X.Scale) * t,
            a.X.Offset + (b.X.Offset - a.X.Offset) * t,
            a.Y.Scale + (b.Y.Scale - a.Y.Scale) * t,
            a.Y.Offset + (b.Y.Offset - a.Y.Offset) * t
        )
    end
    
    -- Start dragging
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            currentPos = frame.Position
            targetPos = frame.Position
            
            -- Start render loop for smooth movement
            if not renderConnection then
                renderConnection = RunService.RenderStepped:Connect(function(deltaTime)
                    if dragging then
                        -- Smooth interpolation
                        currentPos = lerpUDim2(currentPos, targetPos, math.min(1, smoothness / deltaTime * 0.016))
                        frame.Position = currentPos
                    end
                end)
            end
        end
    end)
    
    -- Track mouse movement globally
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Stop dragging
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                -- Snap to final position
                frame.Position = targetPos
                
                -- Clean up render connection
                if renderConnection then
                    renderConnection:Disconnect()
                    renderConnection = nil
                end
            end
        end
    end)
end

-- Create shadow effect
function Utilities.CreateShadow(parent, offset, blur)
    offset = offset or 4
    blur = blur or 12
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, offset)
    shadow.Size = UDim2.new(1, blur * 2, 1, blur * 2)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Image = "rbxassetid://6014261993" -- Shadow image
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = parent
    
    return shadow
end

return Utilities

