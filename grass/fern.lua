
local S = minetest.get_translator("grass")

minetest.register_node("grass:fern", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"grass_fern_1.png"},
	inventory_image = "grass_fern_1.png",
	wield_image = "grass_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1,
		fern = 1, attached_node = 1},
	sounds = dirt.grass_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("grass:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("grass:fern " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("grass:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"grass_fern_" .. i .. ".png"},
		inventory_image = "grass_fern_" .. i .. ".png",
		wield_image = "grass_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "grass:fern",
		sounds = dirt.grass_sounds,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

local function copy_with_defaults(t, defaults)
	local def_table = table.copy(defaults)

	for k, v in pairs(t) do 
		def_table[k] = v 
	end
	return def_table
end

local function register_fern_decoration(biome, length, def)
	def = def or {}

	local fern_def = {
		name = biome..":fern_" .. length,
		deco_type = "simple",
		place_on = {"dirt:litter", "dirt:dry_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 3823 + length,
			octaves = 3,
			persist = 0.7
		},
		biomes = { biome },
		y_max = 31000,
		y_min = 6,
		decoration = "grass:fern_" .. length,
	}

	fern_def = copy_with_defaults(def, fern_def) 
	minetest.register_decoration(fern_def)
end

function grass.add_fern_to_biome(biome, def) 
	register_fern_decoration(biome, 3, def)
	register_fern_decoration(biome, 2, def)
	register_fern_decoration(biome, 1, def)
end
