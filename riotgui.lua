if sharedid ~= "penis" then
    return
end

-- Services
local player = game:GetService("Players").LocalPlayer
local players = game:GetService("Players")
local self = player.Character
local playergui = player.PlayerGui
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local coregui = game:GetService("CoreGui")
local vu = game:GetService("VirtualUser")

-- Variables

local ExploitName = "Riot"

local random = Random.new()
local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',"{","}","(",")","[","]",".",",","?","/"}
local killdistance = 4
local predictions = 2

-- Functions

function CreateInstance(cls,props)
    local inst = Instance.new(cls)
    for i,v in pairs(props) do
        inst[i] = v
    end
    return inst
end

function corner(parent,sizex,sizey)
    local c = CreateInstance("UICorner",{CornerRadius=UDim.new(sizex,sizey),Parent=parent})
end

function getRandomLetter()
	return letters[random:NextInteger(1,#letters)]
end

function getRandomString(length, includeCapitals)
	local length = length or 10
	local str = ''
	for i=1,length do
		local randomLetter = getRandomLetter()
		if includeCapitals and random:NextNumber() > .5 then
			randomLetter = string.upper(randomLetter)
		end
		str = str .. randomLetter
	end
	return str
end

function dragify(inputobj,obj,dampening)
    local dragInput
    local dragStart
    local startPos
    local dragging = false

    local function update(input)
        local delta = input.Position - dragStart
        ts:Create(obj,TweenInfo.new(dampening),{Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
    end
    
    inputobj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
    
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    inputobj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

--[[
local function get_player(s)
    s = s:lower() -- Remove this if you want case sensitivity
    for _, p in ipairs(players:GetPlayers()) do
        if s == p.Name:lower() then
            return p
        end
    end
    return nil
end

local function get_nick(s)
    s = s:lower() -- Remove this if you want case sensitivity
    for _, p in ipairs(players:GetPlayers()) do
        if s == p.DisplayName:lower():sub(1, #s) then
            return p
        end
    end
    return nil
end
--]]

function kill(enemy)
    self.HumanoidRootPart.CFrame = enemy.Character.HumanoidRootPart.CFrame*CFrame.new(0+enemy.Character.Humanoid.MoveDirection.X*predictions,-killdistance,-0.5+enemy.Character.Humanoid.MoveDirection.Z*predictions)*CFrame.Angles(math.rad(90),0,0)
    self.HumanoidRootPart.Velocity = Vector3.new(0,0,0)

    print(enemy.Character.Humanoid.MoveDirection)

    local ohTable1 = {
        ["KeyCode"] = Enum.KeyCode.X
    }

    game:GetService("ReplicatedStorage").Remotes.MainRemote:FireServer(ohTable1)

    vu:CaptureController()
    vu:ClickButton1(Vector2.new(0.5,0.5))
end

-- Main Script

local Gui = CreateInstance("ScreenGui",{ResetOnSpawn=false,Parent=coregui,Name=getRandomString(25,true)})
local Frame = CreateInstance("Frame",{BackgroundColor3=Color3.fromRGB(31, 31, 31),Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0.25,0,0.265,0),Visible=true,Parent=Gui})
local SideBar = CreateInstance("Frame",{BackgroundColor3=Color3.fromRGB(26, 26, 26),Position=UDim2.new(0,0,0,0),Size=UDim2.new(0.25,0,1,0),Visible=true,Parent=Frame})
local TopBar = CreateInstance("Frame",{BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(26, 26, 26),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,0.1,0),Visible=true,Parent=Frame})
local TabsList = CreateInstance("Frame",{BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(153, 153, 153),Position=UDim2.new(0.1,0,0.25,0),Size=UDim2.new(0.8,0,0.7,0),Visible=true,Parent=SideBar})
local Tabs = CreateInstance("Frame",{BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(153, 153, 153),Position=UDim2.new(0.25,0,0,0),Size=UDim2.new(0.75,0,1,0),Visible=true,Parent=Frame})
local Decoration1 = CreateInstance("Frame",{BackgroundColor3=Color3.fromRGB(255, 255, 255),Position=UDim2.new(0.1,0,0.15,0),Size=UDim2.new(0.8,0,0.0125,0),Visible=true,Parent=SideBar})
local Title = CreateInstance("TextLabel",{Text=ExploitName,Font=Enum.Font.SourceSansLight,TextSize=24,TextTransparency=0,TextColor3=Color3.fromRGB(209, 209, 209),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 255, 255),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=SideBar})

-- Tabs

local FunctionsTab = CreateInstance("Frame",{Name="Functions",BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(153, 153, 153),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0),Visible=false,Parent=Tabs})
local HomeTab = CreateInstance("Frame",{Name="Home",BackgroundTransparency=0.3,BackgroundColor3=Color3.fromRGB(125, 118, 167),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0),Visible=false,Parent=Tabs})
local SettingsTab = CreateInstance("Frame",{Name="Settings",BackgroundTransparency=0.3,BackgroundColor3=Color3.fromRGB(255, 43, 43),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0),Visible=false,Parent=Tabs})

local FunctionsTab_AutoKill = CreateInstance("Frame",{Name="AutoKill",BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 43, 43),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0),Visible=true,Parent=FunctionsTab})
local ui = CreateInstance('UIGridLayout',{CellPadding=UDim2.new(0,0,0,0),CellSize=UDim2.new(1,0,0.33333333333,0),Parent=FunctionsTab_AutoKill})

local FunctionsTab_PlayerEffects = CreateInstance("Frame",{Name="PlayerEffects",BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 43, 43),Position=UDim2.new(0,0,0,0),Size=UDim2.new(1,0,1,0),Visible=true,Parent=FunctionsTab})
local ui3 = CreateInstance('UIGridLayout',{CellPadding=UDim2.new(0,0,0,0),CellSize=UDim2.new(1,0,0.33333333333,0),Parent=FunctionsTab_PlayerEffects})

local FunctionsTab_KillUserTextBox = CreateInstance("TextBox",{ClearTextOnFocus=false,PlaceholderText="Kill User...",Text="",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=0.75,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=FunctionsTab_AutoKill})
local FunctionsTab_DistanceTextBox = CreateInstance("TextBox",{ClearTextOnFocus=false,PlaceholderText="Set Kill Distance...",Text="",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=0.75,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=FunctionsTab_AutoKill})
local FunctionsTab_PredictionsTextBox = CreateInstance("TextBox",{ClearTextOnFocus=false,PlaceholderText="Set Kill Prediction...",Text="",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=0.75,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=FunctionsTab_AutoKill})

local FunctionsTab_InfiniteStaminaToggle = CreateInstance("Frame",{BackgroundTransparency=0.75,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=FunctionsTab_PlayerEffects})
local FunctionsTab_InfiniteStaminaText = CreateInstance("TextLabel",{ZIndex=3,Text="Infinite Stamina",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0.35,0,0,0),Size=UDim2.new(0.3,0,1,0),Visible=true,Parent=FunctionsTab_InfiniteStaminaToggle})
local FunctionsTab_InfiniteStaminaButton = CreateInstance("TextButton",{ZIndex=2,Text="",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=1,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=0,BackgroundColor3=Color3.fromRGB(255, 0, 0),Position=UDim2.new(1,0,0.05,0),Size=UDim2.new(0.125,0,1,0),Visible=true,Parent=FunctionsTab_InfiniteStaminaText})

local FunctionsTab_NoHitDelayToggle = CreateInstance("Frame",{BackgroundTransparency=0.75,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=FunctionsTab_PlayerEffects})
local FunctionsTab_NoHitDelayText = CreateInstance("TextLabel",{ZIndex=3,Text="No Hit Delay",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(24, 24, 24),Position=UDim2.new(0.35,0,0,0),Size=UDim2.new(0.3,0,1,0),Visible=true,Parent=FunctionsTab_NoHitDelayToggle})
local FunctionsTab_NoHitDelayButton = CreateInstance("TextButton",{ZIndex=2,Text="",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=1,TextColor3=Color3.fromRGB(255, 255, 255),BackgroundTransparency=0,BackgroundColor3=Color3.fromRGB(255, 0, 0),Position=UDim2.new(1,0,0.05,0),Size=UDim2.new(0.125,0,1,0),Visible=true,Parent=FunctionsTab_NoHitDelayText})

corner(FunctionsTab_PredictionsTextBox,0,2)
corner(FunctionsTab_DistanceTextBox,0,2)
corner(FunctionsTab_KillUserTextBox,0,2)
corner(FunctionsTab_InfiniteStaminaButton,0,2)
corner(FunctionsTab_InfiniteStaminaToggle,0,2)
corner(FunctionsTab_NoHitDelayButton,0,2)
corner(FunctionsTab_NoHitDelayToggle,0,2)

local ui2 = CreateInstance('UIGridLayout',{CellPadding=UDim2.new(0,0,0.025,0),CellSize=UDim2.new(1,0,0.175,0),Parent=FunctionsTab})

local isinfinitestamina = false
local isnohitdelay = false

FunctionsTab_NoHitDelayButton.MouseButton1Click:Connect(function()
    if isnohitdelay == false then
        isnohitdelay = true
        ts:Create(FunctionsTab_NoHitDelayButton,TweenInfo.new(0.75),{BackgroundColor3 = Color3.fromRGB(59, 255, 20),Rotation = 360}):Play()

        while isnohitdelay == true do
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == self:FindFirstChildWhichIsA("Tool").WeaponClient then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, 0)
                        end
                    end
                end
            end
            wait(0.5)
        end
    elseif isnohitdelay == true then
        ts:Create(FunctionsTab_NoHitDelayButton,TweenInfo.new(0.75),{BackgroundColor3 = Color3.fromRGB(255, 0, 0),Rotation = 0}):Play()
        isnohitdelay = false
    end
end)

FunctionsTab_InfiniteStaminaButton.MouseButton1Click:Connect(function()
    if isinfinitestamina == false then
        isinfinitestamina = true
        ts:Create(FunctionsTab_InfiniteStaminaButton,TweenInfo.new(0.75),{BackgroundColor3 = Color3.fromRGB(59, 255, 20),Rotation = 360}):Play()

        while isinfinitestamina == true do
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == playergui.Profile.StaminaMain then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, math.huge)
                        end
                    end
                end
            end
            wait(0.25)
        end
    elseif isinfinitestamina == true then
        ts:Create(FunctionsTab_InfiniteStaminaButton,TweenInfo.new(0.75),{BackgroundColor3 = Color3.fromRGB(255, 0, 0),Rotation = 0}):Play()
        isinfinitestamina = false
    end
end)

FunctionsTab_KillUserTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local enemy = nil
        local oldpos = self.HumanoidRootPart.CFrame

        --pcall(function()
            for i,v in ipairs(players:GetChildren()) do
                if string.lower(v.DisplayName) == string.lower(FunctionsTab_KillUserTextBox.Text) then
                    enemy = v

                    local tp = rs.RenderStepped:Connect(function()
                        kill(enemy)
                    end)

                    enemy.Character.Humanoid.HealthChanged:Connect(function(health)
                        if health < 0.01 then
                            self.HumanoidRootPart.CFrame = oldpos
                            tp:Disconnect()
                        end
                    end)

                    self.Humanoid.HealthChanged:Connect(function(health)
                        if health < 0.01 then
                            tp:Disconnect()
                        end            
                    end)
                elseif string.lower(v.Name) == string.lower(FunctionsTab_KillUserTextBox.Text) then
                    enemy = v

                    local tp = rs.RenderStepped:Connect(function()
                        kill(enemy)
                    end)

                    enemy.Character.Humanoid.HealthChanged:Connect(function(health)
                        if health < 0.01 then
                            self.HumanoidRootPart.CFrame = oldpos
                            tp:Disconnect()
                        end
                    end)

                    self.Humanoid.HealthChanged:Connect(function(health)
                        if health < 0.01 then
                            tp:Disconnect()
                        end            
                    end)
                end
            end
        --end)
    end
end)

FunctionsTab_DistanceTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        killdistance = tonumber(FunctionsTab_DistanceTextBox.Text)
    end
end)

FunctionsTab_PredictionsTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        predictions = tonumber(FunctionsTab_PredictionsTextBox.Text)
    end
end)

-- TabsList

local ui1 = CreateInstance('UIGridLayout',{CellPadding=UDim2.new(0,0,0,0),CellSize=UDim2.new(1,0,0.1,0),Parent=TabsList})

local HomeButton = CreateInstance("TextButton",{Text="Home",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(209, 209, 209),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 255, 255),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=TabsList})
local HomeValue = CreateInstance("StringValue",{Name="Tab",Value="Home",Parent=HomeButton})

local FunctionsButton = CreateInstance("TextButton",{Text="Functions",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(209, 209, 209),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 255, 255),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=TabsList})
local FunctionsValue = CreateInstance("StringValue",{Name="Tab",Value="Functions",Parent=FunctionsButton})

local SettingsButton = CreateInstance("TextButton",{Text="Settings",Font=Enum.Font.SourceSans,TextSize=16,TextTransparency=0,TextColor3=Color3.fromRGB(209, 209, 209),BackgroundTransparency=1,BackgroundColor3=Color3.fromRGB(255, 255, 255),Position=UDim2.new(0,0,0.05,0),Size=UDim2.new(1,0,0.075,0),Visible=true,Parent=TabsList})
local SettingsValue = CreateInstance("StringValue",{Name="Tab",Value="Settings",Parent=FunctionsButton})

local function opentab(tab)
    for i,v in ipairs(Tabs:GetChildren()) do
        print(i,v)
        v.Visible = false
    end

    Tabs[tab].Visible = true
end

local function tabbutton()
    for i,v in ipairs(TabsList:GetChildren()) do
        if v:IsA("TextButton") then
            v.MouseButton1Click:Connect(function()
                opentab(v.Tab.Value)
                local ClickEffect = CreateInstance("Frame",{Name="ClickEffect",BackgroundTransparency=0.3,BackgroundColor3=Color3.fromRGB(19, 19, 19),Position=UDim2.new(0.5,0,0,0),Size=UDim2.new(0,0,1,0),Visible=true,Parent=v})
                corner(ClickEffect,1,0)
                local sizeeffect = ts:Create(ClickEffect,TweenInfo.new(1),{Size=UDim2.new(1,0,1,0)}):Play()
                local positioneffect = ts:Create(ClickEffect,TweenInfo.new(1),{Position=UDim2.new(0,0,0,0)}):Play()
                local transparenteffect = ts:Create(ClickEffect,TweenInfo.new(1),{BackgroundTransparency=1})

                transparenteffect:Play()
                transparenteffect.Completed:Wait()
                ClickEffect:Destroy()
            end)
        end
    end
end

rs.RenderStepped:Connect(function()
    player = game:GetService("Players").LocalPlayer
    self = player.Character
    playergui = player.PlayerGui
end)

player.Chatted:Connect(function(msg)
    if msg == "!ping" then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), "ALL")
    end
end)

tabbutton()

-- Corners

corner(Decoration1,1,0)
corner(FunctionsTab_KillUserTextBox,2,0)
corner(SideBar,0,2)
corner(Frame,0,2)

-- Drag

dragify(TopBar,Frame,0.2)
