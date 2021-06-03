
local S = minetest.get_translator("grass")

-- GRASS TUFTS 
minetest.register_node("grass:jungle", {
	description = S("Jungle Grass"),
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.69,
	tiles = {"grass_jungle.png"},
	inventory_image = "grass_jungle.png",
	wield_image = "grass_jungle.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
	sounds = wood.leaves_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

-- MAPGEN
function grass.add_jungle_to_biome(biome, def) 
	def = def or {}

	local def_table = {
		name = biome..":jungle_grass",
		deco_type = "simple",
		place_on = {"dirt:litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = {biome},
		y_max = 31000,
		y_min = 1,
		decoration = "grass:jungle",
	}

	local def_table = table.copy(def_table)

	for k, v in pairs(def) do 
		def_table[k] = v 
	end

	minetest.register_decoration(def_table)

end

minetest.register_craft({
	type = "fuel",
	recipe = "grass:jungle",
	burntime = 3,
})
