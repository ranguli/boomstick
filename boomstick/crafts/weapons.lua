if boomstick_api.mod_exists("technic") and boomstick_api.mod_exists("basic_materials") then
    -- Musket
    minetest.register_craft({
        output = "boomstick:musket",
        recipe = {
            {"boomstick:wrought_iron_long_barrel", "", ""},
            {"", "group:wood", ""},
            {"boomstick:trigger", "", "group:wood"}
        }
    })

    -- Rustington
    minetest.register_craft({
        output = "boomstick:rustington",
        recipe = {
            {"boomstick:stainless_steel_long_barrel", "", ""},
            {"group:wood", "boomstick:body", ""},
            {"", "", "group:wood"}
        }
    })
end
