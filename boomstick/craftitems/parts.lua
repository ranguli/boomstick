local S = minetest.get_translator()

-- Gun Trigger
minetest.register_craftitem("boomstick:trigger", {
    description = S("Trigger"),
    inventory_image = "boomstick_trigger.png",
    wield_image = "boomstick_trigger.png",
    stack_max = 1,
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

-- Gun Body
minetest.register_craftitem("boomstick:body", {
    description = S("@1 Body", S("Gun")),
    inventory_image = "boomstick_body.png",
    wield_image = "boomstick_body.png",
    stack_max = 1,
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

-- Shotgun Hull
minetest.register_craftitem("boomstick:hull", {
    description = S("Hull"),
    inventory_image = "boomstick_shotgun_ammo.png",
    wield_image = "boomstick_shotgun_buckshot.png",
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

-- High Grade Powder
minetest.register_craftitem("boomstick:high_grade_powder", {
    description = S("@1 Powder", S("High Grade")),
    inventory_image = "boomstick_high_grade_powder.png",
    wield_image = "boomstick_high_grade_powder.png"
})

-- Low Grade Powder
minetest.register_craftitem("boomstick:low_grade_powder", {
    description = S("@1 Powder", S("Low Grade")),
    inventory_image = "boomstick_low_grade_powder.png",
    wield_image = "boomstick_low_grade_powder.png"
})
