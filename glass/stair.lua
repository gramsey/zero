
stair.register_stair("glass:", { 
	recipeitem = "glass:glass",
	tiles = {
		"glass_stair_split.png", "glass.png",
		"glass_stairside.png^[transformFX", "glass_stairside.png",
		"glass.png", "glass_stair_split.png",
	},
})

stair.register_slab("glass:", { 
	recipeitem = "glass:glass",
	tiles = {"glass.png", "glass.png", "glass_stair_split.png"},
})

stair.register_inner("glass:", { 
	recipeitem = "glass:glass",
	use_texture_alpha = "clip", -- only needed for stairs API
	tiles = {
		"glass_stairside.png^[transformR270", "glass.png",
		"glass_stairside.png^[transformFX", "glass.png",
		"glass.png", "glass_stairside.png"
	},
})

stair.register_outer("glass:", { 
	recipeitem = "glass:glass",
	use_texture_alpha = "clip", -- only needed for stairs API
	tiles = {
		"glass_stairside.png^[transformR90", "glass.png",
		"glass_outer_stairside.png", "glass_stairside.png",
		"glass_stairside.png^[transformR90","glass_outer_stairside.png"
	},
})
