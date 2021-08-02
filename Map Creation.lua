local library = {}

local tweenservice = game:GetService("TweenService")
local floor = 250

makefolder("Custom Maps")
writefile("Custom Maps/Documentation.DOC")

function library:Setup(height)
    pcall(function()
        if workspace.CurrentCamera.CustomMap then
            workspace.CurrentCamera.CustomMap:Destroy()
        end
    end)

    local folder = Instance.new("Folder")
    folder.Name = "CustomMap"
    folder.Parent = workspace.CurrentCamera

    local buildings = Instance.new("Folder")
    buildings.Name = "Buildings"
    buildings.Parent = folder

    local objects = Instance.new("Folder")
    objects.Name = "Objects"
    objects.Parent = folder

    floor = height

    return folder,buildings,objects,floor
end

function library:FetchPlayer()
    local player = game:GetService("Players").LocalPlayer

    return player
end

function library:SetPlayerPosition(player,position)
    player.Character.HumanoidRootPart.CFrame = position
end

function library:Build(name,parent,placetime,buildtime,position,size,transparency,material)
    local part = Instance.new("Part")
    part.Name = name
    part.Material = material
    part.Parent = parent
    part.Transparency = transparency
    part.CFrame = CFrame.new(position.X,0,position.Z)
    part.Size = Vector3.new(size.X/7.5,size.Y,size.Z/7.5)
    part.Anchored = true

    local tweenb = tweenservice:Create(part, TweenInfo.new(placetime), {CFrame = position})
    tweenb:Play()
    tweenb.Completed:Wait()

    local tweena = tweenservice:Create(part, TweenInfo.new(buildtime), {Size = size})
    tweena:Play()
    tweena.Completed:Wait()
end

function library:Chair(obj,debounce)
    local sitdebounce = false
    
    obj.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") then
            if sitdebounce == false then
                sitdebounce = true
    
                hit.Parent:FindFirstChild("Humanoid").Sit = true
                hit.Parent:FindFirstChild("HumanoidRootPart").CFrame = buildings.chairsit.CFrame*CFrame.new(0,1,0)
                
                wait(debounce)
    
                sitdebounce = false
            end
        end
    end)
end

return library
