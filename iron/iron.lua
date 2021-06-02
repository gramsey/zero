
local S = minetest.get_translator("iron");

local iron_metal = metal.register_metal("iron", {
	block = {description = S("Steel Block"), png = "iron_block.png"},
	ingot = {description = S("Steel Ingot"), png = "iron_ingot.png"},
	lump =  {description = S("Iron Lump"), png = "iron_lump.png"},
	ore =   {description = S("Iron Ore"), png = "iron_mineral.png"}
})

if (iron_metal.ore ~= nil) then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = iron_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 12,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = iron_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = iron_metal.ore,
		wherein        = "mapgen_stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 29,
		clust_size     = 5,
		y_max          = -256,
		y_min          = -31000,
	})
end

if(minetest.get_modpath("tools")) ~= nil then

	tools.register_pickaxe("iron:pick", {
		description = S("Steel Pickaxe"),
		inventory_image = "iron_pick.png",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
		recipeitem = iron_metal.ingot,
	})

	tools.register_shovel("iron:shovel", {
		description = S("Steel Shovel"),
		inventory_image = "iron_shovel.png",
		wield_image = "iron_shovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.1,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
			},
			damage_groups = {fleshy=3},
		},
		recipeitem = iron_metal.ingot,
	})

	tools.register_axe("iron:axe", {
		description = S("Steel Axe"),
		inventory_image = "iron_axe.png",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
		recipeitem = iron_metal.ingot,
	})

	tools.register_sword("iron:sword", {
		description = S("Steel Sword"),
		inventory_image = "iron_sword.png",
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
			},
			damage_groups = {fleshy=6},
		},
		recipeitem = iron_metal.ingot,
	})
end
