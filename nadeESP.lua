---------------------
---------API---------
---------------------
local api = {
    client = {
        set_event_callback = client.set_event_callback
    },
    entity = {
        get_all = entity.get_all,
        get_prop = entity.get_prop
    },
    globals = {
        tickcount = globals.tickcount,
    },
    renderer = {
        world_to_screen = renderer.world_to_screen,
        circle_outline = renderer.circle_outline,
        circle = renderer.circle
    },
    ui = {
        new_color_picker = ui.new_color_picker,
        new_multiselect = ui.new_multiselect,
        new_slider = ui.new_slider,
        set_visible = ui.set_visible
        get = ui.get,
    }
}
---------------------
---------LIB---------
---------------------
local images = require "gamesense/images"
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
        ui_enabled = api.ui.new_multiselect("VISUALS", "Other ESP", "Nade ESP", "Smoke", "Molotov"),
        outline_color = api.ui.new_color_picker("VISUALS", "Other ESP", "Nade ESP outline color", 149, 184, 6, 255),
        icon_size = api.ui.new_slider("VISUALS", "Other ESP", "Nade ESP icon size", 1, 35, 25, true, "px")
    }
}
---------------------
------FUNCTIONS------
---------------------
-- nade esp
local function draw_inferno()
    local molos = api.entity.get_all("CInferno")

    for i = 1, #molos do
        local index = molos[i]

        local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
        local endTime = api.entity.get_prop(index, "m_nFireEffectTickBegin") + var.nade_data.inferno.time

        local curtime = api.globals.tickcount()
        local dif = endTime - curtime
        local percentage = (dif * 100 / var.nade_data.inferno.time) / 100

        local posX, posY = api.renderer.world_to_screen(x, y, z)

        if posX ~= nil and posY ~= nil then
            local color = {api.ui.get(ui_additions.nade_esp.outline_color)}

            api.renderer.circle(posX, posY, 0, 0, 0, 200, 20, 0, 1)
            api.renderer.circle_outline(posX, posY, color[1], color[2], color[3], color[4], 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/molotov.svg"):measure(nil, api.ui.get(ui_additions.nade_esp.icon_size))
            images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2) + 1, posY - (height / 2) - 2, width, height)
        end
    end
end

local function draw_smoke()
    local smokes = api.entity.get_all("CSmokeGrenadeProjectile")

    for i = 1, #smokes do
        local index = smokes[i]
        local smokeEffect = api.entity.get_prop(index, "m_bDidSmokeEffect")
        -- wait for m_nSmokeEffectTickBegin
        if smokeEffect ~= 1 then
            goto skip_to_next
        end

        local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
        local endTime = api.entity.get_prop(index, "m_nSmokeEffectTickBegin") + var.nade_data.smoke.time

        local curtime = api.globals.tickcount()
        local dif = endTime - curtime
        local percentage = (dif * 100 / var.nade_data.smoke.time) / 100

        local posX, posY = api.renderer.world_to_screen(x, y, z)

        if posX ~= nil and posY ~= nil then
            local color = {api.ui.get(ui_additions.nade_esp.outline_color)}

            api.renderer.circle(posX, posY, 0, 0, 0, 200, 20, 0, 1)
            api.renderer.circle_outline(posX, posY, color[1], color[2], color[3], color[4], 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/smokegrenade.svg"):measure(nil, api.ui.get(ui_additions.nade_esp.icon_size))
            images.get_panorama_image("icons/equipment/smokegrenade.svg"):draw(posX - (width / 2) + 1, posY - (height / 2) - 1, width, height)
        end

        ::skip_to_next::
    end
end
--------------------
-------EVENTS-------
--------------------
local function paint()
    local selected = api.ui.get(ui_additions.nade_esp.ui_enabled)

    api.ui.set_visible(ui_additions.nade_esp.icon_size, #selected > 0)

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
local function init()
    api.client.set_event_callback("paint", paint)
end
init()
