-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

-- projectile stats + categories that projectile implementations can use

function on_step(self, dtime, moveresult)
    self.timer = self.timer + dtime

    if self.timer >= self._lifetime then
        self.object:remove()
    end


    if moveresult.collides then
        self.object:remove()

        -- TODO: This code for the target block should not be in projectile.lua.
        -- Maybe use an observer pattern
        for _, collision in pairs(moveresult.collisions) do
            if collision.type == "node" then
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

on_step_function = on_step

local default_stats = {
    on_activate = function(self, staticdata, dtime_s)
        self.timer = 0
    end,
    on_step = on_step_function,
    -- Custom values
    _velocity = 500,
    _lifetime = 2.5,
}

boomstick.create_new_category("projectile", nil, default_stats)
