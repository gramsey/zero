
function apple.add_to_biome(biome, place_on_node)

	local sch_tree = minetest.get_modpath("apple") .. "/schematics/apple_tree.mts";
	place_on_node = place_on_node or "dirt:grass"

	minetest.debug("adding ", biome..":apple_trees", " on ", place_on_node)

	minetest.register_decoration({
		   name = biome.."apple_trees",
		   deco_type = "schematic",
		   place_on = { place_on_node },
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
		   schematic = sch_tree,
		   flags = "place_center_x, place_center_z",
		   rotation = "random",
	})
end

function apple.add_log_to_biome(biome, place_on_node)

	local sch_log = minetest.get_modpath("apple") .. "/schematics/apple_log.mts"
	if (minetest.get_modpath("mushroom") ~= nil) then
		sch_log = minetest.get_modpath("apple").."/schematics/apple_log_with_mushroom.mts"
	end
	place_on_node = place_on_node or "dirt:grass"

	minetest.debug("adding ", biome..":apple_logs", " on ", place_on_node)

	minetest.register_decoration({
		name = biome..":apple_logs",
		deco_type = "schematic",
		place_on = { place_on_node },
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
	})
end

