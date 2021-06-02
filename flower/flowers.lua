local S = minetest.get_translator("flower")

function flower.add_all_flowers_to_biome(biome)
	local rarity = flower.rarity
	flower.add_to_biome("flower:rose", biome, rarity.uncommon)
	flower.add_to_biome("flower:tulip", biome, rarity.common)
	flower.add_to_biome("flower:dandelion_yellow", biome, rarity.very_common)
	flower.add_to_biome("flower:dandelion_white", biome, rarity.very_common)
	flower.add_to_biome("flower:chrysanthemum", biome, rarity.uncommon)
	flower.add_to_biome("flower:geranium", biome, rarity.uncommon)
	flower.add_to_biome("flower:viola", biome, rarity.uncommon)
	flower.add_to_biome("flower:tulip_black", biome, rarity.rare)
end

flower.register("flower:rose", {
	description = S("Red Rose"),
	tiles = {"flower_rose.png"},
	selection_box = {type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
	},
	color = "red",
})

flower.register("flower:tulip", {
	description = S("Orange Tulip"),
	tiles = {"flower_tulip.png"},
	selection_box = {type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
	},
	color = "orange",
})

flower.register("flower:dandelion_yellow", {
	description = S("Yellow Dandelion"),
	tiles = {"flower_dandelion_yellow.png"},
	selection_box = {type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16},
	},
	color = "yellow",
})

flower.register("flower:dandelion_white", {
	description = S("White Dandelion"),
	tiles = {"flower_dandelion_white.png"},
	selection_box = {type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16},
	},
	color = "white",
})

flower.register("flower:chrysanthemum", {
	description = S("Green Chrysanthemum"),
	tiles = {"flower_chrysanthemum.png"},
	selection_box = {type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
	color = "green",
})

flower.register("flower:geranium", {
	description = S("Blue Geranium"),
	tiles = {"flower_geranium.png"},
	selection_box = {type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
	},
	color = "blue",
})

flower.register("flower:viola", {
	description = S("Viola"),
	tiles = {"flower_viola.png"},
	selection_box = {type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},
	},
	color = "violet",
})

flower.register("flower:tulip_black", {
	description = S("Black Tulip"),
	tiles = {"flower_tulip_black.png"},
	selection_box = {type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
	},
	color = "black",
})

