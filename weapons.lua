function get_weapon_texture_name(prefix, weapon_name, texture_type, filetype)
    -- Given a weapon name "rustington" and a texture type "icon",
    -- return a string "boomstick_rustington_icon.png"
    return prefix .. "_" .. weapon_name .. "_" .. texture_type .. "." .. filetype
end

function get_all_weapon_texture_names(prefix, weapon_name, filetype)
    local texture_data = {
        icon = nil,
        default = nil,
        reload = nil
    }

    for k,v in pairs(texture_data) do
        texture_data.k = boomstick.get_weapon_texture_name(prefix, weapon_name, k, filetype)
    end

    return texture_data
end

function weapon_cycle(itemstack, user, pointed_thing)
    -- TODO: this should also call a function that ejects a shell. if the
    -- chamber was loaded, a loaded shell should eject, otherwise an empty
    -- shell
    --
    print("AAAYA")

    local player_metadata = user:get_meta()
    local weapon_metadata = itemstack:get_meta()

    if player_metadata:get_float("boomstick_cycle_cooldown") > 0 then
        return
    end

    local boomstick_data = itemstack:get_definition(itemstack).boomstick_weapon_data
    local player_position = user:get_pos()

    minetest.sound_play(
        {name=boomstick_data.cycle_weapon_sound},
        {
            pos = player_position,
            gain = 1.0,
            max_hear_distance = 5,
        },
        false
    )

    -- Start the cooldown time after firing
    player_metadata:set_float("boomstick_cycle_cooldown", boomstick_data.cycle_cooldown)
    boomstick_data.ready = true

end

function weapon_fire(itemstack, user, pointed_thing)
    local player_metadata = user:get_meta()
    local weapon_metadata = itemstack:get_meta()
    print("BANG!")

    if player_metadata:get_float("boomstick_cycle_cooldown") > 0 then
        return
    end

    local boomstick_data = itemstack:get_definition(itemstack).boomstick_weapon_data
    local player_position = user:get_pos()

    if boomstick_data.rounds_loaded == 0 or boomstick_data.ready == false then
        minetest.sound_play(
            {name=boomstick_data.empty_sound},
            {
                pos = player_position,
                gain = 0.25,
                max_hear_distance = 5,
            },
            false
        )
    else
        minetest.sound_play(
            {name=boomstick_data.fire_weapon_sound},
            {
                pos = player_position,
                gain = 1.0,
                max_hear_distance = 32,
            },
            false
        )
    end

    -- Start the cooldown time after firing
    boomstick_data.ready = false

    return itemstack
end

function load_weapon(held_itemstack, user, pointed_thing)
    -- Loads a single round into a weapon.

    local player_name = user:get_player_name()
    local inv = minetest.get_inventory({type = "player", name = player_name})
    local weapons_data = held_itemstack:get_definition().boomstick_weapon_data

    inv = inv:get_list("main")

    for i, inv_itemstack in ipairs(inv) do
        if boomstick.item_is_weapon(inv_itemstack) then
            local weapon_data = boomstick.get_weapon_data(inv_itemstack)

            if weapon_data.ammo_type == held_itemstack:get_name() then
                if not boomstick.weapon_is_full(weapons_data) then
                    weapon_data.rounds_loaded = weapons_data.rounds_loaded + 1
                end
            end
        end
    end
end

function weapon_fire_cooldown(dtime)
    for _, player in pairs(minetest.get_connected_players()) do
        local player_metadata = player:get_meta()
        local fire_weapon_cooldown = player_metadata:get_float("boomstick_fire_cooldown")

        if fire_weapon_cooldown > 0 then
            player_metadata:set_float("boomstick_fire_cooldown", fire_weapon_cooldown - dtime)
        end
    end
end

function weapon_cycle_cooldown(dtime)
    for _, player in pairs(minetest.get_connected_players()) do
        local player_metadata = player:get_meta()
        local cycle_weapon_cooldown = player_metadata:get_float("boomstick_cycle_cooldown")

        if cycle_weapon_cooldown > 0 then
            player_metadata:set_float("boomstick_cycle_cooldown", cycle_weapon_cooldown - dtime)
        end
    end
end


minetest.register_globalstep(weapon_cycle_cooldown)
minetest.register_globalstep(weapon_fire_cooldown)
