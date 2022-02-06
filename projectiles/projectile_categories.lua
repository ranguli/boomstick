-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

-- projectile stats + categories that projectile implementations can use

Projectile = {
    _velocity = 500,
    _lifetime = 2.5,
}

function Projectile:new(o)
      o = o or {}
      setmetatable(o, self)
      self.__index = self
      return o
end

function Projectile:on_activate(staticdata, dtime_s)
    -- Lifespan of the projectile
    self.timer = 0
end

function Projectile:set_owner(player)
    self.owner = player
end

function Projectile:get_owner()
    return self.owner
end


function Projectile:on_step(dtime, moveresult)
    self.timer = self.timer + dtime

    if self.timer >= self._lifetime then
        self.object:remove()
    end

    if moveresult.collides then
        self.object:remove()

        -- TODO: This code for the target block should not be in projectile.lua.
        -- Maybe use an observer pattern?
        for _, collision in pairs(moveresult.collisions) do
            if collision.type == "object" then
                if collision.object:get_player_name() ~= self.owner:get_player_name() then
                    if self._item_name ~= collision.object:get_luaentity().name then
                        collision.object:punch(self.owner, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy = self._damage}}, nil)
                    end
                end
            elseif collision.type == "node" then
                local target_node = minetest.get_node(collision.node_pos)
                if target_node.name == "boomstick:target" then
                    local sound_parameter_table = {name = "boomstick_ding"}
                    local sound_spec = {pos = collision.node_pos, gain = 1.5, max_hear_distance = 100}
                    minetest.sound_play(sound_parameter_table, sound_spec, false)
                end
            end
        end
    end
end

--boomstick.create_new_category("projectile", nil, DefaultProjectile)
