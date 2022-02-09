minetest.register_craft({
    output = "boomstick:rustington",
    recipe = {
        {"boomstick:longbarrel", "", ""},
        {"group:tree", "boomstick:body", ""},
        {"", "", "group:tree"}
    }
})

minetest.register_craft({
    output = 'boomstick:longbarrel',
    recipe = {
        {"technic:stainless_steel_ingot", "", ""},
        {"", "technic:stainless_steel_ingot", ""},
        {"", "", "technic:stainless_steel_ingot"}
    }
})

minetest.register_craft({
    output = 'boomstick:leadpellets',
    recipe = {{"", "", ""}, {"", "technic:lead_ingot", ""}, {"", "", ""}}
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
    output = 'boomstick:body',
    recipe = {
        {
            "technic:stainless_steel_ingot",
            "technic:stainless_steel_ingot",
            "technic:stainless_steel_ingot"
        },
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
    output = 'boomstick:hull',
    recipe = {
        {"basic_materials:plastic_strip", "", "basic_materials:plastic_strip"},
        {"basic_materials:plastic_strip", "", "basic_materials:plastic_strip"},
        {"", "basic_materials:brass_ingot", ""}
    }
})

minetest.register_craft({
    output = 'boomstick:buckshot',
    recipe = {
        {"", "group:boomstick_pellets", ""},
        {"", "tnt:gunpowder", ""},
        {"", "boomstick:hull", ""}
    }
})
