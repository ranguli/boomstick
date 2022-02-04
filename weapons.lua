boomstick.weapon_cycle_function = function(itemstack, user, pointed_thing)
    -- TODO: this should also call a function that renders a shell being ejected. if the
    -- chamber was loaded (if boomstick_data.ready=true), a loaded shell should
    -- eject, otherwise an empty shell should eject

    local item_def = itemstack:get_definition()
    local boomstick_weapon_data = item_def.boomstick_weapon_data

    if not boomstick.weapon_is_ready(item_def) then
        return
    end

    local player_position = user:get_pos()

    local sound_parameter_table = {name = boomstick_weapon_data.cycle_weapon_sound}
    local sound_spec = {pos = player_position, gain = 1.5, max_hear_distance = 5}

    minetest.sound_play(sound_parameter_table, sound_spec, false)

    boomstick_weapon_data.ready = false

    minetest.after(boomstick_weapon_data.cycle_cooldown, function()
        boomstick_weapon_data.ready = true
    end
)
end


function weapon_fire(itemstack, user, pointed_thing)
    local item_def = itemstack:get_definition()
    local boomstick_weapon_data = itemstack:get_definition().boomstick_weapon_data
    local player_position = user:get_pos()

    if boomstick.weapon_is_empty(item_def) or not boomstick.weapon_is_ready(item_def) then
        -- "Click!"
        local sound_parameter_table = {name = boomstick_weapon_data.empty_sound}
        local sound_spec = {pos = player_position, gain = 0.25, max_hear_distance = 5}

        minetest.sound_play(sound_parameter_table, sound_spec, false)
    else
        -- "Bang!"
        local sound_parameter_table = {name = boomstick_weapon_data.fire_weapon_sound}
        local sound_spec = {pos = player_position, gain = 1.0, max_hear_distance = 32}

        minetest.sound_play(sound_parameter_table, sound_spec, false)

        boomstick_weapon_data.rounds_loaded = boomstick_weapon_data.rounds_loaded - 1
    end

    -- Start the cooldown time after firing
    boomstick_weapon_data.ready = false

    minetest.after(boomstick_weapon_data.fire_cooldown, function()
        boomstick_weapon_data.ready = true
    end
)

    return itemstack
end


boomstick.weapon_fire_function = weapon_fire

function load_weapon(held_itemstack, user, pointed_thing)
    -- Loads a single round into a weapon.

    local player_name = user:get_player_name()
    local player_position = user:get_pos()

    local sound_spec = {pos = player_position, gain = 1.0, max_hear_distance = 32}

    local inv = minetest.get_inventory({type = "player", name = player_name})

    inv = inv:get_list("main")

    for i, inv_itemstack in ipairs(inv) do
        local inv_itemstack_def = inv_itemstack:get_definition()

        if boomstick.item_is_weapon(inv_itemstack_def) then
            local weapon_data = boomstick.get_weapon_data(inv_itemstack_def)
            local sound_parameter_table = {name = weapon_data.load_weapon_sound}

            if weapon_data.ammo_type == held_itemstack:get_name() then
                if not boomstick.weapon_is_full(inv_itemstack_def) then
                    weapon_data.rounds_loaded = weapon_data.rounds_loaded + 1
                    minetest.sound_play(sound_parameter_table, sound_spec, false)
                end
            end
        end
    end
end


boomstick.weapon_load_function = load_weapon
