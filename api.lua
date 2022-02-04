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

function boomstick.validate_weapon_data(weapon_data)
    keys = {
        "name",
        "category",
        "item_name",
        "capacity",
        "textures",
        "wield_scale"
    }

    for _, key in pairs(keys) do
        if weapon_data[key] == nil then
            return false
        end
    end

    return true
end


function boomstick.create_new_weapon(new_weapon_data)
    local weapon_category = new_weapon_data.category

    if not boomstick.validate_weapon_data(new_weapon_data) then
        error("Weapon data is missing required value")
    end

    if not boomstick_data[weapon_category] then
        error("Weapon category '" .. weapon_category .. "' does not exist.")
    end

    -- Inherit any default values from the weapons category
    for k,v in pairs(boomstick_data[weapon_category]) do
        if new_weapon_data[k] == nil then
            new_weapon_data[k] = v
        end
    end

    boomstick_data.weapons[new_weapon_data.name] = new_weapon_data

end

function boomstick.create_new_weapon_category(name, weapon_category)
    local default_weapon_stats = boomstick_data.default_weapon_stats

    -- Inherit any default values from the weapon defaults
    for k,v in pairs(default_weapon_stats) do
        if weapon_category[k] == nil then
            weapon_category[k] = v
        end
    end

    boomstick_data[name] = weapon_category
end
