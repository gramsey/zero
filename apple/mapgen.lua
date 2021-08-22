
local schematic_path = minetest.get_modpath("apple").."/schematics/"

function apple.add_to_biome(biome, def)

	local tree_def =  {
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

	local schem = schematic_path.."apple_log.mts"
	
	if minetest.get_modpath("mushroom") ~= nil then
		schem = schematic_path.."apple_log_with_mushroom.mts"
	end

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
		schematic = schem,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "dirt:grass",
		num_spawn_by = 8,
	}

	def = def or {}
	for k, v in pairs(def) do log_def[k] = v end

	minetest.register_decoration(log_def)
end


function apple.add_bush_to_biome(biome, def) 
	local def_bush = {
		name = biome..":apple_bush",
		deco_type = "schematic",
		place_on = {"dirt:grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = schematic_path.."apple_bush.mts",
		flags = "place_center_x, place_center_z",
	}

	def = def or {}
	for k, v in pairs(def) do def_bush[k] = v end

	minetest.register_decoration(def_bush)
end
