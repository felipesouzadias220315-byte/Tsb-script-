local Library = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = Library.CreateLib("TSB TECHS - XENO", "BloodTheme")

-- Variáveis de Controle
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local configs = {
    Twisted = false,
    LoopDash = false,
    Lethal = false,
    Meow = false,
    Speed = 16
}

-- Funções das Techs
local function applyImpulse(vec, duration)
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = vec
        bv.Parent = root
        task.wait(duration)
        bv:Destroy()
    end
end

-- Main Tab
local Main = Window:NewTab("Techs Principal")
local Section = Main:NewSection("Movimentação & Combat")

Section:NewToggle("Twisted Dash (Teclado Q)", "Gira o personagem no dash", function(state)
    configs.Twisted = state
end)

Section:NewToggle("Loop Dash (Segurar T)", "Mantém o dash ativo", function(state)
    configs.LoopDash = state
end)

Section:NewToggle("Lethal / Meow Tech", "Aumenta alcance e velocidade de reação", function(state)
    configs.Lethal = state
end)

Section:NewButton("Auto Kyoto (Combo Garou)", "Executa sequência Kyoto", function()
    -- Lógica de automação de teclas (Exemplo de sequência)
    -- Você precisa estar com o Garou e ter as skills prontas
    print("Iniciando Kyoto...")
    applyImpulse(player.Character.HumanoidRootPart.CFrame.RightVector * 50, 0.1)
    task.wait(0.05)
    -- Aqui você chamaria o RemoteEvent da Skill 3 capturado no Spy
end)

-- Loop de Update (Roda o tempo todo)
RS.RenderStepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        -- Speed Hack / Lethal Speed
        if configs.Lethal then
            player.Character.Humanoid.WalkSpeed = 35
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Detectar Teclas
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Lógica Twisted (Q)
    if input.KeyCode == Enum.KeyCode.Q and configs.Twisted then
        task.wait(0.05)
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(90), 0)
        applyImpulse(root.CFrame.LookVector * 40, 0.1)
    end

    -- Lógica Loop Dash (T)
    if input.KeyCode == Enum.KeyCode.T and configs.LoopDash then
        _G.Loop = true
        while _G.Loop do
            applyImpulse(root.CFrame.LookVector * 60, 0.1)
            task.wait(0.15)
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        _G.Loop = false
    end
end)

game.StarterGui:SetCore("SendNotification", {Title = "TSB Techs", Text = "Script Carregado com Sucesso!", Duration = 5})
