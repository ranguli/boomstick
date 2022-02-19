local S = minetest.get_translator()

-- A small pellet
PelletProjectile = boomstick_api.Projectile:new({
    _name = S("Pellet"),
    _item_name = "pellet_projectile",
    _entity_name = "boomstick:pellet_projectile",
    _velocity = 40,
    _damage = 6, -- *per* pellet
    initial_properties = {
        visual = "sprite",
        textures = {"boomstick_projectile_pellet.png"},
        physical = true,
        collide_with_objects = true,
        visual_size = {y = 0.1, x = 0.1, z = 0.1},
        collisionbox = {-0.01, 0, -0.01, 0.01, 0.01, 0.01}
    }
})

minetest.register_entity("boomstick:pellet_projectile", PelletProjectile)

-- A larger lead ball, used in Muskets
BallProjectile = boomstick_api.Projectile:new({
    _name = S("Ball"),
    _item_name = "ball",
    _entity_name = "boomstick:ball_projectile",
    _velocity = 25,
    _damage = 6,
    initial_properties = {
        visual = "sprite",
        textures = {"boomstick_projectile_pellet.png"},
        physical = true,
        collide_with_objects = true,
        visual_size = {y = 0.25, x = 0.25, z = 0.25},
        collisionbox = {-0.01, 0, -0.01, 0.01, 0.01, 0.01}
    }
})

minetest.register_entity("boomstick:ball_projectile", BallProjectile)

MediumBulletProjectile = boomstick_api.Projectile:new({
    _name = S("Medium Bullet"),
    _item_name = "Medium Bullet",
    _entity_name = "boomstick:medium_bullet_projectile",
    _velocity = 0,
    _damage = 6,
    initial_properties = {
        visual = "mesh",
        mesh = "boomstick_bullet_projectile.b3d",
        textures = {"boomstick_bullet_projectile_texture.png"},
        physical = true,
        collide_with_objects = true,
        visual_size = {y = 1, x = 1, z = 1},
        collisionbox = {-0.01, 0, -0.01, 0.01, 0.01, 0.01}
    }
})
minetest.register_entity("boomstick:medium_bullet_projectile", MediumBulletProjectile)

