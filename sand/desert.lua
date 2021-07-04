local S = minetest.get_translator("sand")

minetest.register_node("sand:desert", {
	description = S("Desert Sand"),
	tiles = {"sand_desert.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
    sounds = sand.sounds,
})

minetest.register_node("sand:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"sand_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "sand:desert_cobble",
	legacy_mineral = true,
	sounds = stone.sounds,
})

minetest.register_node("sand:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"sand_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = stone.sounds,
})

minetest.register_node("sand:desert_stone_brick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"sand_desert_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone.sounds,
})

minetest.register_node("sand:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"sand_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = stone.sounds,
})


minetest.register_node("sand:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"sand_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = stone.sounds,
})

minetest.register_node("sand:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"sand_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = stone.sounds,
})

minetest.register_node("sand:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"sand_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = stone.sounds,
})
