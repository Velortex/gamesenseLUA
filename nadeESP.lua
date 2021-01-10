---------------------
---------API---------
---------------------
local api = {
    bit = {
        rol = bit.rol,
        rshift = bit.rshift,
        ror = bit.ror,
        bswap = bit.bswap,
        bxor = bit.bxor,
        bor = bit.bor,
        arshift = bit.arshift,
        bnot = bit.bnot,
        tobit = bit.tobit,
        lshift = bit.lshift,
        tohex = bit.tohex,
        band = bit.band
    },
    client = {
        world_to_screen = client.world_to_screen,
        draw_rectangle = client.draw_rectangle,
        draw_circle_outline = client.draw_circle_outline,
        userid_to_entindex = client.userid_to_entindex,
        draw_gradient = client.draw_gradient,
        set_event_callback = client.set_event_callback,
        screen_size = client.screen_size,
        trace_bullet = client.trace_bullet,
        unset_event_callback = client.unset_event_callback,
        color_log = client.color_log,
        reload_active_scripts = client.reload_active_scripts,
        scale_damage = client.scale_damage,
        get_cvar = client.get_cvar,
        camera_position = client.camera_position,
        create_interface = client.create_interface,
        random_int = client.random_int,
        latency = client.latency,
        set_clan_tag = client.set_clan_tag,
        find_signature = client.find_signature,
        log = client.log,
        timestamp = client.timestamp,
        delay_call = client.delay_call,
        draw_indicator = client.draw_indicator,
        trace_line = client.trace_line,
        draw_circle = client.draw_circle,
        draw_line = client.draw_line,
        draw_text = client.draw_text,
        register_esp_flag = client.register_esp_flag,
        get_model_name = client.get_model_name,
        system_time = client.system_time,
        visible = client.visible,
        exec = client.exec,
        key_state = client.key_state,
        set_cvar = client.set_cvar,
        unix_time = client.unix_time,
        error_log = client.error_log,
        draw_debug_text = client.draw_debug_text,
        update_player_list = client.update_player_list,
        camera_angles = client.camera_angles,
        eye_position = client.eye_position,
        draw_hitboxes = client.draw_hitboxes,
        random_float = client.random_float
    },
    database = {
        read = database.read,
        write = database.write,
        flush = database.flush
    },
    entity = {
        get_local_player = entity.get_local_player,
        is_enemy = entity.is_enemy,
        get_bounding_box = entity.get_bounding_box,
        get_all = entity.get_all,
        set_prop = entity.set_prop,
        is_alive = entity.is_alive,
        get_steam64 = entity.get_steam64,
        get_classname = entity.get_classname,
        get_player_resource = entity.get_player_resource,
        get_esp_data = entity.get_esp_data,
        is_dormant = entity.is_dormant,
        get_player_name = entity.get_player_name,
        get_game_rules = entity.get_game_rules,
        get_origin = entity.get_origin,
        hitbox_position = entity.hitbox_position,
        get_player_weapon = entity.get_player_weapon,
        get_players = entity.get_players,
        get_prop = entity.get_prop
    },
    globals = {
        realtime = globals.realtime,
        absoluteframetime = globals.absoluteframetime,
        chokedcommands = globals.chokedcommands,
        oldcommandack = globals.oldcommandack,
        tickcount = globals.tickcount,
        commandack = globals.commandack,
        lastoutgoingcommand = globals.lastoutgoingcommand,
        curtime = globals.curtime,
        mapname = globals.mapname,
        tickinterval = globals.tickinterval,
        framecount = globals.framecount,
        frametime = globals.frametime,
        maxplayers = globals.maxplayers
    },
    materialsystem = {
        chams_material = materialsystem.chams_material,
        arms_material = materialsystem.arms_material,
        viewmodel_material = materialsystem.viewmodel_material,
        find_texture = materialsystem.find_texture,
        find_material = materialsystem.find_material,
        override_material = materialsystem.override_material,
        find_materials = materialsystem.find_materials,
        get_model_materials = materialsystem.get_model_materials
    },
    renderer = {
        load_svg = renderer.load_svg,
        world_to_screen = renderer.world_to_screen,
        circle_outline = renderer.circle_outline,
        rectangle = renderer.rectangle,
        gradient = renderer.gradient,
        circle = renderer.circle,
        text = renderer.text,
        line = renderer.line,
        load_jpg = renderer.load_jpg,
        load_png = renderer.load_png,
        triangle = renderer.triangle,
        measure_text = renderer.measure_text,
        load_rgba = renderer.load_rgba,
        indicator = renderer.indicator,
        texture = renderer.texture
    },
    ui = {
        new_slider = ui.new_slider,
        new_combobox = ui.new_combobox,
        reference = ui.reference,
        set_visible = ui.set_visible,
        new_textbox = ui.new_textbox,
        new_color_picker = ui.new_color_picker,
        new_checkbox = ui.new_checkbox,
        mouse_position = ui.mouse_position,
        new_listbox = ui.new_listbox,
        new_multiselect = ui.new_multiselect,
        is_menu_open = ui.is_menu_open,
        new_hotkey = ui.new_hotkey,
        set = ui.set,
        update = ui.update,
        menu_size = ui.menu_size,
        name = ui.name,
        menu_position = ui.menu_position,
        set_callback = ui.set_callback,
        new_button = ui.new_button,
        new_label = ui.new_label,
        new_string = ui.new_string,
        get = ui.get
    },
    math = {
        ceil = math.ceil,
        tan = math.tan,
        log10 = math.log10,
        randomseed = math.randomseed,
        cos = math.cos,
        sinh = math.sinh,
        random = math.random,
        huge = math.huge,
        pi = math.pi,
        max = math.max,
        atan2 = math.atan2,
        ldexp = math.ldexp,
        floor = math.floor,
        sqrt = math.sqrt,
        deg = math.deg,
        atan = math.atan,
        fmod = math.fmod,
        acos = math.acos,
        pow = math.pow,
        abs = math.abs,
        min = math.min,
        sin = math.sin,
        frexp = math.frexp,
        log = math.log,
        tanh = math.tanh,
        exp = math.exp,
        modf = math.modf,
        cosh = math.cosh,
        asin = math.asin,
        rad = math.rad
    },
    table = {
        maxn = table.maxn,
        clear = table.clear,
        move = table.move,
        pack = table.pack,
        foreach = table.foreach,
        sort = table.sort,
        remove = table.remove,
        foreachi = table.foreachi,
        unpack = table.unpack,
        getn = table.getn,
        concat = table.concat,
        insert = table.insert
    },
    string = {
        find = string.find,
        rep = string.rep,
        format = string.format,
        len = string.len,
        gsub = string.gsub,
        gmatch = string.gmatch,
        match = string.match,
        reverse = string.reverse,
        byte = string.byte,
        char = string.char,
        upper = string.upper,
        lower = string.lower,
        sub = string.sub
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
        ui_enabled = api.ui.new_multiselect("VISUALS", "Other ESP", "Nade ESP", "Smoke", "Molotov");
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
        
        local curtime = api.globals.tickcount();
        local dif = endTime - curtime;
        local percentage = (dif * 100 / var.nade_data.inferno.time) / 100;

        local posX, posY = api.renderer.world_to_screen(x, y, z);

        if posX ~= nil and posY ~= nil then
            api.renderer.circle(posX, posY, 0, 0, 0, 200, 20, 0, 1);
            api.renderer.circle_outline(posX, posY, 255, 255, 255, 255, 18, 270, percentage, 2)
            local width, height = images.get_panorama_image("icons/equipment/molotov.svg"):measure(nil, 20);
            images.get_panorama_image("icons/equipment/molotov.svg"):draw(posX - (width / 2), posY - (height / 2), width, height)
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
