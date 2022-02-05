-- Target block, makes a sound when shot.
minetest.register_node("boomstick:target", {
    description = "Target",
    tiles = {"boomstick_target_node.png"},
    is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1},
})


