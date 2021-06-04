
local S = minetest.get_translator("snow")

minetest.register_node("snow:permafrost", {
	description = S("Permafrost"),
	tiles = {"snow_permafrost.png"},
	groups = {cracky = 3},
	sounds = stone.sounds,
})

minetest.register_node("snow:permafrost_with_stones", {
	description = S("Permafrost with Stones"),
	tiles = {"snow_permafrost.png^stone_stones.png",
		"snow_permafrost.png",
		"snow_permafrost.png^stone_stones_side.png"},
	groups = {cracky = 3},
	sounds = stone.sounds,
})

minetest.register_node("snow:permafrost_with_moss", {
	description = S("Permafrost with Moss"),
	tiles = {"snow_moss.png", "snow_permafrost.png",
		{name = "snow_permafrost.png^snow_moss_side.png",
			tileable_vertical = false}},
	groups = {cracky = 3},
	sounds = stone.sounds,
})

function snow.add_permafrost_to_biome(biome, def)

	local frost_def = {
		name = biome..":permafrost",
		deco_type = "simple",
		place_on = {"default:permafrost_with_stones"},
		sidelen = 4,
		noise_params = {
			offset = -0.8,
			scale = 2.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 53995,
			octaves = 3,
			persist = 1.0
		},
		biomes = { biome },
		y_max = 50,
		y_min = 2,
		decoration = "snow:permafrost_with_moss",
		place_offset_y = -1,
		flags = "force_placement",
	}

	def = def or {}
	for k, v in pairs(def) do 
		frost_def[k] = v 
	end

	minetest.register_decoration(frost_def)
end
