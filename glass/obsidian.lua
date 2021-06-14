
local S = minetest.get_translator("glass")
minetest.register_node("glass:obsidian", {
	description = S("Obsidian"),
	tiles = {"glass_obsidian.png"},
	sounds = glass.sounds,
	groups = {cracky = 1, level = 2},
})

minetest.register_node("glass:obsidian_brick", {
	description = S("Obsidian Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"glass_obsidian_brick.png"},
	is_ground_content = false,
	sounds = glass.sounds,
	groups = {cracky = 1, level = 2},
})

minetest.register_node("glass:obsidian_block", {
	description = S("Obsidian Block"),
	tiles = {"glass_obsidian_block.png"},
	is_ground_content = false,
	sounds = glass.sounds,
	groups = {cracky = 1, level = 2},
})
