function on_activate(self, staticdata, dtime_s)
    self.timer = 0
end


on_activate_function = on_activate

function on_step(self, dtime, moveresult)
    self.timer = self.timer + dtime

    if self.timer >= self.boomstick_data.lifetime then
        self.object:remove()
    end

    local sound_parameter_table = {name = "boomstick_ding"}

    -- TODO: should be pos of the node, not player
    local sound_spec = {pos = player_position, gain = 1.5, max_hear_distance = 5}

    if moveresult.collides then
        self.object:remove()

        -- TODO: This code for the target block should not be in projectile.lua.
        -- Maybe use an observer pattern
        for _, collision in pairs(moveresult.collisions) do
            if collision.type == "node" then
                local target_node = minetest.get_node(collision.node_pos)
                if target_node.name == "boomstick:target" then
                    minetest.sound_play(sound_parameter_table, sound_spec, false)
                end
            end
        end
    end

end


on_step_function = on_step

function on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
    -- print("on punch!")
end


on_punch_function = on_punch

function get_staticdata(self)
    return minetest.write_json({})
end


get_staticdata_function = get_staticdata

-- General data for a projectile entity.
local projectile = {
    initial_properties = {
        visual = "sprite",
        visual_size = {x = 0.1, y = 0.1, z = 0.1},
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.01, 0.0, -0.01, 0.01, 0.01, 0.01}
    },
    on_activate = on_activate_function,
    on_step = on_step_function,
    on_punch = on_punch_function,
    get_staticdata = get_staticdata_function,
    boomstick_data = {lifetime = 2.5, hp = 1, armor_groups = {}}
}

boomstick_data.projectile_data = projectile
