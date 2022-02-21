function boomstick_api.validate_ammo_data(data)
    local keys = {"_category", "inventory_image", "wield_image"}
    return boomstick_api.validate_table(keys, data)
end

--- Wrapper around minetest.register_craftitem() that does a bunch of ammo-specific
--stuff
function boomstick_api.create_new_ammo(ammo_name, ammo_data)
    local ammo_category = ammo_data._category

    if not boomstick_api.validate_ammo_data(ammo_data) then
        error("Ammo data is missing required value")
    end

    if not boomstick_api.data.categories[ammo_category] then
        error("Category '" .. ammo_category .. "' does not exist.")
    end

    local ammo_data = boomstick_api.table_merge(ammo_data, boomstick_api.data.categories[ammo_category])

    boomstick_api.data.ammo[ammo_name] = ammo_data

    minetest.register_craftitem(ammo_name, ammo_data)
end

function boomstick_api.load_ammo_into_magazine(held_itemstack, user)
    -- Loads a single round into a magazine.
    local inv = user:get_inventory()
    print('meep')

    -- Search the inventory for an item that is a magazine
    for i, inv_itemstack in ipairs(inv:get_list("main")) do
        if boomstick_api.can_load_magazine_with_ammo(inv_itemstack, held_itemstack) then
            return handle_load_ammo_into_magazine(inv_itemstack, held_itemstack, user)
        end
    end
end

function boomstick_api.get_ammo_data(item_definition)
    return item_definition._boomstick_ammo_data
end

function handle_load_ammo_into_magazine(inv_itemstack, held_itemstack, player)

    local inv_itemstack_def = inv_itemstack:get_definition()
    local magazine_data = boomstick_api.get_magazine_data(inv_itemstack_def)

    local ammo_data = boosmtick_api.get_ammo_data(held_itemstack)

    local count = 1 -- for now?

    boomstick_api.load_rounds_into_magazine(magazine_data, ammo_type, count)
    boomstick_api.play_random_sound_on_player(weapon_data.load_weapon_sounds, player)
    held_itemstack:take_item()

    return held_itemstack
end


boomstick_api.load_ammo_into_magazine_function = boomstick_api.load_ammo_into_magazine

boomstick_api.create_new_category("ammo", {
    inventory_image = "boomstick_556_ammo.png",
    wield_image = "boomstick_556_ammo.png",
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    stack_max = 30,
    range = 1,
    groups = {boomstick_ammo = 1},
    on_secondary_use = boomstick_api.load_ammo_into_magazine_function
})

