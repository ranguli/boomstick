--- Magazines are implemented at a high-level as a table called
-- `magazine_data`. It stores the state of a magazine (it's capacity, current
-- number of rounds), what type of ammo can be loaded in it, and a stack
-- containing the rounds themselves, which follows a LIFO principle. The stack is useful when a magazine is
-- loaded with different types of ammunition.
-- Only applicable when a magazine is an item
function boomstick_api.get_magazine_data(item_definition)
    return item_definition._boomstick_magazine_data
end


function boomstick_api.item_is_magazine(item_definition)
    if boomstick_api.get_magazine_data(item_definition) == nil then
        return false
    end
    return true
end

--- Returns a boolean for whether a magazine is at maximum capacity (i.e no more
--  ammo will fit).
--
-- @param item_definition An [Item Definition](https://minetest.gitlab.io/minetest/definition-tables/#item-definition) of a weapon, returned by [get_definition()](https://minetest.gitlab.io/minetest/class-reference/#methods_2)
-- @return boolean - Indicating if the weapon is full.
function boomstick_api.magazine_is_full(item_definition)
    if item_definition == nil or not boomstick_api.item_is_magazine(item_definition) then
        return
    elseif not boomstick_api.item_is_magazine(item_definition) then
        return
    end

    local rounds_loaded = boomstick_api.get_rounds_loaded(magazine_data)
    if rounds_loaded == magazine_data._capacity then
        return true
    end
    return false
end


--- Returns a boolean for whether or not a magazine is empty (i.e not loaded).
--
--  A convenience function that returns the `rounds_loaded` field from the magazine
--  data.
--
-- @param magazine_data Magazine Data table
-- @return boolean - Indicating if the magazine is empty.

function boomstick_api.magazine_is_empty(magazine_data)
    if boomstick_api.get_rounds_loaded(magazine_data) == 0 then
        return true
    end
    return false
end

function boomstick_api.get_rounds_loaded(magazine_data)
    return magazine_data._ammo_stack:count()
end

function boomstick_api.can_load_magazine_with_ammo(inv_itemstack, held_itemstack)
    -- if the item is a) a magazine b) takes the type of ammo we are holding
    -- and c) is not full then we can load it

    if boomstick_api.item_is_magazine(inv_itemstack) then
        boomstick_api.debug("Loading \"%s\", it is a magazine", {inv_itemstack:get_name()})
        local magazine_data = boomstick_api.get_magazine_data(inv_itemstack)

        if not boomstick_api.magazine_is_full(magazine_data) then
            return true
        end
    end

    boomstick_api.debug("Tried loading but \"%s\" is not a magazine", {inv_itemstack:get_name()})

    return false
end

function boomstick_api.can_load_magazine_into_weapon(inv_itemstack, held_itemstack)
end

function boomstick_api.load_magazine_into_weapon()
end

boomstick_api.load_magazine_into_weapon_function = boomstick_api.load_magazine_into_weapon

function boomstick_api.load_rounds_into_magazine(magazine_data, ammo_type, count)
    local rounds_loaded = boomstick_api.get_rounds_loaded(magazine_data)
    local capacity = magazine_data._capacity

    if rounds_loaded + count <= capacity then
        magazine_data._ammo_stack:repeat_push(ammo_type, count)
    end
end

function boomstick_api.unload_rounds_from_magazine(magazine_data, ammo_type, count)
    local rounds_loaded = boomstick_api.get_rounds_loaded(magazine_data)

    if rounds_loaded == 0 then
        return
    elseif count > rounds_loaded then
        magazine_data.ammo_stack:empty()
    else
        magazine_data._ammo_stack:repeat_push(ammo_type, count)
    end
end

function boomstick_api.validate_magazine_data(magazine_data)
    local keys = {"category", "capacity"}
    return boomstick_api.validate_table(keys, magazine_data)
end

function boomstick_api.create_new_magazine(magazine_name, magazine_definition)
    local magazine_data = magazine_definition._boomstick_magazine_data

    local magazine_category = magazine_data.category

    if not boomstick_api.validate_magazine_data(magazine_data) then
        error("Magazine data is missing required value")
    end

    if not boomstick_api.data.categories[magazine_category] then
        error("Category '" .. magazine_category .. "' does not exist.")
    end

    local magazine_definition = boomstick_api.table_merge(magazine_definition, boomstick_api.data.categories[magazine_category])

    -- Register the magazine type globally
    boomstick_api.data.magazines[magazine_name] = magazine_data

    minetest.register_craftitem(magazine_name, magazine_definition)
end

boomstick_api.create_new_category("detachable_magazine", {
    wield_scale = {x = 0.75, y = 0.75, z = 1},
    stack_max = 1,
    range = 1,
    groups = {boomstick_magazine = 1},
    on_secondary_use = boomstick_api.load_magazine_into_weapon_function
})
