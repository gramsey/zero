
local function copy_with_defaults(t, defaults)
	local def_table = table.copy(defaults)

	for k, v in pairs(t) do 
		def_table[k] = v 
	end
	return def_table
end

local mod_path = minetest.get_modpath("jungle")

function jungle.add_to_biome(biome, def)
	def = def or {}

	local tree_def = {
		name = biome.."jungle_trees",
		deco_type = "schematic",
		place_on = {"dirt:litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = mod_path.."/schematics/jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	}

	tree_def = copy_with_defaults(def, tree_def) 
	minetest.register_decoration(tree_def)
end

function jungle.add_log_to_biome(biome, def)
	def = def or {}

	local schem = mod_path.."/schematics/jungle_log.mts"
	
	if minetest.get_modpath("mushroom") ~= nil then
		schem = mod_path.."/schematics/jungle_log_with_mushroom.mts"
	end

	local log_def = {
		name = biome..":jungle_logs",
		deco_type = "schematic",
		place_on = {"dirt:litter"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		schematic = schem,
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "dirt:litter",
		num_spawn_by = 8,
	}

	log_def = copy_with_defaults(def, log_def) 
	minetest.register_decoration(log_def)
end


function jungle.add_emergent_to_biome(biome, def)

	-- Due to 32 node height, depends on chunksize
	local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
	if chunksize < 5 then return end

	def = def or {}

	local tree_def = {
		name = biome..":jungle_trees_emergent",
		deco_type = "schematic",
		place_on = { "dirt:litter" },
		sidelen = 80,
		noise_params = {
			offset = 0.0,
			scale = 0.0025,
			spread = {x = 250, y = 250, z = 250},
			seed = 2685,
			octaves = 3,
			persist = 0.7
		},
		biomes = { biome },
		y_max = 32,
		y_min = 1,
		schematic = mod_path.."/schematics/emergent_jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
		place_offset_y = -4,
	}

	tree_def = copy_with_defaults(def, tree_def) 
	minetest.register_decoration(tree_def)
end

