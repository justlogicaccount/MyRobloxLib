-- MyLib.lua
local MyLib = {}

function MyLib:SayHello()
    print("Привет! Библиотека работает 🎉")
end

-- Создание главного окна
function MyLib:CreateMainWindow(title)
    local MyLibUI = Instance.new("ScreenGui")
    local TabBar = Instance.new("Frame")
    local TabList = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local HubName = Instance.new("Frame")
    local HubName_2 = Instance.new("TextLabel")
    local MainFrame = Instance.new("Frame")

    -- ScreenGui
    MyLibUI.Name = "MyLibUI"
    MyLibUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MyLibUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- TabBar
    TabBar.Name = "TabBar"
    TabBar.Parent = MyLibUI
    TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabBar.BorderSizePixel = 0
    TabBar.Position = UDim2.new(0.05, 0, 0.1, 0)
    TabBar.Size = UDim2.new(0, 160, 0, 499)

    -- TabList
    TabList.Name = "TabList"
    TabList.Parent = TabBar
    TabList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 0, 0.15, 0)
    TabList.Size = UDim2.new(0, 160, 0, 423)

    UIListLayout.Parent = TabList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0.05, 0)

    -- HubName
    HubName.Name = "HubName"
    HubName.Parent = TabBar
    HubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HubName.BorderSizePixel = 0
    HubName.Size = UDim2.new(1, 0, 0, 30)

    HubName_2.Name = "HubName"
    HubName_2.Parent = HubName
    HubName_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    HubName_2.BorderSizePixel = 0
    HubName_2.Size = UDim2.new(1, 0, 1, 0)
    HubName_2.Font = Enum.Font.FredokaOne
    HubName_2.Text = title or "arseniy.pub"
    HubName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubName_2.TextSize = 25

    -- MainFrame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = MyLibUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 675, 0, 500)

    -- возвращаем структуру окна
    local window = {
        Gui = MyLibUI,
        TabBar = TabBar,
        TabList = TabList,
        MainFrame = MainFrame,
        Tabs = {}
    }

    return window
end

-- Создание вкладки
function MyLib:CreateTab(window, name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Parent = window.TabList

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    tabFrame.Visible = false
    tabFrame.Parent = window.MainFrame

    -- логика переключения
    tabButton.MouseButton1Click:Connect(function()
        for _, t in ipairs(window.Tabs) do
            t.Frame.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- сброс цвета
        end
        tabFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- активная вкладка
    end)

    local tab = {Button = tabButton, Frame = tabFrame}
    table.insert(window.Tabs, tab)

    -- если это первая вкладка → сразу показываем её
    if #window.Tabs == 1 then
        tabFrame.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end

    return tab
end

function MyLib:CreateSection(tab, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -20, 0, 50)
    section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    section.BorderSizePixel = 0
    section.Parent = tab.Frame

    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Size = UDim2.new(1, -10, 0, 25)
    sectionLabel.Position = UDim2.new(0, 5, 0, 5)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Font = Enum.Font.FredokaOne
    sectionLabel.Text = title
    sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionLabel.TextSize = 18
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = section


    local layout = Instance.new("UIListLayout")
    layout.Parent = section
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    return section
end


-- Создание кнопки внутри вкладки
function MyLib:CreateButton(tab, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = tab.Frame

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return btn
end

return MyLib
