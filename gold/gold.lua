-- Gold
local S = minetest.get_translator("gold");

local gold_metal = metal.register_metal("gold", {
	block = {description = S("Gold Block"), png = "gold_block.png"},
	ingot = {description = S("Gold Ingot"), png = "gold_ingot.png"},
	lump =  {description = S("Gold Lump"), png = "gold_lump.png"},
	ore =   {description = S("Gold Ore"), png = "gold_mineral.png"},
})

if (gold_metal.ore ~= nil) then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = gold_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = gold_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -256,
		y_min          = -511,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = gold_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -512,
		y_min          = -31000,
	})
end
