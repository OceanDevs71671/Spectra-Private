local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ESP Variables
local ESPColor = Color3.fromRGB(255, 255, 255)
local espObjects = {}
_G.ESPEnabled = false
local ESPTransparency = 0

print("Welcome to Spectra Private, if this script has any bugs, report to the Github!")

MenuName = "Spectra Private"
MenuVersion = "v1.0.0"

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/coastified/src.lua"))()
local Window = Lib:Window(MenuName, MenuVersion, Enum.KeyCode.P)

local MiscTab = Window:Tab("Misc")
MiscTab:Label("'P' to toggle Spectra Private")
local ESPTab = Window:Tab("ESP")
ESPTab:Toggle('Toggle ESP', function(ESPState)
    _G.ESPEnabled = ESPState
    if _G.ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not espObjects[player] then
                createESP(player)
            end
        end
    end
    print(ESPState)
end)

ESPTab:Slider('ESP Transparency',0,1,0.25,function(ESPTrans)
    ESPTransparency = ESPTrans
    for _, box in pairs(espObjects) do
        box.Transparency = ESPTransparency
    end
    print(ESPTrans)
end)

ESPTab:Colorpicker("ESP Color", Color3.fromRGB(255, 255, 255), function(TabESPColor)
    ESPColor = TabESPColor
    for _, box in pairs(espObjects) do
        box.Color3 = ESPColor
    end
    print(TabESPColor)
end)

local function createESP(player)
    if player == LocalPlayer or espObjects[player] then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Size = Vector3.new(2, 5, 1)
    box.Color3 = ESPColor
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Parent = workspace
    box.Transparency = ESPTransparency
    espObjects[player] = box
end

local function removeESP(player)
    if espObjects[player] then
        espObjects[player]:Destroy()
        espObjects[player] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for player, box in pairs(espObjects) do
        if _G.ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            box.Adornee = player.Character.HumanoidRootPart
        else
            box.Adornee = nil
        end
    end
end)

Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)

-- Initialize ESP for current players
for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end
