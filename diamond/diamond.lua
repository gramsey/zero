local S = minetest.get_translator("diamond");

minetest.register_node("diamond:ore", {
	description = S("Diamond Ore"),
	tiles = {"stone.png^diamond_mineral.png"},
	groups = {cracky = 1},
	drop = "diamond:diamond",
	sounds = stone.sounds,
})
minetest.register_node("diamond:block", {
	description = S("Diamond Block"),
	tiles = {"diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = stone.sounds,
})

-- crafting
minetest.register_craftitem("diamond:diamond", {
	description = S("Diamond"),
	inventory_image = "diamond.png",
})

minetest.register_craft({
	output = "diamond:diamond 9",
	recipe = {
		{"diamond:block"},
	}
})

minetest.register_craft({
	output = "diamond:block",
	recipe = {
		{"diamond:diamond", "diamond:diamond", "diamond:diamond"},
		{"diamond:diamond", "diamond:diamond", "diamond:diamond"},
		{"diamond:diamond", "diamond:diamond", "diamond:diamond"},
	}
})

-- ore distribution
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "diamond:ore",
	wherein        = "mapgen_stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "diamond:ore",
	wherein        = "mapgen_stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -1024,
	y_min          = -2047,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "diamond:ore",
	wherein        = "mapgen_stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -2048,
	y_min          = -31000,
})

-- tools

if(minetest.get_modpath("tools")) ~= nil then

	tools.register_pickaxe("diamond:pick", {
		description = S("Diamond Pickaxe"),
		inventory_image = "diamond_pick.png",
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=3,
			groupcaps={
				cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=5},
		},
		recipeitem = "diamond:diamond",
	})

	tools.register_shovel("diamond:shovel", {
		description = S("Diamond Shovel"),
		inventory_image = "diamond_shovel.png",
		wield_image = "diamond_shovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=4},
		},
		recipeitem = "diamond:diamond",
	})

	tools.register_axe("diamond:axe", {
		description = S("Diamond Axe"),
		inventory_image = "diamond_axe.png",
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=7},
		},
		recipeitem = "diamond:diamond",
	})

	tools.register_sword("diamond:sword", {
		description = S("Diamond Sword"),
		inventory_image = "diamond_sword.png",
		tool_capabilities = {
			full_punch_interval = 0.7,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
			},
			damage_groups = {fleshy=8},
		},
		recipeitem = "diamond:diamond",
	})
end
