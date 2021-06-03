local S = minetest.get_translator("grass")

-- DRY GRASS TUFTS
minetest.register_node("grass:dry", {
	description = S("Dry Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_dry_1.png"},
	inventory_image = "grass_dry_3.png",
	wield_image = "grass_dry_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, grass = 1, grass_dry = 1},
	sounds = dirt.grass_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("grass:dry_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("grass:dry " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("grass:dry_" .. i, {
		description = S("Dry Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"grass_dry_" .. i .. ".png"},
		inventory_image = "grass_dry_" .. i .. ".png",
		wield_image = "grass_dry_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, grass_dry = 1},
		drop = "grass:dry",
		sounds = dirt.grass_sounds,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end

-- MAPGEN
local function register_dry_grass_decoration(biome, offset, scale, length)
	minetest.register_decoration({
		name = biome .. ":dry_grass_decoration_" .. length,
		deco_type = "simple",
		place_on = {"dirt:grass_dry"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 429,
			octaves = 3,
			persist = 0.6
		},
		biomes = { biome }, -- one decoration for each biome
		y_max = 31000,
		y_min = 1,
		decoration = "grass:dry_" .. length,
	})
end

function grass.add_dry_to_biome(biome) 
	minetest.debug("adding dry grass decoration")
	register_dry_grass_decoration(biome, -0.03,  0.09,  5)
	register_dry_grass_decoration(biome, -0.015, 0.075, 4)
	register_dry_grass_decoration(biome, 0,      0.06,  3)
	register_dry_grass_decoration(biome, 0.015,  0.045, 2)
	register_dry_grass_decoration(biome, 0.03,   0.03,  1)
end

