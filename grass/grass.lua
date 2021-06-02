
local S = minetest.get_translator("grass")

-- GRASS BLOCK
grass.sounds = table.copy(dirt.sounds)
grass.sounds.footstep = {name = "grass_footstep", gain = 0.4}

minetest.register_node("grass:dirt", {
    description = S("Dirt with Grass"),
    tiles = {"grass.png", "dirt.png", 
		{name = "dirt.png^grass_side.png", tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spread_to_dirt = 1, oddly_breakable_by_hand=2},
    drop = "dirt:dirt",
    sounds = grass.sounds,
})

-- GRASS TUFTS 
minetest.register_node("grass:grass_1", {
	description = S("Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "grass_3.png",
	wield_image = "grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1, oddly_breakable_by_hand=2},
	sounds = grass.sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("grass:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("grass:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("grass:grass_" .. i, {
		description = S("Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"grass_" .. i .. ".png"},
		inventory_image = "grass_" .. i .. ".png",
		wield_image = "grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "grass:grass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1, flammable = 1, oddly_breakable_by_hand=2},
		sounds = grass.sounds,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end

-- MAPGEN
local function register_grass_decoration(biome, offset, scale, length)
	minetest.register_decoration({
		name = biome .. ":grass_decoration_" .. length,
		deco_type = "simple",
		place_on = {"grass:dirt"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = { biome }, -- one decoration for each biome
		y_max = 31000,
		y_min = 1,
		decoration = "grass:grass_" .. length,
	})
end

function grass.add_to_biome(biome) 
	register_grass_decoration(biome, -0.03,  0.09,  5)
	register_grass_decoration(biome, -0.015, 0.075, 4)
	register_grass_decoration(biome, 0,      0.06,  3)
	register_grass_decoration(biome, 0.015,  0.045, 2)
	register_grass_decoration(biome, 0.03,   0.03,  1)
end

