local S = minetest.get_translator("farm")

-- Wheat

farm.register_plant("farm:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "farm_wheat_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = minetest.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_craftitem("farm:flour", {
	description = S("Flour"),
	inventory_image = "farm_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("farm:bread", {
	description = S("Bread"),
	inventory_image = "farm_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "farm:flour",
	recipe = {"farm:wheat", "farm:wheat", "farm:wheat", "farm:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farm:bread",
	recipe = "farm:flour"
})


-- Cotton

farm.register_plant("farm:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "farm_cotton_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = minetest.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

function farm.add_cotton_to_biome(biome, dirt)
	minetest.debug("registering decoration cotton on ", biome, " and ", dirt) 
	minetest.register_decoration({
		name = biome..":cotton_wild",
		deco_type = "simple",
		place_on = {dirt},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 50, y = 50, z = 50},
			seed = 4242,
			octaves = 3,
			persist = 0.7
		},
		biomes = {biome},
		y_max = 31000,
		y_min = 1,
		decoration = "farm:cotton_wild",
	})
end

minetest.register_craftitem("farm:string", {
	description = S("String"),
	inventory_image = "farm_string.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farm:cotton", "farm:cotton"},
		{"farm:cotton", "farm:cotton"},
	}
})

minetest.register_craft({
	output = "farm:string 2",
	recipe = {
		{"farm:cotton"},
		{"farm:cotton"},
	}
})


-- Straw

minetest.register_craft({
	output = "farm:straw 3",
	recipe = {
		{"farm:wheat", "farm:wheat", "farm:wheat"},
		{"farm:wheat", "farm:wheat", "farm:wheat"},
		{"farm:wheat", "farm:wheat", "farm:wheat"},
	}
})

minetest.register_craft({
	output = "farm:wheat 3",
	recipe = {
		{"farm:straw"},
	}
})


-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "farm:wheat",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farm:cotton",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farm:string",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farm:hoe_wood",
	burntime = 5,
})


-- Register farming items as dungeon loot

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "farm:string", chance = 0.5, count = {1, 8}},
		{name = "farm:wheat", chance = 0.5, count = {2, 5}},
		{name = "farm:seed_cotton", chance = 0.4, count = {1, 4},
			types = {"normal"}},
	})
end
