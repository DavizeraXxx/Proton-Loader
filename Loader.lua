--[[
    Proton Loader - Conecta UI + Core
    Compatível com a UI original
]]

-- Carregar UI e Core
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Ui/main/Ui.lua"))()
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Cheats/main/Core.lua"))()

-- ======================
-- CONECTAR UI COM CORE
-- ======================

-- Conectar eventos da UI com as funções do Core
UI.OnToggleChange = function(name, state)
    print("[UI → Core] Toggle:", name, state)
    
    if name == "Noclip" then
        Core.Options.Noclip = state
        Core:UpdateNoclip()
    elseif name == "ESPSheriff" then
        Core.Options.ESPSheriff = state
        Core:UpdateESP()
    elseif name == "ESPMurder" then
        Core.Options.ESPMurder = state
        Core:UpdateESP()
    elseif name == "Aimbot" then
        Core.Options.Aimbot = state
        Core:UpdateAimbotVisual()
    elseif name == "ESPGun" then
        Core.Options.ESPGun = state
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
-- CRIAR UI E INICIAR
-- ======================

-- Criar UI
UI:CreateGUI()
UI:StartFooterUpdates()

-- Iniciar Core
Core:Start()

-- Notificar
UI:Notify("✅ Proton Menu carregado!", 3)

-- ======================
-- COMANDOS RÁPIDOS
-- ======================
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightShift then
        UI.Open = not UI.Open
        UI.GUI.MainFrame.Visible = UI.Open
    end
    
    if input.KeyCode == Enum.KeyCode.G then
        Core:TeleportSheriffGun()
    end
    
    if input.KeyCode == Enum.KeyCode.L then
        Core:CopyLog()
    end
end)

print("[Proton Loader] Tudo pronto! ✅")