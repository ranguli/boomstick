--- Weapons functions
--
--
function boomstick_api.get_weapon_data(item_definition)
    return item_definition.boomstick_weapon_data
end


function boomstick_api.item_is_weapon(item_definition)
    if boomstick_api.get_weapon_data(item_definition) == nil then
        return false
    end
    return true
end


--- Registers a callback function that allows or denies a player to fire a weapon based on your own custom logic.
-- If you'd like to allow or deny the use of weapons at your discretion,
-- register a function that **must return a boolean value**. If it returns `true`, the player can fire their weapon.
-- This is useful for implementing things like 'no guns zones' (for spawn or
-- public areas), or even russian roulette.
--
-- **Note:** This is distinct from a normal callback, in that the callback function is not only called but its return value can affect execution of other code.
-- @usage
-- -- Custom logic that is executed when a weapon is fired
-- local custom_fire_condition = function(player) {
--     -- no weapons for dave
--     if player:get_player_name() == "dave" then
--         return false
--     end
--
--     return true
-- }
--
-- -- Our function will now be called when a player fires a weapon.
-- -- If the player's name is dave, their weapon will not fire.
-- boomstick_api.register_custom_fire_condition(custom_fire_condition)
--
-- @tparam function func Function returning a boolean that will allow/deny a weapon to be fired.
function boomstick_api.register_weapon_fire_condition(func)
    boomstick_api.register_callback(func, "fire_condition")
end


--- Registers a callback function to be called when any projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when a projectile collides with something.
--
-- @tparam function func Function to be executed when a projectle has a collision.
function boomstick_api.register_projectile_collision(func)
    boomstick_api.register_callback(func, "projectile_collision")
end


--- Registers a callback function to be called when any projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when a projectile collides with something.
--
-- @tparam function func Function to be executed when a projectle has a collision.
function boomstick_api.register_weapon_fire(func)
    boomstick_api.register_callback(func, "weapon_fired")
end


function boomstick_api.register_callback(func, event_name)
    table.insert(boomstick_api.data.callbacks,
        {callback_type = event_name, callback_func = func})
end


--- Returns a boolean for whether a weapon is at maximum capacity (i.e no more
--  ammo will fit).
--
-- @param item_definition An [Item Definition](https://minetest.gitlab.io/minetest/definition-tables/#item-definition) of a weapon, returned by [get_definition()](https://minetest.gitlab.io/minetest/class-reference/#methods_2)
-- @return boolean - Indicating if the weapon is full.
function boomstick_api.weapon_is_full(item_definition)
    local full = true
    local weapon_data = boomstick_api.get_weapon_data(item_definition)

    local rounds_loaded = weapon_data.rounds_loaded
    local capacity = weapon_data.capacity

    if rounds_loaded < capacity then
        boomstick_api.debug("rounds_loaded < capacity (%d < %d)",
            {rounds_loaded, capacity})
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

function boomstick_api.weapon_is_empty(item_definition)
    local weapon_data = boomstick_api.get_weapon_data(item_definition)

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

function boomstick_api.weapon_is_cocked(item_definition)
    local weapon_data = boomstick_api.get_weapon_data(item_definition)

    if weapon_data.cocked then
        return true
    end

    return false
end


function boomstick_api.validate_weapon_data(data)
    local keys = {"name", "category", "item_name", "capacity", "textures", "wield_scale"}

    return boomstick_api.validate_table(keys, data)
end


function boomstick_api.create_new_weapon(new_weapon_data)
    local weapon_category = new_weapon_data.category

    if not boomstick_api.validate_weapon_data(new_weapon_data) then
        error("Weapon data is missing required value")
    end

    if not boomstick_api.data.categories[weapon_category] then
        error("Weapon category '" .. weapon_category .. "' does not exist.")
    end

    -- TODO: replace with table_merge
    -- Inherit any default values from the weapons category
    for k, v in pairs(boomstick_api.data.categories[weapon_category]) do
        if new_weapon_data[k] == nil then
            new_weapon_data[k] = v
        end
    end

    boomstick_api.data.weapons[new_weapon_data.name] = new_weapon_data

    minetest.register_tool(new_weapon_data.entity_name, {
        description = new_weapon_data.description,
        wield_scale = new_weapon_data.wield_scale,
        range = 1,
        inventory_image = new_weapon_data.textures.default,
        boomstick_weapon_data = new_weapon_data,
        on_secondary_use = boomstick_api.weapon_cycle_function,
        on_use = boomstick_api.weapon_fire_function
    })
end


function boomstick_api.cycle_weapon(itemstack, user)
    -- TODO: this should also call a function that renders a shell being ejected. if the
    -- chamber was loaded (if boomstick_api_data.cocked=true), a loaded shell should
    -- eject, otherwise an empty shell should eject

    local item_def = itemstack:get_definition()

    if boomstick_api.weapon_is_cocked(item_def) then
        return
    end

    local weapon_data = item_def.boomstick_weapon_data
    boomstick_api.play_random_sound_on_player(weapon_data.cycle_weapon_sounds, user)

    minetest.after(weapon_data.cycle_cooldown, function()
        weapon_data.cocked = true
    end
)

end


boomstick_api.weapon_cycle_function = boomstick_api.cycle_weapon

--- Fires a weapon.
-- @param itemstack - An [ItemStack](https://minetest.gitlab.io/minetest/class-reference/#itemstack) passed by Minetest when called as a callback.
-- @param user - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref) passed by Minetest when called as a callback. This is the player who fired the weapon.
-- @param pointed_thing - [pointed_thing](https://minetest.gitlab.io/minetest/representations-of-simple-things/#pointed_thing) passed by Minetest when called as a callback.
function boomstick_api.fire_weapon(itemstack, user, pointed_thing)
    local item_def = itemstack:get_definition()
    local weapon_data = itemstack:get_definition().boomstick_weapon_data

    if not boomstick_api.weapon_is_cocked(item_def) then
        return
    elseif boomstick_api.fire_weapon_callbacks(callbacks, user) == false then
        return
    elseif boomstick_api.weapon_is_empty(item_def) then
        boomstick_api.fire_empty_weapon(weapon_data, user)
    else
        boomstick_api.fire_loaded_weapon(weapon_data, user, pointed_thing)
        itemstack:add_wear(weapon_data.wear)
    end

    if weapon_data.action == "manual" then
        weapon_data.cocked = false
    end

    return itemstack
end


function boomstick_api.fire_weapon_callbacks(callbacks, user)
    -- Execute any registered callbacks that should run when a weapon is fire.
    for i, callback in pairs(boomstick_api.data.callbacks) do
        -- Special callbacks that can determine whether or not a weapon can be
        -- fired. Useful for disabling weapons programatically.
        if callback.callback_type == "fire_condition" then
            local can_fire = callback.callback_func(user)
            if can_fire == false then
                return false
            end
            -- Regular callbacks, useful for things like achievements or statistics.
        elseif callback.callback_type == "weapon_fired" then
            callback.callback_func(user)
        end
    end

    return true
end


boomstick_api.weapon_fire_function = boomstick_api.fire_weapon

--- Fires a weapon as if it is loaded.
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
-- @param weapon_data - Weapon data for a weapon.
-- @param user - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref) passed by Minetest when called as a callback. This is the player who fired the weapon.
-- @param pointed_thing - [pointed_thing](https://minetest.gitlab.io/minetest/representations-of-simple-things/#pointed_thing) passed by Minetest when called as a callback.
function boomstick_api.fire_loaded_weapon(weapon_data, user, pointed_thing)
    assert(weapon_data ~= nil)
    assert(user and minetest.is_player(user), "Must provide a valid player object")

    boomstick_api.play_random_sound_on_player(weapon_data.fire_weapon_sounds, user)
    boomstick_api.launch_projectiles(user, weapon_data, pointed_thing)
    boomstick_api.spawn_smoke_particles(user, nil)
    boomstick_api.recoil(user, weapon_data.recoil)
    boomstick_api.knockback(user, weapon_data.recoil)

    weapon_data.rounds_loaded = weapon_data.rounds_loaded - 1
end


--- Generates smoke particles that look like smoke from a fired weapon
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref) that the smoke particles will be created near. This would usually be the player firing the weapon.
-- @param particles - A table containing attributes of the particles.
-- @usage
-- boomstick_api.spawn_smoke_particles(player, {
--     -- The number of smoke particles to spawn
--     count = 5,
--
--     -- The maximum possible size of each particle
--     size = 2,
--
--     -- The maximum possible variance in position, velocity, and acceleration
--     between particles.
--     variance = 0.25,
--
--     -- How long each particle will linger before despawning
--     lifespan = 2,
--
--     -- The maximum possible velocity of a particle
--     velocity = 2
-- })
function boomstick_api.spawn_smoke_particles(player, particles)
    if player == nil or not minetest.is_player(player) then
        minetest.log("error",
            "Argument \"player\" to boomstick_api.spawn_smoke_particles() must be non-nil and valid player object.")
        return
    end

    if particles == nil then
        particles = {count = 5, size = 2, variance = 0.25, lifespan = 2, velocity = 2}
    end

    local player_pos = player:get_pos()
    local player_offset_pos = vector.add(player_pos,
        boomstick_api.data.player_height_offset)

    local look_dir = player:get_look_dir()

    minetest.add_particlespawner({
        amount = particles.count,
        time = particles.lifespan,
        minpos = vector.subtract(player_offset_pos, particles.variance),
        maxpos = vector.add(player_offset_pos, particles.variance),
        minvel = vector.multiply(look_dir, 1),
        maxvel = vector.multiply(look_dir, particles.velocity),
        minacc = vector.multiply(look_dir, particles.variance),
        maxacc = vector.multiply(look_dir, particles.variance),
        minsize = 1,
        maxsize = particles.size,
        texture = "boomstick_smoke.png"
    })
end


--- Fires a weapon as if it is empty.
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
-- @param weapon_data - Weapon data for a weapon.
-- @param user - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref) passed by Minetest when called as a callback. This is the player who fired the weapon.
function boomstick_api.fire_empty_weapon(weapon_data, user)
    boomstick_api.play_random_sound_on_player(weapon_data.empty_weapon_sounds, user)
end


function boomstick_api.load_weapon(held_itemstack, user)
    -- Loads a single round into a weapon.

    local inv = user:get_inventory()

    for i, inv_itemstack in ipairs(inv:get_list("main")) do
        if boomstick_api.can_load_weapon(inv_itemstack, held_itemstack) then
            return load_weapon_with_ammo(inv_itemstack, held_itemstack, user)
        end
    end
end


function load_weapon_with_ammo(inv_itemstack, held_itemstack, player)
    local inv_itemstack_def = inv_itemstack:get_definition()
    local weapon_data = boomstick_api.get_weapon_data(inv_itemstack_def)

    weapon_data.rounds_loaded = weapon_data.rounds_loaded + 1
    weapon_data.ammo_ready = false

    print(dump(weapon_data.load_weapon_sounds))
    boomstick_api.play_random_sound_on_player(weapon_data.load_weapon_sounds, player)
    held_itemstack:take_item()

    minetest.after(weapon_data.reload_delay, function()
        weapon_data.ammo_ready = true
    end
)
    return held_itemstack
end


boomstick_api.weapon_load_function = boomstick_api.load_weapon

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

function boomstick_api.can_load_weapon(inventory_item, ammo_item)
    local inv_itemstack_def = inventory_item:get_definition()
    local weapon_data = boomstick_api.get_weapon_data(inv_itemstack_def)

    if not boomstick_api.item_is_weapon(inv_itemstack_def) then
        return false
    end

    -- TODO: This will only account for 1:1 relationships between a weapon
    -- and its ammo. Update to use groups for weapons that support it.
    if weapon_data.ammo_type ~= ammo_item:get_name() then
        return false
    end

    if boomstick_api.weapon_is_full(inv_itemstack_def) then
        return false
    end

    if not weapon_data.ammo_ready then
        return false
    end

    return true
end


function boomstick_api.launch_projectiles(player, weapon_data, pointed_thing)

    for i, callback in pairs(boomstick_api.data.callbacks) do
        if callback.callback_type == "projectile_collision" then
            weapon_data.projectile_data:register_on_collision(callback.callback_func)
        end
    end

    for i = 1, weapon_data.projectiles do
        launch_single_projectile(player, weapon_data)
    end
end


function launch_single_projectile(player, weapon_data)
    local projectile = weapon_data.projectile_data

    projectile:set_owner(player)

    local accuracy = (100 - weapon_data.accuracy)
    local position = projectile:get_position(player, accuracy)

    local entity_name = projectile._entity_name
    local entity = minetest.add_entity(position, entity_name)

    local velocity = projectile:get_velocity(player)
    entity:set_velocity(velocity)

    local acceleration = projectile:get_acceleration(player, accuracy)
    entity:set_acceleration(acceleration)

    local rotation = projectile:get_rotation(player)
    entity:set_rotation(rotation)
end


--- Pushes the player's view up, simulating recoil.
--
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
--
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who will experience recoil.
-- @tparam number recoil - A weapon [ItemStack](https://minetest.gitlab.io/minetest/class-reference/#itemstack)
function boomstick_api.recoil(player, recoil)
    local muzzle_climb = boomstick_api.calculate_muzzle_climb(recoil)
    local muzzle_sway = boomstick_api.calculate_muzzle_sway(recoil)

    local player_pitch = player:get_look_vertical()
    player:set_look_vertical(player_pitch - muzzle_climb)

    local player_yaw = player:get_look_horizontal()
    player:set_look_horizontal(player_yaw + muzzle_sway)

end


function boomstick_api.calculate_muzzle_climb(recoil)
    return math.random(recoil / 2, recoil * 2) / 100
end


function boomstick_api.calculate_muzzle_sway(recoil)
    return math.random(-recoil * 2, recoil * 2) / 100
end


--- Pushes the player backwards based on recoil.
--
-- **Note:** It is usually not necesary to call this function directly unless
-- you are extending the mod or making custom behavior.
--
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who will experience recoil.
-- @tparam number recoil -
function boomstick_api.knockback(player, recoil)
    local look_dir = player:get_look_dir()
    player:add_velocity({x = -look_dir.x * recoil, y = -look_dir.y * recoil, z = 0})
end


boomstick_api.create_new_category("weapon", {
    rounds_loaded = 0,
    accuracy = 75,
    cycle_cooldown = 0.25, -- Applicable for manual and semi-automatic weapons
    reload_delay = 0.75,
    durability = 1000,
    action = "manual", -- Currently unused
    cocked = true,
    ammo_ready = true,
    wear = 2,
    recoil = 2,
    wield_scale = {x = 1.5, y = 1.5, z = 1},
    empty_weapon_sounds = {
        {name = "boomstick_empty", gain = 0.25, max_hear_distance = 5},
        {name = "boomstick_empty_2", gain = 0.25, max_hear_distance = 5}
    }
})
