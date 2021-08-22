
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

minetest.register_node("glass:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"glass_obsidian_glass.png", "glass_obsidian_glass_detail.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = glass.sounds,
	groups = {cracky = 3},
})

minetest.register_craftitem("glass:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "glass_obsidian_shard.png",
})

minetest.register_craft({
	output = "glass:obsidian_shard 9",
	recipe = {
		{"glass:obsidian"}
	}
})

minetest.register_craft({
	output = "glass:obsidian",
	recipe = {
		{"glass:obsidian_shard", "glass:obsidian_shard", "glass:obsidian_shard"},
		{"glass:obsidian_shard", "glass:obsidian_shard", "glass:obsidian_shard"},
		{"glass:obsidian_shard", "glass:obsidian_shard", "glass:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "glass:obsidian_brick 4",
	recipe = {
		{"glass:obsidian", "glass:obsidian"},
		{"glass:obsidian", "glass:obsidian"}
	}
})

minetest.register_craft({
	output = "glass:obsidian_block 9",
	recipe = {
		{"glass:obsidian", "glass:obsidian", "glass:obsidian"},
		{"glass:obsidian", "glass:obsidian", "glass:obsidian"},
		{"glass:obsidian", "glass:obsidian", "glass:obsidian"},
	}
})
