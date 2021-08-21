
local S = minetest.get_translator("clay");

minetest.register_node("clay:brick_block", {
	description = S("Brick Block"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {
		"clay_brick_block.png^[transformFX",
		"clay_brick_block.png",
	},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = stone.sounds,
})

minetest.register_craftitem("clay:brick", {
	description = S("Clay Brick"),
	inventory_image = "clay_brick.png",
})

minetest.register_craft({
	output = "clay:brick_block",
	recipe = {
		{"clay:brick", "clay:brick"},
		{"clay:brick", "clay:brick"},
	}
})

minetest.register_craft({
	output = "clay:brick 4",
	recipe = {
		{"clay:brick_block"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "clay:brick",
	recipe = "clay:lump",
})
