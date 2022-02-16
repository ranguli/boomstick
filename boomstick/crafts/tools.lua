if boomstick_api.mod_exists("technic") and boomstick_api.mod_exists("basic_materials") then
    -- Shotgun Pellets Mold
    minetest.register_craft({
        output = "boomstick:shotgun_pellets_mold",
        recipe = {
            {"technic:cast_iron_ingot", "", "technic:cast_iron_ingot"},
            {"", "technic:cast_iron_ingot", ""},
            {"group:stick", "", ""}
        }
    })

    -- Musket Ball Mold
    minetest.register_craft({
        output = "boomstick:musket_ball_mold",
        recipe = {
            {"technic:cast_iron_ingot", "", "technic:cast_iron_ingot"},
            {"", "technic:cast_iron_ingot", ""},
            {"group:stick", "", ""}
        }
    })

    -- 9mm Bullet Mold
    minetest.register_craft({
        output = "boomstick:9mm_bullet_mold",
        recipe = {
            {"technic:stainless_steel_ingot", "", "technic:stainless_steel_ingot"},
            {"", "technic:stainless_steel_ingot", ""},
            {"group:stick", "", ""}
        }
    })
end
