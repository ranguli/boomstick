function boomstick.get_weapon_data(item_definition)
    return item_definition.boomstick_weapon_data
end


function boomstick.item_is_weapon(item_definition)
    if boomstick.get_weapon_data(item_definition) == nil then
        return false
    end
    return true
end


function boomstick.weapon_is_full(item_definition)
    local full = true
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.rounds_loaded < weapon_data.capacity then
        full = false
    end

    return full
end


function boomstick.weapon_is_empty(item_definition)
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.rounds_loaded == 0 then
        return true
    end

    return false
end


function boomstick.weapon_is_ready(item_definition)
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.ready then
        return true
    end

    return false
end


function boomstick.validate_table(keys, data)
    for _, key in pairs(keys) do
        if data[key] == nil then
            return false
        end
    end
    return true
end


function boomstick.validate_weapon_data(data)
    local keys = {"name", "category", "item_name", "capacity", "textures", "wield_scale"}

    return boomstick.validate_table(keys, data)
end


function boomstick.validate_projectile_data(data)
    local keys = {"_name", "_category", "_item_name"}
    return boomstick.validate_table(keys, data)
end


function boomstick.create_new_weapon(new_weapon_data)
    local weapon_category = new_weapon_data.category

    if not boomstick.validate_weapon_data(new_weapon_data) then
        error("Weapon data is missing required value")
    end

    if not boomstick_data.categories[weapon_category] then
        error("Weapon category '" .. weapon_category .. "' does not exist.")
    end

    -- TODO: replace with table_merge
    -- Inherit any default values from the weapons category
    for k, v in pairs(boomstick_data.categories[weapon_category]) do
        if new_weapon_data[k] == nil then
            new_weapon_data[k] = v
        end
    end

    boomstick_data.weapons[new_weapon_data.name] = new_weapon_data

    minetest.register_tool("boomstick:" .. new_weapon_data.item_name, {
        description = new_weapon_data.description,
        wield_scale = new_weapon_data.wield_scale,
        range = 0,
        inventory_image = new_weapon_data.textures.default,
        boomstick_weapon_data = new_weapon_data,
        on_secondary_use = boomstick.weapon_cycle_function,
        on_use = boomstick.weapon_fire_function
    })

    -- Crafting recipe
    minetest.register_craft({
        output = new_weapon_data.item_name,
        recipe = new_weapon_data.crafting_recipe
    })
end


-- Creates a new projectile (an entity that can be fired from a weapon)
function boomstick.create_new_projectile(projectile_data)
    local category = projectile_data._category

    if not boomstick.validate_projectile_data(projectile_data) then
        error("Projectile data is missing required value")
    end

    if not boomstick_data.categories[category] then
        error("Projectile category'" .. category .. "' does not exist.")
    end

    -- Inherit any default values from the weapons category
    --
    projectile_data = boomstick.table_merge(boomstick_data.categories["projectile"],
        projectile_data)

    boomstick_data.projectiles[projectile_data._item_name] = projectile_data
    minetest.register_entity("boomstick:pellet", projectile_data)

    if projectile_data._crafting_recipe ~= nil then
        minetest.register_craft({
            output = projectile_data._item_name,
            recipe = projectile_data._crafting_recipe
        })
    end
end


-- Creates a new category. A category is a table that extend another table
-- (called a base). This is useful for creating default stats for weapons,
-- projectiles, ammo, etc.
function boomstick.create_new_category(name, base, category)
    -- Inherit any default values from a base, if one is provided.
    if base ~= nil then
        category = boomstick.table_merge(boomstick_data.categories[base], category)
    end

    boomstick_data.categories[name] = category
end


-- Add the values from table1 to table2, if they don't already exist
function boomstick.table_merge(table1, table2)
    assert(table1 ~= nil and table2 ~= nil, "Can't merge a nil table")

    for k, v in pairs(table1) do
        if table2[k] == nil then
            table2[k] = v
        end
    end

    return table2
end


