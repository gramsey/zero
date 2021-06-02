-- Copper

local S = minetest.get_translator("copper");

local copper_metal = metal.register_metal("copper", {
	block = {description = S("Copper Block"), png = "copper_block.png"},
	ingot = {description = S("Copper Ingot"), png = "copper_ingot.png"},
	lump =  {description = S("Copper Lump"), png = "copper_lump.png"},
	ore =   {description = S("Copper Ore"), png = "copper_mineral.png"},
})

if (copper_metal.ore ~= nil) then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = copper_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = copper_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = copper_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})
end
