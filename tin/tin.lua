
local S = minetest.get_translator("tin");

local tin_metal = metal.register_metal("tin", {
	block = {description = S("Tin Block"), png = "tin_block.png"},
	ingot = {description = S("Tin Ingot"), png = "tin_ingot.png"},
	lump =  {description = S("Tin Lump"), png = "tin_lump.png"},
	ore =   {description = S("Tin Ore"), png = "tin_mineral.png"},
})

if (tin_metal.ore ~= nil) then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = tin_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = tin_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = tin_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})
end
