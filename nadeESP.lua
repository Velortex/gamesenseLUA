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
        get = ui.get
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
        ui_hvhmode = api.ui.new_checkbox("VISUALS", "Other ESP", "Nade ESP HvH-mode")
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
            api.renderer.circle(posX, posY, 0, 0, 0, 200, 20, 0, 1);
            api.renderer.circle_outline(posX, posY, 255, 255, 255, 255, 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/molotov.svg"):measure(nil, 20);
            if enemy == false and api.ui.get(ui_additions.nade_esp.ui_hvhmode) == true and owner ~= local_player then
                images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2), posY - (height / 2), width, height, 0,255,0,255)
            else
                images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2), posY - (height / 2), width, height)
            end
        end
    end
end

local function draw_smoke()
    local val = api.ui.get(ui_additions.nade_esp.ui_enabled);
    if val[1] ~= "Smoke" and val[2] ~= "Smoke" then
        return;
    end

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
            api.renderer.circle(posX, posY, 0, 0, 0, 200, 20, 0, 1);
            api.renderer.circle_outline(posX, posY, 255, 255, 255, 255, 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/smokegrenade.svg"):measure(nil, 20);
            images.get_panorama_image("icons/equipment/smokegrenade.svg"):draw(posX - (width / 2), posY - (height / 2), width, height)
        end

        ::skip_to_next::
    end
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
local function init()
    api.client.set_event_callback("paint", paint);
end
init();
