-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

--- Projectile class from which custom projectiles can be created.
-- @classmod boomstick.Projectile
boomstick.Projectile = {
    _velocity = 500,
    _lifetime = 2.5,
    _on_collision_functions = {}
}

function boomstick.Projectile:new(o)
      o = o or {}
      setmetatable(o, self)
      self.__index = self
      return o
end

function boomstick.Projectile:on_activate(staticdata, dtime_s)
    -- Timer for despawning
    self.timer = 0
end

function boomstick.Projectile:set_owner(player)
    -- Who fired the projectile
    self.owner = player
end

function boomstick.Projectile:get_owner()
    return self.owner
end

--- Registers a callback function to be called when the projectile has a collision.
--  If you'd like certain behavior to happen when a projectile collides with
--  something, you can pass another function as an argument to this function,
--  and it will be executed when the projectile collides with something.
--
-- **Note:** It is usually not necesary to call this function directly to create a new weapon,
-- unless you are extending the mod or making custom behavior.
--
-- @param func Function to be executed on collision.
function boomstick.Projectile:register_on_collision(func)
    table.insert(self._on_collision_functions, func)
end

--- For determining whether or not a projectile collided with another projectile.
-- Sometimes (especially with shotguns) projectiles will collide with one
-- another. It is often necessary to check if a collision happened between two
-- projectiles, so that we can do something (usually ignore it). Otherwise
-- projectiles would deal damage to one another.
--
-- **Note:** It is usually not necesary to call this function directly to create a new weapon,
-- unless you are extending the mod or making custom behavior.
--
-- @param collision Collision object returned by Minetest
-- @return boolean - whether or not the projectile collided with another
-- projectile.
function boomstick.Projectile:collision_is_projectile(collision)
    local entity = collision.object:get_luaentity()

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
-- @return boolean - whether or not the projectile collided with another
-- projectile.
--
-- **Note:** It is usually not necesary to call this function directly to create a new weapon,
-- unless you are extending the mod or making custom behavior.
function boomstick.Projectile:do_damage(collision)

    if collision.type ~= "object" then
        -- TODO: this won't allow weapons to do damage to blocks
        return
    end

    if not self:collision_is_projectile(collision) then
        local tool_capabilities = {full_punch_interval = 1.0, damage_groups = {fleshy = self._damage}}
        collision.object:punch(self.owner, 1.0, tool_capabilities)
    end
end

function boomstick.Projectile:collision_is_suicide(collision)
    if not collision then
        return
    end

    if collision.type ~= "object" then
        return
    end

    if not self.owner then
        return
    end

    if collision.object:get_player_name() == self.owner:get_player_name() then
        return true
    end

    return false
end

function boomstick.Projectile:on_step(dtime, moveresult)
    self.timer = self.timer + dtime

    if self.timer >= self._lifetime then
        self.object:remove()
    end

    if moveresult.collides then
        for _, collision in pairs(moveresult.collisions) do

            -- Don't get killed walking into our own bullets
            if not self:collision_is_suicide(collision) then
                self:do_damage(collision)
            end

            -- Execute any registered callbacks
            for i=1, #self._on_collision_functions do
                self._on_collision_functions[i](self, collision)
            end
            self.object:remove()
        end

    end
end


