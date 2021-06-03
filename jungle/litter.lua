local S = minetest.get_translator("jungle")

minetest.register_node("jungle:litter", {
	description = S("Dirt with Rainforest Litter"),
	tiles = {
		"jungle_litter.png",
		"dirt.png",
		{name = "dirt.png^jungle_litter_side.png", tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "dirt:dirt",
	sounds = grass.sounds,
})
