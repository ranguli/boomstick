local S = minetest.get_translator()

-- Target block, makes a sound when shot.
minetest.register_node("boomstick:target", {
    description = S("@1 Block", S("Target")),
    tiles = {"boomstick_target_node.png"},
    is_ground_content = false,
    groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1}
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

-- Anti-gun block, prevents the use of weapons within a 10 block radius.
minetest.register_node("boomstick:antigun", {
    description = S("@1 Node", S("Anti-Gun")),
    tiles = {"boomstick_antigun_node.png"},
    is_ground_content = false,
    groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1}
})

function is_near_antigun_node(player)
    local player_pos = player:get_pos()

    local antigun_nodes = minetest.find_node_near(player_pos, 10, "boomstick:antigun")

    if antigun_nodes ~= nil then
        minetest.chat_send_player(player:get_player_name(), "Weapons are prohibited in this area!")
        return false
    end

    return true
end


boomstick_api.register_weapon_fire_condition(is_near_antigun_node)
