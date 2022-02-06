-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

-- weapon functionality like reloading, firing, and cycling


boomstick.weapon_cycle_function = function(itemstack, user)
    -- TODO: this should also call a function that renders a shell being ejected. if the
    -- chamber was loaded (if boomstick_data.ready=true), a loaded shell should
    -- eject, otherwise an empty shell should eject

    local item_def = itemstack:get_definition()
    local boomstick_weapon_data = item_def.boomstick_weapon_data

    if boomstick.weapon_is_ready(item_def) then
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

    if not boomstick.weapon_is_ready(item_def) then
        return
    elseif boomstick.weapon_is_empty(item_def) then
        -- "Click"
        local sound_parameter_table = {name = boomstick_weapon_data.empty_sound}
        local sound_spec = {pos = player_position, gain = 0.25, max_hear_distance = 5}

        minetest.sound_play(sound_parameter_table, sound_spec, false)
    else
        -- "Bang"
        local sound_parameter_table = {name = boomstick_weapon_data.fire_weapon_sound}
        local sound_spec = {pos = player_position, gain = 1.0, max_hear_distance = 32}

        local projectiles = boomstick_weapon_data.projectiles

        if projectiles == 1 then
            boomstick.launch_projectile(user, boomstick_weapon_data, pointed_thing)
        else
            boomstick.launch_projectiles(user, boomstick_weapon_data, pointed_thing, projectiles)
        end

        minetest.sound_play(sound_parameter_table, sound_spec, false)

        boomstick_weapon_data.rounds_loaded = boomstick_weapon_data.rounds_loaded - 1
    end

    -- Start the cooldown time after firing
    boomstick_weapon_data.ready = false

    return itemstack
end


boomstick.weapon_fire_function = weapon_fire

boomstick.weapon_load_function = function(held_itemstack, user)
    -- Loads a single round into a weapon.
    --

    local player_name = user:get_player_name()
    local player_position = user:get_pos()

    local sound_spec = {pos = player_position, gain = 1.0, max_hear_distance = 32}

    local inv = minetest.get_inventory({type = "player", name = player_name})

    for i, inv_itemstack in ipairs(inv:get_list("main")) do
        repeat
            local inv_itemstack_def = inv_itemstack:get_definition()

            if not boomstick.item_is_weapon(inv_itemstack_def) then
                do
                    break
                end
            end

            local weapon_data = boomstick.get_weapon_data(inv_itemstack_def)
            local sound_parameter_table = {name = weapon_data.load_weapon_sound}

            if weapon_data.ammo_type ~= held_itemstack:get_name() then
                do
                    break
                end
            end

            if boomstick.weapon_is_full(inv_itemstack_def) then
                do
                    break
                end
            end

            if not weapon_data.ammo_ready then
                do
                    break
                end
            end

            weapon_data.rounds_loaded = weapon_data.rounds_loaded + 1
            weapon_data.ammo_ready = false

            held_itemstack:take_item()

            minetest.sound_play(sound_parameter_table, sound_spec, false)

            minetest.after(weapon_data.reload_delay, function()
                weapon_data.ammo_ready = true
            end
)

        until true
    end
    return held_itemstack
end

function boomstick.launch_projectiles(player, weapon_data, pointed_thing, projectiles)

    local projectile_data = weapon_data.projectile_data
    local vel = projectile_data._velocity

    local projectile = PelletProjectile
    projectile:set_owner(player)

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

function boomstick.launch_projectile(player, weapon_data, pointed_thing)

    local projectile_data = weapon_data.projectile_data

    local player_position = player:get_pos()
    player_position.y = player_position.y + 1.5

    local entity_name = "boomstick:" .. projectile_data._item_name
    local projectile = minetest.add_entity(player_position, entity_name)

    -- Keep track of who will be responsible for the damage it will cause
    projectile:set_owner(player)

    local player_look_direction = player:get_look_dir()
    local vel = projectile_data._velocity

    -- Set projectile velocity so it moves toward the player's look direction
    local projectile_velocity = {
        x = player_look_direction.x * vel,
        y = player_look_direction.y * vel,
        z = player_look_direction.z * vel
    }

    projectile:set_velocity(projectile_velocity)
end
