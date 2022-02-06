minetest.register_craftitem("boomstick:buckshot", {
    description = "Buckshot",
    inventory_image = "boomstick_shotgun_ammo.png",
    wield_image = "boomstick_shotgun_ammo.png",
    stack_max = 25,
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    on_secondary_use = boomstick.weapon_load_function,
    range = 0
})

minetest.register_craftitem("boomstick:longbarrel", {
    description = "Long Barrel",
    inventory_image = "boomstick_long_barrel.png",
    wield_image = "boomstick_long_barrel.png",
    stack_max = 1,
    wield_scale = {x = 2, y = 2, z = 1}
})

minetest.register_craftitem("boomstick:leadpellets", {
    description = "Lead Pellets",
    groups = {boomstick_pellets = 1},
    inventory_image = "boomstick_pellets.png",
    wield_image = "boomstick_pellets.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5}
})

minetest.register_craftitem("boomstick:trigger", {
    description = "Trigger",
    inventory_image = "boomstick_trigger.png",
    wield_image = "boomstick_trigger.png",
    stack_max = 1,
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

minetest.register_craftitem("boomstick:body", {
    description = "Gun Body",
    inventory_image = "boomstick_body.png",
    wield_image = "boomstick_body.png",
    stack_max = 1,
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

minetest.register_craftitem("boomstick:hull", {
    description = "Hull",
    inventory_image = "boomstick_shotgun_ammo.png",
    wield_image = "boomstick_shotgun_buckshot.png",
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

