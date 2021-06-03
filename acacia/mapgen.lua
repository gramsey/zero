
function acacia.add_to_biome(biome, place_on_node)

	local sch_tree = minetest.get_modpath("acacia") .. "/schematics/acacia_tree.mts";
	place_on_node = place_on_node or "dirt:grass_dry"

	minetest.debug("adding ", biome..":acacia_trees", " on ", place_on_node)

	minetest.register_decoration({
		   name = biome.."acacia_trees",
		   deco_type = "schematic",
		   place_on = { place_on_node },
		   sidelen = 16,
		   noise_params = {
				   offset = 0,
				   scale = 0.002,
				   spread = {x = 250, y = 250, z = 250},
				   seed = 2342,
				   octaves = 3,
				   persist = 0.66
		   },
		   biomes = { biome },
		   y_max = 31000,
		   y_min = 1,
		   schematic = sch_tree,
		   flags = "place_center_x, place_center_z",
		   rotation = "random",
	})
end

function acacia.add_log_to_biome(biome, place_on_node)

	local sch_log = minetest.get_modpath("acacia") .. "/schematics/acacia_log.mts"
	place_on_node = place_on_node or "dirt:grass_dry"

	minetest.debug("adding ", biome..":acacia_logs", " on ", place_on_node)

	minetest.register_decoration({
		name = biome..":acacia_logs",
		deco_type = "schematic",
		place_on = { place_on_node },
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			--offset = 0.0012,
			offset = 0,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2342,
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
	})
end

