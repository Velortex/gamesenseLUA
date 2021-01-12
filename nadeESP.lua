---------------------
---------API---------
---------------------
local api = {
    client = {
        set_event_callback = client.set_event_callback,
        get_cvar = client.get_cvar
    },
    entity = {
        get_local_player = entity.get_local_player,
        is_enemy = entity.is_enemy,
        get_all = entity.get_all,
        get_prop = entity.get_prop
    },
    globals = {
        tickcount = globals.tickcount
    },
    renderer = {
        world_to_screen = renderer.world_to_screen,
        circle_outline = renderer.circle_outline,
        circle = renderer.circle
    },
    ui = {
        new_slider = ui.new_slider,
        new_checkbox = ui.new_checkbox,
        new_multiselect = ui.new_multiselect,
        get = ui.get,
        new_color_picker = ui.new_color_picker,
        new_combobox = ui.new_combobox,
        set_callback = ui.set_callback,
        new_label = ui.new_label,
        set_visible = ui.set_visible
    },
    table = {
        foreach = table.foreach
    },
    string = {
        lower = string.lower
    }
}
---------------------
---------LIB---------
---------------------
local images = require "gamesense/images"

function ternary(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end

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
    },
    cvar = {
        mp_friendlyfire = 1
    }
}
----------------------
-----UI ADDITIONS-----
----------------------
local ui_additions = {
    nade_esp = {
        ui_enabled = api.ui.new_multiselect("VISUALS", "Other ESP", "Nade ESP", "Smoke", "Molotov"),
        ui_settings = api.ui.new_combobox("VISUALS", "Other ESP", "Nade ESP settings", "General", "Smoke", "Molotov"),
        settings = {
            molotov = {
                background_color_label = api.ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = api.ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = api.ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = api.ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = api.ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = api.ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255),
                hvhmode = api.ui.new_checkbox("VISUALS", "Other ESP", "HvH-mode"),
                hvh_safe_color_label = api.ui.new_label("VISUALS", "Other ESP", "  safe"),
                hvh_safe_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_safe_color", 0, 255, 0, 255),
                hvh_unsafe_color_label = api.ui.new_label("VISUALS", "Other ESP", "  unsafe"),
                hvh_unsafe_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_unsafe_color", 255, 0, 0, 255)
            },
            smoke = {
                background_color_label = api.ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = api.ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = api.ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = api.ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = api.ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = api.ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255)
            },
            general = {
                fade_out = api.ui.new_checkbox("VISUALS", "Other ESP", "Fade out"),
                circle_radius = api.ui.new_slider("VISUALS", "Other ESP", "Indicator radius", 10, 30, 20, true, "px", 1, nil),
                outline_thickness = api.ui.new_slider("VISUALS", "Other ESP", "Outline thickness", 1, 5, 2, true, "px", 1, nil),
                icon_size = api.ui.new_slider("VISUALS", "Other ESP", "Icon size", 10, 50, 20, true, "px", 1, nil)
            }
        }
    }
}
---------------------
------FUNCTIONS------
---------------------
-- nade esp
local function get_inferno_color(hvh_mode_enabled)
    local icon_color, indicator_color, icon_color2, indicator_color2 = nil, nil, nil, nil

    if hvh_mode_enabled == true then
        icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_unsafe_color))
        indicator_color = icon_color

        icon_color2 = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_safe_color))
        indicator_color2 = icon_color2
    else
        icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.icon_color))
        indicator_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.indicator_color))
    end

    return {
        icon_color = {
            [1] = icon_color,
            [2] = icon_color2
        },
        indicator_color = {
            [1] = indicator_color,
            [2] = indicator_color2
        }
    }
end

local function draw_inferno()
    local hvh_mode_enabled = api.ui.get(ui_additions.nade_esp.settings.molotov.hvhmode)
    local background_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.background_color))
    local color = get_inferno_color(hvh_mode_enabled)
    local icon_size = api.ui.get(ui_additions.nade_esp.settings.general.icon_size)
    local circle_radius = api.ui.get(ui_additions.nade_esp.settings.general.circle_radius)
    local outline_thickness = api.ui.get(ui_additions.nade_esp.settings.general.outline_thickness)
    local fade_out = api.ui.get(ui_additions.nade_esp.settings.general.fade_out)

    local molos = api.entity.get_all("CInferno")
    for i = 1, #molos do
        local index = molos[i]

        local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
        local endTime = api.entity.get_prop(index, "m_nFireEffectTickBegin") + var.nade_data.inferno.time
        local local_player = api.entity.get_local_player()
        local owner = api.entity.get_prop(index, "m_hOwnerEntity")
        local enemy = api.entity.is_enemy(owner)

        local curtime = api.globals.tickcount()
        local dif = endTime - curtime
        local percentage = (dif * 100 / var.nade_data.inferno.time) / 100

        local posX, posY = api.renderer.world_to_screen(x, y, z)

        if posX ~= nil and posY ~= nil then
            local is_molly_safe = (enemy == false and hvh_mode_enabled == true and owner ~= local_player and var.cvar.mp_friendlyfire == "0")

            local _background_color = background_color
            local _indicator_color = ternary(is_molly_safe, color.indicator_color[2], color.indicator_color[1])
            local _icon_color = ternary(is_molly_safe, color.icon_color[2], color.icon_color[1])

            if fade_out == true then
                local alpha = (255 * ((percentage) * 100) / 100)

                _background_color.a = alpha
                _indicator_color.a = alpha
                _icon_color.a = alpha
            end

            api.renderer.circle(posX, posY, _background_color.r, _background_color.g, _background_color.b, _background_color.a, circle_radius, 0, 1)
            api.renderer.circle_outline(
                posX,
                posY,
                _indicator_color.r,
                _indicator_color.g,
                _indicator_color.b,
                _indicator_color.a,
                circle_radius - (outline_thickness / 2),
                270,
                percentage,
                outline_thickness
            )

            local width, height = images.get_panorama_image("hud/deathnotice/icon-molotov.png"):measure(nil, icon_size)
            images.get_panorama_image("hud/deathnotice/icon-molotov.png"):draw(
                posX - (width / 2),
                posY - (height / 2),
                width,
                height,
                _icon_color.r,
                _icon_color.g,
                _icon_color.b,
                _icon_color.a
            )
        end
    end
end

local function draw_smoke()
    local background_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.background_color))
    local icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.icon_color))
    local indicator_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.indicator_color))
    local icon_size = api.ui.get(ui_additions.nade_esp.settings.general.icon_size)
    local circle_radius = api.ui.get(ui_additions.nade_esp.settings.general.circle_radius)
    local outline_thickness = api.ui.get(ui_additions.nade_esp.settings.general.outline_thickness)
    local fade_out = api.ui.get(ui_additions.nade_esp.settings.general.fade_out)

    local smokes = api.entity.get_all("CSmokeGrenadeProjectile")
    for i = 1, #smokes do
        local index = smokes[i]
        local smokeEffect = api.entity.get_prop(index, "m_bDidSmokeEffect")

        -- wait for m_nSmokeEffectTickBegin
        if smokeEffect == 1 then
            local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
            local endTime = api.entity.get_prop(index, "m_nSmokeEffectTickBegin") + var.nade_data.smoke.time

            local curtime = api.globals.tickcount()
            local dif = endTime - curtime
            local percentage = (dif * 100 / var.nade_data.smoke.time) / 100

            local posX, posY = api.renderer.world_to_screen(x, y, z)

            if posX ~= nil and posY ~= nil then
                local _background_color = background_color
                local _indicator_color = indicator_color
                local _icon_color = icon_color

                if fade_out == true then
                    local alpha = (255 * ((percentage) * 100) / 100)
    
                    _background_color.a = alpha
                    _indicator_color.a = alpha
                    _icon_color.a = alpha
                end

                api.renderer.circle(posX, posY, _background_color.r, _background_color.g, _background_color.b, _background_color.a, circle_radius, 0, 1)
                api.renderer.circle_outline(
                    posX,
                    posY,
                    _indicator_color.r,
                    _indicator_color.g,
                    _indicator_color.b,
                    _indicator_color.a,
                    circle_radius - (outline_thickness / 2),
                    270,
                    percentage,
                    outline_thickness
                )

                local width, height = images.get_panorama_image("hud/deathnotice/icon-smokegrenade.png"):measure(nil, icon_size)
                images.get_panorama_image("hud/deathnotice/icon-smokegrenade.png"):draw(
                    posX - (width / 2),
                    posY - (height / 2),
                    width,
                    height,
                    _icon_color.r,
                    _icon_color.g,
                    _icon_color.b,
                    _icon_color.a
                )
            end
        end
    end
end

local function nade_esp_setvisible()
    local active_settings_tab = api.ui.get(ui_additions.nade_esp.ui_settings)

    api.table.foreach(
        ui_additions.nade_esp.settings,
        function(index)
            local status = index:lower() == active_settings_tab:lower()

            api.table.foreach(
                ui_additions.nade_esp.settings[index],
                function(index1)
                    api.ui.set_visible(ui_additions.nade_esp.settings[index][index1], status)
                end
            )
        end
    )
end
--------------------
-------EVENTS-------
--------------------
local function paint()
     local selected = api.ui.get(ui_additions.nade_esp.ui_enabled)

    if selected[1] == "Molotov" or selected[2] == "Molotov" then
        draw_inferno()
    end

    if selected[1] == "Smoke" or selected[2] == "Smoke" then
        draw_smoke()
    end
end

local function round_start()
    var.cvar.mp_friendlyfire = api.client.get_cvar("mp_friendlyfire");
end
--------------------
-----INITIALIZE-----
--------------------
local function init_nade_esp()
    var.cvar.mp_friendlyfire = api.client.get_cvar("mp_friendlyfire");
    nade_esp_setvisible();
    api.ui.set_callback(ui_additions.nade_esp.ui_settings, nade_esp_setvisible)
end

local function init()
    init_nade_esp();
    api.client.set_event_callback("paint", paint);
    api.client.set_event_callback("round_start", round_start);
end
init();
