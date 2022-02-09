--- yeah
--
--
function boomstick.get_weapon_data(item_definition)
    return item_definition.boomstick_weapon_data
end

function boomstick.item_is_weapon(item_definition)
    if boomstick.get_weapon_data(item_definition) == nil then
        return false
    end
    return true
end

--- Returns a boolean for whether a weapon is at maximum capacity (i.e no more
--  ammo will fit).
--
-- @param item_definition An [Item Definition](https://minetest.gitlab.io/minetest/definition-tables/#item-definition) of a weapon, returned by [get_definition()](https://minetest.gitlab.io/minetest/class-reference/#methods_2)
-- @return boolean - Indicating if the weapon is full.
function boomstick.weapon_is_full(item_definition)
    local full = true
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.rounds_loaded < weapon_data.capacity then
        boomstick.debug(string.format("rounds_loaded < capacity (%d < %d)", weapon_data.rounds_loaded, weapon_data.capacity))
        full = false
    end

    return full
end

--- Returns a boolean for whether or not a weapon is empty (i.e not loaded).
--
--  A convenience function that returns the `rounds_loaded` field from the weapon
--  data.
--
-- @param item_definition An [Item Definition](https://minetest.gitlab.io/minetest/definition-tables/#item-definition) of a weapon, returned by [get_definition()](https://minetest.gitlab.io/minetest/class-reference/#methods_2)
-- @return boolean - Indicating if the weapon is empty.

function boomstick.weapon_is_empty(item_definition)
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.rounds_loaded == 0 then
        return true
    end

    return false
end

--- Returns a boolean for whether or not a weapon is ready to fire.
--
--  A convenience function that returns the `cocked` field from the weapon
--  data. A weapon is considered cocked (and therefore ready to fire) when it is
--  loaded and no cooldown timers are currently active on it.
--
-- @param item_definition An [Item Definition](https://minetest.gitlab.io/minetest/definition-tables/#item-definition) of a weapon, returned by [get_definition()](https://minetest.gitlab.io/minetest/class-reference/#methods_2)
-- @return boolean - Indicating if the weapon is ready to fire.

function boomstick.weapon_is_cocked(item_definition)
    local weapon_data = boomstick.get_weapon_data(item_definition)

    if weapon_data.cocked then
        return true
    end

    return false
end

function boomstick.validate_weapon_data(data)
    local keys = {"name", "category", "item_name", "capacity", "textures", "wield_scale"}

    return boomstick.validate_table(keys, data)
end

function boomstick.create_new_weapon(new_weapon_data)
    local weapon_category = new_weapon_data.category

    if not boomstick.validate_weapon_data(new_weapon_data) then
        error("Weapon data is missing required value")
    end

    if not boomstick.data.categories[weapon_category] then
        error("Weapon category '" .. weapon_category .. "' does not exist.")
    end

    -- TODO: replace with table_merge
    -- Inherit any default values from the weapons category
    for k, v in pairs(boomstick.data.categories[weapon_category]) do
        if new_weapon_data[k] == nil then
            new_weapon_data[k] = v
        end
    end

    boomstick.data.weapons[new_weapon_data.name] = new_weapon_data

    minetest.register_tool("boomstick:" .. new_weapon_data.item_name, {
        description = new_weapon_data.description,
        wield_scale = new_weapon_data.wield_scale,
        range = 1,
        inventory_image = new_weapon_data.textures.default,
        boomstick_weapon_data = new_weapon_data,
        on_secondary_use = boomstick.weapon_cycle_function,
        on_use = boomstick.weapon_fire_function
    })

end

function boomstick.create_new_category(name, base, category)
    -- Inherit any default values from a base, if one is provided.
    if base ~= nil then
        category = boomstick.table_merge(boomstick.data.categories[base], category)
    end

    boomstick.data.categories[name] = category
end

function boomstick.cycle_weapon(itemstack, user)
    -- TODO: this should also call a function that renders a shell being ejected. if the
    -- chamber was loaded (if boomstick_data.cocked=true), a loaded shell should
    -- eject, otherwise an empty shell should eject

    local item_def = itemstack:get_definition()
    local weapon_data = item_def.boomstick_weapon_data

    if boomstick.weapon_is_cocked(item_def) then
        return
    end

    local player_position = user:get_pos()

    local sounds = weapon_data.cycle_weapon_sounds
    local sound_spec = boomstick.get_random_sound(sounds)
    local sound_table = {pos = player_position, gain = 1.5, max_hear_distance = 5}

    minetest.sound_play(sound_spec, sound_table, false)
    --weapon_data.cocked = true

    minetest.after(weapon_data.cycle_cooldown, function()
        weapon_data.cocked = true
    end)

end
boomstick.weapon_cycle_function = boomstick.cycle_weapon

function boomstick.fire_weapon(itemstack, user, pointed_thing)
    local item_def = itemstack:get_definition()
    local weapon_data = itemstack:get_definition().boomstick_weapon_data

    if not boomstick.weapon_is_cocked(item_def) then
        return
    end

    if boomstick.weapon_is_empty(item_def) then
        boomstick.fire_empty_weapon(weapon_data)
    else
        boomstick.fire_loaded_weapon(user, weapon_data, pointed_thing)
    end

    weapon_data.cocked = false

    return itemstack
end

boomstick.weapon_fire_function = boomstick.fire_weapon

--- Fires a weapon as if it is loaded.
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
-- @param user - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref)
-- @param weapon_data - Weapon data for a weapon.
-- @param pointed_thing - Returned by Minetest callback.
function boomstick.fire_loaded_weapon(user, weapon_data, pointed_thing)
    local player_pos = user:get_pos()

    local sounds = weapon_data.fire_weapon_sounds
    local sound_spec = boomstick.get_random_sound(sounds)
    local sound_table = {pos = player_pos, gain = 1.0, max_hear_distance = 32}

    local projectiles = weapon_data.projectiles

    if projectiles == 1 then
        boomstick.launch_projectile(user, weapon_data, pointed_thing)
    else
        boomstick.launch_projectiles(user, weapon_data, pointed_thing, projectiles)
    end

    minetest.sound_play(sound_spec, sound_table, false)
    weapon_data.rounds_loaded = weapon_data.rounds_loaded - 1
end

--- Fires a weapon as if it is empty.
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
-- @param weapon_data - Weapon data for a weapon.
function boomstick.fire_empty_weapon(weapon_data)
    local player_pos = user:get_pos()

    local sounds = weapon_data.weapon_empty_sounds
    local sound_spec = boomstick.get_random_sound(sounds)
    local sound_table = {pos = player_position, gain = 0.25, max_hear_distance = 5}

    minetest.sound_play(sound_spec, sound_table, false)
end

function boomstick.load_weapon(held_itemstack, user)
    -- Loads a single round into a weapon.

    local player_name = user:get_player_name()
    local player_position = user:get_pos()

    local sound_table = {pos = player_position, gain = 1.0, max_hear_distance = 32}

    local inv = minetest.get_inventory({type = "player", name = player_name})

    for i, inv_itemstack in ipairs(inv:get_list("main")) do
        repeat
            if not boomstick.can_load_weapon(inv_itemstack, held_itemstack) then
                do break end
            end

            local inv_itemstack_def = inv_itemstack:get_definition()

            local weapon_data = boomstick.get_weapon_data(inv_itemstack_def)

            local sounds = weapon_data.load_weapon_sounds
            local sound_spec = boomstick.get_random_sound(sounds)

            weapon_data.rounds_loaded = weapon_data.rounds_loaded + 1
            weapon_data.ammo_ready = false

            held_itemstack:take_item()

            minetest.sound_play(sound_spec, sound_table, false)

            minetest.after(weapon_data.reload_delay, function()
                weapon_data.ammo_ready = true
            end)
        until true
    end
    return held_itemstack
end

boomstick.weapon_load_function = boomstick.load_weapon

--- Returns a boolean for whether or not a given weapon can be loaded.
--
-- Given one item (typically a weapon from an inventory), and a second
-- item (typically an ammo stack from an inventory), return whether or not
-- the weapon can be loaded. A weapon can be loaded if it is not empty, not
-- full, and not under any active reload cooldown.
--
-- **Note:** This function nor the rest of the API handle the concept of a
-- weapon item having a stack size of >1.
--
-- @param inventory_item A weapon [ItemStack](https://minetest.gitlab.io/minetest/class-reference/#itemstack)
-- @param ammo_item An ammo [ItemStack](https://minetest.gitlab.io/minetest/class-reference/#itemstack)
-- @return boolean - Incidating whether the weapon can be loaded.

function boomstick.can_load_weapon(inventory_item, ammo_item)
    local inv_itemstack_def = inventory_item:get_definition()
    local weapon_data = boomstick.get_weapon_data(inv_itemstack_def)

    if not boomstick.item_is_weapon(inv_itemstack_def) then
        return false
    end

    --TODO: This will only account for 1:1 relationships between a weapon
    --and its ammo. Update to use groups for weapons that support it.
    if weapon_data.ammo_type ~= ammo_item:get_name() then
        return false
    end

    if boomstick.weapon_is_full(inv_itemstack_def) then
        return false
    end

    if not weapon_data.ammo_ready then
        return false
    end

    return true
end

function boomstick.launch_projectiles(player, weapon_data, pointed_thing, projectiles)

    local projectile_data = weapon_data.projectile_data
    local vel = projectile_data._velocity

    local projectile = PelletProjectile
    projectile:set_owner(player)
    projectile:register_on_collision(boomstick.on_target_block_hit)

    local entity_name = "boomstick:" .. projectile_data._item_name

    for i = 1, projectiles do
        --TODO: This whole loop needs to be broken down into functions
        local accuracy = weapon_data.accuracy
        local rndacc = (100 - accuracy) or 0

        local player_position = player:get_pos()
        player_position.y = player_position.y + 1.5

        local spawn_position = {
            x = player_position.x + (math.random(-rndacc, rndacc) / 100),
            y = player_position.y + (math.random(-rndacc, rndacc) / 100),
            z = player_position.z + (math.random(-rndacc, rndacc) / 100)
        }

        local pellet = minetest.add_entity(spawn_position, entity_name)

        local yaw = player:get_look_horizontal()
        local vertical = player:get_look_vertical()
        local player_look_direction = player:get_look_dir()

        local pellet_velocity = {
            x = player_look_direction.x * vel,
            y = player_look_direction.y * vel,
            z = player_look_direction.z * vel
        }

        pellet:set_velocity(pellet_velocity)

        local pellet_rotation = {
            x = 0,
            y = yaw + math.pi,
            z = -vertical
        }

        pellet:set_rotation(pellet_rotation)

        local acc = ((100 - weapon_data.accuracy) / 10)

        local pellet_acceleration = {
            x = math.random(-acc, acc),
            y = math.random(-acc, acc),
            z = math.random(-acc, acc)
        }

        pellet:set_acceleration(pellet_acceleration)
    end
end

boomstick.create_new_category("weapon", nil,  {
    rounds_loaded = 0,
    accuracy = 95,
    cycle_cooldown = 0.25,
    reload_delay = 0.75,
    durability = 1000, -- Currently used
    action = "manual", -- Currently unused
    cocked = true,
    ammo_ready = true,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
    weapon_empty_sounds = {"boomstick_empty"}
})


-- generic shotgun weapon category
boomstick.create_new_category("shotgun", "weapon", {
    projectiles = 9,
    ammo_type = "boomstick:buckshot",
})

-- pump shotgun weapon category
boomstick.create_new_category("pump_shotgun", "shotgun", {
    cycle_weapon_sounds = {"boomstick_shotgun_rack"},
    fire_weapon_sounds = {"boomstick_shotgun_fire_1", "boomstick_shotgun_fire_2", "boomstick_shotgun_fire_3"},
    load_weapon_sounds = {"boomstick_shotgun_load_1", "boomstick_shotgun_load_2"}
})
