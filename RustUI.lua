-- RustUI Library
local RustUI = {}
RustUI.__index = RustUI

-- Utility function to make UI draggable
local function makeDraggable(frame, handle)
    local UIS = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function RustUI:CreateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RustUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    mainFrame.Parent = screenGui
    mainFrame.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    local outline = Instance.new("UIStroke")
    outline.Thickness = 1.5
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    titleBar.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Text = "RustUI"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Size = UDim2.new(0, 100, 1, 0)
    title.Position = UDim2.new(1, -110, 0, 0)
    title.BackgroundTransparency = 1
    title.Parent = titleBar

    local description = Instance.new("TextLabel")
    description.Text = "UI Description"
    description.Font = Enum.Font.Gotham
    description.TextSize = 14
    description.TextColor3 = Color3.fromRGB(200, 200, 200)
    description.Size = UDim2.new(0, 200, 1, 0)
    description.Position = UDim2.new(1, -320, 0, 0)
    description.BackgroundTransparency = 1
    description.TextXAlignment = Enum.TextXAlignment.Right
    description.Parent = titleBar

    makeDraggable(mainFrame, titleBar)

    local tabsFrame = Instance.new("Frame")
    tabsFrame.Size = UDim2.new(0, 100, 1, -40)
    tabsFrame.Position = UDim2.new(1, -100, 0, 40)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    tabsFrame.Parent = mainFrame

    local tabsLayout = Instance.new("UIListLayout")
    tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabsLayout.Parent = tabsFrame

    local elementsFrame = Instance.new("Frame")
    elementsFrame.Size = UDim2.new(1, -100, 1, -40)
    elementsFrame.Position = UDim2.new(0, 0, 0, 40)
    elementsFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    elementsFrame.Parent = mainFrame

    local elementsLayout = Instance.new("UIListLayout")
    elementsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    elementsLayout.Parent = elementsFrame

    return screenGui, tabsFrame, elementsFrame
end

function RustUI:CreateTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Text = name
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 16
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Size = UDim2.new(1, 0, 0, 50)
    tabButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)

    local tabButtonCorner = Instance.new("UICorner")
    tabButtonCorner.CornerRadius = UDim.new(0, 10)
    tabButtonCorner.Parent = tabButton

    local tabButtonOutline = Instance.new("UIStroke")
    tabButtonOutline.Thickness = 1.5
    tabButtonOutline.Color = Color3.fromRGB(255, 255, 255)
    tabButtonOutline.Parent = tabButton

    return tabButton
end

function RustUI:CreateElement(parent, elementType, text)
    local element
    if elementType == "Label" then
        element = Instance.new("TextLabel")
    elseif elementType == "Button" then
        element = Instance.new("TextButton")
    end

    element.Text = text
    element.Font = Enum.Font.Gotham
    element.TextSize = 16
    element.TextColor3 = Color3.fromRGB(255, 255, 255)
    element.Size = UDim2.new(1, -10, 0, 50)
    element.Position = UDim2.new(0, 5, 0, 5)
    element.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    element.Parent = parent

    local elementCorner = Instance.new("UICorner")
    elementCorner.CornerRadius = UDim.new(0, 10)
    elementCorner.Parent = element

    local elementOutline = Instance.new("UIStroke")
    elementOutline.Thickness = 1.5
    elementOutline.Color = Color3.fromRGB(255, 255, 255)
    elementOutline.Parent = element

    return element
end

return RustUI

