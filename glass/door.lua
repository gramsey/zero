
local S = minetest.get_translator("glass");

-- DOOR
door.register("glass:door", {
	--tiles = {{name="glass_door.png", backface_culling = true}},
	tiles = {{name="test_door_2.png", backface_culling = true}},
	inventory_image = "doors_item_glass.png",
	description = S("Glass Door"),
	groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
	sounds = glass.sounds,
	sound_open = "glass_door_open",
	sound_close = "glass_door_close",
})

minetest.register_craft( {
	output = "glass:door",
	recipe = {
		{"glass:glass", "glass:glass"},
		{"glass:glass", "glass:glass"},
		{"glass:glass", "glass:glass"},
	},
})

door.register("glass:obsidian_door", {
		tiles = {{name = "glass_obsidian_door.png", backface_culling = true}},
		description = S("Obsidian Glass Door"),
		inventory_image = "glass_obsidian_door_item.png",
		groups = {node = 1, cracky=3},
		sounds = glass.sounds,
		sound_open = "glass_door_open",
		sound_close = "glass_door_close",
})

minetest.register_craft( {
	output = "glass:obsidian_door",
	recipe = {
		{"glass:obsidian", "glass:obsidian"},
		{"glass:obsidian", "glass:obsidian"},
		{"glass:obsidian", "glass:obsidian"},
	},
})
