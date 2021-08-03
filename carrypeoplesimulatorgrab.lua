local player = nil
local playersservice = game:GetService("Players")
local players = game:GetService("Players"):GetChildren()
local self = game:GetService("Players").LocalPlayer
local originalpos = self.Character.HumanoidRootPart.CFrame

local humanoid = self.Character.Humanoid

--Options

local keybind = Enum.KeyCode.LeftBracket

--Services

local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")

local function CreateInstance(cls,props)
    local inst = Instance.new(cls)
    for i,v in pairs(props) do
        inst[i] = v
    end
    return inst
end

local function corner(parent,roundness)
    local c = Instance.new("UICorner")
    c.Parent = parent
    c.CornerRadius = UDim.new(0,roundness)
end

local gui = CreateInstance('ScreenGui',{Parent = self.PlayerGui,ResetOnSpawn=false})
local frame = CreateInstance('Frame',{Parent=gui,Style=Enum.FrameStyle.Custom,Size=UDim2.new(0.1,0,0.1,0),Position=UDim2.new(0.5,0,0.5,0)})
local dropdownbutton = CreateInstance('TextButton',{Parent=frame,BackgroundTransparency = 1,Size=UDim2.new(1,0,0.25,0),Position=UDim2.new(0,0,0.5,0),TextSize=20,Text="None",Font=Enum.Font.ArialBold})
local bringbutton = CreateInstance('TextButton',{Parent=frame,BackgroundTransparency = 1,Size=UDim2.new(1,0,0.25,0),Position=UDim2.new(0,0,0.75,0),TextSize=20,Text="Bring",Font=Enum.Font.Arial})

corner(frame,2)
corner(dropdownbutton,2)

local dropdown = CreateInstance('ScrollingFrame',{Parent=frame,Size=UDim2.new(0.75,0,1,0),CanvasSize=UDim2.new(0,0,20,0),Position=UDim2.new(-0.75,0,0,0),Visible=false,BackgroundTransparency=0})
local ui = CreateInstance('UIGridLayout',{CellPadding=UDim2.new(0,0,0,0),CellSize=UDim2.new(0,math.floor(dropdown.AbsoluteSize.X)-1,0,math.floor(dropdown.AbsoluteSize.Y/5)-1),Parent=dropdown})
local isdroppeddown = false
local spectatedplayer = nil
local isspectated = false

uis.InputBegan:Connect(function(key)
    if key.KeyCode == keybind then
        workspace.CurrentCamera.CameraSubject = self.Character
        isspectated = not isspectated
    end
end)

dropdownbutton.MouseButton1Down:Connect(function()
    if isdroppeddown == false then
        isdroppeddown = true
        dropdown.Visible = true
    elseif isdroppeddown == true then
        isdroppeddown = false
        dropdown.Visible = false
    end
end)

bringbutton.MouseButton1Down:Connect(function()
    if player ~= nil then
        originalpos = self.Character.HumanoidRootPart.CFrame
        self.Character.HumanoidRootPart.CFrame = game:GetService("Players")[player].Character.HumanoidRootPart.CFrame
        pcall(function()humanoid:EquipTool(self.Backpack.Carry)end)

        wait(0.35)
        
        local ohInstance1 = game:GetService("Players")[player]
        game:GetService("ReplicatedStorage").ArrestFunction:InvokeServer(ohInstance1)
        
        wait(0.35)
        
        self.Character.HumanoidRootPart.CFrame = originalpos
    end
end)

runservice.RenderStepped:Connect(function()
    if isspectated == true then
        workspace.CurrentCamera.CameraSubject = game:GetService("Players")[player].Character
    elseif isspectated == false then
        workspace.CurrentCamera.CameraSubject = self.Character
    end
end)

local function createbutton(v)
    v = game:GetService("Players")[v]
    local selfbutton = CreateInstance('TextButton',{Parent=dropdown,BackgroundTransparency = 0,Size=UDim2.new(1,0,0.25,0),Position=UDim2.new(0,0,0.5,0),TextScaled=true,Text=v.Name.." ("..v.DisplayName..")",Name=v.Name})
    corner(selfbutton,2)
    selfbutton.MouseButton1Down:Connect(function()
        player = v.Name
        dropdownbutton.Text = v.Name
    end)
end

for i,v in pairs(game.Players:GetChildren()) do
    createbutton(v.Name)
end

playersservice.PlayerRemoving:Connect(function(player)
    dropdown[player.name]:Destroy()
end)

playersservice.PlayerAdded:Connect(function(player)
    createbutton(player.Name)
end)

local tweenservice = game:GetService("TweenService")

local dragInput
local dragStart
local startPos
local dampening = 0.3

function dragify(obj)
    local dragging = false

    local function update(input)
        local delta = input.Position - dragStart
        tweenservice:Create(obj,TweenInfo.new(dampening),{Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
    end
    
    obj.InputBegan:Connect(function(input)
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
    
    obj.InputChanged:Connect(function(input)
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

dragify(frame)
dragify(dropdown)
