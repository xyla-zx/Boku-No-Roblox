local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local ArmorMenu = LocalPlayer.PlayerGui.MainMenus.ArmorMenu.ScrollingFrame
local SellPoint = Vector3.new(-15.38, 339.02, 935.09)
local QuestModule = require(game:GetService("ReplicatedStorage").Questing.Main)
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Plr = Players.LocalPlayer
local Clipon = false
local SteppedConnection = nil

local Window = Fluent:CreateWindow({
    Title = "My Hero AutoFarm ",
    SubTitle = "By XyLa",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
})

local nameid, posid, questid

-- ฟังก์ชันแปลงชื่อมอนเป็น config
function do2s()
    if SelectedMobConfig == "Criminal" then
        nameid = "Criminal"
        posid = Vector3.new(806.45, 329.07, 289.61)
        questid = "QUEST_INJURED MAN_1"
    elseif SelectedMobConfig == "Police" then
        nameid = "Police"
        posid = Vector3.new(16.41, 329.30, -200.03)
        questid = "QUEST_GANG MEMBER_1"
    elseif SelectedMobConfig == "Weak Villain" then
        nameid = "Weak Villain"
        posid = Vector3.new(1140.52, 329.31, 44.85)
        questid = "QUEST_AIZAWA_1"
    elseif SelectedMobConfig == "UA Student" then
        nameid = "UA Student"
        posid = Vector3.new(560.46, 329.31, -564.49)
        questid = "QUEST_SUSPICIOUS CHARACTER_1"
    elseif SelectedMobConfig == "Villain" then
        nameid = "Villain"
        posid = Vector3.new(206.80, 329.30, 832.86)
        questid = "QUEST_HERO_1"
    elseif SelectedMobConfig == "Hero" then
        nameid = "Hero"
        posid = Vector3.new(-188.61, 329.30, 69.99)
        questid = "QUEST_VILLAIN_1"
    elseif SelectedMobConfig == "Forest Beast" then
        nameid = "Forest Beast"
        posid = Vector3.new(2929.94, 349.00, 174.12)
        questid = "QUEST_TWICE_1"






    elseif SelectedMobConfig == "Tomura" then
        nameid = "Tomura"
        posid = Vector3.new(1443.8404541015625, 328.7466735839844, -176.1107635498047)
        questid = " "
    elseif SelectedMobConfig == "Present Mic" then
        nameid = "Present Mic"
        posid = Vector3.new(883.7568359375, 328.79486083984375, -810.4763793945312)
        questid = " "
    elseif SelectedMobConfig == "Midnight" then
        nameid = "Midnight"
        posid = Vector3.new(139.2104949951172, 328.44293212890625, -809.781982421875)
        questid = " "
    elseif SelectedMobConfig == "Dabi" then
        nameid = "Dabi"
        posid = Vector3.new(2642.8720703125, 328.56427001953125, 101.32640075683594)
        questid = " "
    elseif SelectedMobConfig == "Gang Orca" then
        nameid = "Gang Orca"
        posid = Vector3.new(-500.7497863769531, 328.6766357421875, 172.7642059326172)
        questid = " "
    elseif SelectedMobConfig == "Muscular" then
        nameid = "Muscular"
        posid = Vector3.new(3114.08740234375, 327.1622619628906, -50.300804138183594)
        questid = " "
    elseif SelectedMobConfig == "Gigantomachia" then
        nameid = "Gigantomachia"
        posid = Vector3.new(-7.837398052215576, 480.42242431640625, 174.45111083984375)
        questid = " "
    elseif SelectedMobConfig == "Noumu" then
        nameid = "Noumu"
        posid = Vector3.new(785.61, 328.91, 1104.00)
        questid = " "
    elseif SelectedMobConfig == "Mount Lady" then
        nameid = "Mount Lady"
        posid = Vector3.new(-496.80, 329.30, 656.16)
        questid = " "
    elseif SelectedMobConfig == "Overhaul" then
        nameid = "Overhaul"
        posid = Vector3.new(-668.58, 328.90, 1087.56)
        questid = " "
    elseif SelectedMobConfig == "Endeavor" then
        nameid = "Endeavor"
        posid = Vector3.new(-479.44, 329.30, -306.19)
        questid = " "
    elseif SelectedMobConfig == "All Might" then
        nameid = "All Might 1"
        posid = Vector3.new(1433.59, 328.91, 1101.04)
        questid = " "
    elseif SelectedMobConfig == "Mirko" then
        nameid = "-157.20103454589844, 1892.6004638671875, -1775.60693359375"
        posid = Vector3.new(1433.59, 328.91, 1101.04)
        questid = " "
    end
end




-- ฟังก์ชันเปิด/ปิด noclip
local function SetNoclip(enabled)
	Clipon = enabled

	-- ถ้าเปิด noclip
	if Clipon then
		-- ถ้ามีการเชื่อมต่อเก่า ให้ยกเลิกก่อน
		if SteppedConnection then
			SteppedConnection:Disconnect()
		end

		-- เชื่อมต่อฟังก์ชันกับ RunService.Stepped เพื่อทำให้วัตถุทะลุได้
		SteppedConnection = RunService.Stepped:Connect(function()
			for _, obj in pairs(Workspace:GetChildren()) do
				if obj.Name == Plr.Name then
					for _, part in pairs(obj:GetChildren()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end
		end)
	else
		-- ถ้าปิด noclip ให้หยุดการเชื่อมต่อ
		if SteppedConnection then
			SteppedConnection:Disconnect()
			SteppedConnection = nil
		end
	end
end


function do2r()
    if SelectedItemConfig == "Purse" then
        itemid = "^Purse@"
    elseif SelectedItemConfig == "Damascus Knife" then
        itemid = "^Damascus_Steel@"
    elseif SelectedItemConfig == "Belt" then
        itemid = "^Belt@"
    elseif SelectedItemConfig == "Body Armor" then
        itemid = "^BodyArmor@"
    end
end


local function getItemsToSell()
    local items = {}

    for _, child in pairs(ArmorMenu:GetChildren()) do
        if child.Name:match(itemid) then
            table.insert(items, child.Name)
        end
    end

    return items
end

local function teleportToSellPoint()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(SellPoint)
    wait(2)
end


local function sellItems(items)
    if #items > 0 then
        ReplicatedStorage:WaitForChild("WeaponShop"):WaitForChild("Sell"):FireServer(unpack({items}))
        print("ขายไอเทม: " .. SelectedItemConfig .. " => " .. table.concat(items, ", "))
    else
        print("ไม่มีไอเทมที่สามารถขายได้ในรอบนี้")
    end
end

-- 🔁 ฟังก์ชันลูปขายอัตโนมัติทุก 10 วินาที
local function autoSellItems()
        teleportToSellPoint()  -- วาร์ปไปยังจุดขายก่อน
        local itemsToSell = getItemsToSell()
        sellItems(itemsToSell)
end


-- ฟังก์ชันรอให้ตัวละครโหลด
local function waitForCharacter()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    while not char:FindFirstChild("HumanoidRootPart") do
        char.ChildAdded:Wait()
    end
    return char
end

-- ฟังก์ชันไปยังจุดที่เลือก
local function moveToLoadPoint()
    local char = waitForCharacter()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local goalCFrame = CFrame.new(posid)
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = goalCFrame})
    tween:Play()
    tween.Completed:Wait()

    task.wait(0.1)
end

local function moveToLoadPoint2()
    local char = waitForCharacter()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local goalCFrame = CFrame.new(Vector3.new(687.179443359375, 329.0298156738281, 3122.509521484375))
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = goalCFrame})
    tween:Play()
    tween.Completed:Wait()

    task.wait(0.1)
end


local function aafk()
    wait(0.5)
    local gui = Instance.new("ScreenGui")
    local header = Instance.new("TextLabel")
    local frame = Instance.new("Frame")
    local footer = Instance.new("TextLabel")
    local status = Instance.new("TextLabel")

    gui.Parent = game.CoreGui
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Header Design
    header.Parent = gui
    header.Active = true
    header.BackgroundColor3 = Color3.new(0, 0, 0.4)
    header.Draggable = true
    header.Position = UDim2.new(0.7, 0, 0.1, 0)
    header.Size = UDim2.new(0, 400, 0, 50)
    header.Font = Enum.Font.Fantasy
    header.Text = "Anti-AFK"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.TextSize = 24

    -- Frame Design
    frame.Parent = header
    frame.BackgroundColor3 = Color3.new(0, 0, 0.3)
    frame.Position = UDim2.new(0, 0, 1, 0)
    frame.Size = UDim2.new(0, 400, 0, 100)

    -- Footer Design
    footer.Parent = frame
    footer.BackgroundColor3 = Color3.new(0, 0, 0.4)
    footer.Position = UDim2.new(0, 0, 0.8, 0)
    footer.Size = UDim2.new(0, 400, 0, 20)
    footer.Font = Enum.Font.GothamBold
    footer.Text = "Made by XyLa"
    footer.TextColor3 = Color3.new(0.8, 0.8, 1)
    footer.TextSize = 18

    -- Status Design
    status.Parent = frame
    status.BackgroundColor3 = Color3.new(0, 0, 0.5)
    status.Position = UDim2.new(0, 0, 0.2, 0)
    status.Size = UDim2.new(0, 400, 0, 40)
    status.Font = Enum.Font.Gotham
    status.Text = "Status: Active"
    status.TextColor3 = Color3.new(0.8, 1, 0.8)
    status.TextSize = 22

    -- Anti-AFK Logic
    local virtualUser = game:service('VirtualUser')
    game:service('Players').LocalPlayer.Idled:connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
        status.Text = "Kicked AFK detection! Still active."
        wait(2)
        status.Text = "Status: Active"
    end)
end


local function rejoinw()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = Players.LocalPlayer
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    if #Players:GetPlayers() <= 1 then
        -- เข้าห้องใหม่
        TeleportService:Teleport(PlaceId, LocalPlayer)
    else
        -- เข้าห้องเดิม
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
    end
end


local function autoquestw()
    if not questid then
        return
    end

    task.spawn(function()
        while _G.AutoQuest do
            local quest = QuestModule.PlayerQuests.getQuestFromUser(LocalPlayer, questid)

            if not quest then
                QuestModule.startQuest(LocalPlayer, questid)
            elseif quest:IsFinished() then
                QuestModule.startQuest(LocalPlayer, questid)
            end

            task.wait(1) -- ใส่ wait ตรงนี้ให้ลูปช้าลง ป้องกันเกมค้าง
        end
    end)
end

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    -- Fluent:Notify({
    --     Title = "Notification",
    --     Content = "This is a notification",
    --     SubContent = "SubContent", -- Optional
    --     Duration = 5 -- Set to nil to make the notification not disappear
    -- })





    local Dropdown1 = Tabs.Main:AddDropdown("Dropdown", {
        Title = "เลือกมอนสเตอร์ที่จะฟาร์ม",
        Values = {"Criminal", "Police", "Weak Villain", "UA Student", "Villain", "Hero","Tomura","Forest Beast","Present Mic","Midnight","Dabi","Gang Orca","Muscular","Gigantomachia","Noumu","Mount Lady","Overhaul","Endeavor","All Might","Mirko"},
        Multi = false,
        Default = 1,
    })

    Dropdown1:OnChanged(function(Value)
        print("Dropdown changed:", Value)
        SelectedMobConfig = Value
        do2s()
        print(nameid)
        print(questid)
        print(posid)
    end)


local Toggle = Tabs.Main:AddToggle("AutoF", {Title = "AUTO FARM", Default = false })
    Toggle:OnChanged(function(state)
    SetNoclip(state)
        _G.AutoFarm = state
        if not state then return end

        if not nameid or not posid or not questid then
            return
        end
            -- Move to the selected monster location
    moveToLoadPoint()

    -- Start AutoFarm loop
    while _G.AutoFarm do
        pcall(function()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = character:FindFirstChild("Humanoid")

            -- ถ้า Player ตาย ให้รอจนฟื้นก่อน แล้วค่อย moveToLoadPoint
            if humanoid and humanoid.Health <= 0 then
                repeat
                    task.wait(1)
                    character = LocalPlayer.Character
                    humanoid = character and character:FindFirstChild("Humanoid")
                until humanoid and humanoid.Health > 0

                -- ย้ายไปยังจุดโหลดหลังฟื้น
                moveToLoadPoint()
            end

            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character.Humanoid.Health <= 0 then
                    repeat task.wait(0.5) until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
                    task.wait(1)
                end

                local targets = {}
                for _, v in pairs(workspace.NPCs:GetDescendants()) do
                    if table.find({nameid}, v.Name) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        if v.Humanoid.Health > 0 then
                            table.insert(targets, v)
                        end
                    end
                end
                
                for _, target in pairs(targets) do
                    if not _G.AutoFarm then break end

                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local goalCFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)

                        local tween = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = goalCFrame})
                        tween:Play()
                        tween.Completed:Wait()

                
                        local args = {
                            [1] = CFrame.new(target.HumanoidRootPart.Position)  -- ใช้ตำแหน่งของเป้าหมาย
                        }
                        local swing = LocalPlayer.Character:FindFirstChild("Main") and LocalPlayer.Character.Main:FindFirstChild("Swing")
                            for i = 1, 50 do
                            if swing and hrp and target.Humanoid.Health > 0 then
                                swing:FireServer(hrp.Position, hrp)
                            end
                        end

                        task.wait(0.09)
                    end
                end
        end)
        task.wait(0.05)  -- Adjust the delay for optimal performance
    end
end)
Options.AutoF:SetValue(false)





local Toggle = Tabs.Main:AddToggle("AutoFN", {Title = "AUTO FARM(noumu กาก)", Default = false })
    Toggle:OnChanged(function(state)

        _G.AutoFarm = state
        if not state then return end
            -- Move to the selected monster location
    moveToLoadPoint2()

    -- Start AutoFarm loop
    while _G.AutoFarm do
        pcall(function()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = character:FindFirstChild("Humanoid")
            local quest = QuestModule.PlayerQuests.getQuestFromUser(LocalPlayer, "QUEST_JEANIST_1")

            if not quest then
                QuestModule.startQuest(LocalPlayer, "QUEST_JEANIST_1")
            elseif quest:IsFinished() then
                QuestModule.startQuest(LocalPlayer, "QUEST_JEANIST_1")
            end
            -- ถ้า Player ตาย ให้รอจนฟื้นก่อน แล้วค่อย moveToLoadPoint
            if humanoid and humanoid.Health <= 0 then
                repeat
                    task.wait(1)
                    character = LocalPlayer.Character
                    humanoid = character and character:FindFirstChild("Humanoid")
                until humanoid and humanoid.Health > 0

                -- ย้ายไปยังจุดโหลดหลังฟื้น
                moveToLoadPoint2()
            end

            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character.Humanoid.Health <= 0 then
                    repeat task.wait(0.5) until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0
                    task.wait(1)
                end

                local targets = {}
                for _, v in pairs(workspace.NPCs:GetDescendants()) do
                    if table.find({"Weak Nomu 1","Weak Nomu 2","Weak Nomu 3","Weak Nomu 4"}, v.Name) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        if v.Humanoid.Health > 0 then
                            table.insert(targets, v)
                        end
                    end
                end
                
                for _, target in pairs(targets) do
                    if not _G.AutoFarm then break end

                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local goalCFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, -30, 0)

                        local tween = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = goalCFrame})
                        tween:Play()
                        tween.Completed:Wait()

                
                        local args = {
                            [1] = CFrame.new(target.HumanoidRootPart.Position)  -- ใช้ตำแหน่งของเป้าหมาย
                        }
                        local swing = LocalPlayer.Character:FindFirstChild("Main") and LocalPlayer.Character.Main:FindFirstChild("Swing")
                            for i = 1, 50 do
                            if swing and hrp and target.Humanoid.Health > 0 then
                                swing:FireServer(hrp.Position, hrp)
                            end
                        end

                        task.wait(0.09)
                    end
                end
        end)
        task.wait(0.05)  -- Adjust the delay for optimal performance
    end
end)
Options.AutoFN:SetValue(false)









local Toggle = Tabs.Main:AddToggle("AutoQ", {Title = "Auto Quest", Default = false })

    Toggle:OnChanged(function(state)
        _G.AutoQuest = state
        autoquestw()
    end)
Options.AutoQ:SetValue(false)


local Dropdown2 = Tabs.Main:AddDropdown("Dropdown", {
        Title = "เลือก Item ที่จะขาย",
        Values = {"Purse", "Damascus Knife", "Belt","Body Armor"},
        Multi = false,
        Default = 1,
    })

    Dropdown2:OnChanged(function(Value)
        SelectedItemConfig = Value
        do2r()
        print(itemid)
    end)



    Tabs.Main:AddButton({
        Title = "ขายไอเทม",
        Description = "ขายไอเทมทั้งหมดตามประเภทที่เลือก(รึเปล่า???????!!!!)",
        Callback = function()
            Window:Dialog({
                Title = "ขายไอเทม",
                Content = "ITEM ประเภทที่เลือกทั้งหมดจะถูกขาย",
                Buttons = {
                    {
                        Title = "จัดไปวัยรุ่น",
                        Callback = function()
                            autoSellItems()
                        end
                    },
                    {
                        Title = "หะ!?",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

    Tabs.Main:AddButton({
        Title = "anti afk",
        Description = "anti afk 20 นาที มั้งๆๆๆ",
        Callback = function()
            aafk()
        end
    })

   
    Tabs.Main:AddButton({
        Title = "ReJoin",
        Description = "รีจอย ยาสระผม555555",
        Callback = function()
            rejoinw()
        end
    })

   
























































            -- -- Attack the selected mob
            -- for _, mob in pairs(workspace.NPCs:GetChildren()) do
            --     if mob.Name == nameid and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            --         local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            --         local mobHRP = mob:FindFirstChild("HumanoidRootPart")

            --         if hrp and mobHRP then
            --             local goalCFrame = mobHRP.CFrame * CFrame.new(0, 0, 2)
            --             local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Linear)
            --             local tween = TweenService:Create(hrp, tweenInfo, {CFrame = goalCFrame})
            --             tween:Play()
            --             tween.Completed:Wait()

            --             LocalPlayer.Character:SetPrimaryPartCFrame(mobHRP.CFrame)

            --             local swing = LocalPlayer.Character:FindFirstChild("Main") and LocalPlayer.Character.Main:FindFirstChild("Swing")
            --             if swing then
            --                 local swingArgs = { mobHRP.Position, mobHRP }
            --                 for i = 1, 2 do
            --                     swing:FireServer(unpack(swingArgs))
            --                     task.wait(0.1)
            --                 end
            --             end

            --             task.wait(0.1)
            --         end
            --     end
            -- end







    

    -- Tabs.Main:AddParagraph({
    --     Title = "Paragraph",
    --     Content = "This is a paragraph.\nSecond line!"
    -- })



    -- Tabs.Main:AddButton({
    --     Title = "Button",
    --     Description = "Very important button",
    --     Callback = function()
    --         Window:Dialog({
    --             Title = "Title",
    --             Content = "This is a dialog",
    --             Buttons = {
    --                 {
    --                     Title = "Confirm",
    --                     Callback = function()
    --                         print("Confirmed the dialog.")
    --                     end
    --                 },
    --                 {
    --                     Title = "Cancel",
    --                     Callback = function()
    --                         print("Cancelled the dialog.")
    --                     end
    --                 }
    --             }
    --         })
    --     end
    -- })


    -- local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Toggle", Default = false })

    -- Toggle:OnChanged(function()
    --     print("Toggle changed:", Options.MyToggle.Value)
    -- end)

    -- Options.MyToggle:SetValue(false)


    -- local Slider = Tabs.Main:AddSlider("Slider", {
    --     Title = "Slider",
    --     Description = "This is a slider",
    --     Default = 2,
    --     Min = 0,
    --     Max = 5,
    --     Rounding = 1,
    --     Callback = function(Value)
    --         print("Slider was changed:", Value)
    --     end
    -- })

    -- Slider:OnChanged(function(Value)
    --     print("Slider changed:", Value)
    -- end)

    -- Slider:SetValue(3)



    -- local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
    --     Title = "Dropdown",
    --     Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
    --     Multi = false,
    --     Default = 1,
    -- })

    -- Dropdown:SetValue("four")

    -- Dropdown:OnChanged(function(Value)
    --     print("Dropdown changed:", Value)
    -- end)


    
    -- local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdown", {
    --     Title = "Dropdown",
    --     Description = "You can select multiple values.",
    --     Values = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen"},
    --     Multi = true,
    --     Default = {"seven", "twelve"},
    -- })

    -- MultiDropdown:SetValue({
    --     three = true,
    --     five = true,
    --     seven = false
    -- })

    -- MultiDropdown:OnChanged(function(Value)
    --     local Values = {}
    --     for Value, State in next, Value do
    --         table.insert(Values, Value)
    --     end
    --     print("Mutlidropdown changed:", table.concat(Values, ", "))
    -- end)



    -- local Colorpicker = Tabs.Main:AddColorpicker("Colorpicker", {
    --     Title = "Colorpicker",
    --     Default = Color3.fromRGB(96, 205, 255)
    -- })

    -- Colorpicker:OnChanged(function()
    --     print("Colorpicker changed:", Colorpicker.Value)
    -- end)
    
    -- Colorpicker:SetValueRGB(Color3.fromRGB(0, 255, 140))



    -- local TColorpicker = Tabs.Main:AddColorpicker("TransparencyColorpicker", {
    --     Title = "Colorpicker",
    --     Description = "but you can change the transparency.",
    --     Transparency = 0,
    --     Default = Color3.fromRGB(96, 205, 255)
    -- })

    -- TColorpicker:OnChanged(function()
    --     print(
    --         "TColorpicker changed:", TColorpicker.Value,
    --         "Transparency:", TColorpicker.Transparency
    --     )
    -- end)



    -- local Keybind = Tabs.Main:AddKeybind("Keybind", {
    --     Title = "KeyBind",
    --     Mode = "Toggle", -- Always, Toggle, Hold
    --     Default = "LeftControl", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

    --     -- Occurs when the keybind is clicked, Value is `true`/`false`
    --     Callback = function(Value)
    --         -- print("Keybind clicked!", Value)
    --     end,

    --     -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    --     ChangedCallback = function(New)
    --         -- print("Keybind changed!", New)
    --     end
    -- })

    -- -- OnClick is only fired when you press the keybind and the mode is Toggle
    -- -- Otherwise, you will have to use Keybind:GetState()
    -- Keybind:OnClick(function()
    --     -- print("Keybind clicked:", Keybind:GetState())
    -- end)

    -- Keybind:OnChanged(function()
    --     -- print("Keybind changed:", Keybind.Value)
    -- end)

    -- task.spawn(function()
    --     while true do
    --         wait(1)

    --         -- example for checking if a keybind is being pressed
    --         local state = Keybind:GetState()
    --         if state then
    --             -- print("Keybind is being held down")
    --         end

    --         if Fluent.Unloaded then break end
    --     end
    -- end)

    -- Keybind:SetValue("MB2", "Toggle") -- Sets keybind to MB2, mode to Hold


    -- local Input = Tabs.Main:AddInput("Input", {
    --     Title = "Input",
    --     Default = "Default",
    --     Placeholder = "Placeholder",
    --     Numeric = false, -- Only allows numbers
    --     Finished = false, -- Only calls callback when you press enter
    --     Callback = function(Value)
    --         print("Input changed:", Value)
    --     end
    -- })

    -- Input:OnChanged(function()
    --     print("Input updated:", Input.Value)
    -- end)
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "XyLa",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
