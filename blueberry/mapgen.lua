
local schematic_path = minetest.get_modpath("blueberry").."/schematics/"

function blueberry.add_to_biome(biome, def)
minetest.debug("adding blueberry to ".. biome)

	local bush_def = {
		name = biome..":blueberry_bush",
		deco_type = "schematic",
		place_on = {"dirt:grass", "dirt:snow"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 697,
			octaves = 3,
			persist = 0.7,
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		place_offset_y = 1,
		schematic = schematic_path .. "blueberry_bush.mts",
		flags = "place_center_x, place_center_z",
	}

	def = def or {}
	for k, v in pairs(def) do bush_def[k] = v end

	minetest.register_decoration(bush_def)
end
