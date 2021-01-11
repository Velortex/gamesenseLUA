---------------------
---------LIB---------
---------------------
local images = require "gamesense/images"

function Color(R, G, B, A)
    return {
        r = R or 0,
        g = G or 0,
        b = B or 0,
        a = A or 255
    }
end
---------------------
------VARIABLES------
---------------------
local var = {
    nade_data = {
        smoke = {
            time = 1156,
        },
        inferno = {
            time = 449
        }
    }
}
----------------------
-----UI ADDITIONS-----
----------------------
local ui_additions = {
    nade_esp = {
        ui_enabled = ui.new_multiselect("VISUALS", "Other ESP", "Nade ESP", "Smoke", "Molotov"),
        ui_settings = ui.new_combobox("VISUALS", "Other ESP", "Nade ESP settings", "Smoke", "Molotov"),

        settings = {
            molotov = {
                fade_out = ui.new_checkbox("VISUALS", "Other ESP", "Fade-out over time"),
                background_color_label = ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255),
                hvhmode = ui.new_checkbox("VISUALS", "Other ESP", "HvH-mode"),
                hvh_safe_color_label = ui.new_label("VISUALS", "Other ESP", "  safe"),
                hvh_safe_color = ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_safe_color", 0, 255, 0, 255),
                hvh_unsafe_color_label = ui.new_label("VISUALS", "Other ESP", "  unsafe"),
                hvh_unsafe_color = ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_unsafe_color", 255, 0, 0, 255)
            },
            smoke = {
                fade_out = ui.new_checkbox("VISUALS", "Other ESP", "Fade-out over time"),
                background_color_label = ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255)
            }
        }
    }
}
---------------------
------FUNCTIONS------
---------------------
-- nade esp
local function draw_inferno()
    local hvh_mode_enabled = ui.get(ui_additions.nade_esp.settings.molotov.hvhmode)
    local background_color = Color(ui.get(ui_additions.nade_esp.settings.molotov.background_color))

    local icon_color = nil
    local icon_color2 = nil
    local indicator_color = nil
    local indicator_color2 = nil

    if hvh_mode_enabled == true then
        icon_color = Color(ui.get(ui_additions.nade_esp.settings.molotov.hvh_unsafe_color))
        indicator_color = icon_color

        icon_color2 = Color(ui.get(ui_additions.nade_esp.settings.molotov.hvh_safe_color))
        indicator_color2 = icon_color2
    else
        icon_color = Color(ui.get(ui_additions.nade_esp.settings.molotov.icon_color))
        indicator_color = Color(ui.get(ui_additions.nade_esp.settings.molotov.indicator_color))
    end

    local molos = entity.get_all("CInferno")
    for i = 1, #molos do
        local index = molos[i]

        local x, y, z = entity.get_prop(index, "m_vecOrigin")
        local endTime = entity.get_prop(index, "m_nFireEffectTickBegin") + var.nade_data.inferno.time
        local local_player = entity.get_local_player()
        local owner = entity.get_prop(index, "m_hOwnerEntity")
        local enemy = entity.is_enemy(owner)

        local curtime = globals.tickcount()
        local dif = endTime - curtime
        local percentage = (dif * 100 / var.nade_data.inferno.time) / 100

        local posX, posY = renderer.world_to_screen(x, y, z)

        if posX ~= nil and posY ~= nil then
            local _background_color = background_color
            local _indicator_color = {}
            local _icon_color = {}

            if enemy == false and hvh_mode_enabled == true and owner ~= local_player then
                _indicator_color = indicator_color2
                _icon_color = icon_color2
            else
                _indicator_color = indicator_color
                _icon_color = icon_color
            end

            if(ui.get(ui_additions.nade_esp.settings.molotov.fade_out)) then
                local alpha = (255 * ((percentage) * 100) / 100)

                _background_color.a = alpha
                _indicator_color.a = alpha
                _icon_color.a = alpha
            end

            renderer.circle(posX, posY, background_color.r, background_color.g, background_color.b, background_color.a, 20, 0, 1)

            local width, height = images.get_panorama_image("hud/deathnotice/icon-molotov.png"):measure(nil, 20)
            renderer.circle_outline(posX, posY, _indicator_color.r, _indicator_color.g, _indicator_color.b, _indicator_color.a, 18, 270, percentage, 2)
            images.get_panorama_image("hud/deathnotice/icon-molotov.png"):draw(posX - (width / 2), posY - (height / 2), width, height, _icon_color.r, _icon_color.g, _icon_color.b, _icon_color.a)
        end
    end
end

local function draw_smoke()
    local background_color = Color(ui.get(ui_additions.nade_esp.settings.smoke.background_color))
    local icon_color = Color(ui.get(ui_additions.nade_esp.settings.smoke.icon_color))
    local indicator_color = Color(ui.get(ui_additions.nade_esp.settings.smoke.indicator_color))

    local smokes = entity.get_all("CSmokeGrenadeProjectile")
    for i = 1, #smokes do
        local index = smokes[i]
        local smokeEffect = entity.get_prop(index, "m_bDidSmokeEffect")

        -- wait for m_nSmokeEffectTickBegin
        if smokeEffect == 1 then
            local x, y, z = entity.get_prop(index, "m_vecOrigin")
            local endTime = entity.get_prop(index, "m_nSmokeEffectTickBegin") + var.nade_data.smoke.time

            local curtime = globals.tickcount()
            local dif = endTime - curtime
            local percentage = (dif * 100 / var.nade_data.smoke.time) / 100

            local posX, posY = renderer.world_to_screen(x, y, z)

            if posX ~= nil and posY ~= nil then
                local _background_color = background_color
                local _indicator_color = indicator_color
                local _icon_color = icon_color

                if(ui.get(ui_additions.nade_esp.settings.smoke.fade_out)) then
                    local alpha = (255 * ((percentage) * 100) / 100)

                    _background_color.a = alpha
                    _indicator_color.a = alpha
                    _icon_color.a = alpha
                end

                renderer.circle(posX, posY, _background_color.r, _background_color.g, _background_color.b, _background_color.a, 20, 0, 1)
                renderer.circle_outline(posX, posY, _indicator_color.r, _indicator_color.g, _indicator_color.b, _indicator_color.a, 18, 270, percentage, 2)

                local width, height = images.get_panorama_image("hud/deathnotice/icon-smokegrenade.png"):measure(nil, 20)
                images.get_panorama_image("hud/deathnotice/icon-smokegrenade.png"):draw(posX - (width / 2), posY - (height / 2), width, height, _icon_color.r, _icon_color.g, _icon_color.b, _icon_color.a)
            end
        end
    end
end

local function nade_esp_setvisible()
    local active_settings_tab = ui.get(ui_additions.nade_esp.ui_settings)

    table.foreach(ui_additions.nade_esp.settings, function(index)
        local status = index:lower() == active_settings_tab:lower()

        table.foreach(ui_additions.nade_esp.settings[index], function(index1)
            ui.set_visible(ui_additions.nade_esp.settings[index][index1], status)
        end)
    end)
end
--------------------
-------EVENTS-------
--------------------
local function paint()
    local selected = ui.get(ui_additions.nade_esp.ui_enabled)

    if selected[1] == "Molotov" or selected[2] == "Molotov" then
        draw_inferno()
    end

    if selected[1] == "Smoke" or selected[2] == "Smoke" then
        draw_smoke()
    end
end
--------------------
-----INITIALIZE-----
--------------------
nade_esp_setvisible()
ui.set_callback(ui_additions.nade_esp.ui_settings, nade_esp_setvisible)
client.set_event_callback("paint", paint)
