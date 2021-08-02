local library = {}

local tweenservice = game:GetService("TweenService")
local floor = 250

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

    makefolder("Custom Maps")

    floor = height

    return folder,buildings,objects,floor
end

function library:FetchPlayer()
    local player = game:GetService("Players").LocalPlayer

    return player
end

function library:SetPlayerPosition(player,position,delay)
    player.Character.HumanoidRootPart.CFrame = position
    player.Character.HumanoidRootPart.Anchored = true
    wait(delay)
    player.Character.HumanoidRootPart.Anchored = false
end

function library:Build(name,parent,placetime,buildtime,position,rotation,size,transparency,material)
    local part = Instance.new("Part")
    part.Name = name
    part.Material = material
    part.Parent = parent
    part.Transparency = transparency
    part.CFrame = CFrame.new(position.X,0,position.Z)
    part.Size = Vector3.new(size.X/7.5,size.Y,size.Z/7.5)
    part.Anchored = true

    local tweenb = tweenservice:Create(part, TweenInfo.new(placetime), {CFrame = position * rotation})
    tweenb:Play()
    tweenb.Completed:Wait()

    local tweena = tweenservice:Create(part, TweenInfo.new(buildtime), {Size = size})
    tweena:Play()
    tweena.Completed:Wait()
end

function library:Chair(obj,sitheight,debounce)
    local sitdebounce = false
    
    obj.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") then
            if sitdebounce == false then
                sitdebounce = true
    
                hit.Parent:FindFirstChild("Humanoid").Sit = true
                hit.Parent:FindFirstChild("HumanoidRootPart").CFrame = obj.CFrame*CFrame.new(0,sitheight,0)
                
                wait(debounce)
    
                sitdebounce = false
            end
        end
    end)
end

function library:LaunchPad(obj,height)
    obj.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") then
            local bv = Instance.new("BodyVelocity",hit.Parent:FindFirstChild("HumanoidRootPart"))
            bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            bv.Velocity = Vector3.new(0,1*height,0)
            wait(0.1)
            bv:Destroy()
        end
    end)
end

return library
