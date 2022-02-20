--- Projectile class from which custom projectiles can be created.
-- @usage
-- local myprojectile = boomstick.Projectile:new({
--     _name = "Pellet",
--     _item_name = "pellet",
--     _entity_name = "boomstick:pellet",
--
--     -- How fast our projectile will go (optional)
--     _velocity = 50,
--
--     -- How long until our projectile should despawn (optional)
--     _lifetime = 2.5,
--
--     -- How much damage each projectile will do
--     _damage = 6,
--
--     initial_properties = {
--         -- Use a sprite for our projectile (instead of a mesh)
--         visual = "sprite",
--         textures = {"boomstick_projectile_pellet.png"},
--
--         -- If we want our projectile to be able to hit things
--         physical = true,
--         collide_with_objects = true,
--
--         -- How big our projectile looks
--         visual_size = {y = 0.1, x = 0.1, z = 0.1},
--
--         -- How big our projectile is for collision purposes
--         collisionbox = {-0.01, 0, -0.01, 0.01, 0.01, 0.01}
--     }
-- })
--
-- -- Register the entity with the Minetest engine
-- minetest.register_entity("boomstick:pellet", PelletProjectile)
-- @classmod boomstick.Projectile
boomstick_api.Projectile = {
    _velocity = 500,
    _lifetime = 15,
    _damage = 4,
    _on_collision_functions = {}
}

function boomstick_api.Projectile:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function boomstick_api.Projectile:on_activate(staticdata, dtime_s)
    -- Timer for despawning
    self._timer = 0
end


--- Registers a callback function to be called when the projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when the projectile collides with something.
--
-- **Note:** Unless you're doing something special, the owner of the weapon
-- should be the player who is holding it.
-- @tparam ObjectRef player An [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref) of the player that will own the weapon.
function boomstick_api.Projectile:set_owner(player)
    -- Who fired the projectile
    self._owner = player
end


--- Registers a callback function to be called when the projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when the projectile collides with something.
--
-- **Note:** It is usually not necesary to call this function directly to create a new weapon,
-- unless you are extending the mod or making custom behavior.
--
-- @tparam function func Function to be executed on collision.
function boomstick_api.Projectile:get_owner()
    return self._owner
end


--- Registers a callback function to be called when the projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when the projectile collides with something.
--
-- @tparam function func Function to be executed on collision.
function boomstick_api.Projectile:register_on_collision(func)
    table.insert(self._on_collision_functions, func)
end


--- For determining whether or not a projectile collided with another projectile.
-- Sometimes (especially with shotguns) projectiles will collide with one
-- another. It is often necessary to check if a collision happened between two
-- projectiles, so that we can do something (usually ignore it). Otherwise
-- projectiles would deal damage to one another.
--
-- @param collision Collision object returned by Minetest
-- @treturn boolean whether or not the projectile collided with another
-- projectile.
function boomstick_api.Projectile:collision_is_projectile(collision)
    local entity = collision.object:get_luaentity()

    if not entity then
        return
    end

    -- TODO: this only accounts for a "boomstick:pellet" colliding with a
    -- "boomstick:pellet". Should work on a group basis.
    if entity["name"] == "boomstick:pellet" then
        return true
    end

    return false
end


--- Deal damage to whatever object or node the projectile collided with.
-- This is how we actually make projectiles do damage when they hit their
-- target.
-- @param collision Collision object returned by Minetest
-- @treturn bool whether or not the projectile collided with another projectile.
function boomstick_api.Projectile:do_damage(collision)

    if collision.type ~= "object" then
        -- TODO: this won't allow weapons to do damage to blocks
        return
    end

    if self._owner == nil or not minetest.is_player(self._owner) then
        return
    end

    if not self:collision_is_projectile(collision) then
        local tool_capabilities = {
            full_punch_interval = 1.0,
            damage_groups = {fleshy = self._damage}
        }
        collision.object:punch(self._owner, 1.0, tool_capabilities)
    end
end


function boomstick_api.Projectile:collision_is_suicide(collision)
    if not collision or collision.type ~= "object" then
        return
    end

    if not self._owner then
        return
    end

    if collision.object:get_player_name() == self._owner:get_player_name() then
        return true
    end

    return false
end


--- Given a player and a velocity value, create a
-- vector that sends the projectile off in the direction the player is
-- pointing.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who fired the weapon.
function boomstick_api.Projectile:get_velocity(player)
    assert(player and minetest.is_player(player), "Must provide a valid player object")
    assert(self._velocity)

    local player_look_direction = player:get_look_dir()
    return vector.multiply(player_look_direction, self._velocity)
end


--- Given a player and an accuracy value, create a randomized
-- vector for the projectiles acceleration
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who fired the weapon.
-- @param accuracy - An accuracy value that will determine randomized acceleration spread
function boomstick_api.Projectile:get_acceleration(player, accuracy)
    assert(player and minetest.is_player(player), "Must provide a valid player object")

    accuracy = accuracy / 10

    return vector.new(math.random(-accuracy, accuracy), math.random(-accuracy, accuracy),
        math.random(-accuracy, accuracy))
end


--- Given a player and an accuracy value, create a randomized
-- position that the projectile should be spawned in at.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who fired the weapon.
-- @param accuracy - An accuracy value that will determine randomized acceleration spread
function boomstick_api.Projectile:get_position(player, accuracy)
    assert(player and minetest.is_player(player), "Must provide a valid player object")

    local player_pos = player:get_pos()
    local player_offset_pos = vector.add(player_pos,
        boomstick_api.data.player_height_offset)

    local randomization_vector = {
        x = (math.random(-accuracy, accuracy) / 100),
        y = (math.random(-accuracy, accuracy) / 100),
        z = (math.random(-accuracy, accuracy) / 100)
    }

    return vector.add(player_offset_pos, randomization_vector)
end


--- Given a player position, set the rotation of a projectile
-- so the projectile model is facing the direction the playing is looking.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). This is the player who fired the weapon.

function boomstick_api.Projectile:get_rotation(player)
    assert(player and minetest.is_player(player), "Must provide a valid player object")

    local yaw = player:get_look_horizontal()
    local pitch = player:get_look_vertical()

    return vector.new(-pitch, yaw, 0)
end


function boomstick_api.Projectile:on_step(dtime, moveresult)
    self._timer = self._timer + dtime

    if self._timer >= self._lifetime then
        self.object:remove()
    end

    if moveresult.collides then
        for _, collision in pairs(moveresult.collisions) do

            -- Don't get killed walking into our own bullets
            if not self:collision_is_suicide(collision) then
                self:do_damage(collision)
            end

            -- Execute any registered callbacks
            for i = 1, #self._on_collision_functions do
                self._on_collision_functions[i](self, collision)
            end
            self.object:remove()
        end

    end
end


