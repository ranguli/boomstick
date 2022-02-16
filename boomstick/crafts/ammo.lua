minetest.register_craft({
    output = "boomstick:9mm",
    recipe = {
        {"", "boomstick:9mm_projectile", ""},
        {"", "boomstick:high_grade_powder", ""},
        {"", "boomstick:9mm_casing", "" }
    }
})

minetest.register_craft({
    output = "boomstick:556",
    recipe = {
        {"", "boomstick:556_projectile", ""},
        {"", "boomstick:high_grade_powder", ""},
        {"", "boomstick:556_casing", "" }
    }
})

minetest.register_craft({
    output = "boomstick:762x39",
    recipe = {
        {"", "boomstick:762x39_projectile", ""},
        {"", "boomstick:high_grade_powder", ""},
        {"", "boomstick:762x39_casing", "" }
    }
})


minetest.register_craft({
    output = 'boomstick:buckshot',
    recipe = {
        {"", "boomstick:pellets", ""},
        {"", "boomstick:high_grade_powder", ""},
        {"", "boomstick:shotgun_casing", ""}
    }
})

minetest.register_craft({
    output = "boomstick:musket_charge",
    type = "shapeless",
    recipe = {"boomstick:musket_ball", "boomstick:low_grade_powder"}
})
