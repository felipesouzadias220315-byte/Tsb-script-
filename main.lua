local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "TSB TECHS | 60K KILLS",
   LoadingTitle = "Carregando Techs...",
   LoadingSubtitle = "by Xeno",
})

-- Variáveis Globais para as Techs
_G.Twisted = false
_G.Loop = false
_G.AutoKyoto = false
_G.Meow = false

local Tab = Window:CreateTab("Combate", 4483362458)

-- 1. TWISTED DASH (Q)
Tab:CreateToggle({
   Name = "Twisted Dash (Q)",
   CurrentValue = false,
   Callback = function(Value) _G.Twisted = Value end,
})

-- 2. LOOP DASH (T)
Tab:CreateToggle({
   Name = "Loop Dash (Segurar T)",
   CurrentValue = false,
   Callback = function(Value) _G.Loop = Value end,
})

-- 3. MEOW / OREO TECH (E)
Tab:CreateToggle({
   Name = "Meow/Oreo Tech (E)",
   CurrentValue = false,
   Callback = function(Value) _G.Meow = Value end,
})

-- 4. BOTAO AUTO KYOTO
Tab:CreateButton({
   Name = "Executar Auto Kyoto (Garou)",
   Callback = function()
      -- Lógica rápida de impulso lateral + Skill 3
      local root = game.Players.LocalPlayer.Character.HumanoidRootPart
      root.Velocity = root.CFrame.RightVector * 50
      task.wait(0.1)
      -- Aqui você deve adicionar o Remote da Skill 3 capturado no Spy
      print("Kyoto Executado!")
   end,
})

-- LOGICA DE TECLAS (INPUT)
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    
    -- Lógica Twisted (Giro 90 graus no Dash)
    if input.KeyCode == Enum.KeyCode.Q and _G.Twisted then
        task.wait(0.08)
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(90), 0)
    end

    -- Lógica Meow Tech (Flick + Impulso)
    if input.KeyCode == Enum.KeyCode.E and _G.Meow then
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(180), 0)
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(1e6, 0, 1e6)
        bv.Velocity = root.CFrame.LookVector * 50
        task.wait(0.1)
        bv:Destroy()
    end

    -- Lógica Loop Dash (T)
    if input.KeyCode == Enum.KeyCode.T and _G.Loop then
        _G.LoopActive = true
        while _G.LoopActive do
            local bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(1e6, 0, 1e6)
            bv.Velocity = root.CFrame.LookVector * 65
            task.wait(0.1)
            bv:Destroy()
            task.wait(0.05)
            if not _G.LoopActive then break end
        end
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then _G.LoopActive = false end
end)

Rayfield:Notify({Title = "Sucesso!", Content = "Todas as Techs prontas!", Duration = 5})
