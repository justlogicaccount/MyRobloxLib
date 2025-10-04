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
    tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- твой цвет для вкладки
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

-- Создание кнопки внутри вкладки
function MyLib:CreateButton(tab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- твой цвет для кнопки
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Parent = tab.Frame

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

return MyLib
