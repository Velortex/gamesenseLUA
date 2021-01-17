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
        circle = renderer.circle,
	triangle = renderer.triangle,
	line = renderer.line
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
    },
   math = {
       rad = math.rad,
       sin = math.sin,
       cos = math.cos
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

function Vector(X, Y, Z)
    return {
        x = X or 0,
        y = Y or 0,
        z = Z or 0
    }
end

function ScreenPos(X, Y)
    return {
        x = X or nil,
        y = Y or nil
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
        ui_settings = api.ui.new_combobox("VISUALS", "Other ESP", "Nade ESP settings", "General", "Smoke", "Molotov", "Fade out"),
        settings = {
            molotov = {
                draw_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Draw spread circles"),
                radius_color = api.ui.new_color_picker("VISUALS", "Other ESP", "radius_color", 255, 0, 0, 255),
                fill_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Fill spread"),
                radius_fill_color = api.ui.new_color_picker("VISUALS", "Other ESP", "fill_radius_color", 255, 0, 0, 100),
                indicate_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Indicate time on the spread circles"),
                background_color_label = api.ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = api.ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = api.ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = api.ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = api.ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = api.ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255),
                hvhmode = api.ui.new_checkbox("VISUALS", "Other ESP", "HvH-mode"),
                hvh_safe_color_label = api.ui.new_label("VISUALS", "Other ESP", "Safe Molotov: Indicator"),
                hvh_safe_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_safe_color", 0, 255, 0, 255),
                hvh_safe_spread_color_label = api.ui.new_label("VISUALS", "Other ESP", "Safe Molotov: Draw spread circle"),
                hvh_safe_spread_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_safe_spread_color", 0, 255, 0, 255),
                hvh_safe_spread_fill_color_label = api.ui.new_label("VISUALS", "Other ESP", "Safe Molotov: Fill spread"),
                hvh_safe_spread_fill_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_safe_spread_fill_color", 0, 255, 0, 100),
                hvh_unsafe_color_label = api.ui.new_label("VISUALS", "Other ESP", "Unsafe Molotov: Indicator"),
                hvh_unsafe_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_unsafe_color", 255, 0, 0, 255),
                hvh_unsafe_spread_color_label = api.ui.new_label("VISUALS", "Other ESP", "Unsafe Molotov: Draw spread circle"),
                hvh_unsafe_spread_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_unsafe_spread_color", 255, 0, 0, 255),
                hvh_unsafe_spread_fill_color_label = api.ui.new_label("VISUALS", "Other ESP", "Unsafe Molotov: Fill spread"),
                hvh_unsafe_spread_fill_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_unsafe_spread_fill_color", 255, 0, 0, 100)
            },
            smoke = {
                draw_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Draw radius outline"),
                radius_color = api.ui.new_color_picker("VISUALS", "Other ESP", "smoke_radius_color", 0, 0, 255, 255),
                fill_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Fill radius"),
                radius_fill_color = api.ui.new_color_picker("VISUALS", "Other ESP", "smoke_fill_radius_color", 0, 0, 255, 100),
                indicate_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Indicate time on the radius outline"),
                background_color_label = api.ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = api.ui.new_color_picker("VISUALS", "Other ESP", "smoke_background_color", 0, 0, 0, 200),
                icon_color_label = api.ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = api.ui.new_color_picker("VISUALS", "Other ESP", "smoke_icon_color", 255, 255, 255, 255),
                indicator_color_label = api.ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = api.ui.new_color_picker("VISUALS", "Other ESP", "smoke_indicator_color", 255, 255, 255, 255)
            },
            general = {
                circle_radius = api.ui.new_slider("VISUALS", "Other ESP", "Indicator radius", 10, 30, 20, true, "px", 1, nil),
                outline_thickness = api.ui.new_slider("VISUALS", "Other ESP", "Outline thickness", 1, 5, 2, true, "px", 1, nil),
                icon_size = api.ui.new_slider("VISUALS", "Other ESP", "Icon size", 10, 50, 20, true, "px", 1, nil)
            },
            fade_out = {
                smoke_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Smoke: Fade radius outline"),
                smoke_radius_fill = api.ui.new_checkbox("VISUALS", "Other ESP", "Smoke: Fade radius fill"),
                smoke_esp = api.ui.new_checkbox("VISUALS", "Other ESP", "Smoke: Fade icon"),
                molotov_radius = api.ui.new_checkbox("VISUALS", "Other ESP", "Molotov: Fade spread outline"),
                molotov_radius_fill = api.ui.new_checkbox("VISUALS", "Other ESP", "Molotov: Fade spread fill"),
                molotov_esp = api.ui.new_checkbox("VISUALS", "Other ESP", "Molotov: Fade icon")
            }
        }
    }
}
--------------------
------RENDERER------
--------------------
local renderer3D = {
    circle_outline = function(pos, radius, r, g, b, a, segments, start_degrees, percentage)
        local old_positon = nil

        for rotation = start_degrees, percentage * 360, 360 / segments do
            temp_rotation = api.math.rad(rotation)

            local x = radius * api.math.cos(temp_rotation) + pos.x
            local y = radius * api.math.sin(temp_rotation) + pos.y
            local positon = Vector(x, y, pos.z)

            if old_positon ~= nil then
                local screen_pos = ScreenPos(api.renderer.world_to_screen(positon.x, positon.y, positon.z))

                if screen_pos.x ~= nil and old_positon.x ~= nil then
                    api.renderer.line(old_positon.x, old_positon.y, screen_pos.x, screen_pos.y, r, g, b, a)
                end
                old_positon = screen_pos
            else
                old_positon = ScreenPos(api.renderer.world_to_screen(positon.x, positon.y, positon.z))
            end
        end
    end,
    circle = function(pos, radius, r, g, b, a, segments, start_degrees, percentage)
        local middle = ScreenPos(api.renderer.world_to_screen(pos.x, pos.y, pos.z))
        local old_positon = nil
        local waitfornext = false
        local last_visible

        for rotation = start_degrees, percentage * 360, 360 / segments do
            temp_rotation = api.math.rad(rotation)

            local x = radius * api.math.cos(temp_rotation) + pos.x
            local y = radius * api.math.sin(temp_rotation) + pos.y
            local positon = Vector(x, y, pos.z)

            if old_positon ~= nil then
                local screen_pos = ScreenPos(api.renderer.world_to_screen(positon.x, positon.y, positon.z))

                if screen_pos.x ~= nil and old_positon.x ~= nil then
                    api.renderer.triangle(middle.x, middle.y, old_positon.x, old_positon.y, screen_pos.x, screen_pos.y, r, g, b, a)
                    last_visible = screen_pos
                elseif middle.x ~= nil and waitfornext == true and last_visible ~= nil and screen_pos.x ~= nil then
                    api.renderer.triangle(middle.x, middle.y, last_visible.x, last_visible.y, screen_pos.x, screen_pos.y, r, g, b, a)
                    last_visible = screen_pos
                else
                    waitfornext = true
                end
                old_positon = screen_pos
            else
                old_positon = ScreenPos(api.renderer.world_to_screen(positon.x, positon.y, positon.z))
            end
        end
    end
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

        spread_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_unsafe_spread_color))
        spread_color2 = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_safe_spread_color))

        spread_fill_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_unsafe_spread_fill_color))
        spread_fill_color2 = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_safe_spread_fill_color))
    else
        icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.icon_color))
        indicator_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.indicator_color))
        spread_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.radius_fill_color))
        spread_fill_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.radius_color))
    end

    return {
        icon_color = {
            [1] = icon_color,
            [2] = icon_color2
        },
        indicator_color = {
            [1] = indicator_color,
            [2] = indicator_color2
        },
        spread_color = {
            [1] = spread_color,
            [2] = spread_color2
        },
        spread_fill_color = {
            [1] = spread_fill_color,
            [2] = spread_fill_color2
        }
    }
end

local function draw_inferno()
    local hvh_mode_enabled = api.ui.get(ui_additions.nade_esp.settings.molotov.hvhmode)
    local background_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.background_color))
    local color = {}
    local icon_size = api.ui.get(ui_additions.nade_esp.settings.general.icon_size)
    local circle_radius = api.ui.get(ui_additions.nade_esp.settings.general.circle_radius)
    local outline_thickness = api.ui.get(ui_additions.nade_esp.settings.general.outline_thickness)
    local fade_out_esp = api.ui.get(ui_additions.nade_esp.settings.fade_out.molotov_esp)
    local fade_out_radius = api.ui.get(ui_additions.nade_esp.settings.fade_out.molotov_radius)
    local fade_out_radius_fill = api.ui.get(ui_additions.nade_esp.settings.fade_out.molotov_radius_fill)
    local draw_radius = api.ui.get(ui_additions.nade_esp.settings.molotov.draw_radius)
    local radius_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.radius_color))
    local draw_filled_radius = api.ui.get(ui_additions.nade_esp.settings.molotov.fill_radius)
    local filled_radius_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.radius_fill_color))
    local indicate_radius = api.ui.get(ui_additions.nade_esp.settings.molotov.indicate_radius)

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

        color = get_inferno_color(hvh_mode_enabled)
        local is_molly_safe = (enemy == false and hvh_mode_enabled == true and owner ~= local_player and var.cvar.mp_friendlyfire == "0")

        local _background_color = background_color
        local _indicator_color = ternary(is_molly_safe, color.indicator_color[2], color.indicator_color[1])
        local _icon_color = ternary(is_molly_safe, color.icon_color[2], color.icon_color[1])
        local _filled_radius_color = ternary(is_molly_safe, color.spread_fill_color[2], color.spread_fill_color[1])
        local _radius_color = ternary(is_molly_safe, color.spread_color[2], color.spread_color[1])

        if fade_out_esp == true then
            local alpha = (255 * ((percentage) * 100) / 100)
            _background_color.a = alpha
            _indicator_color.a = alpha
            _icon_color.a = alpha
        end

        if fade_out_radius_fill == true then
            local alpha = (filled_radius_color.a * ((percentage) * 100) / 100)
            _filled_radius_color.a = alpha
        end

        if fade_out_radius == true then
            local alpha = (radius_color.a * ((percentage) * 100) / 100)
            _radius_color.a = alpha
        end

        local firecount = api.entity.get_prop(index, "m_fireCount")

        for i = 0, firecount do
            local x1 = x + api.entity.get_prop(index, "m_fireXDelta", i)
            local y1 = y + api.entity.get_prop(index, "m_fireYDelta", i)
            local z1 = z + api.entity.get_prop(index, "m_fireZDelta", i)

            local spread_pos = Vector(x1, y1, z1)
            if draw_filled_radius == true then
                renderer3D.circle(spread_pos, 60, _filled_radius_color.r, _filled_radius_color.g, _filled_radius_color.b, _filled_radius_color.a, 90, 0, 1)
            end

            if draw_radius == true then
                renderer3D.circle_outline(
                    spread_pos,
                    60,
                    _radius_color.r,
                    _radius_color.g,
                    _radius_color.b,
                    _radius_color.a,
                    ternary(indicate_radius, 360, 90),
                    0,
                    ternary(indicate_radius, percentage, 1)
                )
            end
        end

        if posX ~= nil and posY ~= nil then
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
    local fade_out_esp = api.ui.get(ui_additions.nade_esp.settings.fade_out.smoke_esp)
    local fade_out_radius = api.ui.get(ui_additions.nade_esp.settings.fade_out.smoke_radius)
    local fade_out_radius_fill = api.ui.get(ui_additions.nade_esp.settings.fade_out.smoke_radius_fill)
    local draw_radius = api.ui.get(ui_additions.nade_esp.settings.smoke.draw_radius)
    local radius_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.radius_color))
    local draw_filled_radius = api.ui.get(ui_additions.nade_esp.settings.smoke.fill_radius)
    local filled_radius_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.radius_fill_color))
    local indicate_radius = api.ui.get(ui_additions.nade_esp.settings.smoke.indicate_radius)

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

            local _background_color = background_color
            local _indicator_color = indicator_color
            local _icon_color = icon_color
            local _filled_radius_color = filled_radius_color
            local _radius_color = radius_color

            if fade_out_esp == true then
                local alpha = (255 * ((percentage) * 100) / 100)
                _background_color.a = alpha
                _indicator_color.a = alpha
                _icon_color.a = alpha
            end

            if fade_out_radius_fill == true then
                local alpha = (filled_radius_color.a * ((percentage) * 100) / 100)
                _filled_radius_color.a = alpha
            end

            if fade_out_radius == true then
                local alpha = (radius_color.a * ((percentage) * 100) / 100)
                _radius_color.a = alpha
            end

            if draw_radius == true then
                renderer3D.circle_outline(
                    Vector(x, y, z),
                    144,
                    _radius_color.r,
                    _radius_color.g,
                    _radius_color.b,
                    _radius_color.a,
                    ternary(indicate_radius, 360, 90),
                    0,
                    ternary(indicate_radius, percentage, 1)
                )
            end

            if draw_filled_radius == true then
                renderer3D.circle(Vector(x, y, z), 144, _filled_radius_color.r, _filled_radius_color.g, _filled_radius_color.b, _filled_radius_color.a, 90, 0, 1)
            end

            if posX ~= nil and posY ~= nil then
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
            local status = index:lower() == active_settings_tab:lower():gsub(" ", "_")

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
