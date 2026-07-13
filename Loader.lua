--[[
    Proton Loader - Conecta UI + Core
    GitHub: DavizeraXxx/Proton-Loader
]]

-- Carregar UI e Core
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Ui/main/Ui.lua"))()
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/DavizeraXxx/Proton-Cheats/main/Core.lua"))()

-- Conectar Core com UI
Core.UI = UI

-- Criar UI
UI:CreateUI()

-- ======================
-- PÁGINAS
-- ======================
local function BuildPages()
    UI:ClearMainArea()
    
    local page = UI.SelectedCategory or "Aimbot"
    local y = 10
    
    if page == "Aimbot" then
        -- Botão Aimbot
        local btn = UI:CreateButton("🎯 Aimbot: " .. (Core.Options.Aimbot and "ATIVADO" or "DESATIVADO"), y, function()
            local state = Core:ToggleAimbot()
            btn.Text = "🎯 Aimbot: " .. (state and "ATIVADO" or "DESATIVADO")
        end)
        y = y + 40
        
        -- FOV Label
        local label = UI:CreateLabel("FOV: " .. Core.Options.AimbotFOV, y)
        y = y + 25
        
        -- FOV - / +
        local btnMinus = UI:CreateButton("-", y, function()
            local val = Core:SetFOV(Core.Options.AimbotFOV - 10)
            label.Text = "FOV: " .. val
        end)
        btnMinus.Size = UDim2.new(0, 30, 0, 25)
        btnMinus.Position = UDim2.new(0, 10, 0, y)
        
        local btnPlus = UI:CreateButton("+", y, function()
            local val = Core:SetFOV(Core.Options.AimbotFOV + 10)
            label.Text = "FOV: " .. val
        end)
        btnPlus.Size = UDim2.new(0, 30, 0, 25)
        btnPlus.Position = UDim2.new(0, 50, 0, y)
        
    elseif page == "ESP" then
        -- ESP Sheriff
        local btn1 = UI:CreateButton("👁️ ESP Sheriff: " .. (Core.Options.ESPSheriff and "ATIVADO" or "DESATIVADO"), y, function()
            local state = Core:ToggleESP("Sheriff")
            btn1.Text = "👁️ ESP Sheriff: " .. (state and "ATIVADO" or "DESATIVADO")
        end)
        y = y + 40
        
        -- ESP Murder
        local btn2 = UI:CreateButton("👁️ ESP Murder: " .. (Core.Options.ESPMurder and "ATIVADO" or "DESATIVADO"), y, function()
            local state = Core:ToggleESP("Murder")
            btn2.Text = "👁️ ESP Murder: " .. (state and "ATIVADO" or "DESATIVADO")
        end)
        y = y + 40
        
        -- ESP Gun
        local btn3 = UI:CreateButton("👁️ ESP Gun: " .. (Core.Options.ESPGun and "ATIVADO" or "DESATIVADO"), y, function()
            local state = Core:ToggleESP("Gun")
            btn3.Text = "👁️ ESP Gun: " .. (state and "ATIVADO" or "DESATIVADO")
        end)
        
    elseif page == "Teleport" then
        UI:CreateButton("🚀 Teleportar Arma do Sheriff", y, function()
            Core:TeleportGun()
        end)
        
    elseif page == "Logs" then
        UI:CreateButton("📋 Copiar Log (Sheriff/Murder)", y, function()
            Core:CopyLog()
        end)
        
    elseif page == "Misc" then
        local btn = UI:CreateButton("⚙️ Noclip: " .. (Core.Options.Noclip and "ATIVADO" or "DESATIVADO"), y, function()
            local state = Core:ToggleNoclip()
            btn.Text = "⚙️ Noclip: " .. (state and "ATIVADO" or "DESATIVADO")
        end)
    end
end

-- ======================
-- EVENTOS DA UI
-- ======================
UI.OnCategorySwitch = function(name)
    UI.SelectedCategory = name
    UI:HighlightCategory(name)
    BuildPages()
end

UI.OnClose = function()
    Core:Cleanup()
    UI:Close()
end

-- ======================
-- INICIAR
-- ======================
-- Selecionar categoria inicial
UI.SelectedCategory = "Aimbot"
UI:HighlightCategory("Aimbot")
BuildPages()

-- Notificar
UI:Notify("✅ Proton Menu carregado!")
print("[Proton] Menu carregado com sucesso!")

-- Atualizar FPS
local Stats = game:GetService("Stats")
local last = tick()
local frames = 0

game:GetService("RunService").Heartbeat:Connect(function()
    frames = frames + 1
    local now = tick()
    if now - last >= 1 then
        if UI.GUI.FPSLabel then
            UI.GUI.FPSLabel.Text = "FPS: " .. math.floor(frames / (now - last))
        end
        frames = 0
        last = now
    end
end)

return { UI = UI, Core = Core }