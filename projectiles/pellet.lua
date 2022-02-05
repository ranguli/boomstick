local pellet = boomstick_data.projectile_data

pellet.initial_properties.textures = {"boomstick_shotgun_pellet.png"}
pellet.hp = 1
pellet.armor_groups = {}
pellet.velocity = 125

minetest.register_entity("boomstick:pellet", pellet)
return pellet
