--[[
    Proton Loader - Conecta UI + Core
    GitHub: DavizeraXxx/Proton-Loader
    Versão: 4.0
]]

-- Carregar UI e Core
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Ui/main/Ui.lua"))()
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Cheats/main/Core.lua"))()

-- Conectar Core com UI
Core:ConnectUI(UI)

-- Criar UI
UI:CreateWindow()

-- Iniciar Core
Core:Start()

-- Notificar
UI:Notify("Proton Menu carregado! 🚀")

print("[Loader] Proton Menu iniciado com sucesso!")

return { UI = UI, Core = Core }