for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
    if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
    game:GetService("RunService").Heartbeat:connect(function()
    v.Velocity = Vector3.new(45,0,0)
    end)
    end
    end
    --[[
                                             _                   
                                            | |                  
    __   ___ __    __ _ _ __  _   ___      _| |__   ___ _ __ ___ 
    \ \ / / '__|  / _` | '_ \| | | \ \ /\ / / '_ \ / _ \ '__/ _ \
     \ V /| |    | (_| | | | | |_| |\ V  V /| | | |  __/ | |  __/
      \_/ |_|     \__,_|_| |_|\__, | \_/\_/ |_| |_|\___|_|  \___|
                               __/ |
                              |___/ 
    
     _                 _            _                            
    | |               | |          | |                           
    | |__  _   _   ___| | _____  __| |                           
    | '_ \| | | | / __| |/ / _ \/ _` |                           
    | |_) | |_| | \__ \   <  __/ (_| |                           
    |_.__/ \__, | |___/_|\_\___|\__,_|                           
            __/ |                                                
           |___/
           
       __ _              _ 
      / _(_)            | |
     | |_ ___  _____  __| |
     |  _| \ \/ / _ \/ _` |
     | | | |>  <  __/ (_| |
     |_| |_/_/\_\___|\__,_|
    
    (Credit to 64Will64 for first managing to fix the script before I did!)
    ]]
    
    spawn(function()
        while true do
            settings().Physics.AllowSleep = false
            setsimulationradius(math.huge*math.huge,math.huge*math.huge)
            game:GetService("RunService").Heartbeat:wait()
        end
    end)
    
    local options = {}
    
    -- OPTIONS:
    
    options.enabletorso = false -- enable this to disable torso
    options.hidecharacter = true

    options.MoveSpeed = 1
    options.runningmovespeed = 1.45

    options.MoveUpSpeed = 2
    options.mode = "normal" -- fly normal teleport
    options.movewithhand = true
    
    options.height = 4
    options.headscale = 1.25 -- how big you are in vr, 1 is default, 3 is recommended for max comfort in vr
    options.handscale = 1.35 -- divides your hand size
    options.handtranspareny = 0 -- (other players cannot see this).
    options.forcebubblechat = true -- decide if to force bubblechat so you can see peoples messages
    
    options.headhat = "MedivalBikeHelmet" -- name of the accessory which you are using as a head
    options.torsohat = "SeeMonkey"
    options.righthandhat = "Pal Hair" -- name of the accessory which you are using as your right hand
    options.lefthandhat = "LavanderHair" -- name of the accessory which you are using as your left hand
    
    options.righthandrotoffset = Vector3.new(0,0,0)
    options.lefthandrotoffset = Vector3.new(0,0,0)
    
    --
    
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character
    
    local VRService = game:GetService("VRService")
    local input = game:GetService("UserInputService")
    
    local cam = workspace.CurrentCamera
    cam.CameraType = "Scriptable"
    cam.HeadScale = options.headscale
    
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
    game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)
    game:GetService("VRService"):RecenterUserHeadCFrame()

    local playerModule = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
    playerModule:GetControls():Disable()
    local VRFolder = game.Workspace.CurrentCamera:WaitForChild("VRCorePanelParts", math.huge)
    spawn(function() while true do pcall(function() VRFolder:WaitForChild("UserGui", math.huge).Parent = nil end) end end)
    
    local function createpart(size, name)
        local Part = Instance.new("Part", char)
        Part.CFrame = char.HumanoidRootPart.CFrame
        Part.Size = size/options.handscale
        Part.Transparency = options.handtranspareny
        Part.CanCollide = false
        Part.Material = Enum.Material.SmoothPlastic
        Part.Anchored = true
        Part.Name = name
        return Part
    end
    
    local moveHandL = createpart(Vector3.new(1,1,2), "moveRH")
    local moveHandR = createpart(Vector3.new(1,1,2), "moveLH")
    local moveHead = createpart(Vector3.new(1,1,1), "moveH")

    if options.enabletorso == true then
        _G.moveTorso = createpart(Vector3.new(1,2,1), "moveT")
    end
    
    local handL
    local handR
    local head

    if options.enabletorso == true then
        _G.torso = nil
    end

    local R1down = false
    
    for i,v in pairs(char.Humanoid:GetAccessories()) do
        if v:FindFirstChild("Handle") then
            local handle = v.Handle
            
            if options.enable_G.torso == true then
                if v.Name == options.torsohat and not torso then
                    handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
                    _G.torso = v
                    handle.Transparency = 1
                end
            end
            
            if v.Name == options.righthandhat and not handR then
                handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
                handR = v
                handle.Transparency = 1
            elseif v.Name == options.lefthandhat and not handL then
                handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
                handL = v
                handle.Transparency = 1
            elseif v.Name == options.headhat and not head then
                handle.Transparency = 1
                head = v
            end
        end
    end
    
    char.Humanoid.AnimationPlayed:connect(function(anim)
        anim:Stop()
    end)
    
    for i,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
        v:AdjustSpeed(0)
    end
    
    local t = char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso")
    
    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position)
    
    input.UserCFrameChanged:connect(function(part,move)
        if part == Enum.UserCFrame.Head then
            --move(head,cam.CFrame*move)
            moveHead.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move)
        elseif part == Enum.UserCFrame.LeftHand then
            --move(handL,cam.CFrame*move)
            moveHandL.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
        elseif part == Enum.UserCFrame.RightHand then
            --move(handR,cam.CFrame*move)
            moveHandR.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
        end
    end)
    
    local function Align(Part1,Part0,CFrameOffset) -- i dont know who made this function but 64will64 sent it to me so credit to whoever made it
        local AlignPos = Instance.new('AlignPosition', Part1);
        AlignPos.Parent.CanCollide = false;
        AlignPos.ApplyAtCenterOfMass = true;
        AlignPos.MaxForce = 67752;
        AlignPos.MaxVelocity = math.huge/9e110;
        AlignPos.ReactionForceEnabled = false;
        AlignPos.Responsiveness = 200;
        AlignPos.RigidityEnabled = false;
        local AlignOri = Instance.new('AlignOrientation', Part1);
        AlignOri.MaxAngularVelocity = math.huge/9e110;
        AlignOri.MaxTorque = 67752;
        AlignOri.PrimaryAxisOnly = false;
        AlignOri.ReactionTorqueEnabled = false;
        AlignOri.Responsiveness = 200;
        AlignOri.RigidityEnabled = false;
        local AttachmentA=Instance.new('Attachment',Part1);
        local AttachmentB=Instance.new('Attachment',Part0);
        AttachmentB.CFrame = AttachmentB.CFrame * CFrameOffset
        AlignPos.Attachment0 = AttachmentA;
        AlignPos.Attachment1 = AttachmentB;
        AlignOri.Attachment0 = AttachmentA;
        AlignOri.Attachment1 = AttachmentB;
    end
    
    head.Handle:BreakJoints()
    handR.Handle:BreakJoints()
    handL.Handle:BreakJoints()
    _G.torso.Handle:BreakJoints()
    
    Align(head.Handle,moveHead,CFrame.new(0,0,0))
    Align(_G.torso.Handle,_G.moveTorso,CFrame.new(0,0,0))
    Align(handR.Handle,moveHandR,CFrame.new(0,0,0))
    Align(handL.Handle,moveHandL,CFrame.new(0,0,0))

    local MoveY = 0
    local MoveX = 0
    local MoveYR = 0

    local CurrentMoveSpeed = options.MoveSpeed
    
    input.InputChanged:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.ButtonR3 then
            if key.Position.Z > 0.01 then
                if (options.mode == "fly") then
                    R1down = true
                end
            else
                R1down = false
            end
        elseif key.KeyCode == Enum.KeyCode.Thumbstick1 then
            MoveY = key.Position.Y
            MoveX = key.Position.X
        elseif key.KeyCode == Enum.KeyCode.Thumbstick2 then
			MoveYR = key.Position.Y
        end
    end)
    
    input.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.ButtonR3 then
            if options.mode == "fly" then
                R1down = true
            end
        end
        if key.KeyCode == Enum.KeyCode.ButtonL3 then
            if options.mode == "normal" then
                CurrentMoveSpeed = options.runningmovespeed
            end
        end
    end)
    
    input.InputEnded:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.ButtonR3 then
            if (options.mode == "fly") then
                R1down = false
            elseif (options.mode == "teleport") then
                local origin = moveHandR.Position
                local direction = moveHandR.CFrame.LookVector * 100
                local raycastResult = game.Workspace:Raycast(origin, direction, RaycastParams.new())

                if raycastResult then
                    if raycastResult.Instance.Parent ~= char then
                        local cameraAngles = cam.CFrame - cam.CFrame.Position
                        local headCFrame = game:GetService("VRService"):GetUserCFrame(Enum.UserCFrame.Head)

                        cam.CFrame = CFrame.new(raycastResult.Position + Vector3.new(0, options.height + headCFrame.Position.Y, 0) - headCFrame.Position) * cameraAngles
                    end
                end
            end
        end
        if key.KeyCode == Enum.KeyCode.ButtonL3 then
            if options.mode == "normal" then
                CurrentMoveSpeed = options.MoveSpeed
            end
        end
    end)
    
    local function gprtc(cf)
        return cam.CFrame*CFrame.new(cf.Position*cam.HeadScale) * (cf - cf.Position)
    end
    
    game:GetService("RunService").RenderStepped:connect(function()
        _G.moveTorso.CFrame = moveHead.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0)
        --char.HumanoidRootPart.CFrame = CFrame.new(0,1000,0)

        if (options.mode == "normal") then      
            local offsetCFrameUp = CFrame.new(gprtc(char.HumanoidRootPart.CFrame).RightVector)
            local offsetCFrameR = CFrame.new(gprtc(VRService:GetUserCFrame(Enum.UserCFrame.Head)).RightVector)
            local offsetCFrame = CFrame.new(gprtc(VRService:GetUserCFrame(Enum.UserCFrame.Head)).LookVector)
	        cam.CFrame = (cam.CFrame:ToWorldSpace(CFrame.new(offsetCFrame.X/3*MoveY*CurrentMoveSpeed, 0, offsetCFrame.Z/3*MoveY*options.MoveSpeed)))
            cam.CFrame = (cam.CFrame:ToWorldSpace(CFrame.new(0,  offsetCFrameUp.Z/3*MoveYR*options.MoveUpSpeed,0)))
            cam.CFrame = (cam.CFrame:ToWorldSpace(CFrame.new(offsetCFrameR.X/3*MoveX*CurrentMoveSpeed, 0, offsetCFrameR.Z/3*MoveX*options.MoveSpeed)))
        end
        if R1down then
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
            
            if options.movewithhand == true then
                cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (moveHandR.CFrame*CFrame.Angles(-math.rad(options.righthandrotoffset.X),-math.rad(options.righthandrotoffset.Y),math.rad(180-options.righthandrotoffset.X))).LookVector * cam.HeadScale/2, 0.5)
            elseif options.movewithhand == false then
                cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (moveHead.CFrame*CFrame.Angles(0,0,0)).LookVector * cam.HeadScale/2, 0.5)
            end
        end
    end)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {char}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    game:GetService("RunService").Stepped:Connect(function()
    end)
    
    local function bubble(plr,msg)
        game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
    end
    
    if options.forcebubblechat == true then
        game.Players.PlayerAdded:Connect(function(plr)
            plr.Chatted:connect(function(msg)
                game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
            end)
        end)
    end
        
    for i,v in pairs(game.Players:GetPlayers()) do
        v.Chatted:connect(function(msg)
            game:GetService("Chat"):Chat(v.Character.Head,msg,Enum.ChatColor.White)
        end)
    end
