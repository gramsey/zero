
local schematic_path = minetest.get_modpath("pine").."/schematics/"

function pine.add_to_biome(biome, def)
	local pine_def = {
		name = biome..":pine_tree",
		deco_type = "schematic",
		place_on = {"dirt:snow", "dirt:litter_dry"},
		sidelen = 16,
		noise_params = {
			offset = 0.010,
			scale = 0.048,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 4,
		schematic = schematic_path.."pine_tree.mts",
		flags = "place_center_x, place_center_z",
	}

	def = def or {}
	for k, v in pairs(def) do pine_def[k] = v end

	minetest.register_decoration(pine_def)
end

function pine.add_small_to_biome(biome, def)

	local small_pine_def = {
		name = biome..":pine_tree_small",
		schematic = schematic_path.."pine_tree_small.mts",
	}

	def = def or {}
	for k, v in pairs(def) do small_pine_def[k] = v end

	pine.add_to_biome(biome, small_pine_def)
end

function pine.add_log_to_biome(biome, def)
	local log_schematic = schematic_path.."pine_log.mts"

	if minetest.get_modpath("mushroom") then 
		log_schematic = schematic_path.."pine_log_with_mushroom.mts"
	end

	local log_def = {
		name = biome..":pine_log",
		deco_type = "schematic",
		place_on = {"dirt:snow", "dirt:litter_dry"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"taiga", "coniferous_forest"},
		y_max = 31000,
		y_min = 4,
		schematic = log_schematic,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"dirt:snow", "dirt:litter_dry"},
		num_spawn_by = 8,
	}

	def = def or {}
	for k, v in pairs(def) do log_def[k] = v end

	minetest.register_decoration(log_def)
end
