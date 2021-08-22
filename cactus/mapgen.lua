
local schematic_path = minetest.get_modpath("cactus").."/schematics/"

function cactus.add_to_biome(biome, def)
	minetest.debug("adding cactus to "..biome)
	local cactus_def = {
		name = biome..":cactus",
		deco_type = "simple",
		place_on = {"sand:desert"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 4,
		decoration = "cactus:cactus",
		height = 2,
		height_max = 5,
	}
	def = def or {}
	for k, v in pairs(def) do cactus_def[k] = v end

	minetest.register_decoration(cactus_def)
end

function cactus.add_large_to_biome(biome, def)
	minetest.debug("adding large cactus to "..biome)
	local cactus_def = {
		name = biome..":large_cactus",
		deco_type = "schematic",
		place_on = {"sand:desert"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 4,
		schematic = schematic_path.."cactus_large.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	}

	def = def or {}
	for k, v in pairs(def) do cactus_def[k] = v end

	minetest.register_decoration(cactus_def)
end

function cactus.add_all_to_biome(biome, def)
	cactus.add_to_biome(biome,def)
	cactus.add_large_to_biome(biome,def)
end
