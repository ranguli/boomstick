local S = minetest.get_translator()

-- Anti-gun node, prevents the use of weapons within a 10 block radius.
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
        minetest.chat_send_player(player:get_player_name(),
            "Weapons are prohibited in this area!")
        return false
    end

    return true
end

boomstick_api.register_weapon_fire_condition(is_near_antigun_node)
