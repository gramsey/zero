local S = minetest.get_translator("vessel")

minetest.register_node("vessel:steel_bottle", {
	description = S("Empty Heavy Steel Bottle"),
	drawtype = "plantlike",
	tiles = {"vessel_steel_bottle.png"},
	inventory_image = "vessel_steel_bottle.png",
	wield_image = "vessel_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = metal.sounds,
})

minetest.register_craft( {
	output = "vessel:steel_bottle 5",
	recipe = {
		{"iron:ingot", "", "iron:ingot"},
		{"iron:ingot", "", "iron:ingot"},
		{"", "iron:ingot", ""}
	}
})

minetest.register_craft( {
	type = "cooking",
	output = "iron:ingot",
	recipe = "vessel:steel_bottle",
})

