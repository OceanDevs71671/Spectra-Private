-- Printing

print("Welcome to Spectra Private, if this script has any bugs, report to the Github!")

-- Variables
MenuName = "Spectra Private"
MenuVersion = "v1.0.0"

-- The Code

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/coastified/src.lua"))()
local Window = Lib:Window(MenuName, MenuVersion, Enum.KeyCode.RightShift)
local Test = Window:Tab("ESP")

Test:Toggle('Enable',function(ESPState)
    print(ESPState)
end)

Test:Colorpicker("ESP Color",Color3.fromRGB(0,0,0), function(color)
    print(color)
end)