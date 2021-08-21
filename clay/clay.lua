
local S = minetest.get_translator("clay");

minetest.register_node("clay:clay", {
	description = S("Clay"),
	tiles = {"clay.png"},
	groups = {crumbly = 3},
	drop = "clay:lump 4",
	sounds = dirt.sounds,
})


minetest.register_craftitem("clay:lump", {
	description = S("Clay Lump"),
	inventory_image = "clay_lump.png",
})

minetest.register_craft({
	output = "clay:clay",
	recipe = {
		{"clay:lump", "clay:lump"},
		{"clay:lump", "clay:lump"},
	}
})

minetest.register_craft({
	output = "clay:lump 4",
	recipe = {
		{"clay:clay"},
	}
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "clay:clay",
	wherein         = {"sand:sand"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_max           = 0,
	y_min           = -15,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})
