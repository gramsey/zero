
minetest.register_decoration({
	name = "cactus:cactus",
	deco_type = "simple",
	place_on = {"sand:desert"},
	sidelen = 16,
	noise_params = {
		offset = -0.012,
		scale = 0.024,
		spread = {x = 100, y = 100, z = 100},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	y_max = 30,
	y_min = 1,
	decoration = "cactus:cactus",
	height = 3,
		height_max = 4,
})
