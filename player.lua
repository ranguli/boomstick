function initialize_player_metadata(player)
    local player_metadata = player:get_meta()
    player_metadata.set_float("boomstick_cooldown", 0.0)
end

minetest.register_on_newplayer(initialize_player_metadata)
