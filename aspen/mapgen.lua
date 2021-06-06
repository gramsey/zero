local mod_path = minetest.get_modpath("aspen")

function aspen.add_to_biome(biome, def)

	local tree_def = {
		name = biome..":aspen_trees",
		deco_type = "schematic",
		place_on = {"dirt:grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = mod_path.."/schematics/aspen_tree.mts",
		flags = "place_center_x, place_center_z",
	}

	def = def or {}
	for k, v in pairs(def) do tree_def[k] = v end

	minetest.register_decoration(tree_def)
end

function aspen.add_log_to_biome(biome, def)

	local schem = mod_path.."/schematics/aspen_log.mts"
	
	if minetest.get_modpath("mushroom") ~= nil then
		schem = mod_path.."/schematics/aspen_log_with_mushroom.mts"
	end

	local log_def = {
		name = biome..":aspen_log",
		deco_type = "schematic",
		place_on = {"dirt:grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.0008,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = schem,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "dirt:grass",
		num_spawn_by = 8,
	}

	def = def or {}
	for k, v in pairs(def) do tree_def[k] = v end

	minetest.register_decoration(log_def)
end
