
local S = minetest.get_translator("mushroom")

minetest.register_node("mushroom:red", {
	description = S("Red Mushroom"),
	tiles = {"mushroom_red.png"},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {mushroom = 1, snappy = 3, oddly_breakable_by_hand=3, attached_node = 1, flammable = 1},
	sounds = dirt.sounds,
	on_use = minetest.item_eat(-5),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

minetest.register_node("mushroom:brown", {
	description = S("Brown Mushroom"),
	tiles = {"mushroom_brown.png"},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {mushroom = 1, food_mushroom = 1, snappy = 3, oddly_breakable_by_hand=3, attached_node = 1, flammable = 1},
	sounds = dirt.sounds,
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
})

function mushroom.add_to_biome(mushroom_name, biome)
	minetest.register_decoration({
		name = biome..":"..mushroom_name:gsub(":","_"),
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 1,
		decoration = mushroom_name,
	})
end

function mushroom.add_all_to_biome(biome)
	mushroom.add_to_biome("mushroom:red", biome)
	mushroom.add_to_biome("mushroom:brown", biome)
end
