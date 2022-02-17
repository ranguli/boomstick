local S = minetest.get_translator()

-- Target block, makes a sound when shot.
minetest.register_node("boomstick:target", {
    description = S("@1 Node", S("Target")),
    tiles = {"boomstick_target_node.png"},
    is_ground_content = false,
    groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1}
})

minetest.register_craft({
    output = "boomstick:target",
    recipe = {
        {"technic:wrought_iron_ingot", "technic:wrought_iron_ingot", "technic:wrought_iron_ingot"},
        {"technic:wrought_iron_ingot", "group:boomstick_ammo", "technic:wrought_iron_ingot"},
        {"technic:wrought_iron_ingot", "technic:wrought_iron_ingot", "technic:wrought_iron_ingot"}
    }
})

-- Callback for when the target block is hit with a projectile.
function on_target_block_hit(projectile, collision)
    if collision.type ~= "node" then
        return
    end

    local target_node = minetest.get_node(collision.node_pos)
    if target_node.name == "boomstick:target" then
        local sound_parameter_table = {name = "boomstick_ding"}
        local sound_spec = {
            pos = collision.node_pos,
            gain = 0.25,
            max_hear_distance = 100
        }
        minetest.sound_play(sound_parameter_table, sound_spec, false)
    end
end


-- Register our function to be called on collision events.
boomstick_api.register_projectile_collision(on_target_block_hit)


