local S = minetest.get_translator("sand")

-- SILVER SAND
minetest.register_node("sand:silver", {
	description = S("Silver Sand"),
	tiles = {"sand_silver.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
    sounds = sand.sounds,
})

minetest.register_node("sand:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"sand_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = stone.sounds,
})

minetest.register_node("sand:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"sand_silver_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = stone.sounds,
})

minetest.register_node("sand:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = {"sand_silver_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = stone.sounds,
})
