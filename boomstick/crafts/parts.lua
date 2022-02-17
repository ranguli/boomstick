if boomstick_api.mod_exists("technic") and boomstick_api.mod_exists("basic_materials") then
    minetest.register_craft({
        output = 'boomstick:body',
        recipe = {
            {"", "", ""},
            {
                "technic:stainless_steel_ingot",
                "technic:stainless_steel_ingot",
                "technic:stainless_steel_ingot"
            },
            {
                "technic:stainless_steel_ingot",
                "boomstick:trigger",
                "technic:stainless_steel_ingot"
            }
        }
    })

    minetest.register_craft({
        output = 'boomstick:trigger',
        recipe = {
            {"", "basic_materials:steel_strip", ""},
            {"", "", "basic_materials:steel_strip"},
            {"", "basic_materials:steel_strip", ""}
        }
    })

    minetest.register_craft({
        output = 'boomstick:shotgun_casing',
        recipe = {
            {"basic_materials:plastic_strip", "", "basic_materials:plastic_strip"},
            {"basic_materials:plastic_strip", "", "basic_materials:plastic_strip"},
            {"technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot"}
        }
    })

    -- Low-Grade Gunpowder, used in Muskets and smoke grenades.
    minetest.register_craft({
        output = "boomstick:low_grade_powder",
        type = "shapeless",
        recipe = {"technic:sulfur_lump", "boomstick:coal_lump"}
    })


    -- High-Grade Gunpowder, used in modern weapons (i.e not muskets) and grenades.
    minetest.register_craft({
        output = "boomstick:high_grade_powder",
        type = "shapeless",
        recipe = {"technic:sulfur_dust", "technic:coal_dust"}
    })
end
