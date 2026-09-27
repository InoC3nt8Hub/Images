local LibraryURL =
    "https://raw.githubusercontent.com/InoC3nt8Hub/InoC3nt8-Obsidian/refs/heads/main/Library.lua"
    
local AddonRepo =
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"

local Library = loadstring(
    game:HttpGet(LibraryURL)
)()

local ThemeManager = loadstring(
    game:HttpGet(AddonRepo .. "addons/ThemeManager.lua")
)()

local SaveManager = loadstring(
    game:HttpGet(AddonRepo .. "addons/SaveManager.lua")
)()

local Options = Library.Options
local Toggles = Library.Toggles
Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true
Library.Scheme.BackgroundColor = Color3.fromRGB(0, 0, 0)
Library.Scheme.MainColor = Color3.fromRGB(0, 0, 0)
Library.Scheme.AccentColor = Color3.fromRGB(85, 217, 255)
Library.Scheme.OutlineColor = Color3.fromRGB(0, 0, 0)
Library.Scheme.FontColor = Color3.fromRGB(235, 250, 255)
Library.Scheme.RedColor = Color3.fromRGB(255, 75, 100)
Library.Scheme.DarkColor = Color3.fromRGB(2, 4, 7)
Library.Scheme.WhiteColor = Color3.fromRGB(255, 255, 255)

Library:Notify({
    Title = "Load Menu",
    Description = "Examination Script Loading",
    Icon = "info",
    Time = 4,
})

-- Window
local Window = Library:CreateWindow({
    Title = "InoC3nt8 Hub",
    Footer = "v1.0  •  ONLINE",

    Icon = 93633054316269,
    ToggleKeybind = Enum.KeyCode.RightShift,

    Center = true,
    AutoShow = true,
    Resizable = true,
    AlwaysOnTop = true,

    CornerRadius = 10,

    EnableSidebarResize = true,
    EnableCompacting = true,
    SidebarCompacted = false,

    MinSidebarWidth = 170,
    SidebarCompactWidth = 58,

    TabButtonsStyle = {
        Gap = 5,
        Padding = 6,
        CornerRadius = 7,

        Indicator = true,
        IndicatorWidth = 3,
        IndicatorHeight = 20,
    },

    Animations = {
        ToggleWindow = true,
        TabSwitch = true,
        Groupbox = true,
        Dropdown = true,
        KeyPicker = true,
    },

    TabTransitionTime = 0.16,
    TabSwipeOffset = 20,
    TabSwipeFrom = "bottom",

    ProfileCard = {
        Enabled = true,
        UserId = 0,
        DisplayName = "",
        Username = "",
        Height = 35,
    },
})

Window:SetAlwaysOnTop(true)
Window:SetAnimations({ ToggleWindow = true, TabSwitch = true, Groupbox = true, Dropdown = true, KeyPicker = true }, 0.10, 17, "bottom")


local DiscordInvite = "https://discord.gg/j5CvpeN7DZ"
local DiscordTab = Window:AddTab("Discord", "message-circle")

-- Tabs
local Tabs = {
    Main = Window:AddTab("Main", "house"),
    Combat = Window:AddTab("Combat", "crosshair"),
    Visual = Window:AddTab("Visual", "eye"),
    Misc = Window:AddTab("Misc", "wrench"),
    Settings = Window:AddTab("Settings", "cog"),
}

local Main = Tabs.Main

Main:UpdateWarningBox({
    Title = "📢・Dev Announcement ",
    Text = "Some features may be undetectable, while others may be detected by other players. Please use the script in Private Servers whenever possible. If your account gets banned because of using it, I am not responsible.",
    IsNormal = false, 
    Visible = true,
    LockSize = true,
})

local CommunityBox = DiscordTab:AddLeftGroupbox("Community Info", "crown")

CommunityBox:AddLabel(
    "Welcome to our community!\n\n"
    .. "• Script updates\n"
    .. "• Game support\n"
    .. "• Announcements\n"
    .. "• Community events\n"
    .. "• Support & feedback",
    true
)

CommunityBox:AddDivider()

CommunityBox:AddLabel("Discord Server: Online")

local DiscordBox = DiscordTab:AddLeftGroupbox("Discord", "external-link")

DiscordBox:AddButton({
    Text = "Join Discord",

    Func = function()

        if setclipboard then
            setclipboard(DiscordInvite)
        end

        Library:Notify({
            Title = "Discord",
            Description = "Invite link copied!",
            Time = 3
        })

        -- Opens Discord invite when supported by the executor
        pcall(function()
            if syn and syn.request then
                syn.request({
                    Url = DiscordInvite,
                    Method = "GET"
                })
            end
        end)

    end
})


DiscordBox:AddButton({
    Text = "Copy Invite Link",

    Func = function()

        if setclipboard then

            setclipboard(DiscordInvite)

            Library:Notify({
                Title = "Discord",
                Description = "Invite link copied to clipboard!",
                Time = 3
            })

        else

            Library:Notify({
                Title = "Discord",
                Description = DiscordInvite,
                Time = 5
            })

        end

    end
})

DiscordBox:AddDivider()

DiscordBox:AddLabel("Server Status")

local StatusLabel = DiscordBox:AddLabel(
    "● Checking...",
    false
)

local MemberLabel = DiscordBox:AddLabel(
    "Members: Checking...",
    false
)


task.spawn(function()

    while task.wait(30) do

        local Success, Response = pcall(function()

            return game:HttpGet(
                "https://discord.com/api/v10/invites/"
                .. DiscordInvite:match("discord.gg/(.+)$")
                .. "?with_counts=true"
            )

        end)

        if Success and Response then

            local Data = game:GetService("HttpService"):JSONDecode(Response)

            if Data and Data.approximate_presence_count then

                StatusLabel:SetText("● Server Online")

                MemberLabel:SetText(
                    "Members Online: "
                    .. tostring(Data.approximate_presence_count)
                )

            else

                StatusLabel:SetText("● Server Available")

            end

        else

            StatusLabel:SetText("● Status Unavailable")

            MemberLabel:SetText("Members: Unknown")

        end

    end

end)

StatusLabel:SetText("● Server Available")
MemberLabel:SetText("Members: Loading...")

local UpdateBox = DiscordTab:AddRightGroupbox("Update Logs","scroll-text")

UpdateBox:AddLabel([[
Examination V1.0

+ Testing
]], true)

--------------------------------------------------
-- MAIN TAB
--------------------------------------------------

local MainBox = Tabs.Main:AddLeftGroupbox("Main Features", "sword")
local MainBox2 = Tabs.Combat:AddLeftGroupbox("Gun Modifier Features", "crosshair")
local MainBox3 = Tabs.Main:AddRightGroupbox("Player Modifier Features", "user")
local MainBox4 = Tabs.Combat:AddRightGroupbox("Aimbot Features", "bot")
local MainBox5 = Tabs.Combat:AddRightGroupbox("SilentAim & Triggerbot", "bot")

--==============================================================
-- INSTANT PROMPT HOLD
-- PC + MOBILE | TOGGLE ON/OFF | AUTO DETECT
--==============================================================

local ProximityPromptService = game:GetService("ProximityPromptService")

local InstantPrompt = {
    Enabled = false,
    Connections = {}
}

--==============================================================
-- APPLY
--==============================================================

local function ApplyPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then
        return
    end

    if InstantPrompt.Enabled then
        prompt.HoldDuration = 0
    end
end

--==============================================================
-- SCAN ALL EXISTING PROMPTS
--==============================================================

local function ScanPrompts()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            ApplyPrompt(obj)
        end
    end
end

--==============================================================
-- NEW PROMPT DETECTION
--==============================================================

InstantPrompt.Connections.DescendantAdded =
    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("ProximityPrompt") then
            task.defer(function()
                ApplyPrompt(obj)
            end)
        end
    end)

--==============================================================
-- TOGGLE FUNCTION
--==============================================================

function InstantPrompt:SetEnabled(state)
    self.Enabled = state == true

    if self.Enabled then
        ScanPrompts()
    end
end

--==============================================================
-- TOGGLE
--==============================================================
MainBox:AddToggle("InstantPrompt", {
    Text = "Instant Prompt Hold",
    Default = false,

    Callback = function(Value)
        InstantPrompt:SetEnabled(Value)
    end
})



local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local ATTR = "infiniteStamina"
local guardConns = {}   
local enabled = false


local function setStamina(state)
    local char = lp.Character
    if char then
        char:SetAttribute(ATTR, state and true or nil)
    end
end


local function guard(char)
    if not char then return end
    local conn = char:GetAttributeChangedSignal(ATTR):Connect(function()
        if enabled and char:GetAttribute(ATTR) ~= true then
            char:SetAttribute(ATTR, true)
        end
    end)
    table.insert(guardConns, conn)
end


lp.CharacterAdded:Connect(function(char)

    for _, c in ipairs(guardConns) do c:Disconnect() end
    table.clear(guardConns)

    if enabled then
        task.wait(0.1)  
        char:SetAttribute(ATTR, true)
    end
    guard(char)
end)

--// Initial guard on current character
if lp.Character then guard(lp.Character) end


MainBox:AddToggle("InfStaminaToggle", {
    Text = "Infinite Stamina",
    Default = false,

    Callback = function(state)
        enabled = state
        setStamina(state)

        if state then
            print("[InfiniteStamina] ENABLED")
        else
            print("[InfiniteStamina] DISABLED")
        end
    end
})

--------------------------------------------------
-- ZERO RECOIL (Obsidian MainBox Toggle)
--------------------------------------------------

local _ZR_RS  = game:GetService("ReplicatedStorage")
local _ZR_UIS = game:GetService("UserInputService")
local _ZR_Run = game:GetService("RunService")
local _ZR_PL  = game:GetService("Players")
local _ZR_LP  = _ZR_PL.LocalPlayer
local _ZR_Cam = workspace.CurrentCamera

-- ============================================================
-- STATE + BACKUP STORAGE (for reversible toggle)
-- ============================================================
local ZR = {
    Enabled    = false,
    HooksReady = false,
    RenderConn = nil,
    EventConn  = nil,
    StateConn  = nil,
    Backup     = {},   -- stores original functions for restore
}

-- ============================================================
-- HELPER: safe require
-- ============================================================
local function _ZR_safeRequire(inst)
    if not inst then return nil end
    local ok, mod = pcall(require, inst)
    if ok then return mod end
    return nil
end

-- ============================================================
-- [1] HOOK SHARED SPRING MODULE (camera spring recoil source)
-- ============================================================
local function _ZR_hookSharedSpring()
    local Assets = _ZR_RS:FindFirstChild("Assets")
    if not Assets then return end
    local Modules = Assets:FindFirstChild("Modules")
    if not Modules then return end
    local SpringInst = Modules:FindFirstChild("Spring")
    if not SpringInst then return end

    local SpringModule = _ZR_safeRequire(SpringInst)
    if not SpringModule or not SpringModule.spring then return end

    local spring = SpringModule.spring

    -- Backup originals
    ZR.Backup.spring_Accelerate = spring.Accelerate
    ZR.Backup.spring_Impulse    = spring.Impulse
    ZR.Backup.spring_new        = spring.new

    -- Kill acceleration & impulse
    spring.Accelerate = function(self) return self end
    spring.Impulse    = function(self) return self end

    -- Neutralize future instances too
    if ZR.Backup.spring_new then
        spring.new = function(...)
            local s = ZR.Backup.spring_new(...)
            if s then
                s.Accelerate = function() return s end
                s.Impulse    = function() return s end
            end
            return s
        end
    end

    ZR.HooksReady = true
end

local function _ZR_unhookSharedSpring()
    local Assets = _ZR_RS:FindFirstChild("Assets")
    if not Assets then return end
    local Modules = Assets:FindFirstChild("Modules")
    if not Modules then return end
    local SpringInst = Modules:FindFirstChild("Spring")
    if not SpringInst then return end

    local SpringModule = _ZR_safeRequire(SpringInst)
    if not SpringModule or not SpringModule.spring then return end

    local spring = SpringModule.spring
    if ZR.Backup.spring_Accelerate then spring.Accelerate = ZR.Backup.spring_Accelerate end
    if ZR.Backup.spring_Impulse    then spring.Impulse    = ZR.Backup.spring_Impulse    end
    if ZR.Backup.spring_new        then spring.new        = ZR.Backup.spring_new        end
end

-- ============================================================
-- [2] HOOK LOCAL SPRING MODULE (viewmodel bob/sway)
-- ============================================================
local function _ZR_hookLocalSpring()
    local ok, localSpring = pcall(function()
        return _ZR_LP.PlayerScripts:WaitForChild("Spring", 3)
    end)
    if not ok or not localSpring then return end

    local mod = _ZR_safeRequire(localSpring)
    if not mod or not mod.new then return end

    local testVec = Vector3.new()
    local mt = getmetatable(mod.new(testVec))
    if not mt or not mt.__index then return end

    -- Backup original __index
    ZR.Backup.localSpring_index = mt.__index

    local oldIdx = mt.__index
    mt.__index = function(self, key)
        if key == "Impulse" or key == "Accelerate" or key == "Update" then
            return function() return self end
        end
        return oldIdx(self, key)
    end
end

local function _ZR_unhookLocalSpring()
    local ok, localSpring = pcall(function()
        return _ZR_LP.PlayerScripts:FindFirstChild("Spring")
    end)
    if not ok or not localSpring then return end

    local mod = _ZR_safeRequire(localSpring)
    if not mod or not mod.new then return end

    local testVec = Vector3.new()
    local mt = getmetatable(mod.new(testVec))
    if mt and ZR.Backup.localSpring_index then
        mt.__index = ZR.Backup.localSpring_index
    end
end

-- ============================================================
-- [3] FREEZE VIEWMODEL ROOT (kills fire recoil kick)
-- ============================================================
local function _ZR_freezeViewModelRoot()
    local terrain = workspace:FindFirstChild("Terrain")
    if not terrain then return end
    local ignore = terrain:FindFirstChild("Ignore")
    if not ignore then return end
    local vm = ignore:FindFirstChild(_ZR_LP.Name .. "viewmodel")
    if not vm then return end
    local hrp = vm:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local rj = hrp:FindFirstChild("RootJoint")
    if rj then
        rj.Transform = CFrame.new()
    end
end

-- ============================================================
-- [4] CONNECT FIRE EVENT (locks viewmodel every shot)
-- ============================================================
local function _ZR_connectFireEvent()
    local Events = _ZR_RS:FindFirstChild("Events")
    if not Events then return end
    local ClientEvent = Events:FindFirstChild("client")
    if not ClientEvent then return end

    ZR.EventConn = ClientEvent.Event:Connect(function(action)
        if not ZR.Enabled then return end
        if action == "fire" then
            _ZR_freezeViewModelRoot()
        end
    end)
end

-- ============================================================
-- [5] RENDER LOOP — keep viewmodel locked each frame
-- ============================================================
local function _ZR_startRenderLoop()
    if ZR.RenderConn then ZR.RenderConn:Disconnect() end
    ZR.RenderConn = _ZR_Run.RenderStepped:Connect(function()
        if not ZR.Enabled then return end
        pcall(_ZR_freezeViewModelRoot)
    end)
end

-- ============================================================
-- [6] ENABLE / DISABLE
-- ============================================================
local function _ZR_Enable()
    if ZR.Enabled then return end
    ZR.Enabled = true

    _ZR_hookSharedSpring()
    _ZR_hookLocalSpring()
    _ZR_connectFireEvent()
    _ZR_startRenderLoop()

    print("[ZeroRecoil] ✓ ENABLED — No Recoil / No Camera Kick active")
end

local function _ZR_Disable()
    if not ZR.Enabled then return end
    ZR.Enabled = false

    -- Restore original spring functions
    _ZR_unhookSharedSpring()
    _ZR_unhookLocalSpring()

    -- Disconnect loops
    if ZR.RenderConn then ZR.RenderConn:Disconnect(); ZR.RenderConn = nil end
    if ZR.EventConn  then ZR.EventConn:Disconnect();  ZR.EventConn  = nil end

    print("[ZeroRecoil] ✗ DISABLED — original recoil restored")
end

-- ============================================================
-- [7] OBSIDIAN UI — MainBox TOGGLE
-- ============================================================
MainBox:AddToggle("ZeroRecoil_Toggle", {
    Text     = "No Recoil",
    Default  = false,
    Callback = function(v)
        if v then
            _ZR_Enable()
        else
            _ZR_Disable()
        end
    end,
})

--==============================================================
-- RAPID FIRE MODULE — Obsidian UI Integration
-- Safe / No Crash / Toggle + Sliders
--==============================================================

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS               = game:GetService("UserInputService")

local LP = Players.LocalPlayer

--==============================================================
-- STATE
--==============================================================
local State = {
    Enabled          = false,
    FirePerSecond    = 60,
    RemoveFloodLimit = false,
    AutoFireOnTarget = false,
    AimAssistBoost   = false,
    AutoReload       = false,

    -- runtime
    _firing      = false,
    _thread      = nil,
    _aimThread   = nil,
    _autoReload  = nil,
    _origFireServer = nil,
    _fireRemote  = nil,
}

--==============================================================
-- HELPERS
--==============================================================

local function getCharacter()
    return LP.Character
end

local function getEquippedTool()
    local char = getCharacter()
    if not char then return nil end
    return char:FindFirstChildOfClass("Tool")
end

-- Auto-detect gun by common attributes (safe check)
local function isGun(tool)
    if not tool then return false end

    -- Try IsGun first
    if tool:GetAttribute("IsGun") == true then return true end

    -- Fallback: check common gun attributes
    local attrs = tool:GetAttributes()
    for name in pairs(attrs) do
        local lower = string.lower(name)
        if lower:find("ammo") or lower:find("clip")
           or lower:find("firemode") or lower:find("reload") then
            return true
        end
    end
    return false
end

local function isReloading(tool)
    if not tool then return false end
    return tool:GetAttribute("Reloading") == true
        or tool:GetAttribute("IsReloading") == true
end

local function getAmmo(tool)
    if not tool then return 0 end
    return tonumber(tool:GetAttribute("ClipCurrent"))
        or tonumber(tool:GetAttribute("Ammo"))
        or tonumber(tool:GetAttribute("CurrentAmmo"))
        or 0
end

local function getMaxAmmo(tool)
    if not tool then return 0 end
    return tonumber(tool:GetAttribute("ClipSize"))
        or tonumber(tool:GetAttribute("MaxAmmo"))
        or tonumber(tool:GetAttribute("MagSize"))
        or 0
end

--==============================================================
-- FIRE
--==============================================================

local function fireTool(tool)
    if not tool then return end
    pcall(function() tool:Activate() end)
end

--==============================================================
-- RELOAD
--==============================================================

local function tryReload(tool)
    if not tool then return end

    local reloadRemote = tool:FindFirstChild("Reload")
    if reloadRemote and reloadRemote:IsA("RemoteEvent") then
        pcall(function() reloadRemote:FireServer() end)
        return
    end

    local reloadFn = tool:FindFirstChild("Reload")
    if reloadFn and reloadFn:IsA("RemoteFunction") then
        pcall(function() reloadFn:InvokeServer() end)
        return
    end

    -- Fallback: activate tool
    pcall(function() tool:Activate() end)
end

--==============================================================
-- [1] FLOOD LIMIT BYPASS (safe wrapper on fire remote)
--==============================================================

local function installFloodBypass()
    if State._origFireServer then return end  -- already installed

    -- Find the actual fire remote
    task.spawn(function()
        local comm = ReplicatedStorage:FindFirstChild("Communication")
        local events = comm and comm:FindFirstChild("Events")
        local fireRemote = events and events:FindFirstChild("fire")

        if not fireRemote then
            warn("[RapidFire] fire remote not found — flood bypass disabled")
            return
        end

        State._fireRemote = fireRemote
        print("[RapidFire] Fire remote hooked:", fireRemote:GetFullName())
    end)
end

local function uninstallFloodBypass()
    State._fireRemote = nil
    State._origFireServer = nil
end

--==============================================================
-- [2] AUTO-FIRE ON TARGET
--==============================================================

local function installAutoFire()
    task.spawn(function()
        local cs = LP:FindFirstChild("ClientSettings")
        if not cs then
            cs = LP:WaitForChild("ClientSettings", 5)
        end
        if not cs then return end

        local mobile = cs:FindFirstChild("Mobile")
        if not mobile then
            mobile = cs:WaitForChild("Mobile", 5)
        end
        if not mobile then return end

        pcall(function()
            mobile:SetAttribute("AutoFireOnTargetEnabled", true)
            mobile:SetAttribute("AimAssistEnabled", true)
        end)
    end)
end

local function uninstallAutoFire()
    task.spawn(function()
        local cs = LP:FindFirstChild("ClientSettings")
        local mobile = cs and cs:FindFirstChild("Mobile")
        if not mobile then return end

        pcall(function()
            mobile:SetAttribute("AutoFireOnTargetEnabled", false)
        end)
    end)
end

--==============================================================
-- [3] AIM ASSIST BOOST
--==============================================================

local function startAimBoost()
    if State._aimThread then return end

    State._aimThread = task.spawn(function()
        while State.AimAssistBoost do
            local cs = LP:FindFirstChild("ClientSettings")
            local mobile = cs and cs:FindFirstChild("Mobile")

            if mobile then
                pcall(function()
                    mobile:SetAttribute("AimAssistStrength", 100)
                    mobile:SetAttribute("AimAssistFOVDegrees", 20)
                    mobile:SetAttribute("AimAssistMaxDistance", 1000)
                end)
            end

            task.wait(0.5)
        end
        State._aimThread = nil
    end)
end

local function stopAimBoost()
    State._aimThread = nil
end

--==============================================================
-- [4] AUTO RELOAD
--==============================================================

local function startAutoReload()
    if State._autoReload then return end

    State._autoReload = task.spawn(function()
        while State.AutoReload do
            local tool = getEquippedTool()
            if tool and isGun(tool) then
                local ammo = getAmmo(tool)
                local maxAmmo = getMaxAmmo(tool)

                if maxAmmo > 0 and ammo <= 0 and not isReloading(tool) then
                    tryReload(tool)
                end
            end
            task.wait(0.15)
        end
        State._autoReload = nil
    end)
end

local function stopAutoReload()
    State._autoReload = nil
end

--==============================================================
-- [5] MAIN FIRE LOOP
--==============================================================

local function startFireLoop()
    if State._thread then return end

    State._thread = task.spawn(function()
        while State.Enabled do
            local tool = getEquippedTool()

            if tool and isGun(tool)
               and not isReloading(tool)
               and (getAmmo(tool) > 0 or getMaxAmmo(tool) == 0) then

                fireTool(tool)

                local rate = math.clamp(State.FirePerSecond, 1, 120)
                task.wait(1 / rate)
            else
                task.wait(0.05)
            end
        end
        State._thread = nil
    end)
end

local function stopFireLoop()
    State._thread = nil
end

--==============================================================
-- MASTER TOGGLE
--==============================================================

local function Enable()
    if State.Enabled then return end
    State.Enabled = true

    if State.RemoveFloodLimit then installFloodBypass() end
    if State.AutoFireOnTarget then installAutoFire() end

    startFireLoop()
    print("[RapidFire] ENABLED —", State.FirePerSecond, "RPS")
end

local function Disable()
    if not State.Enabled then return end
    State.Enabled = false

    stopFireLoop()
    uninstallFloodBypass()
    uninstallAutoFire()

    print("[RapidFire] DISABLED")
end

--==============================================================
-- OBSIDIAN UI
--==============================================================

-- MainBox2 = Gun Modifier Features (သင့် Script ထဲမှာ ရှိပြီးသား)

MainBox2:AddSlider("RapidFire_Rate", {
    Text = "Fire Rate (per sec)",
    Default = 60,
    Min = 0.001,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        State.FirePerSecond = Value
    end,
})

MainBox2:AddToggle("RapidFire_Enabled", {
    Text = "Fire Rate Bypass",
    Default = false,
    Callback = function(Value)
        if Value then
            Enable()
        else
            Disable()
        end
    end,
})

MainBox2:AddToggle("RapidFire_FloodBypass", {
    Text = "Remove Flood Limit",
    Default = false,
    Callback = function(Value)
        State.RemoveFloodLimit = Value
        if Value and State.Enabled then
            installFloodBypass()
        elseif not Value then
            uninstallFloodBypass()
        end
    end,
})


-- ═══════════════════════════════════════════════════════════
--  WeaponFeatures — Obsidian UI Edition (FastReload v4)
--  Single-file / Crash-safe / Lag-safe
-- ═══════════════════════════════════════════════════════════

local RS  = game:GetService("ReplicatedStorage")
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP  = game.Players.LocalPlayer

local Net      = require(RS.Assets.Modules.Network)
local FastCast = require(RS.Assets.Modules.Raycast)

-- ═══════════════════════════════════════════════════════════
--  State (single source of truth)
-- ═══════════════════════════════════════════════════════════
local State = {
    NoSpread        = false,
    FireSpeed       = false,
    FireSpeedMult   = 3.0,

    RapidFire       = false,
    RapidFireCPS    = 20,

    FastReload      = false,
    FastReloadAnim  = 8.0,
    FastReloadWatchdogHz = 60,
    FastReloadAutoRefill = true,
    FastReloadCancel     = true,
    FastReloadSkipMag    = true,

    EquipBypass     = false,
    InstantSwap     = false,
    NoSwitchDelay   = false,

    SpeedMod        = false,
    SpeedMult       = 1.5,

    InfiniteSlide   = false,
    SlideSpeed      = 40,

    FastCooldown    = false,
    FastCooldownGap = 0.01,

    NoFalloff       = false,
    NoFalloffDist   = 5000,

    DoubleTap       = false,
    DoubleTapCount  = 2,
    DoubleTapGap    = 0.02,

    CustomFOV       = false,
    ADSFOV          = 45,
    HipFOV          = 90,
    SprintFOV       = 100,

    FastCrouch      = false,
    FastCrouchAnim  = 2.5,
}

-- ═══════════════════════════════════════════════════════════
--  Shared helpers
-- ═══════════════════════════════════════════════════════════
local function getTool()
    local char = LP.Character
    if not char then return nil end
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Tool") then return c end
    end
end

local function getHumanoid()
    local char = LP.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getAnimator()
    local hum = getHumanoid()
    return hum and hum:FindFirstChildOfClass("Animator")
end

local function isReloadTrack(track)
    local n = (track.Animation and track.Animation.Name or ""):lower()
    return n:find("reload") ~= nil
end

local function isCrouchTrack(track)
    local n = (track.Animation and track.Animation.Name or ""):lower()
    return n:find("crouch") ~= nil
end

local function clearDurations(tool)
    if not tool or not tool:IsA("Tool") then return end
    pcall(function()
        tool:SetAttribute("ToolSwapLocked", false)
        tool:SetAttribute("EquipDuration",   0)
        tool:SetAttribute("HolsterDuration", 0)
        tool:SetAttribute("DisposeDuration", 0)
        tool:SetAttribute("SwitchDelay",     0)
    end)
end

-- ═══════════════════════════════════════════════════════════
--  SINGLE FireServer hook (NoSpread + FireSpeed + RapidFire
--  + FastCooldown + DoubleTap)
-- ═══════════════════════════════════════════════════════════
local _origFireServer = Net.FireServer
local lastShot  = 0
local lastBurst = 0

Net.FireServer = function(self, name, ...)
    if name ~= "tracer" and name ~= "bulletTracer" then
        return _origFireServer(self, name, ...)
    end

    local args = table.pack(...)
    local cfg  = args[4]
    if type(cfg) ~= "table" then cfg = nil end

    -- No Spread
    if State.NoSpread and cfg and cfg.fire then
        cfg.fire.spread = { x = {0,0}, y = {0,0}, z = {0,0} }
    end

    -- Fire Speed
    if State.FireSpeed and cfg and cfg.fire then
        local base = cfg.fire.fireSpeed or 100
        cfg.fire.fireSpeed = base * math.clamp(State.FireSpeedMult, 1, 10)
    end

    -- Rate limiting
    local now = tick()
    if State.RapidFire then
        local gap = 1 / math.clamp(State.RapidFireCPS, 1, 40)
        if now - lastShot < gap then return end
        lastShot = now
    elseif State.FastCooldown then
        local gap = math.clamp(State.FastCooldownGap, 0.005, 1)
        if now - lastShot < gap then return end
        lastShot = now
    end

    -- Double Tap
    if State.DoubleTap then
        if now - lastBurst < 0.12 then
            return _origFireServer(self, name, table.unpack(args, 1, args.n))
        end
        lastBurst = now
        _origFireServer(self, name, table.unpack(args, 1, args.n))
        local count = math.clamp(State.DoubleTapCount, 1, 5)
        local gap   = math.clamp(State.DoubleTapGap, 0.005, 0.5)
        for i = 2, count do
            task.delay(gap * (i - 1), function()
                if State.DoubleTap then
                    pcall(_origFireServer, self, name, table.unpack(args, 1, args.n))
                end
            end)
        end
        return
    end

    return _origFireServer(self, name, table.unpack(args, 1, args.n))
end

-- ═══════════════════════════════════════════════════════════
--  FastCast hook  (NoFalloff)
-- ═══════════════════════════════════════════════════════════
do
    local _origNew = FastCast.newBehavior
    FastCast.newBehavior = function()
        local b = _origNew()
        if State.NoFalloff then
            b.MaxDistance = math.min(State.NoFalloffDist, 10000)
            if not b.HighFidelitySegmentSize or b.HighFidelitySegmentSize <= 0 then
                b.HighFidelitySegmentSize = 1
            end
        end
        return b
    end
end

-- ═══════════════════════════════════════════════════════════
--  FAST RELOAD v4  (integrated module)
--  Strategies:
--   [1] Animation speed 8x (visual)
--   [2] Attribute spoof watchdog (Reloading/ClipCurrent)
--   [3] Re-equip trick (server cancel)
--   [4] CanMagout spoof (skip mag animation)
-- ═══════════════════════════════════════════════════════════
local FastReload = {}

local reloadStart  = 0
local isReloading  = false
local reEquipLock  = false
local watchdogConn = nil
local watchedTools = setmetatable({}, { __mode = "k" })

-- Logging (off by default — no lag)
local function frLog(...)
    if false then print("[FR4]", ...) end
end

-- ─── Core: force finish reload on tool ────────────────
local function forceFinish(tool)
    if not tool or not tool:IsA("Tool") then return end

    -- [4] Skip mag animation
    if State.FastReloadSkipMag then
        pcall(function()
            if tool:GetAttribute("CanMagout") ~= true then
                tool:SetAttribute("CanMagout", true)
            end
        end)
    end

    -- [1] Animation speed
    local animator = getAnimator()
    if animator then
        local spd = math.clamp(State.FastReloadAnim, 1, 15)
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            pcall(function()
                track:AdjustSpeed(spd)
            end)
        end
    end

    -- [2] Refill ammo
    if State.FastReloadAutoRefill then
        local size = tool:GetAttribute("ClipSize")
        local cur  = tool:GetAttribute("ClipCurrent")
        if size and cur and cur ~= size then
            pcall(function()
                tool:SetAttribute("ClipCurrent", size)
            end)
        end
    end

    -- [2] Cancel reload
    if State.FastReloadCancel then
        pcall(function()
            if tool:GetAttribute("Reloading") == true then
                tool:SetAttribute("Reloading", false)
            end
        end)
    end
end

-- ─── [3] Re-equip trick ───────────────────────────────
local function reEquipTrick(tool)
    if reEquipLock then return end
    if not tool or tool.Parent ~= LP.Character then return end
    reEquipLock = true
    local hum = getHumanoid()
    if hum then
        pcall(function() hum:UnequipTools() end)
        task.wait()
        pcall(function() hum:EquipTool(tool) end)
    end
    task.delay(0.5, function() reEquipLock = false end)
end

-- ─── Watchdog ────────────────────────────────────────
local function startWatchdog()
    if watchdogConn then return end
    local interval = 1 / math.clamp(State.FastReloadWatchdogHz, 10, 120)
    local last = 0
    watchdogConn = Run.Heartbeat:Connect(function()
        if not State.FastReload then return end
        local t = tick()
        if t - last < interval then return end
        last = t

        local char = LP.Character
        if not char then return end
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("IsGun") then
                local rl = tool:GetAttribute("Reloading") == true
                local tickVal = tool:GetAttribute("ReloadTick") or 0
                if rl or (type(tickVal) == "number" and tickVal > 0
                          and (t - tickVal) < 10) then
                    forceFinish(tool)
                end
            end
        end
    end)
    frLog("Watchdog started @", State.FastReloadWatchdogHz, "Hz")
end

local function stopWatchdog()
    if watchdogConn then
        watchdogConn:Disconnect()
        watchdogConn = nil
        frLog("Watchdog stopped")
    end
end

-- ─── Tool watcher ─────────────────────────────────────
local function watchTool(tool)
    if not tool or not tool:IsA("Tool") then return end
    if watchedTools[tool] then return end
    watchedTools[tool] = {}

    watchedTools[tool].reloading =
        tool:GetAttributeChangedSignal("Reloading"):Connect(function()
            local v = tool:GetAttribute("Reloading")
            if v == true then
                isReloading = true
                reloadStart = tick()
                if State.FastReload then
                    forceFinish(tool)
                    task.delay(0.05, function()
                        if State.FastReload and tool.Parent then
                            forceFinish(tool)
                        end
                    end)
                end
            else
                isReloading = false
            end
        end)

    watchedTools[tool].reloadTick =
        tool:GetAttributeChangedSignal("ReloadTick"):Connect(function()
            if State.FastReload and isReloading then
                forceFinish(tool)
            end
        end)

    watchedTools[tool].mag =
        tool:GetAttributeChangedSignal("CanMagout"):Connect(function()
            if State.FastReload and isReloading then
                pcall(function()
                    tool:SetAttribute("CanMagout", true)
                end)
            end
        end)

    watchedTools[tool].clip =
        tool:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
            if State.FastReload and isReloading and State.FastReloadAutoRefill then
                local size = tool:GetAttribute("ClipSize")
                local cur  = tool:GetAttribute("ClipCurrent")
                if size and cur and cur ~= size then
                    pcall(function()
                        tool:SetAttribute("ClipCurrent", size)
                    end)
                end
            end
        end)
end

local function unwatchTool(tool)
    local d = watchedTools[tool]
    if not d then return end
    for _, c in pairs(d) do pcall(function() c:Disconnect() end) end
    watchedTools[tool] = nil
end

-- ─── Character hooks ──────────────────────────────────
local frCharConn   = nil
local frAddedConn  = nil
local frRemovedConn= nil
local frAnimConn   = nil

local function hookCharFR(char)
    if not char then return end
    -- clean old
    for _, c in ipairs({frAddedConn, frRemovedConn, frAnimConn}) do
        if c then pcall(function() c:Disconnect() end) end
    end

    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Tool") then watchTool(c) end
    end
    frAddedConn = char.ChildAdded:Connect(function(c)
        if c:IsA("Tool") then watchTool(c) end
    end)
    frRemovedConn = char.ChildRemoved:Connect(function(c)
        if c:IsA("Tool") then unwatchTool(c) end
    end)

    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        local anim = hum:FindFirstChildOfClass("Animator")
        if anim then
            frAnimConn = anim.AnimationPlayed:Connect(function(track)
                if State.FastReload and isReloading then
                    pcall(function()
                        track:AdjustSpeed(math.clamp(State.FastReloadAnim, 1, 15))
                    end)
                end
            end)
        end
    end
end

if LP.Character then
    task.spawn(hookCharFR, LP.Character)
end
LP.CharacterAdded:Connect(function(c)
    task.wait(0.3)
    hookCharFR(c)
end)

-- ─── Public API ───────────────────────────────────────
function FastReload.Toggle(state)
    State.FastReload = (state ~= nil) and state or not State.FastReload
    if State.FastReload then
        startWatchdog()
        frLog("FastReload ENABLED")
    else
        stopWatchdog()
        frLog("FastReload DISABLED")
    end
    return State.FastReload
end

function FastReload.ForceNow()
    local char = LP.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("IsGun") then
            forceFinish(tool)
        end
    end
end

function FastReload.ReEquip()
    local hum = getHumanoid()
    if not hum then return end
    local tool = hum:FindFirstChildWhichIsA("Tool")
    if tool then reEquipTrick(tool) end
end

-- ═══════════════════════════════════════════════════════════
--  Other tool watcher (EquipBypass / InstantSwap / NoSwitchDelay)
-- ═══════════════════════════════════════════════════════════
local miscWatched = setmetatable({}, { __mode = "k" })

local function setupMiscTool(tool)
    if not tool or not tool:IsA("Tool") then return end
    if miscWatched[tool] then return end
    miscWatched[tool] = true

    for _, attr in ipairs({
        "EquipDuration", "HolsterDuration", "DisposeDuration",
        "ToolSwapLocked", "SwitchDelay"
    }) do
        tool:GetAttributeChangedSignal(attr):Connect(function()
            if State.EquipBypass or State.NoSwitchDelay or State.InstantSwap then
                clearDurations(tool)
            end
        end)
    end

    local req = tool:FindFirstChild("RequestUnequip")
    if req and req:IsA("BindableFunction") then
        req.OnInvoke = function()
            return true
        end
    end

    if State.EquipBypass or State.NoSwitchDelay or State.InstantSwap then
        clearDurations(tool)
    end
end

local function watchCharacterMisc(char)
    if not char then return end
    char.DescendantAdded:Connect(function(d)
        if d:IsA("Tool") then setupMiscTool(d) end
    end)
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("Tool") then setupMiscTool(d) end
    end
end

-- ═══════════════════════════════════════════════════════════
--  Animator watcher (FastCrouch only — FastReload handles its own)
-- ═══════════════════════════════════════════════════════════
local hookedAnimators = setmetatable({}, { __mode = "k" })

local function setupAnimator(animator)
    if not animator or hookedAnimators[animator] then return end
    hookedAnimators[animator] = true
    animator.AnimationPlayed:Connect(function(track)
        if State.FastCrouch and isCrouchTrack(track) then
            pcall(function()
                track:AdjustSpeed(math.clamp(State.FastCrouchAnim, 1, 5))
            end)
        end
    end)
end

local function setupAnimators(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator")
    if anim then setupAnimator(anim) end
    hum.ChildAdded:Connect(function(c)
        if c:IsA("Animator") then setupAnimator(c) end
    end)
end

-- ═══════════════════════════════════════════════════════════
--  Character bootstrap
-- ═══════════════════════════════════════════════════════════
local function onCharacter(char)
    watchCharacterMisc(char)
    task.wait(0.3)
    setupAnimators(char)
end

if LP.Character then onCharacter(LP.Character) end
LP.CharacterAdded:Connect(onCharacter)

-- ═══════════════════════════════════════════════════════════
--  Walk / Sprint Speed
-- ═══════════════════════════════════════════════════════════
local baseSpeed = 16
local function captureBase()
    local hum = getHumanoid()
    if hum then baseSpeed = hum.WalkSpeed end
end
captureBase()
LP.CharacterAdded:Connect(function()
    task.wait(0.5); captureBase()
end)

Run.RenderStepped:Connect(function()
    if not State.SpeedMod then return end
    local hum = getHumanoid()
    if not hum then return end
    local target = math.min(baseSpeed * State.SpeedMult, 60)
    if math.abs(hum.WalkSpeed - target) > 0.1 then
        hum.WalkSpeed = target
    end
end)

-- ═══════════════════════════════════════════════════════════
--  Infinite Slide
-- ═══════════════════════════════════════════════════════════
Run.Heartbeat:Connect(function()
    if not State.InfiniteSlide then return end
    local hum = getHumanoid()
    if not hum then return end

    if hum:GetAttribute("sliding") ~= true then
        pcall(function() hum:SetAttribute("sliding", true) end)
    end

    local root = hum.RootPart
    if not root then return end
    local v = root.AssemblyLinearVelocity
    local flat = Vector3.new(v.X, 0, v.Z)
    if flat.Magnitude < State.SlideSpeed * 0.7 then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0.1 then
            root.AssemblyLinearVelocity = Vector3.new(
                dir.X * State.SlideSpeed,
                v.Y,
                dir.Z * State.SlideSpeed
            )
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  Fast Crouch — hip snap
-- ═══════════════════════════════════════════════════════════
Run.RenderStepped:Connect(function()
    if not State.FastCrouch then return end
    local hum = getHumanoid()
    if not hum then return end
    local crouching = hum:GetAttribute("crouching") == true
                   or hum:GetAttribute("Crouching") == true
    if not crouching then return end
    local target = math.max(0, (hum.HipHeight or 2) - 0.5)
    if math.abs(hum.HipHeight - target) > 0.05 then
        hum.HipHeight = target
    end
end)

-- ═══════════════════════════════════════════════════════════
--  Custom FOV
-- ═══════════════════════════════════════════════════════════
local cam = workspace.CurrentCamera
Run.RenderStepped:Connect(function()
    if not State.CustomFOV then return end
    if not cam then cam = workspace.CurrentCamera end
    if not cam then return end

    local tool = getTool()
    local hum  = getHumanoid()
    local target

    if tool and (tool:GetAttribute("Aiming") == true
        or tool:GetAttribute("IsAiming") == true
        or tool:GetAttribute("ADS") == true) then
        target = State.ADSFOV
    else
        local sprinting = hum and (hum:GetAttribute("sprinting") == true
            or hum:GetAttribute("Sprinting") == true)
        target = sprinting and State.SprintFOV or State.HipFOV
    end

    target = math.clamp(target, 20, 120)
    if math.abs(cam.FieldOfView - target) > 0.5 then
        cam.FieldOfView = cam.FieldOfView + (target - cam.FieldOfView) * 0.25
    end
end)

-- ═══════════════════════════════════════════════════════════
--  OBSIDIAN UI INTEGRATION
-- ═══════════════════════════════════════════════════════════

-- ── GUN: Accuracy ───────────────────────────
MainBox:AddToggle("NoSpread_Toggle", {
    Text = "No Spread",
    Default = false,
    Callback = function(Value)
        State.NoSpread = Value
    end,
})

MainBox2:AddSlider("NoFalloff_Dist", {
    Text = "Max Bullet Distance",
    Default = 5000,
    Min = 1000,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        State.NoFalloffDist = Value
    end,
})

MainBox2:AddToggle("NoFalloff_Toggle", {
    Text = "Bullet Distance",
    Default = false,
    Callback = function(Value)
        State.NoFalloff = Value
    end,
})

MainBox2:AddSlider("FireSpeed_Mult", {
    Text = "Fire Speed Multiplier",
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        State.FireSpeedMult = Value
    end,
})

MainBox2:AddToggle("FireSpeed_Toggle", {
    Text = "Fire Speed Modifier",
    Default = false,
    Callback = function(Value)
        State.FireSpeed = Value
    end,
})

MainBox2:AddSlider("RapidFire_CPS", {
    Text = "Fastet Fire CPS",
    Default = 20,
    Min = 1,
    Max = 40,
    Rounding = 0,
    Callback = function(Value)
        State.RapidFireCPS = Value
    end,
})

MainBox2:AddToggle("RapidFire_Toggle", {
    Text = "Fastet Fire (No RapidFire)",
    Default = false,
    Callback = function(Value)
        State.RapidFire = Value
    end,
})

MainBox2:AddSlider("FastCooldown_Gap", {
    Text = "Cooldown Gap (s)",
    Default = 0.01,
    Min = 0.005,
    Max = 1,
    Rounding = 3,
    Callback = function(Value)
        State.FastCooldownGap = Value
    end,
})

MainBox2:AddToggle("FastCooldown_Toggle", {
    Text = "Fast Fire Cooldown",
    Default = false,
    Callback = function(Value)
        State.FastCooldown = Value
    end,
})

MainBox2:AddSlider("DoubleTap_Count", {
    Text = "Burst Count",
    Default = 2,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        State.DoubleTapCount = Value
    end,
})

MainBox2:AddSlider("DoubleTap_Gap", {
    Text = "Burst Gap (s)",
    Default = 0.02,
    Min = 0.005,
    Max = 0.5,
    Rounding = 3,
    Callback = function(Value)
        State.DoubleTapGap = Value
    end,
})


MainBox2:AddToggle("DoubleTap_Toggle", {
    Text = "Double Tap (Burst Fire)",
    Default = false,
    Callback = function(Value)
        State.DoubleTap = Value
    end,
})
-- ── GUN: Fast Reload v4 ─────────────────────

MainBox:AddSlider("FastReload_Anim", {
    Text = "Reload Speed (2 or 4 Safe)",
    Default = 8,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Callback = function(Value)
        State.FastReloadAnim = Value
    end,
})

MainBox:AddSlider("FastReload_Hz", {
    Text = "Auto Detection Reload",
    Default = 60,
    Min = 10,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        State.FastReloadWatchdogHz = Value
    end,
})

MainBox:AddToggle("FastReload_Toggle", {
    Text = "Fast Reload",
    Default = false,
    Callback = function(Value)
        FastReload.Toggle(Value)
    end,
})

MainBox:AddToggle("FastReload_Refill", {
    Text = "Fast Reload Bypass",
    Default = true,
    Callback = function(Value)
        State.FastReloadAutoRefill = Value
    end,
})

MainBox:AddToggle("FastReload_Cancel", {
    Text = "Force Cancel Reload",
    Default = true,
    Callback = function(Value)
        State.FastReloadCancel = Value
    end,
})

MainBox:AddToggle("FastReload_SkipMag", {
    Text = "Skip Mag",
    Default = true,
    Callback = function(Value)
        State.FastReloadSkipMag = Value
    end,
})

MainBox:AddButton({
    Text = "Force Finish Reload",
    Func = function()
        FastReload.ForceNow()
    end,
})

MainBox:AddButton({
    Text = "Re-Equip Trick (Server Cancel)",
    Func = function()
        FastReload.ReEquip()
    end,
})

-- ── GUN: Equip ──────────────────────────────
MainBox:AddToggle("EquipBypass_Toggle", {
    Text = "Bypass Equip Cooldown",
    Default = false,
    Callback = function(Value)
        State.EquipBypass = Value
        if Value and LP.Character then
            for _, d in ipairs(LP.Character:GetDescendants()) do
                if d:IsA("Tool") then clearDurations(d) end
            end
        end
    end,
})

MainBox:AddToggle("InstantSwap_Toggle", {
    Text = "Instant Tool Swap",
    Default = false,
    Callback = function(Value)
        State.InstantSwap = Value
    end,
})

MainBox:AddToggle("NoSwitchDelay_Toggle", {
    Text = "No Switch Delay",
    Default = false,
    Callback = function(Value)
        State.NoSwitchDelay = Value
        if Value and LP.Character then
            for _, d in ipairs(LP.Character:GetDescendants()) do
                if d:IsA("Tool") then clearDurations(d) end
            end
        end
    end,
})

-- ── MOVEMENT ────────────────────────────────

MainBox3:AddSlider("SpeedMod_Mult", {
    Text = "Speed Multiplier",
    Default = 1.5,
    Min = 1,
    Max = 3.75,
    Rounding = 2,
    Callback = function(Value)
        State.SpeedMult = Value
    end,
})

MainBox3:AddToggle("SpeedMod_Toggle", {
    Text = "Walk / Sprint Speed",
    Default = false,
    Callback = function(Value)
        State.SpeedMod = Value
        if not Value then
            local hum = getHumanoid()
            if hum then hum.WalkSpeed = baseSpeed end
        end
    end,
})

MainBox3:AddSlider("SlideSpeed_Slider", {
    Text = "Slide Speed",
    Default = 40,
    Min = 10,
    Max = 80,
    Rounding = 0,
    Callback = function(Value)
        State.SlideSpeed = Value
    end,
})

MainBox3:AddToggle("InfiniteSlide_Toggle", {
    Text = "Infinite Slide",
    Default = false,
    Callback = function(Value)
        State.InfiniteSlide = Value
        if not Value then
            local hum = getHumanoid()
            if hum then
                pcall(function() hum:SetAttribute("sliding", false) end)
            end
        end
    end,
})

MainBox3:AddSlider("FastCrouch_Anim", {
    Text = "Crouch Speed",
    Default = 2.5,
    Min = 1,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        State.FastCrouchAnim = Value
    end,
})

MainBox3:AddToggle("FastCrouch_Toggle", {
    Text = "Fast Crouch",
    Default = false,
    Callback = function(Value)
        State.FastCrouch = Value
    end,
})

-- ── CAMERA ──────────────────────────────────

MainBox3:AddSlider("ADSFOV_Slider", {
    Text = "ADS FOV",
    Default = 120,
    Min = 20,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        State.ADSFOV = Value
    end,
})

MainBox3:AddSlider("HipFOV_Slider", {
    Text = "Hip FOV",
    Default = 120,
    Min = 20,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        State.HipFOV = Value
    end,
})

MainBox3:AddSlider("SprintFOV_Slider", {
    Text = "Sprint FOV",
    Default = 120,
    Min = 20,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        State.SprintFOV = Value
    end,
})

MainBox3:AddToggle("CustomFOV_Toggle", {
    Text = "Custom FOV",
    Default = false,
    Callback = function(Value)
        State.CustomFOV = Value
    end,
})

-- ═══════════════════════════════════════════════════════════════
--  SERVICES & CACHE
-- ═══════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Config = {
    AimbotEnabled       = false,
    SilentAimEnabled    = false,
    TriggerBotEnabled   = false,
    PredictionEnabled   = true,
    AutoHeadshotEnabled = false,   -- dropdown ကပဲ ဆုံးဖြတ်
    BulletTeleport      = true,
    FOV          = 150,
    Smoothness   = 1,       -- 1 = Instant Snap
    MaxDistance  = 1200,
    TargetPart   = "Head",
    TriggerDelay = 0.05,
    PredictSpeed = 500,
    TeamCheck    = true,
    WallCheck    = true,
    FOVColor     = Color3.fromRGB(85, 217, 255),
}

local AimTarget       = nil
local LastTriggerTime = 0
local DrawFOV, Network, Controller
local myChar, myRoot, myHum

pcall(function() Network = require(RS.Assets.Modules.Network) end)
pcall(function() Controller = require(RS.Assets.Modules.Mobile.Controller) end)

local function RefreshChar()
    myChar = LP.Character
    myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
end
RefreshChar()
LP.CharacterAdded:Connect(function() task.wait(0.5) RefreshChar() end)
LP.CharacterRemoving:Connect(function() myChar, myRoot, myHum = nil, nil, nil end)

-- ═══════════════════════════════════════════════════════════════
--  FOV CIRCLE
-- ═══════════════════════════════════════════════════════════════
pcall(function()
    local sg = Instance.new("ScreenGui")
    sg.Name = "AimFOVCircle"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999
    sg.Parent = LP:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Size = UDim2.fromOffset(Config.FOV * 2, Config.FOV * 2)
    frame.Parent = sg

    local stroke = Instance.new("UIStroke")
    stroke.Color = Config.FOVColor
    stroke.Thickness = 1.5
    stroke.Transparency = 0.15
    stroke.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = frame

    DrawFOV = { gui = frame, stroke = stroke }
end)

local function UpdateFOVCircle()
    if not DrawFOV then return end
    DrawFOV.gui.Position = UDim2.fromOffset(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    DrawFOV.gui.Size = UDim2.fromOffset(Config.FOV * 2, Config.FOV * 2)
    DrawFOV.gui.Visible = Config.AimbotEnabled or Config.SilentAimEnabled or Config.TriggerBotEnabled
end

-- ═══════════════════════════════════════════════════════════════
--  CORE HELPERS
-- ═══════════════════════════════════════════════════════════════
local function IsTeammate(model)
    if not Config.TeamCheck then return false end
    if not model or model == myChar then return true end
    local plr = Players:GetPlayerFromCharacter(model)
    if plr then
        if plr == LP then return true end
        if LP.Team and plr.Team and LP.Team == plr.Team then return true end
    end
    return false
end

local wallParams = RaycastParams.new()
wallParams.FilterType = Enum.RaycastFilterType.Exclude
wallParams.IgnoreWater = true

local function HasLOS(from, to, ignore)
    wallParams.FilterDescendantsInstances = ignore
    local dir = to - from
    local hit = Workspace:Raycast(from, dir, wallParams)
    return not hit or hit.Distance >= dir.Magnitude - 0.5
end

local function GetTargetPart(model)
    if not model then return nil end
    -- Dropdown က အဓိက
    local mode = Config.TargetPart
    if Config.AutoHeadshotEnabled then mode = "Head" end

    if mode == "Head" then
        return model:FindFirstChild("Head")
    elseif mode == "Torso" then
        return model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso")
    else
        return model:FindFirstChild("HumanoidRootPart")
    end
end

local function PredictPosition(pos, vel, from, speed)
    if not Config.PredictionEnabled then return pos end
    speed = speed or 500
    local d = (pos - from).Magnitude
    local t = math.min(d / speed, 1)
    return pos + vel * t
end

-- ═══════════════════════════════════════════════════════════════
--  TARGET SCANNER (Optimized — Cache parts)
-- ═══════════════════════════════════════════════════════════════
local partCache = setmetatable({}, { __mode = "k" })  -- weak keys

local function GetCachedParts(model)
    local c = partCache[model]
    if not c or not c.root.Parent then
        local root = model:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        c = { root = root, parts = {} }
        partCache[model] = c
    end
    return c
end

local function ScanForTarget()
    if not myChar or not myRoot then return nil end
    local chars = Workspace:FindFirstChild("Characters")
    if not chars then return nil end

    local camPos = Camera.CFrame.Position
    local vp = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    local best, bestDiff = nil, math.huge
    local myPos = myRoot.Position
    local maxD = Config.MaxDistance
    local fov = Config.FOV
    local doWall = Config.WallCheck

    for _, model in ipairs(chars:GetChildren()) do
        if model:IsA("Model") and model ~= myChar then
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local c = GetCachedParts(model)
                if c then
                    local dist = (c.root.Position - myPos).Magnitude
                    if dist <= maxD and not IsTeammate(model) then
                        local part = GetTargetPart(model)
                        if part then
                            local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local dx, dy = sp.X - cx, sp.Y - cy
                                local diff = math.sqrt(dx*dx + dy*dy)
                                if diff <= fov and diff < bestDiff then
                                    if not doWall or HasLOS(camPos, part.Position, { myChar, model, Camera, Workspace.Terrain }) then
                                        bestDiff = diff
                                        best = { model = model, part = part, root = c.root, screen = Vector2.new(sp.X, sp.Y) }
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

-- ═══════════════════════════════════════════════════════════════
--  AIM LOGIC
-- ═══════════════════════════════════════════════════════════════
local function ComputeAimCFrame(target)
    if not target or not target.part or not target.part.Parent then return nil end
    local camPos = Camera.CFrame.Position
    local targetPos = target.part.Position
    if Config.PredictionEnabled and target.root then
        targetPos = PredictPosition(targetPos, target.root.Velocity, camPos, Config.PredictSpeed)
    end
    return CFrame.lookAt(camPos, targetPos)
end

local function AimAtTarget(target)
    local desired = ComputeAimCFrame(target)
    if not desired then return end
    if Config.Smoothness <= 1 then
        Camera.CFrame = desired
    else
        Camera.CFrame = Camera.CFrame:Lerp(desired, math.clamp(1 / Config.Smoothness, 0.02, 1))
    end
end

-- ═══════════════════════════════════════════════════════════════
--  SILENT AIM — Direct RemoteEvent Hook (Fixed)
-- ═══════════════════════════════════════════════════════════════
local fireRemote = nil
task.spawn(function()
    for _ = 1, 20 do
        local comm = RS:FindFirstChild("Communication")
        if comm then
            local events = comm:FindFirstChild("Events")
            if events then
                fireRemote = events:FindFirstChild("fire")
                if fireRemote then break end
            end
        end
        task.wait(0.5)
    end
    if fireRemote then
        print("[AimSystem] fire RemoteEvent found:", fireRemote:GetFullName())
    else
        warn("[AimSystem] fire RemoteEvent NOT found — Silent Aim disabled")
    end
end)

local silentHookInstalled = false
local function InstallSilentAim()
    if silentHookInstalled then return end
    if not fireRemote then
        warn("[AimSystem] Cannot install Silent Aim — fire remote not found")
        return
    end
    silentHookInstalled = true

    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- SPECIFIC: only fire remote, only FireServer
        if method == "FireServer" and self == fireRemote then
            if Config.SilentAimEnabled and AimTarget and AimTarget.part and AimTarget.part.Parent then
                local args = {...}
                if #args >= 3 and type(args[3]) == "Vector3" then
                    local origin = Camera.CFrame.Position
                    local targetPos = AimTarget.part.Position
                    if Config.PredictionEnabled and AimTarget.root then
                        targetPos = PredictPosition(targetPos, AimTarget.root.Velocity, origin, Config.PredictSpeed)
                    end
                    args[3] = (targetPos - origin).Unit
                    return oldNamecall(self, table.unpack(args))
                end
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
    print("[AimSystem] Silent Aim installed ✅")
end

-- Fallback: Network module hook
if not hookmetamethod and Network and Network.FireServer then
    local oldFire = Network.FireServer
    Network.FireServer = function(self, event, ...)
        if event == "fire" and Config.SilentAimEnabled and AimTarget and AimTarget.part and AimTarget.part.Parent then
            local args = {...}
            if type(args[3]) == "Vector3" then
                local origin = Camera.CFrame.Position
                local targetPos = AimTarget.part.Position
                if Config.PredictionEnabled and AimTarget.root then
                    targetPos = PredictPosition(targetPos, AimTarget.root.Velocity, origin, Config.PredictSpeed)
                end
                args[3] = (targetPos - origin).Unit
                return oldFire(self, event, table.unpack(args))
            end
        end
        return oldFire(self, event, ...)
    end
end

-- ═══════════════════════════════════════════════════════════════
--  TRIGGER BOT
-- ═══════════════════════════════════════════════════════════════
local function DoTrigger()
    local now = tick()
    if now - LastTriggerTime < Config.TriggerDelay then return end
    LastTriggerTime = now
    if Controller and Controller.FireAction then
        pcall(function()
            Controller.FireAction("Primary", Controller.States.Begin)
            task.delay(0.01, function()
                pcall(function() Controller.FireAction("Primary", Controller.States.End) end)
            end)
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════
--  MAIN LOOPS
--  ● SCAN at 15 FPS (0.066s) — Lag free
--  ● AIM at RenderPriority 999 — AFTER game camera update
-- ═══════════════════════════════════════════════════════════════
local scanAccum = 0
local SCAN_INTERVAL = 0.066

RunService.RenderStepped:Connect(function(dt)
    UpdateFOVCircle()
    scanAccum = scanAccum + dt
    if scanAccum < SCAN_INTERVAL then return end
    scanAccum = 0

    AimTarget = ScanForTarget()

    if Config.TriggerBotEnabled and AimTarget then
        local cx = Camera.ViewportSize.X / 2
        local cy = Camera.ViewportSize.Y / 2
        local dx = AimTarget.screen.X - cx
        local dy = AimTarget.screen.Y - cy
        if math.sqrt(dx*dx + dy*dy) <= 15 then
            DoTrigger()
        end
    end
end)

-- ★ CRITICAL: Run at priority 999 (after game camera at 200, character at 300)
RunService:BindToRenderStep("AimSystem_Snap", 999, function()
    if Config.AimbotEnabled and AimTarget and AimTarget.part and AimTarget.part.Parent then
        AimAtTarget(AimTarget)
    end
end)

MainBox4:AddSlider("Aimbot_FOV", {
    Text = "FOV Circle Radius",
    Default = 150, Min = 20, Max = 800, Rounding = 0,
    Callback = function(Value) Config.FOV = Value end,
})

MainBox4:AddSlider("Aimbot_Smoothness", {
    Text = "Smoothness (1 = Instant Snap)",
    Default = 1, Min = 1, Max = 20, Rounding = 0,
    Callback = function(Value) Config.Smoothness = Value end,
})

MainBox4:AddSlider("Aimbot_MaxDist", {
    Text = "Max Distance (studs)",
    Default = 1200, Min = 50, Max = 5000, Rounding = 0,
    Callback = function(Value) Config.MaxDistance = Value end,
})

MainBox4:AddDropdown("Aimbot_TargetPart", {
    Values = { "Head", "Torso", "HumanoidRootPart" },
    Default = 1,
    Text = "Target Part",
    Callback = function(Value) Config.TargetPart = Value end,
})

MainBox4:AddToggle("Aimbot_Enabled", {
    Text = "Aimbot — Enable",
    Default = false,
    Callback = function(Value) Config.AimbotEnabled = Value end,
})

MainBox5:AddSlider("Pred_Speed", {
    Text = "Prediction Speed (higher = less lead)",
    Default = 500, Min = 100, Max = 2000, Rounding = 0,
    Callback = function(Value) Config.PredictSpeed = Value end,
})

MainBox5:AddToggle("Pred_Enabled", {
    Text = "Prediction — Enable",
    Default = true,
    Callback = function(Value) Config.PredictionEnabled = Value end,
})

MainBox5:AddToggle("AutoHS_Enabled", {
    Text = "Force Headshot (override dropdown)",
    Default = false,
    Callback = function(Value) Config.AutoHeadshotEnabled = Value end,
})

MainBox5:AddSlider("Trigger_Delay", {
    Text = "Trigger Delay (ms)",
    Default = 50, Min = 0, Max = 500, Rounding = 0,
    Callback = function(Value) Config.TriggerDelay = Value / 1000 end,
})

MainBox5:AddToggle("Trigger_Enabled", {
    Text = "Trigger Bot + (FOV Circle)",
    Default = false,
    Callback = function(Value) Config.TriggerBotEnabled = Value end,
})

MainBox5:AddToggle("Silent_Enabled", {
    Text = "Silent Aim + (FOV Circle)",
    Default = false,
    Callback = function(Value)
        Config.SilentAimEnabled = Value
        if Value then InstallSilentAim() end
    end,
})

MainBox5:AddToggle("Team_Check", {
    Text = "Team Check",
    Default = true,
    Callback = function(Value) Config.TeamCheck = Value end,
})

MainBox5:AddToggle("Wall_Check", {
    Text = "Wall Check (LOS)",
    Default = true,
    Callback = function(Value) Config.WallCheck = Value end,
})

MainBox5:AddButton({
    Text = "Clear Current Target",
    Func = function() AimTarget = nil end,
})


local VisualBox = Tabs.Visual:AddLeftGroupbox("Infenction ESP", "eye")
local VisualBox2 = Tabs.Visual:AddRightGroupbox("Objects ESP", "eye")
local VisualBox3 = Tabs.Visual:AddRightGroupbox("Quests ESP", "eye")

--== PART 1: UI ==--
task.spawn(function()
    task.wait(2)
    local ok, err = pcall(function()
        if not VisualBox then return end

        _G.EspV4 = {
            State = {
                PlayerESP = false,
                NpcESP = false,
                EnemyESP = false,
                WallCheck = false,
                Distance = 500,
                Enemies = { Dave = false, Chimera = false, Gilbert = false, Mikhail = false, SIN = false },
            }
        }

        VisualBox:AddToggle("Esp4_Player", {
            Text = "Player ESP",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.PlayerESP = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Npc", {
            Text = "Enemy ESP",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.NpcESP = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Enemy", {
            Text = "Bosses ESP Master",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.EnemyESP = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Wall", {
            Text = "WallCheck",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.WallCheck = (v == true) end
                end)
            end,
        })

        VisualBox:AddSlider("Esp4_Distance", {
            Text = "ESP Distance",
            Min = 50,
            Max = 2000,
            Default = 500,
            Rounding = 0,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Distance = tonumber(v) or 500 end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Dave", {
            Text = "Dave (Orange)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Enemies.Dave = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Chimera", {
            Text = "Chimera (Purple)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Enemies.Chimera = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Gilbert", {
            Text = "Gilbert (Blue)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Enemies.Gilbert = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_Mikhail", {
            Text = "Mikhail (White)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Enemies.Mikhail = (v == true) end
                end)
            end,
        })

        VisualBox:AddToggle("Esp4_SIN", {
            Text = "SIN (Pink)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.EspV4 then _G.EspV4.State.Enemies.SIN = (v == true) end
                end)
            end,
        })

        print("[EspV4] UI ✓ (Skeleton + Label, no dropdown)")
    end)
    if not ok then warn("[EspV4] UI Error:", err) end
end)

--== PART 2: BACKEND ==--
task.spawn(function()
    task.wait(3)
    local ok, err = pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LP = Players.LocalPlayer
        local CAM = workspace.CurrentCamera

        if not _G.EspV4 then
            _G.EspV4 = {
                State = {
                    PlayerESP = false, NpcESP = false, EnemyESP = false,
                    WallCheck = false, Distance = 500,
                    Enemies = { Dave = false, Chimera = false, Gilbert = false, Mikhail = false, SIN = false },
                }
            }
        end
        local State = _G.EspV4.State

        --══════ CONFIG ══════
        local CFG = {
            FontSize = 7,
            NameRow = UDim2.new(0, 130, 0, 12),
            InfoRow = UDim2.new(0, 130, 0, 11),
            Offset = Vector3.new(0, 2.6, 0),
            UpdThrottle = 4,
            ScanThrottle = 15,
            WallHidden = Color3.fromRGB(255, 60, 60),
            WallVisible = Color3.fromRGB(120, 200, 255),
        }

        local ENEMY_DEF = {
            Dave    = { color = Color3.fromRGB(255, 140, 40),  keys = {"dave"} },
            Chimera = { color = Color3.fromRGB(180, 80, 255),  keys = {"chimera", "terror"} },
            Gilbert = { color = Color3.fromRGB(60, 140, 255),  keys = {"gilbert"} },
            Mikhail = { color = Color3.fromRGB(240, 240, 240), keys = {"mikhail", "mik"} },
            SIN     = { color = Color3.fromRGB(255, 100, 200), keys = {"sin"} },
        }

        --══════ CACHE ══════
        local PCache = setmetatable({}, {__mode = "k"})
        local NCache = setmetatable({}, {__mode = "k"})
        local ECache = setmetatable({}, {__mode = "k"})
        local Conns  = setmetatable({}, {__mode = "k"})

        --══════ HELPERS ══════
        local function isInvisible(model)
            local total, invisible = 0, 0
            for _, p in ipairs(model:GetDescendants()) do
                if p:IsA("BasePart") then
                    total = total + 1
                    local t = math.max(p.Transparency, p.LocalTransparencyModifier)
                    if t >= 0.9 then invisible = invisible + 1 end
                end
            end
            if total == 0 then return false end
            return (invisible / total) >= 0.7
        end

        local function isDead(model)
            if not model or not model.Parent then return true end
            local hum = model:FindFirstChildOfClass("Humanoid")
            if not hum then return true end
            if hum.Health <= 0 then return true end
            if hum:GetState() == Enum.HumanoidStateType.Dead then return true end
            local rd = model:FindFirstChild("ragdoll")
            if rd and rd:IsA("BoolValue") and rd.Value then return true end
            return false
        end

        local function matchEnemy(model)
            local names = { model.Name:lower() }
            for _, c in ipairs(model:GetChildren()) do
                table.insert(names, c.Name:lower())
            end
            for enemy, def in pairs(ENEMY_DEF) do
                for _, kw in ipairs(def.keys) do
                    for _, n in ipairs(names) do
                        if n:find(kw, 1, true) then return enemy end
                    end
                end
            end
            return nil
        end

        local function wallVisible(target)
            if not State.WallCheck then return true end
            local tp = target:FindFirstChild("Head") or target:FindFirstChild("HumanoidRootPart")
            if not tp then return true end
            local origin = CAM.CFrame.Position
            local dir = tp.Position - origin
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = { LP.Character, target }
            params.IgnoreWater = true
            local hit = workspace:Raycast(origin, dir, params)
            return hit == nil
        end

        --══════════════════════════════════════════════════
        -- FIXED ESP BUILDER: Skeleton (Highlight outline) + Label
        --══════════════════════════════════════════════════
        local function mkSkeleton(model, color)
            local hl = Instance.new("Highlight")
            hl.Name = "__ESP_Skel"
            hl.FillColor = color
            hl.OutlineColor = color
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.9       -- thin body outline
            hl.OutlineTransparency = 0.1    -- visible edges
            hl.Adornee = model
            hl.Parent = model
            return hl
        end

        local function mkLabel(model, color, txt)
            local head = model:FindFirstChild("Head") or model.PrimaryPart

            local bg = Instance.new("BillboardGui")
            bg.Name = "__ESP_Label"
            bg.Adornee = head
            bg.Size = UDim2.new(0, 130, 0, 24)
            bg.StudsOffset = CFG.Offset
            bg.AlwaysOnTop = true
            bg.LightInfluence = 0
            bg.MaxDistance = State.Distance
            bg.Parent = model

            local n = Instance.new("TextLabel")
            n.Name = "NameL"
            n.Size = CFG.NameRow
            n.BackgroundTransparency = 1
            n.TextColor3 = color
            n.TextStrokeTransparency = 0
            n.TextStrokeColor3 = Color3.new()
            n.Font = Enum.Font.GothamMedium
            n.TextSize = CFG.FontSize
            n.Text = txt
            n.TextXAlignment = Enum.TextXAlignment.Center
            n.Parent = bg

            local info = Instance.new("TextLabel")
            info.Name = "InfoL"
            info.Size = CFG.InfoRow
            info.Position = UDim2.new(0, 0, 0, 13)
            info.BackgroundTransparency = 1
            info.TextColor3 = Color3.fromRGB(220, 220, 220)
            info.TextStrokeTransparency = 0
            info.TextStrokeColor3 = Color3.new()
            info.Font = Enum.Font.Code
            info.TextSize = CFG.FontSize
            info.Text = "0 HP · 0m"
            info.TextXAlignment = Enum.TextXAlignment.Center
            info.Parent = bg

            return {bg = bg, name = n, info = info}
        end

        local function buildESP(model, color, txt)
            -- ALWAYS: Skeleton (Highlight) + Label
            return {
                color = color,
                model = model,
                skel = mkSkeleton(model, color),
                label = mkLabel(model, color, txt),
            }
        end

        --══════════════════════════════════════════════════
        -- UPDATE
        --══════════════════════════════════════════════════
        local function hideAll(c)
            if c.skel then c.skel.Enabled = false end
            if c.label and c.label.bg then c.label.bg.Enabled = false end
        end

        local function updateESP(model, cache)
            local c = cache[model]
            if not c or not model.Parent then return end

            local hum = model:FindFirstChildOfClass("Humanoid")
            local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
            local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")

            if isDead(model) then
                hideAll(c)
                c.hidden = true
                return
            end

            local dist = 0
            if root and myRoot then
                dist = math.floor((root.Position - myRoot.Position).Magnitude)
            end

            if dist > State.Distance then
                hideAll(c)
                c.hidden = true
                return
            end
            c.hidden = false

            -- WallCheck override
            local finalColor = c.color
            if State.WallCheck then
                finalColor = wallVisible(model) and CFG.WallVisible or CFG.WallHidden
            end

            -- Skeleton (Highlight)
            if c.skel then
                c.skel.FillColor = finalColor
                c.skel.OutlineColor = finalColor
                c.skel.Enabled = true
            end

            -- Label
            local lbl = c.label
            if lbl then
                if lbl.bg then
                    lbl.bg.Enabled = true
                    lbl.bg.MaxDistance = State.Distance
                end
                if lbl.name then
                    lbl.name.TextColor3 = finalColor
                end
                if lbl.info and hum then
                    local hp = math.floor(hum.Health)
                    lbl.info.Text = string.format("%d HP · %dm", hp, dist)
                    if hp > 60 then
                        lbl.info.TextColor3 = Color3.fromRGB(140, 255, 160)
                    elseif hp > 30 then
                        lbl.info.TextColor3 = Color3.fromRGB(255, 210, 100)
                    else
                        lbl.info.TextColor3 = Color3.fromRGB(255, 120, 120)
                    end
                end
            end

            -- Invisible check (👻 tag)
            if isInvisible(model) then
                if not c.ghost then
                    c.ghost = true
                    if lbl and lbl.name then
                        lbl.name.Text = "👻 " .. lbl.name.Text
                    end
                end
            else
                if c.ghost then
                    c.ghost = false
                    if lbl and lbl.name then
                        lbl.name.Text = lbl.name.Text:gsub("👻 ", "")
                    end
                end
            end
        end

        --══════════════════════════════════════════════════
        -- DESTROY
        --══════════════════════════════════════════════════
        local function destroyESP(model, cache)
            local c = cache[model]
            if not c then return end
            pcall(function()
                if c.skel then c.skel:Destroy() end
                if c.label and c.label.bg then c.label.bg:Destroy() end
            end)
            cache[model] = nil
        end

        --══════════════════════════════════════════════════
        -- AUTO SPAWN / DESPAWN
        --══════════════════════════════════════════════════
        local function bindModel(model)
            if Conns[model] then return end
            local list = {}

            table.insert(list, model.AncestryChanged:Connect(function(_, p)
                if not p then
                    if PCache[model] then pcall(destroyESP, model, PCache) end
                    if NCache[model] then pcall(destroyESP, model, NCache) end
                    if ECache[model] then pcall(destroyESP, model, ECache) end
                    if Conns[model] then
                        for _, cc in ipairs(Conns[model]) do pcall(function() cc:Disconnect() end) end
                        Conns[model] = nil
                    end
                end
            end))

            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum then
                table.insert(list, hum.Died:Connect(function()
                    for _, cache in ipairs({PCache, NCache, ECache}) do
                        local c = cache[model]
                        if c then hideAll(c) end
                    end
                end))
            end

            local rd = model:FindFirstChild("ragdoll")
            if rd and rd:IsA("BoolValue") then
                table.insert(list, rd.Changed:Connect(function(v)
                    if v then
                        for _, cache in ipairs({PCache, NCache, ECache}) do
                            local c = cache[model]
                            if c then hideAll(c) end
                        end
                    end
                end))
            end

            Conns[model] = list
        end

        --══════════════════════════════════════════════════
        -- MASTER LOOP
        --══════════════════════════════════════════════════
        local frame, upd = 0, 0
        local lastP, lastN, lastE = false, false, false

        RunService.Heartbeat:Connect(function()
            frame = frame + 1
            upd = upd + 1

            local chars = workspace:FindFirstChild("Characters")
            if not chars then return end

            if lastP and not State.PlayerESP then
                for m, _ in pairs(PCache) do pcall(destroyESP, m, PCache) end
            end
            if lastN and not State.NpcESP then
                for m, _ in pairs(NCache) do pcall(destroyESP, m, NCache) end
            end
            if lastE and not State.EnemyESP then
                for m, _ in pairs(ECache) do pcall(destroyESP, m, ECache) end
            end
            lastP, lastN, lastE = State.PlayerESP, State.NpcESP, State.EnemyESP

            local doScan = (frame % CFG.ScanThrottle == 0)
            local doUpdate = (upd % CFG.UpdThrottle == 0)

            for _, model in ipairs(chars:GetChildren()) do
                if model:IsA("Model") then
                    local ePlr = Players:GetPlayerFromCharacter(model)
                    local isPlayer = ePlr ~= nil
                    local enemyName = matchEnemy(model)

                    -- PLAYER
                    if isPlayer and model ~= LP.Character then
                        if State.PlayerESP then
                            if not PCache[model] and doScan then
                                local color = (ePlr.Team == LP.Team)
                                    and Color3.fromRGB(80, 255, 120)
                                    or (ePlr.Team and ePlr.Team.TeamColor.Color or Color3.fromRGB(255, 100, 100))
                                pcall(function()
                                    PCache[model] = buildESP(model, color, ePlr.Name)
                                    bindModel(model)
                                end)
                            end
                            if PCache[model] and doUpdate then
                                pcall(updateESP, model, PCache)
                            end
                        elseif PCache[model] then
                            pcall(destroyESP, model, PCache)
                        end

                    -- ENEMY
                    elseif enemyName then
                        if State.EnemyESP then
                            local on = State.Enemies[enemyName]
                            if on then
                                if not ECache[model] and doScan then
                                    local color = ENEMY_DEF[enemyName].color
                                    pcall(function()
                                        ECache[model] = buildESP(model, color, enemyName)
                                        bindModel(model)
                                    end)
                                end
                                if ECache[model] and doUpdate then
                                    pcall(updateESP, model, ECache)
                                end
                            elseif ECache[model] then
                                pcall(destroyESP, model, ECache)
                            end
                        elseif ECache[model] then
                            pcall(destroyESP, model, ECache)
                        end

                    -- NPC
                    else
                        if State.NpcESP then
                            if not NCache[model] and doScan then
                                pcall(function()
                                    NCache[model] = buildESP(model, Color3.fromRGB(255, 165, 60), model.Name)
                                    bindModel(model)
                                end)
                            end
                            if NCache[model] and doUpdate then
                                pcall(updateESP, model, NCache)
                            end
                        elseif NCache[model] then
                            pcall(destroyESP, model, NCache)
                        end
                    end
                end
            end
        end)

        --══════════════════════════════════════════════════
        -- AUTO DESPAWN
        --══════════════════════════════════════════════════
        local chars2 = workspace:FindFirstChild("Characters")
        if chars2 then
            chars2.ChildRemoved:Connect(function(model)
                if PCache[model] then pcall(destroyESP, model, PCache) end
                if NCache[model] then pcall(destroyESP, model, NCache) end
                if ECache[model] then pcall(destroyESP, model, ECache) end
                if Conns[model] then
                    for _, c in ipairs(Conns[model]) do pcall(function() c:Disconnect() end) end
                    Conns[model] = nil
                end
            end)
        end

        --══════════════════════════════════════════════════
        -- PUBLIC API
        --══════════════════════════════════════════════════
        _G.EspV4.Set = function(f, v)
            if State[f] ~= nil then State[f] = (v == true); return true end
            if State.Enemies[f] ~= nil then State.Enemies[f] = (v == true); return true end
            return false
        end
        _G.EspV4.Get = function(f)
            if State[f] ~= nil then return State[f] end
            if State.Enemies[f] ~= nil then return State.Enemies[f] end
            return nil
        end
        _G.EspV4.DisableAll = function()
            for k, _ in pairs(State) do
                if type(State[k]) == "boolean" then State[k] = false end
            end
            for k, _ in pairs(State.Enemies) do State.Enemies[k] = false end
            for m, _ in pairs(PCache) do pcall(destroyESP, m, PCache) end
            for m, _ in pairs(NCache) do pcall(destroyESP, m, NCache) end
            for m, _ in pairs(ECache) do pcall(destroyESP, m, ECache) end
        end

        print("[EspV4] Backend ✓ (Skeleton + Label, fixed)")
    end)
    if not ok then warn("[EspV4] Backend Error:", err) end
end)

print("[Loader] EspV4 ready ✓")










--//======================================================
--// INOC3NT HUB - OPTIMIZED OBJECT ESP SYSTEM
--// LOW LAG / LOW FPS DROP / NO DUPLICATE
--// EVENT DRIVEN / CACHE BASED / SPAWN DESPAWN SAFE
--// VISUALBOX2 ONLY
--//======================================================

pcall(function()

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")

    local LP = Players.LocalPlayer

    if not LP then
        return
    end

    if not VisualBox2 then
        return
    end

    --==================================================
    -- CONFIG
    --==================================================

    local ESP_CFG = {
        Master = false,
        Distance = 300,

        Lockers = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        },

        Chems = {
            Enabled = false,
            Color = Color3.fromRGB(255,200,0)
        },

        Axe = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        },

        Documents = {
            Enabled = false,
            Color = Color3.fromRGB(255,140,0)
        },

        AT7 = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        },

        Landmine = {
            Enabled = false,
            Color = Color3.fromRGB(255,0,0)
        },

        C4 = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        },

        Loot = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        },

        Ammo = {
            Enabled = false,
            Color = Color3.fromRGB(255,255,255)
        }
    }

    --==================================================
    -- CACHE
    --==================================================

    local ESP_CACHE = {}
    local FEATURE_CONNECTIONS = {}
    local SCAN_DEBOUNCE = {}

    --==================================================
    -- HELPERS
    --==================================================

    local function GetRoot(Object)
        if not Object then
            return nil
        end

        if Object:IsA("BasePart") then
            return Object
        end

        if Object:IsA("Model") then
            if Object.PrimaryPart then
                return Object.PrimaryPart
            end

            local HRP = Object:FindFirstChild("HumanoidRootPart")
            if HRP and HRP:IsA("BasePart") then
                return HRP
            end

            local Root = Object:FindFirstChildWhichIsA("BasePart", true)

            if Root then
                return Root
            end
        end

        return nil
    end

    local function GetDistance(Object)
        local Root = GetRoot(Object)

        if not Root then
            return math.huge
        end

        local Character = LP.Character

        if not Character then
            return math.huge
        end

        local HRP = Character:FindFirstChild("HumanoidRootPart")

        if not HRP then
            return math.huge
        end

        return (HRP.Position - Root.Position).Magnitude
    end

    local function IsAlive(Object)
        return Object
            and Object.Parent
            and Object:IsDescendantOf(Workspace)
    end

    local function RemoveESP(Object)
        local Data = ESP_CACHE[Object]

        if not Data then
            return
        end

        if Data.Highlight then
            pcall(function()
                Data.Highlight:Destroy()
            end)
        end

        if Data.Billboard then
            pcall(function()
                Data.Billboard:Destroy()
            end)
        end

        ESP_CACHE[Object] = nil
    end

    local function RemoveAllESP()
        for Object in pairs(ESP_CACHE) do
            RemoveESP(Object)
        end
    end

    --==================================================
    -- CREATE ESP
    --==================================================

    local function CreateESP(Object, Feature, ShowName)
        if not Object then
            return
        end

        if not ESP_CFG.Master then
            return
        end

        if not ESP_CFG[Feature] then
            return
        end

        if not ESP_CFG[Feature].Enabled then
            return
        end

        if not IsAlive(Object) then
            return
        end

        local Root = GetRoot(Object)

        if not Root then
            return
        end

        -- Prevent duplicate
        local Existing = ESP_CACHE[Object]

        if Existing then
            Existing.Feature = Feature
            Existing.ShowName = ShowName
            Existing.Color = ESP_CFG[Feature].Color

            if Existing.Highlight then
                Existing.Highlight.Adornee = Object
                Existing.Highlight.OutlineColor = Existing.Color
            end

            return
        end

        local Highlight = Instance.new("Highlight")

        Highlight.Name = "InoC3nt_ObjectESP"
        Highlight.Adornee = Object
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 0
        Highlight.OutlineColor = ESP_CFG[Feature].Color
        Highlight.Parent = Object

        local Billboard

        if ShowName then
            Billboard = Instance.new("BillboardGui")

            Billboard.Name = "InoC3nt_ObjectESP_Name"
            Billboard.Adornee = Root
            Billboard.AlwaysOnTop = true
            Billboard.Size = UDim2.fromOffset(160,30)
            Billboard.StudsOffset = Vector3.new(0,2.8,0)
            Billboard.MaxDistance = ESP_CFG.Distance
            Billboard.Parent = Root

            local Label = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.fromScale(1,1)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 7
            Label.TextStrokeTransparency = 0
            Label.TextColor3 = ESP_CFG[Feature].Color
            Label.Text = Object.Name
            Label.Parent = Billboard
        end

        ESP_CACHE[Object] = {
            Highlight = Highlight,
            Billboard = Billboard,
            Feature = Feature,
            ShowName = ShowName,
            Color = ESP_CFG[Feature].Color
        }
    end

    --==================================================
    -- UPDATE EXISTING ESP
    --==================================================

    local function UpdateESP()
        for Object, Data in pairs(ESP_CACHE) do

            if not IsAlive(Object) then
                RemoveESP(Object)
            else
                local Config = ESP_CFG[Data.Feature]

                if not ESP_CFG.Master
                    or not Config
                    or not Config.Enabled then

                    RemoveESP(Object)

                else
                    local Distance = GetDistance(Object)

                    if Distance > ESP_CFG.Distance then
                        if Data.Highlight then
                            Data.Highlight.Enabled = false
                        end

                        if Data.Billboard then
                            Data.Billboard.Enabled = false
                        end
                    else
                        if Data.Highlight then
                            Data.Highlight.Enabled = true
                            Data.Highlight.OutlineColor = Config.Color
                        end

                        if Data.Billboard then
                            Data.Billboard.Enabled = true
                            Data.Billboard.MaxDistance = ESP_CFG.Distance

                            local Label = Data.Billboard:FindFirstChild("Label")

                            if Label then
                                Label.TextColor3 = Config.Color
                                Label.Text = Object.Name
                            end
                        end
                    end
                end
            end
        end
    end

    --==================================================
    -- SAFE SCAN
    --==================================================

    local function SafeScan(Key, Callback)
        if SCAN_DEBOUNCE[Key] then
            return
        end

        SCAN_DEBOUNCE[Key] = true

        task.delay(0.15, function()
            SCAN_DEBOUNCE[Key] = nil

            pcall(Callback)
        end)
    end

    --==================================================
    -- LOCKERS
    --==================================================

    local function ScanLockers()
        if not ESP_CFG.Lockers.Enabled then
            return
        end

        local Folder = Workspace:FindFirstChild("Lockers")

        if not Folder then
            return
        end

        for _, Object in ipairs(Folder:GetChildren()) do
            if Object:IsA("Model") then
                CreateESP(Object, "Lockers", true)
            end
        end
    end

    --==================================================
    -- CHEMS
    --==================================================

    local function ScanChems()
        if not ESP_CFG.Chems.Enabled then
            return
        end

        local Folder = Workspace:FindFirstChild("Chems")

        if not Folder then
            return
        end

        for _, Object in ipairs(Folder:GetChildren()) do
            if Object:IsA("Model") then
                CreateESP(Object, "Chems", false)
            end
        end
    end

    --==================================================
    -- AXE
    --==================================================

    local function ScanAxe()
        if not ESP_CFG.Axe.Enabled then
            return
        end

        local Folder = Workspace:FindFirstChild("AxeContainer Props")

        if not Folder then
            return
        end

        for _, Object in ipairs(Folder:GetChildren()) do
            if Object:IsA("Model") then
                CreateESP(Object, "Axe", false)
            end
        end
    end

    --==================================================
    -- DOCUMENTS
    --==================================================

    local function ScanDocuments()
        if not ESP_CFG.Documents.Enabled then
            return
        end

        local Folder = Workspace:FindFirstChild("Documents")

        if not Folder then
            return
        end

        for _, Object in ipairs(Folder:GetChildren()) do
            if Object:IsA("Model") then
                CreateESP(Object, "Documents", true)
            end
        end
    end

    --==================================================
    -- AT7
    --==================================================

    local function ScanAT7()
        if not ESP_CFG.AT7.Enabled then
            return
        end

        local Folder = Workspace:FindFirstChild("Baseplate Props 4 Copying")

        if not Folder then
            return
        end

        for _, Object in ipairs(Folder:GetDescendants()) do

            if Object:IsA("Model")
                and string.lower(Object.Name) == "at7caseinteractible" then

                local WorldModel = Object:FindFirstChild(
                    "AT7WorldModel",
                    true
                )

                if WorldModel and WorldModel:IsA("Model") then
                    CreateESP(WorldModel, "AT7", false)
                end
            end
        end
    end

    --==================================================
    -- LANDMINE
    --==================================================

    local function ScanLandmine()
        if not ESP_CFG.Landmine.Enabled then
            return
        end

        for _, Object in ipairs(Workspace:GetChildren()) do

            if Object:IsA("Model")
                and string.lower(Object.Name) == "landmine" then

                CreateESP(Object, "Landmine", false)
            end
        end
    end

    --==================================================
    -- C4
    --==================================================

    local function ScanC4()
        if not ESP_CFG.C4.Enabled then
            return
        end

        local Map = Workspace:FindFirstChild("Map")

        if not Map then
            return
        end

        for _, Object in ipairs(Map:GetChildren()) do

            if Object:IsA("Model")
                and string.lower(Object.Name) == "c4" then

                local Handle = Object:FindFirstChild(
                    "Handle",
                    true
                )

                if Handle and Handle:IsA("BasePart") then

                    local Prompt = Handle:FindFirstChildWhichIsA(
                        "ProximityPrompt",
                        true
                    )

                    if Prompt then
                        CreateESP(Object, "C4", false)
                    end
                end
            end
        end
    end

    --==================================================
    -- LOOT
    --==================================================

    local function ScanLoot()
        if not ESP_CFG.Loot.Enabled then
            return
        end

        local Map = Workspace:FindFirstChild("Map")

        if not Map then
            return
        end

        for _, Object in ipairs(Map:GetChildren()) do

            local ObjectName = string.lower(Object.Name)

            if Object:IsA("Model")
                and (
                    ObjectName == "lootbox"
                    or ObjectName == "lootcrate"
                ) then

                local Case = Object:FindFirstChild(
                    "Case",
                    true
                )

                if Case then

                    local CrateRoot = Case:FindFirstChild(
                        "CrateRoot",
                        true
                    )

                    if CrateRoot
                        and CrateRoot:IsA("BasePart") then

                        local Prompt = CrateRoot:FindFirstChildWhichIsA(
                            "ProximityPrompt",
                            true
                        )

                        if Prompt then
                            CreateESP(Object, "Loot", false)
                        end
                    end
                end
            end
        end
    end

    --==================================================
    -- AMMO
    --==================================================

    local function ScanAmmo()
        if not ESP_CFG.Ammo.Enabled then
            return
        end

        local Map = Workspace:FindFirstChild("Map")

        if not Map then
            return
        end

        for _, Object in ipairs(Map:GetChildren()) do

            if Object:IsA("Model")
                and string.lower(Object.Name) == "ammoboxgiver" then

                local Ammo = Object:FindFirstChild(
                    "Ammo",
                    true
                )

                if Ammo and Ammo:IsA("BasePart") then

                    local Prompt = Ammo:FindFirstChild(
                        "AmmoPrompt",
                        true
                    )

                    if not Prompt then
                        Prompt = Ammo:FindFirstChildWhichIsA(
                            "ProximityPrompt",
                            true
                        )
                    end

                    if Prompt then
                        CreateESP(Object, "Ammo", true)
                    end
                end
            end
        end
    end

    --==================================================
    -- INITIAL SCAN
    --==================================================

    local function ScanFeature(Feature)

        if Feature == "Lockers" then
            ScanLockers()

        elseif Feature == "Chems" then
            ScanChems()

        elseif Feature == "Axe" then
            ScanAxe()

        elseif Feature == "Documents" then
            ScanDocuments()

        elseif Feature == "AT7" then
            ScanAT7()

        elseif Feature == "Landmine" then
            ScanLandmine()

        elseif Feature == "C4" then
            ScanC4()

        elseif Feature == "Loot" then
            ScanLoot()

        elseif Feature == "Ammo" then
            ScanAmmo()
        end
    end

    local function ScanAllEnabled()

        SafeScan("Lockers", ScanLockers)
        SafeScan("Chems", ScanChems)
        SafeScan("Axe", ScanAxe)
        SafeScan("Documents", ScanDocuments)
        SafeScan("AT7", ScanAT7)
        SafeScan("Landmine", ScanLandmine)
        SafeScan("C4", ScanC4)
        SafeScan("Loot", ScanLoot)
        SafeScan("Ammo", ScanAmmo)
    end

    --==================================================
    -- MASTER TOGGLE
    --==================================================

    local function SetMaster(Value)
        ESP_CFG.Master = Value

        if not Value then
            RemoveAllESP()
            return
        end

        ScanAllEnabled()
    end

    --==================================================
    -- FEATURE TOGGLE
    --==================================================

    local function SetFeature(Feature, Value)
        ESP_CFG[Feature].Enabled = Value

        if not Value then

            for Object, Data in pairs(ESP_CACHE) do
                if Data.Feature == Feature then
                    RemoveESP(Object)
                end
            end

            return
        end

        if ESP_CFG.Master then
            ScanFeature(Feature)
        end
    end

    --==================================================
    -- COLOR UPDATE
    --==================================================

    local function SetColor(Feature, Color)

        ESP_CFG[Feature].Color = Color

        for Object, Data in pairs(ESP_CACHE) do

            if Data.Feature == Feature then

                if Data.Highlight then
                    Data.Highlight.OutlineColor = Color
                end

                if Data.Billboard then
                    local Label = Data.Billboard:FindFirstChild("Label")

                    if Label then
                        Label.TextColor3 = Color
                    end
                end
            end
        end
    end

    --==================================================
    -- UI
    --==================================================

    pcall(function()

        VisualBox2:AddToggle("ObjectESP_Master", {
            Text = "Master ESP",
            Default = false,

            Callback = function(Value)
                SetMaster(Value)
            end
        })

        VisualBox2:AddSlider("ObjectESP_Distance", {
            Text = "ESP Distance",
            Default = 300,
            Min = 50,
            Max = 1000,
            Rounding = 0,

            Callback = function(Value)
                ESP_CFG.Distance = Value
            end
        })

        VisualBox2:AddToggle("ObjectESP_Lockers", {
            Text = "Lockers ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Lockers", Value)
            end
        }):AddColorPicker("ObjectESP_Lockers_Color", {
            Default = ESP_CFG.Lockers.Color,

            Callback = function(Value)
                SetColor("Lockers", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Chems", {
            Text = "Chems ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Chems", Value)
            end
        }):AddColorPicker("ObjectESP_Chems_Color", {
            Default = ESP_CFG.Chems.Color,

            Callback = function(Value)
                SetColor("Chems", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Axe", {
            Text = "Axe ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Axe", Value)
            end
        }):AddColorPicker("ObjectESP_Axe_Color", {
            Default = ESP_CFG.Axe.Color,

            Callback = function(Value)
                SetColor("Axe", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Documents", {
            Text = "Documents ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Documents", Value)
            end
        }):AddColorPicker("ObjectESP_Documents_Color", {
            Default = ESP_CFG.Documents.Color,

            Callback = function(Value)
                SetColor("Documents", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_AT7", {
            Text = "AT7 ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("AT7", Value)
            end
        }):AddColorPicker("ObjectESP_AT7_Color", {
            Default = ESP_CFG.AT7.Color,

            Callback = function(Value)
                SetColor("AT7", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Landmine", {
            Text = "Landmine ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Landmine", Value)
            end
        }):AddColorPicker("ObjectESP_Landmine_Color", {
            Default = ESP_CFG.Landmine.Color,

            Callback = function(Value)
                SetColor("Landmine", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_C4", {
            Text = "C4 ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("C4", Value)
            end
        }):AddColorPicker("ObjectESP_C4_Color", {
            Default = ESP_CFG.C4.Color,

            Callback = function(Value)
                SetColor("C4", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Loot", {
            Text = "LootBox / LootCrate ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Loot", Value)
            end
        }):AddColorPicker("ObjectESP_Loot_Color", {
            Default = ESP_CFG.Loot.Color,

            Callback = function(Value)
                SetColor("Loot", Value)
            end
        })

        VisualBox2:AddToggle("ObjectESP_Ammo", {
            Text = "AmmoBox ESP",
            Default = false,

            Callback = function(Value)
                SetFeature("Ammo", Value)
            end
        }):AddColorPicker("ObjectESP_Ammo_Color", {
            Default = ESP_CFG.Ammo.Color,

            Callback = function(Value)
                SetColor("Ammo", Value)
            end
        })

    end)

    --==================================================
    -- EVENT SYSTEM
    --==================================================

    local function ConnectFolder(FolderName, Feature)

        local Folder = Workspace:FindFirstChild(FolderName)

        if not Folder then
            return
        end

        if FEATURE_CONNECTIONS[Feature] then
            return
        end

        FEATURE_CONNECTIONS[Feature] = Folder.DescendantAdded:Connect(function()
            if ESP_CFG.Master and ESP_CFG[Feature].Enabled then
                SafeScan(Feature, function()
                    ScanFeature(Feature)
                end)
            end
        end)

        Folder.DescendantRemoving:Connect(function(Object)
            if ESP_CACHE[Object] then
                RemoveESP(Object)
            end
        end)
    end

    --==================================================
    -- LOCKERS / CHEMS / DOCUMENTS / AXE
    --==================================================

    ConnectFolder("Lockers", "Lockers")
    ConnectFolder("Chems", "Chems")
    ConnectFolder("Documents", "Documents")
    ConnectFolder("AxeContainer Props", "Axe")

    --==================================================
    -- AT7
    --==================================================

    local AT7Folder = Workspace:FindFirstChild(
        "Baseplate Props 4 Copying"
    )

    if AT7Folder then

        AT7Folder.DescendantAdded:Connect(function()
            if ESP_CFG.Master and ESP_CFG.AT7.Enabled then
                SafeScan("AT7", ScanAT7)
            end
        end)

        AT7Folder.DescendantRemoving:Connect(function(Object)
            if ESP_CACHE[Object] then
                RemoveESP(Object)
            end
        end)
    end

    --==================================================
    -- MAP EVENTS
    --==================================================

    local Map = Workspace:FindFirstChild("Map")

    if Map then

        Map.DescendantAdded:Connect(function()
            if not ESP_CFG.Master then
                return
            end

            if ESP_CFG.C4.Enabled then
                SafeScan("C4", ScanC4)
            end

            if ESP_CFG.Loot.Enabled then
                SafeScan("Loot", ScanLoot)
            end

            if ESP_CFG.Ammo.Enabled then
                SafeScan("Ammo", ScanAmmo)
            end
        end)

        Map.DescendantRemoving:Connect(function(Object)

            if ESP_CACHE[Object] then
                RemoveESP(Object)
            end

            for Target, Data in pairs(ESP_CACHE) do

                if Target:IsDescendantOf(Object) then
                    RemoveESP(Target)
                end

            end
        end)
    end

    --==================================================
    -- LANDMINE DIRECT CHILD EVENT
    --==================================================

    Workspace.ChildAdded:Connect(function(Object)

        if not ESP_CFG.Master then
            return
        end

        if not ESP_CFG.Landmine.Enabled then
            return
        end

        if Object:IsA("Model")
            and string.lower(Object.Name) == "landmine" then

            SafeScan("Landmine", ScanLandmine)
        end
    end)

    Workspace.ChildRemoved:Connect(function(Object)

        if ESP_CACHE[Object] then
            RemoveESP(Object)
        end
    end)

    --==================================================
    -- CHARACTER RESPAWN
    --==================================================

    LP.CharacterAdded:Connect(function()

        task.delay(0.5, function()

            if ESP_CFG.Master then
                UpdateESP()
            end

        end)

    end)

    --==================================================
    -- LOW LAG UPDATE LOOP
    --==================================================

    task.spawn(function()

        while task.wait(0.25) do

            if ESP_CFG.Master then
                pcall(UpdateESP)
            end

        end

    end)

    --==================================================
    -- INITIAL DELAY
    --==================================================

    task.delay(0.5, function()

        if ESP_CFG.Master then
            ScanAllEnabled()
        end

    end)

end)
























local MiscBox = Tabs.Misc:AddLeftGroupbox("FPS Features", "cog")
local MiscBox2 = Tabs.Misc:AddRightGroupbox("Misc Features", "eye")


MiscBox:AddToggle("ExtremeFPSMode", {
    Text = "⚡ xtreme FPS Mode",
    Default = false,
    Callback = function(v)
        pcall(function()
            if _G.ExtremeFPS and _G.ExtremeFPS.Set then
                _G.ExtremeFPS.Set("Enabled", v)
            end
        end)
    end,
})

MiscBox:AddToggle("KeepGunEffects", {
    Text = "Keep Gun Effects",
    Default = false,
    Callback = function(v)
        pcall(function()
            if _G.ExtremeFPS and _G.ExtremeFPS.Set then
                _G.ExtremeFPS.Set("KeepGunEffects", v)
            end
        end)
    end,
})

print("[ExtremeFPS] UI loaded ✓ — 2 toggles")

--══════════════════════════════════════════════════════════════════
-- STEP 2: BACKEND (task.spawn + pcall — UI block မလုပ်)
--══════════════════════════════════════════════════════════════════

task.spawn(function()
    local ok, err = pcall(function()
        local Players    = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Lighting   = game:GetService("Lighting")
        local LP         = Players.LocalPlayer

        --========================================================--
        -- STATE
        --========================================================--
        local State = {
            Enabled        = false,
            KeepGunEffects = false,   -- Muzzle/Shell/Tracer preserve
        }

        _G.ExtremeFPS = _G.ExtremeFPS or {}
        _G.ExtremeFPS.State = State

        --========================================================--
        -- STORAGE (Weak tables — memory safe)
        --========================================================--
        local saved = {
            lighting = {},
            effects  = {},
            particles = setmetatable({}, {__mode = "k"}),
            beams    = setmetatable({}, {__mode = "k"}),
            trails   = setmetatable({}, {__mode = "k"}),
            fire     = setmetatable({}, {__mode = "k"}),
            smoke    = setmetatable({}, {__mode = "k"}),
            sparkles = setmetatable({}, {__mode = "k"}),
            parts    = setmetatable({}, {__mode = "k"}),
            textures = setmetatable({}, {__mode = "k"}),
            decals   = setmetatable({}, {__mode = "k"}),
            skies    = {},
            ccEffects = {},
            deadBodies = {},
        }
        local lightingSaved = false

        --========================================================--
        -- GUN EFFECT KEYWORDS (Keep Gun Effects)
        --========================================================--
        local GUN_KEYWORDS = {
            "muzzle", "shell", "tracer", "bullet", "firepoint",
            "casings", "gunfire",
        }

        local function isGunEffect(obj)
            if not obj then return false end
            local n = obj.Name:lower()
            for _, kw in ipairs(GUN_KEYWORDS) do
                if n:find(kw, 1, true) then return true end
            end
            -- Parent name check
            local p = obj.Parent
            if p then
                local pn = p.Name:lower()
                for _, kw in ipairs(GUN_KEYWORDS) do
                    if pn:find(kw, 1, true) then return true end
                end
            end
            return false
        end

        --========================================================--
        -- SAVE LIGHTING
        --========================================================--
        local function saveLighting()
            if lightingSaved then return end
            lightingSaved = true

            saved.lighting.FogEnd = Lighting.FogEnd
            saved.lighting.FogStart = Lighting.FogStart
            saved.lighting.FogColor = Lighting.FogColor
            saved.lighting.Ambient = Lighting.Ambient
            saved.lighting.OutdoorAmbient = Lighting.OutdoorAmbient
            saved.lighting.Brightness = Lighting.Brightness
            saved.lighting.ClockTime = Lighting.ClockTime
            saved.lighting.GlobalShadows = Lighting.GlobalShadows
            saved.lighting.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
            saved.lighting.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
            saved.lighting.ShadowSoftness = Lighting.ShadowSoftness
        end

        --========================================================--
        -- APPLY LIGHTING OPTIMIZE
        --========================================================--
        local function applyLighting()
            saveLighting()

            -- Fog
            Lighting.FogEnd = 1e9
            Lighting.FogStart = 1e9
            Lighting.FogColor = Color3.fromRGB(255,255,255)

            -- Atmosphere
            for _, atm in ipairs(Lighting:GetChildren()) do
                if atm:IsA("Atmosphere") then
                    if saved.effects[atm] == nil then
                        saved.effects[atm] = {
                            Density = atm.Density,
                            Haze = atm.Haze,
                            Glare = atm.Glare,
                        }
                    end
                    atm.Density = 0
                    atm.Haze = 0
                    atm.Glare = 0
                end
            end

            -- Global shadows
            Lighting.GlobalShadows = false
            Lighting.ShadowSoftness = 0

            -- Environment
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0

            -- Low brightness
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(150,150,150)
            Lighting.OutdoorAmbient = Color3.fromRGB(150,150,150)

            -- Static time
            Lighting.ClockTime = 14

            -- Post-FX
            for _, eff in ipairs(Lighting:GetChildren()) do
                local isPostFX = 
                    eff:IsA("BloomEffect") or
                    eff:IsA("DepthOfFieldEffect") or
                    eff:IsA("BlurEffect") or
                    eff:IsA("SunRaysEffect") or
                    eff:IsA("ColorCorrectionEffect")

                if isPostFX then
                    if saved.effects[eff] == nil then
                        saved.effects[eff] = eff.Enabled
                    end
                    eff.Enabled = false
                end

                -- Sky
                if eff:IsA("Sky") then
                    if not saved.skies[eff] then
                        saved.skies[eff] = {
                            Parent = eff.Parent,
                        }
                        pcall(function()
                            eff.Parent = nil
                        end)
                    end
                end
            end
        end

        --========================================================--
        -- RESTORE LIGHTING
        --========================================================--
        local function restoreLighting()
            if not lightingSaved then return end

            for k, v in pairs(saved.lighting) do
                if Lighting[k] ~= nil then
                    pcall(function() Lighting[k] = v end)
                end
            end

            -- Atmosphere
            for atm, data in pairs(saved.effects) do
                if atm and atm.Parent and atm:IsA("Atmosphere") then
                    pcall(function()
                        atm.Density = data.Density
                        atm.Haze = data.Haze
                        atm.Glare = data.Glare
                    end)
                end
            end

            -- Post-FX
            for eff, state in pairs(saved.effects) do
                if eff and eff.Parent and typeof(state) == "boolean" then
                    pcall(function() eff.Enabled = state end)
                end
            end

            -- Sky
            for sky, data in pairs(saved.skies) do
                if sky and data.Parent then
                    pcall(function() sky.Parent = data.Parent end)
                end
            end
            table.clear(saved.skies)
            table.clear(saved.effects)

            lightingSaved = false
        end

        --========================================================--
        -- PROCESS OBJECT (Particles, Parts, Textures)
        --========================================================--
        local function processObject(obj)
            if not obj or not obj.Parent then return end

            local gunCheck = State.KeepGunEffects and isGunEffect(obj)

            -- Particles
            if obj:IsA("ParticleEmitter") then
                if not gunCheck then
                    if saved.particles[obj] == nil then
                        saved.particles[obj] = obj.Enabled
                    end
                    if obj.Enabled then obj.Enabled = false end
                end
                return
            end

            -- Beams
            if obj:IsA("Beam") then
                if not gunCheck then
                    if saved.beams[obj] == nil then
                        saved.beams[obj] = obj.Enabled
                    end
                    if obj.Enabled then obj.Enabled = false end
                end
                return
            end

            -- Trails
            if obj:IsA("Trail") then
                if not gunCheck then
                    if saved.trails[obj] == nil then
                        saved.trails[obj] = obj.Enabled
                    end
                    if obj.Enabled then obj.Enabled = false end
                end
                return
            end

            -- Fire
            if obj:IsA("Fire") then
                if saved.fire[obj] == nil then
                    saved.fire[obj] = obj.Enabled
                end
                if obj.Enabled then obj.Enabled = false end
                return
            end

            -- Smoke
            if obj:IsA("Smoke") then
                if saved.smoke[obj] == nil then
                    saved.smoke[obj] = obj.Enabled
                end
                if obj.Enabled then obj.Enabled = false end
                return
            end

            -- Sparkles
            if obj:IsA("Sparkles") then
                if saved.sparkles[obj] == nil then
                    saved.sparkles[obj] = obj.Enabled
                end
                if obj.Enabled then obj.Enabled = false end
                return
            end

            -- Blood particles (specific)
            if obj:IsA("ParticleEmitter") then
                local n = obj.Name:lower()
                if n:find("blood") or n:find("gib") then
                    if saved.particles[obj] == nil then
                        saved.particles[obj] = obj.Enabled
                    end
                    if obj.Enabled then obj.Enabled = false end
                end
                return
            end

            -- BasePart
            if obj:IsA("BasePart") then
                if saved.parts[obj] == nil then
                    saved.parts[obj] = {
                        CastShadow = obj.CastShadow,
                        Material = obj.Material,
                    }
                end
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
                return
            end

            -- Texture
            if obj:IsA("Texture") then
                if saved.textures[obj] == nil then
                    saved.textures[obj] = obj.Transparency
                end
                obj.Transparency = 1
                return
            end

            -- Decal
            if obj:IsA("Decal") then
                if saved.decals[obj] == nil then
                    saved.decals[obj] = obj.Transparency
                end
                obj.Transparency = 1
                return
            end
        end

        --========================================================--
        -- CLEANUP DEAD BODIES
        --========================================================--
        local function cleanDeadBodies()
            local chars = workspace:FindFirstChild("Characters")
            if not chars then return end

            for _, model in ipairs(chars:GetChildren()) do
                if model:IsA("Model") then
                    local hum = model:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health <= 0 then
                        for _, part in ipairs(model:GetDescendants()) do
                            if part:IsA("BasePart") then
                                if saved.deadBodies[part] == nil then
                                    saved.deadBodies[part] = part.LocalTransparencyModifier
                                end
                                part.LocalTransparencyModifier = 1
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
        end

        --========================================================--
        -- REDUCE WATER QUALITY
        --========================================================--
        local savedWater = nil

        local function reduceWater()
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if not terrain then return end

            if savedWater == nil then
                savedWater = {
                    WaterWaveSize = terrain.WaterWaveSize,
                    WaterWaveSpeed = terrain.WaterWaveSpeed,
                    WaterTransparency = terrain.WaterTransparency,
                }
            end

            pcall(function()
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
            end)
        end

        local function restoreWater()
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if not terrain or not savedWater then return end

            pcall(function()
                terrain.WaterWaveSize = savedWater.WaterWaveSize
                terrain.WaterWaveSpeed = savedWater.WaterWaveSpeed
                terrain.WaterTransparency = savedWater.WaterTransparency
            end)
            savedWater = nil
        end

        --========================================================--
        -- RESTORE ALL OBJECTS
        --========================================================--
        local function restoreAll()
            -- Particles
            for obj, state in pairs(saved.particles) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.particles)

            -- Beams
            for obj, state in pairs(saved.beams) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.beams)

            -- Trails
            for obj, state in pairs(saved.trails) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.trails)

            -- Fire
            for obj, state in pairs(saved.fire) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.fire)

            -- Smoke
            for obj, state in pairs(saved.smoke) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.smoke)

            -- Sparkles
            for obj, state in pairs(saved.sparkles) do
                if obj and obj.Parent then
                    pcall(function() obj.Enabled = state end)
                end
            end
            table.clear(saved.sparkles)

            -- Parts
            for obj, data in pairs(saved.parts) do
                if obj and obj.Parent then
                    pcall(function()
                        obj.CastShadow = data.CastShadow
                        obj.Material = data.Material
                    end)
                end
            end
            table.clear(saved.parts)

            -- Textures
            for obj, state in pairs(saved.textures) do
                if obj and obj.Parent then
                    pcall(function() obj.Transparency = state end)
                end
            end
            table.clear(saved.textures)

            -- Decals
            for obj, state in pairs(saved.decals) do
                if obj and obj.Parent then
                    pcall(function() obj.Transparency = state end)
                end
            end
            table.clear(saved.decals)

            -- Dead bodies
            for obj, state in pairs(saved.deadBodies) do
                if obj and obj.Parent then
                    pcall(function()
                        obj.LocalTransparencyModifier = state
                    end)
                end
            end
            table.clear(saved.deadBodies)

            -- Lighting
            restoreLighting()

            -- Water
            restoreWater()
        end

        --========================================================--
        -- FULL SCAN
        --========================================================--
        local function fullScan()
            applyLighting()
            for _, obj in ipairs(workspace:GetDescendants()) do
                processObject(obj)
            end
            cleanDeadBodies()
            reduceWater()
        end

        --========================================================--
        -- WATCHERS
        --========================================================--
        local watchers = {}

        local function startWatchers()
            if watchers.descAdded then return end

            watchers.descAdded = workspace.DescendantAdded:Connect(function(obj)
                if not State.Enabled then return end
                task.defer(function()
                    processObject(obj)
                end)
            end)

            watchers.lightAdded = Lighting.ChildAdded:Connect(function(obj)
                if not State.Enabled then return end
                task.defer(function()
                    applyLighting()
                end)
            end)
        end

        local function stopWatchers()
            for _, conn in pairs(watchers) do
                pcall(function() conn:Disconnect() end)
            end
            table.clear(watchers)
        end

        --========================================================--
        -- CONTINUOUS LOOP (Throttle 30f = 0.5/sec — Very Light)
        --========================================================--
        local fc = 0
        RunService.Heartbeat:Connect(function()
            if not State.Enabled then return end
            fc = fc + 1
            if fc < 30 then return end
            fc = 0

            -- Re-apply lighting (game ပြန်ပြောင်းရင်)
            pcall(applyLighting)

            -- Clean dead bodies
            pcall(cleanDeadBodies)
        end)

        --========================================================--
        -- PUBLIC API
        --========================================================--
        _G.ExtremeFPS.Set = function(f, v)
            if State[f] == nil then return false end
            State[f] = v

            if f == "Enabled" then
                if v then
                    fullScan()
                    startWatchers()
                    print("[ExtremeFPS] ON — Extreme Mode")
                else
                    restoreAll()
                    stopWatchers()
                    print("[ExtremeFPS] OFF — Restored")
                end
            elseif f == "KeepGunEffects" then
                -- Re-scan
                if State.Enabled then
                    pcall(fullScan)
                end
            end

            return true
        end

        _G.ExtremeFPS.Get = function(f) return State[f] end

        print("[ExtremeFPS] Backend loaded ✓")
    end)

    if not ok then
        warn("[ExtremeFPS] Backend error:", err)
    end
end)

--== PART 1: UI ==--
task.spawn(function()
    task.wait(2)
    local ok, err = pcall(function()
        if not MiscBox then return end

        _G.CleanPack = {
            State = {
                Headshot = false,
                ShotgunOP = false,
                NoChimeraRad = false,
                NoTerrorVignette = false,
                TeamCheck = false,
            }
        }

        MiscBox:AddToggle("HeadshotMagnetToggle", {
            Text = "🎯 Headshot Magnet",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CleanPack then
                        _G.CleanPack.State.Headshot = (v == true)
                    end
                end)
            end,
        })

        MiscBox:AddToggle("TeamCheckToggle", {
            Text = "  👥 TeamCheck (Skip Teammates)",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CleanPack then
                        _G.CleanPack.State.TeamCheck = (v == true)
                    end
                end)
            end,
        })

        MiscBox:AddToggle("ShotgunOPToggle", {
            Text = "💥 Shotgun OP Pack",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CleanPack then
                        _G.CleanPack.State.ShotgunOP = (v == true)
                    end
                end)
            end,
        })

        MiscBox:AddToggle("NoChimeraRadToggle", {
            Text = "☢️ No Chimera Radiation",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CleanPack then
                        _G.CleanPack.State.NoChimeraRad = (v == true)
                    end
                end)
            end,
        })

        MiscBox:AddToggle("NoTerrorVignetteToggle", {
            Text = "🌫️ No Terror Vignette",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CleanPack then
                        _G.CleanPack.State.NoTerrorVignette = (v == true)
                    end
                end)
            end,
        })

        print("[CleanPack] UI ✓")
    end)
    if not ok then warn("[CleanPack] UI Error:", err) end
end)

--== PART 2: BACKEND — WITH TEAMCHECK ==--
task.spawn(function()
    task.wait(3)
    local ok, err = pcall(function()
        local Players    = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Lighting   = game:GetService("Lighting")
        local LP         = Players.LocalPlayer
        local Camera     = workspace.CurrentCamera

        if not _G.CleanPack then
            _G.CleanPack = {
                State = {
                    Headshot = false,
                    ShotgunOP = false,
                    NoChimeraRad = false,
                    NoTerrorVignette = false,
                    TeamCheck = false,
                }
            }
        end

        local State = _G.CleanPack.State

        -- FORCE ALL OFF
        State.Headshot = false
        State.ShotgunOP = false
        State.NoChimeraRad = false
        State.NoTerrorVignette = false
        State.TeamCheck = false

        --══════ CONFIG ══════
        local CFG = {
            ScanInterval = 0.4,
            MaxHeadRange = 400,
            ShotgunRange = 1000,
            CamDot = 0.5,
            ChimeraInterval = 1.0,
        }

        --══════ PLAYER CACHE (Team Check) ══════
        -- Team ကို scan တိုင်း မခေါ်ဘဲ cache လုပ်
        local playerTeamCache = setmetatable({}, {__mode = "k"})  -- [player] = team

        local function isTeammate(model)
            if not model or not model:IsA("Model") then return false end
            local player = Players:GetPlayerFromCharacter(model)
            if not player then return false end  -- NPC = not teammate
            if player == LP then return true end  -- Self = skip
            
            local myTeam = LP.Team
            local theirTeam = player.Team
            
            -- Both have teams + same → teammate
            if myTeam and theirTeam then
                return myTeam == theirTeam
            end
            
            return false
        end

        --══════ TOOL CACHE ══════
        local cachedTool = nil
        local cachedIsShotgun = false

        local SHOTGUN_KW = {"shotgun", "pms", "hammer"}

        local function isShotgunName(name)
            if not name or name == "" then return false end
            local n = name:lower()
            for _, kw in ipairs(SHOTGUN_KW) do
                if n:find(kw, 1, true) then return true end
            end
            return false
        end

        local function updateToolCache()
            local c = LP.Character
            if not c then
                cachedTool = nil
                cachedIsShotgun = false
                return
            end

            local t = c:FindFirstChildOfClass("Tool")
            if t ~= cachedTool then
                cachedTool = t
                cachedIsShotgun = t and isShotgunName(t.Name) or false
            end
        end

        --══════ ENEMY HEAD CACHE (TeamCheck Aware) ══════
        local cachedHead = nil
        local lastScan = 0

        local function scanEnemies()
            local now = os.clock()
            if now - lastScan < CFG.ScanInterval then return end
            lastScan = now

            local c = LP.Character
            if not c then cachedHead = nil return end
            local myRoot = c:FindFirstChild("HumanoidRootPart")
            if not myRoot then cachedHead = nil return end

            local chars = workspace:FindFirstChild("Characters")
            if not chars then cachedHead = nil return end

            local camPos = Camera.CFrame.Position
            local camLook = Camera.CFrame.LookVector
            local best, bestScore = nil, -1
            local maxSq = CFG.MaxHeadRange * CFG.MaxHeadRange
            local myPos = myRoot.Position
            local teamCheckOn = State.TeamCheck == true

            for _, m in ipairs(chars:GetChildren()) do
                if m:IsA("Model") and m ~= c then
                    -- ⭐ TEAMCHECK — Skip teammates
                    if teamCheckOn and isTeammate(m) then
                        -- Skip this model — continue to next
                    else
                        local hum = m:FindFirstChildOfClass("Humanoid")
                        local head = m:FindFirstChild("Head")
                        if hum and head and hum.Health > 0 then
                            local diff = head.Position - myPos
                            local distSq = diff.X*diff.X + diff.Y*diff.Y + diff.Z*diff.Z
                            if distSq <= maxSq then
                                local toHead = head.Position - camPos
                                local toHeadUnit = toHead.Unit
                                local dot = camLook:Dot(toHeadUnit)
                                if dot > CFG.CamDot and dot > bestScore then
                                    best = head
                                    bestScore = dot
                                end
                            end
                        end
                    end
                end
            end
            cachedHead = best
        end

        --══════ TOOL CHANGE WATCHER ══════
        local charConns = {}

        local function onChar(c)
            for _, conn in ipairs(charConns) do
                pcall(function() conn:Disconnect() end)
            end
            table.clear(charConns)

            table.insert(charConns, c.ChildAdded:Connect(function(obj)
                if obj:IsA("Tool") then
                    cachedTool = obj
                    cachedIsShotgun = isShotgunName(obj.Name)
                end
            end))

            table.insert(charConns, c.ChildRemoved:Connect(function(obj)
                if obj:IsA("Tool") then
                    cachedTool = nil
                    cachedIsShotgun = false
                end
            end))

            updateToolCache()
        end

        LP.CharacterAdded:Connect(onChar)
        if LP.Character then onChar(LP.Character) end

        --══════ SINGLE HOOK ══════
        local HAS_HOOK = (getrawmetatable ~= nil) and (hookmetamethod ~= nil)
        local HAS_NEWCC = (newcclosure ~= nil)
        local HAS_SETREAD = (setreadonly ~= nil)
        local HAS_GETNAME = (getnamecallmethod ~= nil)

        if HAS_HOOK then
            pcall(function()
                local mt = getrawmetatable(game)
                local oldNamecall = mt.__namecall

                if HAS_SETREAD then pcall(setreadonly, mt, false) end

                local function hookFunc(self, ...)
                    local headshotOn = State.Headshot == true
                    local shotgunOn = State.ShotgunOP == true

                    if not headshotOn and not shotgunOn then
                        return oldNamecall(self, ...)
                    end

                    local method = HAS_GETNAME and getnamecallmethod() or ""

                    if method == "Raycast" then
                        local args = {...}
                        if typeof(args[1]) == "Vector3" 
                            and typeof(args[2]) == "Vector3" then

                            -- ⭐ HEADSHOT (cachedHead already filtered by TeamCheck)
                            if headshotOn and cachedHead and cachedHead.Parent then
                                local origin = args[1]
                                local headPos = cachedHead.Position
                                args[2] = headPos - origin
                                return oldNamecall(self, table.unpack(args))
                            end

                            -- ⭐ SHOTGUN
                            if shotgunOn and cachedIsShotgun then
                                local camLook = Camera.CFrame.LookVector
                                args[2] = camLook * CFG.ShotgunRange
                                return oldNamecall(self, table.unpack(args))
                            end
                        end
                    end

                    return oldNamecall(self, ...)
                end

                mt.__namecall = HAS_NEWCC and newcclosure(hookFunc) or hookFunc
                if HAS_SETREAD then pcall(setreadonly, mt, true) end

                print("[CleanPack] Hook ✓")
            end)
        end

        --══════ CHIMERA ══════
        local lastChimeraApply = 0

        local function applyChimera()
            local now = os.clock()
            if now - lastChimeraApply < CFG.ChimeraInterval then return end
            lastChimeraApply = now

            if State.NoChimeraRad == true then
                for _, eff in ipairs(Lighting:GetChildren()) do
                    if eff:IsA("ColorCorrectionEffect") then
                        local n = eff.Name:lower()
                        if (n:find("rad") or n:find("radiat") or n:find("chimera")) 
                            and eff.Enabled then
                            eff.Enabled = false
                        end
                    end
                end
            end

            if State.NoTerrorVignette == true then
                local PG = LP:FindFirstChild("PlayerGui")
                if PG then
                    for _, gui in ipairs(PG:GetChildren()) do
                        if gui:IsA("ScreenGui") then
                            local gname = gui.Name:lower()
                            if gname:find("terror") or gname:find("rad") 
                                or gname:find("chimera") or gname:find("vignette") then
                                for _, obj in ipairs(gui:GetDescendants()) do
                                    if (obj:IsA("ImageLabel") or obj:IsA("Frame")) 
                                        and obj.Visible then
                                        local n = obj.Name:lower()
                                        if n:find("vignette") or n:find("overlay") 
                                            or n:find("terror") or n:find("rad") then
                                            obj.Visible = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        --══════ SINGLE HEARTBEAT ══════
        local scanFrame = 0
        local chimeraFrame = 0

        RunService.Heartbeat:Connect(function()
            updateToolCache()

            -- Enemy scan (Headshot ON)
            if State.Headshot == true then
                scanFrame = scanFrame + 1
                if scanFrame >= 24 then
                    scanFrame = 0
                    pcall(scanEnemies)
                end
            else
                scanFrame = 0
                -- Clear cache when Headshot OFF
                if cachedHead then cachedHead = nil end
            end

            -- Chimera (only when needed)
            if State.NoChimeraRad == true or State.NoTerrorVignette == true then
                chimeraFrame = chimeraFrame + 1
                if chimeraFrame >= 60 then
                    chimeraFrame = 0
                    pcall(applyChimera)
                end
            else
                chimeraFrame = 0
            end
        end)

        --══════ API ══════
        _G.CleanPack.Set = function(f, v)
            if State[f] ~= nil then
                State[f] = (v == true)
                
                -- TeamCheck change → rescan
                if f == "TeamCheck" then
                    cachedHead = nil
                end
                
                return true
            end
            return false
        end

        _G.CleanPack.Get = function(f) return State[f] end

        print("[CleanPack] Backend ✓ — TeamCheck Ready")
    end)
    if not ok then warn("[CleanPack] Backend Error:", err) end
end)

--== PART 1: UI ==--
task.spawn(function()
    task.wait(2)
    local ok, err = pcall(function()
        if not MiscBox then return end

        _G.AmmoSwitch = {
            State = {
                Enabled = false,
                AmmoType = "Dragon's Breath",
            }
        }

        MiscBox:AddToggle("DragonBreathToggle", {
            Text = "🔥 Shotgun → Dragon's Breath",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.AmmoSwitch then
                        _G.AmmoSwitch.State.Enabled = (v == true)
                    end
                end)
            end,
        })

        print("[AmmoSwitch] UI ✓")
    end)
    if not ok then warn("[AmmoSwitch] UI Error:", err) end
end)

--== PART 2: BACKEND ==--
task.spawn(function()
    task.wait(3)
    local ok, err = pcall(function()
        local Players    = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local RS         = game:GetService("ReplicatedStorage")
        local LP         = Players.LocalPlayer

        if not _G.AmmoSwitch then
            _G.AmmoSwitch = {
                State = { Enabled = false, AmmoType = "Dragon's Breath" }
            }
        end

        local State = _G.AmmoSwitch.State
        State.Enabled = false

        --══════ CONFIG ══════
        local CFG = {
            ScanInterval = 1.0,  -- 1x/sec tool scan
        }

        local SHOTGUN_KW = {"shotgun", "pms", "hammer"}

        local function isShotgun(name)
            if not name then return false end
            local n = name:lower()
            for _, kw in ipairs(SHOTGUN_KW) do
                if n:find(kw, 1, true) then return true end
            end
            return false
        end

        --══════ FIND AMMO REMOTES ══════
        local ammoRemotes = {}

        local function scanAmmoRemotes()
            ammoRemotes = {}
            for _, obj in ipairs(RS:GetDescendants()) do
                if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                    local n = obj.Name:lower()
                    -- Match: ammo + (type/switch/change/set/select)
                    if n:find("ammo", 1, true) 
                        and (n:find("type", 1, true) or n:find("switch", 1, true)
                            or n:find("change", 1, true) or n:find("set", 1, true)
                            or n:find("select", 1, true) or n:find("update", 1, true)) then
                        table.insert(ammoRemotes, obj)
                    end
                end
            end
            return ammoRemotes
        end

        scanAmmoRemotes()

        --══════ AMMO TYPE CONSTANTS ══════
        local AMMO_TYPES = {
            "Dragon's Breath",
            "DragonsBreath",
            "DragonBreath",
            "Dragon",
            "Incendiary",
        }

        --══════ APPLY METHOD ══════
        -- Multiple fallback methods to try

        local function applyAmmoToTool(tool)
            if not tool or not tool:IsA("Tool") then return end
            if not isShotgun(tool.Name) then return end

            local targetAmmo = State.AmmoType

            -- ⭐ Method 1: Tool Attribute
            pcall(function()
                tool:SetAttribute("AmmoType", targetAmmo)
                tool:SetAttribute("ammoType", targetAmmo)
                tool:SetAttribute("AmmoName", targetAmmo)
                tool:SetAttribute("CurrentAmmoType", targetAmmo)
                tool:SetAttribute("SelectedAmmo", targetAmmo)
            end)

            -- ⭐ Method 2: Nested config / value
            for _, obj in ipairs(tool:GetDescendants()) do
                local objName = obj.Name:lower()
                if objName:find("ammo") or objName:find("round") 
                    or objName:find("bullettype") then
                    pcall(function()
                        if obj:IsA("StringValue") then
                            obj.Value = targetAmmo
                        elseif obj:IsA("Configuration") then
                            obj:SetAttribute("Type", targetAmmo)
                            obj:SetAttribute("Value", targetAmmo)
                        end
                    end)
                end
            end

            -- ⭐ Method 3: Character attributes
            local char = LP.Character
            if char then
                pcall(function()
                    char:SetAttribute("AmmoType", targetAmmo)
                end)
            end
        end

        --══════ FIRE REMOTE ══════
        local lastRemoteFire = 0

        local function fireAmmoRemote()
            -- Rate limit: 2s
            local now = os.clock()
            if now - lastRemoteFire < 2 then return end
            lastRemoteFire = now

            if #ammoRemotes == 0 then return end

            local targetAmmo = State.AmmoType

            for _, remote in ipairs(ammoRemotes) do
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        -- Try multiple arg formats
                        remote:FireServer(targetAmmo)
                        task.wait(0.05)
                        remote:FireServer(nil, targetAmmo)
                        task.wait(0.05)
                        remote:FireServer("shotgun", targetAmmo)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(targetAmmo)
                    end
                end)
            end
        end

        --══════ HOOK — Intercept Fire Remote (Silent) ══════
        local HAS_HOOK = (getrawmetatable ~= nil) and (hookmetamethod ~= nil)
        local HAS_NEWCC = (newcclosure ~= nil)
        local HAS_SETREAD = (setreadonly ~= nil)
        local HAS_GETNAME = (getnamecallmethod ~= nil)

        if HAS_HOOK then
            pcall(function()
                local mt = getrawmetatable(game)
                local oldNamecall = mt.__namecall

                if HAS_SETREAD then pcall(setreadonly, mt, false) end

                local function hookFunc(self, ...)
                    -- Early return if OFF
                    if State.Enabled ~= true then
                        return oldNamecall(self, ...)
                    end

                    local method = HAS_GETNAME and getnamecallmethod() or ""
                    local args = {...}

                    -- Intercept FireServer — swap ammo type in args
                    if method == "FireServer" and typeof(self) == "Instance" then
                        local n = self.Name:lower()
                        if n:find("fire", 1, true) or n:find("shoot", 1, true) 
                            or n:find("attack", 1, true) then
                            local targetAmmo = State.AmmoType
                            for i, a in ipairs(args) do
                                -- Direct string ammo match
                                if typeof(a) == "string" then
                                    local al = a:lower()
                                    if al == "buckshot" or al == "slug" 
                                        or al == "standard" or al == "normal" 
                                        or al == "shell" then
                                        args[i] = targetAmmo
                                    end
                                end
                                -- Nested table ammo match
                                if typeof(a) == "table" then
                                    for k, v in pairs(a) do
                                        if typeof(v) == "string" then
                                            local vl = v:lower()
                                            if vl == "buckshot" or vl == "slug" 
                                                or vl == "standard" or vl == "shell" then
                                                a[k] = targetAmmo
                                            end
                                        end
                                    end
                                end
                            end
                            return oldNamecall(self, table.unpack(args))
                        end
                    end

                    return oldNamecall(self, ...)
                end

                mt.__namecall = HAS_NEWCC and newcclosure(hookFunc) or hookFunc
                if HAS_SETREAD then pcall(setreadonly, mt, true) end

                print("[AmmoSwitch] Hook ✓")
            end)
        end

        --══════ CHARACTER BINDING ══════
        local conns = {}

        local function unbind()
            for _, c in ipairs(conns) do
                pcall(function() c:Disconnect() end)
            end
            table.clear(conns)
        end

        local function bindChar(c)
            unbind()

            -- Watch new tool equipped
            table.insert(conns, c.ChildAdded:Connect(function(obj)
                if obj:IsA("Tool") and State.Enabled then
                    task.defer(function()
                        pcall(applyAmmoToTool, obj)
                    end)
                end
            end))

            -- Apply to current tools
            for _, tool in ipairs(c:GetChildren()) do
                if tool:IsA("Tool") then
                    task.defer(function()
                        pcall(applyAmmoToTool, tool)
                    end)
                end
            end
        end

        LP.CharacterAdded:Connect(function(c)
            task.defer(bindChar, c)
        end)

        if LP.Character then
            task.defer(bindChar, LP.Character)
        end

        --══════ BACKPACK WATCH ══════
        local backpackConns = {}

        LP.ChildAdded:Connect(function(obj)
            if obj.Name == "Backpack" then
                for _, c in ipairs(backpackConns) do
                    pcall(function() c:Disconnect() end)
                end
                table.clear(backpackConns)

                table.insert(backpackConns, obj.ChildAdded:Connect(function(t)
                    if t:IsA("Tool") and State.Enabled then
                        task.defer(function()
                            pcall(applyAmmoToTool, t)
                        end)
                    end
                end))
            end
        end)

        --══════ SINGLE HEARTBEAT (Throttle 60f = 1x/sec) ══════
        local fc = 0

        RunService.Heartbeat:Connect(function()
            if State.Enabled ~= true then
                fc = 0
                return
            end

            fc = fc + 1
            if fc < 60 then return end
            fc = 0

            -- Light scan
            local char = LP.Character
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        pcall(applyAmmoToTool, tool)
                    end
                end
            end
        end)

        --══════ PUBLIC API ══════
        _G.AmmoSwitch.Set = function(f, v)
            if State[f] == nil then return false end
            State[f] = (v == true)

            if f == "Enabled" and v == true then
                -- Immediate apply
                task.spawn(function()
                    local char = LP.Character
                    if char then
                        for _, tool in ipairs(char:GetChildren()) do
                            if tool:IsA("Tool") then
                                pcall(applyAmmoToTool, tool)
                            end
                        end
                    end
                    pcall(fireAmmoRemote)
                end)
            end

            return true
        end

        _G.AmmoSwitch.Get = function(f) return State[f] end
        _G.AmmoSwitch.SetAmmoType = function(name)
            if typeof(name) == "string" and #name > 0 then
                State.AmmoType = name
                print("[AmmoSwitch] Ammo type:", name)
                return true
            end
            return false
        end
        _G.AmmoSwitch.ScanRemotes = scanAmmoRemotes
        _G.AmmoSwitch.GetRemotes = function() return ammoRemotes end

        print("[AmmoSwitch] Backend ✓ — OFF by default")
        print("  Ammo remotes found:", #ammoRemotes)
    end)
    if not ok then warn("[AmmoSwitch] Backend Error:", err) end
end)


--== PART 1: UI ==--
task.spawn(function()
    task.wait(2)
    local ok, err = pcall(function()
        if not MiscBox then return end

        _G.CombinePack = {
            State = {
                BloodGorePack = false,
                NoCameraShake = false,
            }
        }

        -- 1️⃣ Blood / Gore Disable Pack
        MiscBox:AddToggle("BloodGorePackToggle", {
            Text = "🩸 Blood / Gore Disable Pack",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CombinePack then
                        _G.CombinePack.State.BloodGorePack = (v == true)
                    end
                end)
            end,
        })

        -- 2️⃣ No Camera Shake
        MiscBox:AddToggle("NoCameraShakeToggle", {
            Text = "📷 No Camera Shake",
            Default = false,
            Callback = function(v)
                pcall(function()
                    if _G.CombinePack then
                        _G.CombinePack.State.NoCameraShake = (v == true)
                    end
                end)
            end,
        })

        print("[CombinePack] UI ✓")
    end)
    if not ok then warn("[CombinePack] UI Error:", err) end
end)














--------------------------------------------------
-- SETTINGS TAB
--------------------------------------------------

local SettingsBox = Tabs.Settings:AddLeftGroupbox("UI Settings", "cog")


SettingsBox:AddToggle("CustomCursor", {

    Text = "Custom Cursor",

    Default = Library.ShowCustomCursor,

    Callback = function(Value)

        Library.ShowCustomCursor = Value

    end,
})

SettingsBox:AddDropdown("NotifySide", {

    Values = {
        "Left",
        "Right"
    },

    Default = "Right",

    Text = "Notification Side",

    Callback = function(Value)

        Library:SetNotifySide(Value)

    end,
})

SettingsBox:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})

SettingsBox:AddButton({

    Text = "Unload Menu",

    Func = function()

        Library:Unload()

    end,

})


SettingsBox:AddLabel("Menu Keybind")
    :AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "Menu Keybind",
    })


--------------------------------------------------
-- CONFIG + THEME
--------------------------------------------------

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({
    "MenuKeybind"
})


ThemeManager:SetFolder("InoC3nt8Hub")
SaveManager:SetFolder("InoC3nt8Hub")


SaveManager:BuildConfigSection(Tabs.Settings)

ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

--------------------------------------------------
-- MENU KEY
--------------------------------------------------

Library.ToggleKeybind = Options.MenuKeybind 