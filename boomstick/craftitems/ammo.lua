local S = minetest.get_translator()

----------------
-- Ammo Casings
----------------

-- 5.56 Casing
minetest.register_craftitem("boomstick:556_casing", {
    description = S("@1 Casing", S("5.56")),
    inventory_image = "boomstick_556_casing.png",
    wield_image = "boomstick_556_casing.png",
})

-- 7.62x39 Casing
minetest.register_craftitem("boomstick:762x39_casing", {
    description = S("@1 Casing", S("7.62x39")),
    inventory_image = "boomstick_762x39_casing.png",
    wield_image = "boomstick_762x39_casing.png",
})

-- 9mm Casing
minetest.register_craftitem("boomstick:9mm_casing", {
    description = S("@1 Casing", S("9mm")),
    inventory_image = "boomstick_9mm_casing.png",
    wield_image = "boomstick_9mm_casing.png",
})

--------------------
-- Ammo Projectiles
--------------------

-- 9mm Projectile
minetest.register_craftitem("boomstick:9mm_projectile", {
    description = S("@1 Projectile", S("9mm")),
    inventory_image = "boomstick_9mm_projectile.png",
    wield_image = "boomstick_9mm_projectile.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5}
})

-- 5.56 Projectile
minetest.register_craftitem("boomstick:556_projectile", {
    description = S("@1 Projectile", S("5.56")),
    inventory_image = "boomstick_missing_texture.png",
    wield_image = "boomstick_missing_texture.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5}
})

-- 7.62x39 Projectile
minetest.register_craftitem("boomstick:762x39_projectile", {
    description = S("@1 Projectile", S("7.62x39")),
    inventory_image = "boomstick_missing_texture.png",
    wield_image = "boomstick_missing_texture.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5}
})

-- Musket Ball
minetest.register_craftitem("boomstick:musket_ball", {
    description = S("Musket Ball"),
    inventory_image = "boomstick_projectile_pellet.png",
    wield_image = "boomstick_projectile_pellet.png",
    stack_max = 99,
    wield_scale = {x = 0.5, y = 0.5, z = 1}
})

-- Shotgun Pellets
minetest.register_craftitem("boomstick:pellets", {
    description = S("Pellets"),
    inventory_image = "boomstick_pellets.png",
    wield_image = "boomstick_pellets.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5}
})

--------
-- Ammo
--------

-- Shotgun Buckshot
minetest.register_craftitem("boomstick:buckshot", {
    description = S("Buckshot"),
    inventory_image = "boomstick_shotgun_ammo.png",
    wield_image = "boomstick_shotgun_ammo.png",
    stack_max = 25,
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    on_secondary_use = boomstick_api.weapon_load_function,
    range = 1,
    groups = {boomstick_ammo = 1}
})

-- Musket Charge
minetest.register_craftitem("boomstick:musket_charge", {
    description = S("@1 Charge", S("Musket")),
    inventory_image = "boomstick_musket_charge.png",
    wield_image = "boomstick_musket_charge.png",
    stack_max = 1,
    on_secondary_use = boomstick_api.weapon_load_function,
    range = 1,
    groups = {boomstick_ammo = 1}
})

-- 9mm Ammo
minetest.register_craftitem("boomstick:9mm", {
    description = S("@1 Ammo", S("9mm")),
    inventory_image = "boomstick_9mm_ammo.png",
    wield_image = "boomstick_9mm_ammo.png",
    stack_max = 50,
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    on_secondary_use = boomstick_api.weapon_load_function,
    range = 1,
    groups = {boomstick_ammo = 1}
})

-- 5.56 Ammo
minetest.register_craftitem("boomstick:556", {
    description = S("@1 Ammo", S("5.56")),
    inventory_image = "boomstick_556_ammo.png",
    wield_image = "boomstick_556_ammo.png",
    wield_scale = {x = 0.25, y = 0.25, z = 0.25},
    stack_max = 30,
    on_secondary_use = boomstick_api.weapon_load_function,
    range = 1,
    groups = {boomstick_ammo = 1}
})
