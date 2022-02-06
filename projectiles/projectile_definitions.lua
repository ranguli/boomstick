-- boomstick by ranguli (github.com/boomstick)
-- feb 5th, 2022

-- definitions of projectiles

local pellet = {
    _name = "Pellet",
    _item_name = "pellet",
    _entity_name = "boomstick:pellet",
    _velocity = 50,
	initial_properties = {
		visual = "sprite",
        textures = {"boomstick_projectile_pellet.png"},
		physical = true,
		collide_with_objects = true,
		visual_size = {y = 0.1, x = 0.1, z = 0.1},
		collisionbox = {-0.01, 0, -0.01, 0.01, 0.01, 0.01}
	},
}

PelletProjectile = Projectile:new(pellet)

minetest.register_entity("boomstick:pellet", PelletProjectile)

