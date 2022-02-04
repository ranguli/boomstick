local modpath = minetest.get_modpath(minetest.get_current_modname())

boomstick.weapon_cycle_function = function(itemstack, user, pointed_thing)
    -- TODO: this should also call a function that renders a shell being ejected. if the
    -- chamber was loaded (if boomstick_data.ready=true), a loaded shell should eject, otherwise an empty shell should eject

    local player_metadata = user:get_meta()
    local item_def = itemstack:get_definition()
    local boomstick_weapon_data = item_def.boomstick_weapon_data

    if not boomstick.weapon_is_ready(item_def) then
        return
    end

    local player_position = user:get_pos()

    minetest.sound_play(
        {name="boomstick_shotgun_rack"},--boomstick_weapon_data.cycle_weapon_sound},
        {
            pos = player_position,
            gain = 1.5,
            max_hear_distance = 5,
        },
        false
    )

    boomstick_weapon_data.ready = false

    minetest.after(boomstick_weapon_data.cycle_cooldown, function()
        boomstick_weapon_data.ready = true
    end)
end

function weapon_fire(itemstack, user, pointed_thing)
    local player_metadata = user:get_meta()
    local weapon_metadata = itemstack:get_meta()

    local item_def = itemstack:get_definition()
    local boomstick_weapon_data = itemstack:get_definition().boomstick_weapon_data
    local player_position = user:get_pos()

    if boomstick.weapon_is_empty(item_def) or not boomstick.weapon_is_ready(item_def) then
        minetest.sound_play(
            {name=boomstick_weapon_data.empty_sound},
            {
                pos = player_position,
                gain = 0.25,
                max_hear_distance = 5,
            },
            false
        )
    else
        minetest.sound_play(
            {name=boomstick_weapon_data.fire_weapon_sound},
            {
                pos = player_position,
                gain = 1.0,
                max_hear_distance = 32,
            },
            false
        )
        boomstick_weapon_data.rounds_loaded = boomstick_weapon_data.rounds_loaded - 1
    end

    -- Start the cooldown time after firing
    boomstick_weapon_data.ready = false

    print(boomstick_weapon_data.fire_cooldown)
    minetest.after(boomstick_weapon_data.fire_cooldown, function()
        boomstick_weapon_data.ready = true
    end)

    return itemstack
end

boomstick.weapon_fire_function = weapon_fire

function load_weapon(held_itemstack, user, pointed_thing)
    -- Loads a single round into a weapon.

    local player_name = user:get_player_name()
    local inv = minetest.get_inventory({type = "player", name = player_name})

    inv = inv:get_list("main")

    for i, inv_itemstack in ipairs(inv) do
        local inv_itemstack_def = inv_itemstack:get_definition()
        local weapon_data = boomstick.get_weapon_data(inv_itemstack_def)

        if boomstick.item_is_weapon(inv_itemstack_def) then
            if weapon_data.ammo_type == held_itemstack:get_name() then
                if not boomstick.weapon_is_full(inv_itemstack_def) then
                    weapon_data.rounds_loaded = weapon_data.rounds_loaded + 1
                    minetest.sound_play(
                        {name=weapon_data.load_weapon_sound},
                        {
                            pos = player_position,
                            gain = 1.0,
                            max_hear_distance = 32,
                        },
                        false
                    )
                end
            end
        end
    end
end

boomstick.weapon_load_function = load_weapon
