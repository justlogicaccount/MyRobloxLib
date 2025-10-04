-- MyLib.lua
local MyLib = {}

-- Проверка
function MyLib:SayHello()
    print("Привет! Библиотека работает 🎉")
end

-- Создание главного окна
function MyLib:CreateMainWindow(title)
    local MyLibUI = Instance.new("ScreenGui")
    MyLibUI.Name = "MyLibUI"
    MyLibUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MyLibUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling



    -- общий контейнер окна
    local WindowFrame = Instance.new("Frame")
    WindowFrame.Name = "WindowFrame"
    WindowFrame.Parent = MyLibUI
    WindowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет
    WindowFrame.BorderSizePixel = 0
    WindowFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
    WindowFrame.Size = UDim2.new(0, 800, 0, 500)
    WindowFrame.Active = true
    WindowFrame.Draggable = true

    -- TabBar слева
    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Parent = WindowFrame
    TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет
    TabBar.Size = UDim2.new(0, 160, 1, 0)
    TabBar.Position = UDim2.new(0, 0, 0, 0)

    local HubName = Instance.new("TextLabel")
    HubName.Parent = TabBar
    HubName.Size = UDim2.new(1, 0, 0, 40)
    HubName.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет
    HubName.BorderSizePixel = 0
    HubName.Font = Enum.Font.FredokaOne
    HubName.Text = title or "arseniy.pub"
    HubName.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubName.TextSize = 22

    local TabList = Instance.new("Frame")
    TabList.Name = "TabList"
    TabList.Parent = TabBar
    TabList.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 0, 0, 50)
    TabList.Size = UDim2.new(1, 0, 1, -50)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- MainFrame справа
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = WindowFrame
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 160, 0, 0)
    MainFrame.Size = UDim2.new(1, -160, 1, 0)

    return {
        Gui = MyLibUI,
        WindowFrame = WindowFrame,
        TabBar = TabBar,
        TabList = TabList,
        MainFrame = MainFrame,
        Tabs = {}
    }
end

-- Создание вкладки
function MyLib:CreateTab(window, name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет для кнопки
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BorderSizePixel = 0
    tabButton.Parent = window.TabList

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- твой цвет для вкладки
    tabFrame.BorderSizePixel = 0
    tabFrame.Visible = false
    tabFrame.Parent = window.MainFrame

    tabButton.MouseButton1Click:Connect(function()
        for _, t in ipairs(window.Tabs) do
            t.Frame.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- сброс цвета
        end
        tabFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- активная вкладка
    end)

    local tab = {Button = tabButton, Frame = tabFrame}
    table.insert(window.Tabs, tab)

    if #window.Tabs == 1 then
        tabFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end

    return tab
end

function MyLib:CreateSection(tab, sectionName)
    -- если ещё нет сетки в MainFrame → создаём
    if not tab.Frame:FindFirstChild("GridLayout") then
        local grid = Instance.new("UIGridLayout")
        grid.Name = "GridLayout"
        grid.Parent = tab.Frame
        grid.SortOrder = Enum.SortOrder.LayoutOrder
        grid.CellPadding = UDim2.new(0, 10, 0, 10) -- отступы между секциями
        grid.CellSize = UDim2.new(0.5, -15, 0.5, -15) -- 4 секции (2x2)
    end

    -- сама секция
    local Section = Instance.new("Frame")
    Section.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- черный фон
    Section.BorderSizePixel = 0
    Section.Parent = tab.Frame

    -- Заголовок секции
    local Title = Instance.new("TextLabel")
    Title.Parent = Section
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -10, 0, 25)
    Title.Position = UDim2.new(0, 5, 0, 5)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = sectionName or "Section"
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(150, 150, 150) -- серый текст
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- контейнер для элементов
    local Content = Instance.new("Frame")
    Content.Parent = Section
    Content.BackgroundTransparency = 1
    Content.Size = UDim2.new(1, -10, 1, -35)
    Content.Position = UDim2.new(0, 5, 0, 30)

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Content
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 5)

    return {
        Frame = Section,
        Content = Content
    }
end


--Кнопка
function MyLib:CreateButton(section, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35) -- кнопка на всю ширину секции
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- тёмный фон
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Parent = section.Content -- теперь внутри контейнера секции

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

function MyLib:CloseGUI(window)
    if window and window.Gui then
        window.Gui:Destroy()
    end
end

function MyLib:CreateToggle(section, text, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 35)
    toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.Parent = section.Content

    -- заголовок
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.SourceSans
    label.Text = text
    label.TextSize = 18
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    -- индикатор (квадрат справа)
    local indicator = Instance.new("Frame")
    indicator.Parent = toggle
    indicator.Size = UDim2.new(0, 25, 0, 25)
    indicator.Position = UDim2.new(1, -35, 0.5, -12)
    indicator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    indicator.BorderSizePixel = 0

    local state = default or false

    local function update()
        if state then
            indicator.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- зелёный (вкл)
        else
            indicator.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- серый (выкл)
        end
    end

    update()

    toggle.MouseButton1Click:Connect(function()
        state = not state
        update()
        if callback then callback(state) end
    end)

    return toggle
end

function MyLib:CreateSlider(section, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = section.Content

    -- Заголовок
    local label = Instance.new("TextLabel")
    label.Parent = sliderFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.7, 0, 0.5, 0)
    label.Font = Enum.Font.SourceSans
    label.Text = text .. " (" .. tostring(default) .. ")"
    label.TextSize = 18
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    -- Полоса
    local bar = Instance.new("Frame")
    bar.Parent = sliderFrame
    bar.Size = UDim2.new(0.9, 0, 0, 8)
    bar.Position = UDim2.new(0.05, 0, 0.7, 0)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    bar.BorderSizePixel = 0

    -- Заполненная часть
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    fill.BorderSizePixel = 0

    local value = default or min
    local dragging = false

    local function update(inputX)
        local relativeX = math.clamp((inputX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * relativeX)
        fill.Size = UDim2.new(relativeX, 0, 1, 0)
        label.Text = text .. " (" .. tostring(value) .. ")"
        if callback then callback(value) end
    end

    -- Управление мышкой
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)

    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    return sliderFrame
end

function MyLib:CreateDropdown(section, text, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = section.Content

    -- Заголовок (сама кнопка открытия)
    local mainButton = Instance.new("TextButton")
    mainButton.Parent = dropdownFrame
    mainButton.Size = UDim2.new(1, 0, 1, 0)
    mainButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainButton.Text = text .. " ▼"
    mainButton.Font = Enum.Font.SourceSans
    mainButton.TextSize = 18
    mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainButton.BorderSizePixel = 0

    -- Контейнер для опций
    local optionFrame = Instance.new("Frame")
    optionFrame.Parent = section.Content
    optionFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    optionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    optionFrame.BorderSizePixel = 0
    optionFrame.Visible = false

    local layout = Instance.new("UIListLayout")
    layout.Parent = optionFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local opened = false

    mainButton.MouseButton1Click:Connect(function()
        opened = not opened
        optionFrame.Visible = opened
        if opened then
            mainButton.Text = text .. " ▲"
        else
            mainButton.Text = text .. " ▼"
        end
    end)

    for _, option in ipairs(options) do
        local optButton = Instance.new("TextButton")
        optButton.Parent = optionFrame
        optButton.Size = UDim2.new(1, 0, 0, 30)
        optButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        optButton.Text = option
        optButton.Font = Enum.Font.SourceSans
        optButton.TextSize = 18
        optButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optButton.BorderSizePixel = 0

        optButton.MouseButton1Click:Connect(function()
            mainButton.Text = text .. ": " .. option .. " ▼"
            optionFrame.Visible = false
            opened = false
            if callback then callback(option) end
        end)
    end

    return dropdownFrame
end

function MyLib:CreateTextbox(section, placeholder, default, callback)
    local textboxFrame = Instance.new("Frame")
    textboxFrame.Size = UDim2.new(1, 0, 0, 40)
    textboxFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    textboxFrame.BorderSizePixel = 0
    textboxFrame.Parent = section.Content

    -- Поле для текста
    local box = Instance.new("TextBox")
    box.Parent = textboxFrame
    box.Size = UDim2.new(1, -10, 1, -10)
    box.Position = UDim2.new(0, 5, 0, 5)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.Text = default or ""
    box.PlaceholderText = placeholder or "Введите текст..."
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 18
    box.BorderSizePixel = 0

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(box.Text)
        end
    end)

    return textboxFrame
end


return MyLib
