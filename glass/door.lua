
local S = minetest.get_translator("glass");

-- DOOR
door.register("glass:door", {
	tiles = {"glass_door.png"},
	inventory_image = "doors_item_glass.png",
	description = S("Glass Door"),
	groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
	sounds = glass.sounds,
	sound_open = "doors_glass_door_open",
	sound_close = "doors_glass_door_close",
})

minetest.register_craft( {
	output = "glass:door",
	recipe = {
		{"glass:glass", "glass:glass"},
		{"glass:glass", "glass:glass"},
		{"glass:glass", "glass:glass"},
	},
})

