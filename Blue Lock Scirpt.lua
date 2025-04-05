-- GUI con botón arrastrable que intenta unirse automáticamente a la mejor posición

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoJoinGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Crear botón
local button = Instance.new("TextButton")
button.Name = "JoinButton"
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.AnchorPoint = Vector2.new(0.5, 0)
button.Text = "Unirse al Partido"
button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Active = true
button.Selectable = true
button.Parent = screenGui

-- Función de arrastre
local dragging = false
local dragInput, mousePos, framePos

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        button.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Equipos y posiciones con prioridad
local positions = {"CF", "RW", "LW", "CM", "GK"}
local teams = {"Home", "Away"}

-- Función que intenta unirse a un equipo y posición
local function tryJoin(team, pos)
    local args = {
        [1] = team,
        [2] = pos
    }

    local teamService = game:GetService("ReplicatedStorage")
        :WaitForChild("Packages")
        :WaitForChild("Knit")
        :WaitForChild("Services")
        :WaitForChild("TeamService")

    teamService.RE.Select:FireServer(unpack(args))
    wait(0.2) -- Espera para verificar si el cambio ocurrió

    -- Verificamos si se cambió el equipo (ajustar si tenés otra forma de comprobar)
    if player.Team and player.Team.Name == team then
        return true
    end

    return false
end

-- Acción al apretar el botón
button.MouseButton1Click:Connect(function()
    for _, team in ipairs(teams) do
        for _, pos in ipairs(positions) do
            if tryJoin(team, pos) then
                button.Text = "¡Unido: " .. team .. " - " .. pos .. "!"
                button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                print("✅ Te uniste como " .. pos .. " en " .. team)

                -- Restaurar botón después de 1 segundo
                task.delay(1, function()
                    button.Text = "Unirse al Partido"
                    button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                end)

                return
            end
        end
    end

    -- Si no se pudo unir a ninguna posición
    button.Text = "❌ No hay lugar"
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    print("❌ Todas las posiciones están ocupadas.")

    -- Restaurar después de 1 segundo
    task.delay(1, function()
        button.Text = "Unirse al Partido"
        button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    end)
end)
