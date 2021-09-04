
function kelp.add_to_biome (biome, def)

	local kelp_def = {
		name = biome .. ":kelp",
		deco_type = "simple",
		place_on = {"sand:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = { biome },
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "kelp:kelp",
		param2 = 48,
		param2_max = 96,
	}

	def = def or {}
	for k, v in pairs(def) do kelp_def[k] = v end

	minetest.register_decoration(kelp_def)
end
