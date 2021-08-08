
function coral.add_to_biome(biome, def)
	coral_def = {
		name = biome..":corals",
		deco_type = "simple",
		place_on = {"sand:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = { biome },
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"coral:green", "coral:pink",
			"coral:cyan", "coral:brown",
			"coral:orange", "coral:skeleton",
		},
	}

	def = def or {}
	for k, v in pairs(def) do coral_def[k] = v end

	minetest.register_decoration(coral_def)
end
