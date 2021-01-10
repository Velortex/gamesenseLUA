---------------------
---------API---------
---------------------
local api = {
    client = {
        set_event_callback = client.set_event_callback
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
        ui_enabled = api.ui.new_multiselect("VISUALS", "Other ESP", "Nade ESP", "Smoke", "Molotov"),
        ui_settings = api.ui.new_combobox("VISUALS", "Other ESP", "Nade ESP settings", "Smoke", "Molotov"),
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
                hvh_unsafe_color = api.ui.new_color_picker("VISUALS", "Other ESP", "hvh_icon_unsafe_color", 255, 0, 0,
                    255)
            },
            smoke = {
                background_color_label = api.ui.new_label("VISUALS", "Other ESP", "Background"),
                background_color = api.ui.new_color_picker("VISUALS", "Other ESP", "background_color", 0, 0, 0, 200),
                icon_color_label = api.ui.new_label("VISUALS", "Other ESP", "Icon"),
                icon_color = api.ui.new_color_picker("VISUALS", "Other ESP", "icon_color", 255, 255, 255, 255),
                indicator_color_label = api.ui.new_label("VISUALS", "Other ESP", "Indicator"),
                indicator_color = api.ui.new_color_picker("VISUALS", "Other ESP", "indicator_color", 255, 255, 255, 255)
            }
        }
    }
}
---------------------
------FUNCTIONS------
---------------------
-- nade esp
local function draw_inferno()
    local val = api.ui.get(ui_additions.nade_esp.ui_enabled);

    if val[1] ~= "Molotov" and val[2] ~= "Molotov" then
        return;
    end

    local hvh_mode_enabled = api.ui.get(ui_additions.nade_esp.settings.molotov.hvhmode);

    local background_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.background_color));
    local icon_color = nil;
    local indicator_color = nil;

    local icon_color2 = nil;
    local indicator_color2 = nil;

    if hvh_mode_enabled == true then
        icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_unsafe_color));
        indicator_color = icon_color;

        icon_color2 = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.hvh_safe_color));
        indicator_color2 = icon_color2;
    else
        icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.icon_color));
        indicator_color = Color(api.ui.get(ui_additions.nade_esp.settings.molotov.indicator_color));
    end

    local molos = api.entity.get_all("CInferno");
    for i = 1, #molos do
        local index = molos[i];

        local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
        local endTime = api.entity.get_prop(index, "m_nFireEffectTickBegin") + var.nade_data.inferno.time;
        local local_player = api.entity.get_local_player();
        local owner = api.entity.get_prop(index, "m_hOwnerEntity");
        local enemy = api.entity.is_enemy(owner);

        local curtime = api.globals.tickcount();
        local dif = endTime - curtime;
        local percentage = (dif * 100 / var.nade_data.inferno.time) / 100;

        local posX, posY = api.renderer.world_to_screen(x, y, z);

        if posX ~= nil and posY ~= nil then
            api.renderer.circle(posX, posY, background_color.r, background_color.g, background_color.b,
                background_color.a, 20, 0, 1);
            local width, height = images.get_panorama_image("icons/equipment/molotov.svg"):measure(nil, 20);
            if enemy == false and hvh_mode_enabled == true and owner ~= local_player then
                api.renderer.circle_outline(posX, posY, indicator_color2.r, indicator_color2.g, indicator_color2.b,
                    indicator_color2.a, 18, 270, percentage, 2)
                images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2), posY - (height / 2),
                    width, height, icon_color2.r, icon_color2.g, icon_color2.b, icon_color2.a)
            else
                api.renderer.circle_outline(posX, posY, indicator_color.r, indicator_color.g, indicator_color.b,
                    indicator_color.a, 18, 270, percentage, 2)
                images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2), posY - (height / 2),
                    width, height, icon_color.r, icon_color.g, icon_color.b, icon_color.a)
            end
        end
    end
end

local function draw_smoke()
    local val = api.ui.get(ui_additions.nade_esp.ui_enabled);
    if val[1] ~= "Smoke" and val[2] ~= "Smoke" then
        return;
    end

    local background_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.background_color));
    local icon_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.icon_color));
    local indicator_color = Color(api.ui.get(ui_additions.nade_esp.settings.smoke.indicator_color));

    local smokes = api.entity.get_all("CSmokeGrenadeProjectile");
    for i = 1, #smokes do
        local index = smokes[i];
        local smokeEffect = api.entity.get_prop(index, "m_bDidSmokeEffect");
        -- wait for m_nSmokeEffectTickBegin
        if smokeEffect ~= 1 then
            goto skip_to_next
        end

        local x, y, z = api.entity.get_prop(index, "m_vecOrigin")
        local endTime = api.entity.get_prop(index, "m_nSmokeEffectTickBegin") + var.nade_data.smoke.time;

        local curtime = api.globals.tickcount();
        local dif = endTime - curtime;
        local percentage = (dif * 100 / var.nade_data.smoke.time) / 100;

        local posX, posY = api.renderer.world_to_screen(x, y, z);

        if posX ~= nil and posY ~= nil then
            api.renderer.circle(posX, posY, background_color.r, background_color.g, background_color.b,
                background_color.a, 20, 0, 1);
            api.renderer.circle_outline(posX, posY, indicator_color.r, indicator_color.g, indicator_color.b,
                indicator_color.a, 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/smokegrenade.svg"):measure(nil, 20);
            images.get_panorama_image("icons/equipment/smokegrenade.svg"):draw(posX - (width / 2), posY - (height / 2),
                width, height, icon_color.r, icon_color.g, icon_color.b, icon_color.a)
        end

        ::skip_to_next::
    end
end

local function nade_esp_setvisible()
    local active_settings_tab = api.ui.get(ui_additions.nade_esp.ui_settings);

    api.table.foreach(ui_additions.nade_esp.settings, function(index)
        local status = index:lower() == active_settings_tab:lower();

        api.table.foreach(ui_additions.nade_esp.settings[index], function(index1)
            api.ui.set_visible(ui_additions.nade_esp.settings[index][index1], status);
        end)
    end)
end
--------------------
-------EVENTS-------
--------------------
local function paint()
    draw_inferno();
    draw_smoke();
end
--------------------
-----INITIALIZE-----
--------------------
local function init_nade_esp()
    nade_esp_setvisible();
    api.ui.set_callback(ui_additions.nade_esp.ui_settings, nade_esp_setvisible)
end

local function init()
    init_nade_esp();
    api.client.set_event_callback("paint", paint);
end
init();
