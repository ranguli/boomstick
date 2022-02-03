boomstick = {}

function boomstick.weapon_is_full(boomstick_weapon_data)
    local full = true
    if boomstick_weapon_data.rounds_loaded < boomstick_weapon_data.capacity then
        full = false
    end

    return full
end

function boomstick.item_is_weapon(item_stack)
    local weapon = false
    if item_stack:get_definition().boomstick_weapon_data ~= nil then
        weapon = true
    end

    return true
end

function boomstick.get_weapon_data(item_stack)
    return item_stack:get_definition().boomstick_weapon_data
end

weapon_cooldown_function = weapon_cooldown
weapon_fire_function = weapon_fire
weapon_cycle_function = weapon_cycle

minetest.register_globalstep(boomstick.weapon_cooldown_function)

