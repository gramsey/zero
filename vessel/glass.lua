local S = minetest.get_translator("vessel")

minetest.register_node("vessel:glass_bottle", {
	description = S("Empty Glass Bottle"),
	drawtype = "plantlike",
	tiles = {"vessel_glass_bottle.png"},
	inventory_image = "vessel_glass_bottle.png",
	wield_image = "vessel_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = glass.sounds,
})

minetest.register_craft( {
	output = "vessel:glass_bottle 10",
	recipe = {
		{"glass:glass", "", "glass:glass"},
		{"glass:glass", "", "glass:glass"},
		{"", "glass:glass", ""}
	}
})

minetest.register_node("vessel:drinking_glass", {
	description = S("Empty Drinking Glass"),
	drawtype = "plantlike",
	tiles = {"vessel_drinking_glass.png"},
	inventory_image = "vessel_drinking_glass_inv.png",
	wield_image = "vessel_drinking_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = glass.sounds,
})

minetest.register_craft( {
	output = "vessel:drinking_glass 14",
	recipe = {
		{"glass:glass", "", "glass:glass"},
		{"glass:glass", "", "glass:glass"},
		{"glass:glass", "glass:glass", "glass:glass"}
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessel:glass_fragments",
	recipe = {
		"vessel:glass_bottle",
		"vessel:glass_bottle",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessel:glass_fragments",
	recipe = {
		"vessel:drinking_glass",
		"vessel:drinking_glass",
	},
})
