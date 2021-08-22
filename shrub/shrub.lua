
local S = minetest.get_translator("shrub")

minetest.register_node("shrub:dry", {
	description = S("Dry Shrub"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"shrub_dry.png"},
	inventory_image = "shrub_dry.png",
	wield_image = "shrub_dry.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = wood.leaves_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})

local schematic_path = minetest.get_modpath("shrub").."/schematics/"

function shrub.add_to_biome(biome, def)

	local shrub_def = {
		name = biome..":dry_shrub",
		deco_type = "simple",
		place_on = {"sand:desert", "sand:sand", "sand:silver"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 2,
		decoration = "shrub:dry",
		param2 = 4,
	}

	def = def or {}
	for k, v in pairs(def) do shrub_def[k] = v end

	minetest.register_decoration(shrub_def)
end
