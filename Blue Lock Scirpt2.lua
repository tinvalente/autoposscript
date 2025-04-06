-- Sistema de clave básico
local KEY = "boblox2025" -- Cambiá esta por tu clave
local player = game.Players.LocalPlayer
local userInput = game:GetService("UserInputService")

-- Crear la GUI de clave
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KeySystem"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Ingresá la clave:"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.8, 0, 0, 35)
textbox.Position = UDim2.new(0.1, 0, 0.4, 0)
textbox.PlaceholderText = "Clave..."
textbox.Font = Enum.Font.SourceSans
textbox.TextSize = 20
textbox.Text = ""

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.5, 0, 0, 30)
button.Position = UDim2.new(0.25, 0, 0.75, 0)
button.Text = "Entrar"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
button.TextColor3 = Color3.new(1, 1, 1)

-- Acción del botón
button.MouseButton1Click:Connect(function()
	if textbox.Text == KEY then
		gui:Destroy()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/tinvalente/autoposscript/main/Blue%20Lock%20Scirpt.lua", true))()
	else
		button.Text = "❌ Clave incorrecta"
		wait(1)
		button.Text = "Entrar"
	end
end)
