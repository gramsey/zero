
local schematic_path = minetest.get_modpath("apple").."/schematics/"

function apple.add_to_biome(biome, def)

	local def_tree =  {
		name = biome.."apple_trees",
		deco_type = "schematic",
		place_on = { "dirt:grass" },
		sidelen = 16,
		noise_params = {
			   offset = 0,
			   scale = 0.015,
			   spread = {x = 250, y = 250, z = 250},
			   seed = 2,
			   octaves = 3,
			   persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = schematic_path.."apple_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	}

	def = def or {}
	for k, v in pairs(def) do tree_def[k] = v end

	minetest.register_decoration(tree_def)
end

function apple.add_log_to_biome(biome, def)

	local log_def = {
		name = biome..":apple_logs",
		deco_type = "schematic",
		place_on = { "dirt:grass" },
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			--offset = 0.0012,
			offset = -0.00003,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = sch_log,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = place_on_node,
		num_spawn_by = 8,
	}

	def = def or {}
	for k, v in pairs(def) do log_def[k] = v end

	minetest.register_decoration(log_def)
end

