if boomstick_api.mod_exists("technic") and boomstick_api.mod_exists("basic_materials") then
    -- Wrought Iron Long Barrel
    minetest.register_craft({
        output = 'boomstick:wrought_iron_long_barrel',
        recipe = {
            {"technic:wrought_iron_ingot", "", ""},
            {"", "technic:wrought_iron_ingot", ""},
            {"", "", "technic:wrought_iron_ingot"}
        }
    })
    -- Wrought Iron Short Barrel
    minetest.register_craft({
        output = 'boomstick:wrought_iron_short_barrel',
        recipe = {
            {"", "", ""},
            {"", "technic:wrought_iron_ingot", ""},
            {"", "", "technic:wrought_iron_ingot"}
        }
    })

    -- Cast Iron Long Barrel
    minetest.register_craft({
        output = 'boomstick:cast_iron_long_barrel',
        recipe = {
            {"technic:cast_iron_ingot", "", ""},
            {"", "technic:cast_iron_ingot", ""},
            {"", "", "technic:cast_iron_ingot"}
        }
    })

    -- Cast Iron Short Barrel
    minetest.register_craft({
        output = 'boomstick:cast_iron_short_barrel',
        recipe = {
            {"", "", ""},
            {"", "technic:cast_iron_ingot", ""},
            {"", "", "technic:cast_iron_ingot"}
        }
    })

    -- Stainless Steel Long Barrel
    minetest.register_craft({
        output = 'boomstick:stainless_steel_long_barrel',
        recipe = {
            {"technic:stainless_steel_ingot", "", ""},
            {"", "technic:stainless_steel_ingot", ""},
            {"", "", "technic:stainless_steel_ingot"}
        }
    })

    -- Stainless Steel Short Barrel
    minetest.register_craft({
        output = 'boomstick:stainless_steel_short_barrel',
        recipe = {
            {"", "", ""},
            {"", "technic:stainless_steel_ingot", ""},
            {"", "", "technic:stainless_steel_ingot"}
        }
    })

end
