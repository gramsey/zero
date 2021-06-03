
local S = minetest.get_translator("dirt")

dirt.sounds = {
	footstep = {name = "dirt_footstep", gain = 0.4},
	dig = {name = "dirt_dig", gain = 1.0},
	dug = {name = "dirt_footstep", gain = 1.0},
  	place = {name = "dirt_place", gain = 1.0},
}

-- DIRT
minetest.register_node("dirt:dirt", {
    description = S("Dirt"),
    tiles = {"dirt.png"},
    groups = {crumbly = 3, soil = 1, oddly_breakable_by_hand=2, blast_loss = 4},
    sounds = dirt.sounds,
})

minetest.register_node("dirt:dry", {
	description = S("Dry Dirt"),
	tiles = {"dirt_dry.png"},
	groups = {crumbly = 3, soil = 1, oddly_breakable_by_hand=2, blast_loss = 4},
	sounds = dirt.sounds,
})

-- DIRT WITH GRASS
dirt.grass_sounds = table.copy(dirt.sounds)
dirt.grass_sounds.footstep = {name = "dirt_grass_footstep", gain = 0.4}

minetest.register_node("dirt:grass", {
    description = S("Dirt with Grass"),
    tiles = {"dirt_grass.png", "dirt.png", 
		{name = "dirt.png^dirt_grass_side.png", tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spread_to_dirt = 1, oddly_breakable_by_hand=2},
    drop = "dirt:dirt",
    sounds = dirt.grass_sounds,
})

minetest.register_node("dirt:grass_dry", {
	description = S("Dirt with Dry Grass"),
	tiles = {"dirt_grass_dry.png", "dirt_dry.png",
		{name = "dirt_dry.png^dirt_grass_dry_side.png", tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spread_to_dry_dirt = 1, oddly_breakable_by_hand=2},
	drop = "dirt:dry",
	sounds = dirt.grass_sounds,
})

-- FOREST FLOOR DIRT
minetest.register_node("dirt:litter", {
	description = S("Dirt with leaves and twigs"),
	tiles = {
		"dirt_litter.png", "dirt.png",
		{name = "dirt.png^dirt_litter_side.png", tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spread_to_dirt = 1, oddly_breakable_by_hand=2},
	drop = "dirt:dirt",
	sounds = dirt.grass_sounds,
})

minetest.register_node("dirt:dry_litter", {
	description = S("Dirt with dry leaves and twigs"),
	tiles = {
		"dirt_dry_litter.png", "dirt.png",
		{name = "dirt.png^dirt_dry_litter_side.png", tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spread_to_dirt = 1, oddly_breakable_by_hand=2},
	drop = "dirt:dirt",
	sounds = dirt.grass_sounds,
})

-- DIRT WITH SNOW
minetest.register_node("dirt:snow", {
	description = S("Dirt with Snow"),
	tiles = {"dirt_snow.png", "dirt.png",
		{name = "dirt.png^dirt_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spread_to_dirt = 1, snowy = 1, oddly_breakable_by_hand=2},
	drop = "dirt:dirt",
	sounds = dirt.grass_sounds,
})

