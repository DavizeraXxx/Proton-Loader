--[[
    Proton Menu - Loader Principal
    Conecta a UI com os Cheats
    GitHub: DavizeraXxx/Proton-Loader
]]

-- ======================
-- CARREGAR MÓDULOS
-- ======================

-- Carregar UI (Repositório 1)
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Ui/main/Ui.lua"))()

-- Carregar Core (Repositório 2)
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Cheats/main/Core.lua"))()

-- ======================
-- CONECTAR UI COM CORE
-- ======================

-- Conectar eventos da UI com as funções do Core
UI.OnToggleChange = function(name, state)
    print("[UI → Core] Toggle:", name, state)
    
    -- Atualizar opções no Core
    Core.Options[name] = state
    
    -- Executar ações específicas
    if name == "Noclip" then
        Core:UpdateNoclip()
    elseif name == "ESPSheriff" or name == "ESPMurder" then
        Core:UpdateESP()
    elseif name == "Aimbot" then
        Core:UpdateAimbotVisual()
    elseif name == "ESPGun" then
        Core:UpdateGunESP()
    end
end

UI.OnSliderChange = function(name, value)
    print("[UI → Core] Slider:", name, value)
    
    if name == "AimbotFOV" then
        Core.Options.AimbotFOV = value
        Core:UpdateAimbotVisual()
    end
end

UI.OnButtonClick = function(name)
    print("[UI → Core] Button:", name)
    
    if name == "TeleportSheriffGun" then
        Core:TeleportSheriffGun()
    elseif name == "CopyLog" then
        Core:CopyLog()
    end
end

UI.OnPlayerSelect = function(player)
    print("[UI → Core] Player selecionado:", player.Name)
    Core.Options.TargetPlayer = player
end

-- ======================
-- INICIAR TUDO
-- ======================

-- Criar a interface
UI:CreateGUI()
UI:StartFooterUpdates()

-- Iniciar o Core (cheats)
Core:Start()

-- Notificar que tudo está pronto
UI:Notify("Proton Menu carregado com sucesso! 🚀", 3)

-- ======================
-- COMANDOS RÁPIDOS (OPCIONAL)
-- ======================

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Tecla RShift para abrir/fechar menu
    if input.KeyCode == Enum.KeyCode.RightShift then
        UI.Open = not UI.Open
        UI.GUI.MainFrame.Visible = UI.Open
    end
    
    -- Tecla G para teleportar arma do Sheriff
    if input.KeyCode == Enum.KeyCode.G then
        Core:TeleportSheriffGun()
    end
    
    -- Tecla L para copiar log
    if input.KeyCode == Enum.KeyCode.L then
        Core:CopyLog()
    end
end)

-- ======================
-- LIMPEZA AO SAIR (OPCIONAL)
-- ======================

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    Core:Cleanup()
end)

print("[Proton Loader] Tudo pronto! ✅")