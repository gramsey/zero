
local S = minetest.get_translator("mese");

local mese_metal = metal.register_metal("mese", {
	block = {description = S("Mese Block"), png = "mese_block.png"},
	ore =   {description = S("Mese Ore"), png = "mese_mineral.png", drop = "mese:crystal"},
})

minetest.register_craftitem("mese:crystal", {
	description = S("Mese Crystal"),
	inventory_image = "mese_crystal.png",
})

minetest.register_craftitem("mese:crystal_fragment", {
	description = S("Mese Crystal Fragment"),
	inventory_image = "mese_crystal_fragment.png",
})

-- crafting
minetest.register_craft({
	output = mese_metal.block,
	recipe = {
		{"mese:crystal", "mese:crystal", "mese:crystal"},
		{"mese:crystal", "mese:crystal", "mese:crystal"},
		{"mese:crystal", "mese:crystal", "mese:crystal"},
	}
})

minetest.register_craft({
	output = "mese:crystal",
	recipe = {
		{"mese:crystal_fragment", "mese:crystal_fragment", "mese:crystal_fragment"},
		{"mese:crystal_fragment", "mese:crystal_fragment", "mese:crystal_fragment"},
		{"mese:crystal_fragment", "mese:crystal_fragment", "mese:crystal_fragment"},
	}
})

minetest.register_craft({
	output = "mese:crystal 9",
	recipe = {
		{"mese:mese"},
	}
})

minetest.register_craft({
	output = "mese:crystal_fragment 9",
	recipe = {
		{"mese:crystal"},
	}
})

-- register ores
if (mese_metal.ore ~= nil) then
    minetest.register_ore({
        ore_type       = "scatter",
        ore            = mese_metal.ore,
        wherein        = "mapgen_stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 5,
        clust_size     = 3,
        y_max          = 31000,
        y_min          = 1025,
    })

    minetest.register_ore({
        ore_type       = "scatter",
        ore            = mese_metal.ore,
        wherein        = "mapgen_stone",
        clust_scarcity = 18 * 18 * 18,
        clust_num_ores = 3,
        clust_size     = 2,
        y_max          = -64,
        y_min          = -255,
    })

    minetest.register_ore({
        ore_type       = "scatter",
        ore            = mese_metal.ore,
        wherein        = "mapgen_stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 5,
        clust_size     = 3,
        y_max          = -256,
        y_min          = -31000,                                                                                                                                                                                                             
    })
end

-- tools
if(minetest.get_modpath("tools")) ~= nil then
	minetest.register_tool("mese:pick", {
		description = S("Mese Pickaxe"),
		inventory_image = "mese_pick.png",
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=3,
			groupcaps={
				cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=5},
		},
		sound = tools.sound,
		groups = {pickaxe = 1}
	})

	minetest.register_tool("mese:shovel", {
		description = S("Mese Shovel"),
		inventory_image = "mese_shovel.png",
		wield_image = "mese_shovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=3,
			groupcaps={
				crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=4},
		},
		sound = tools.sound,
		groups = {shovel = 1}
	})

	minetest.register_tool("mese:axe", {
		description = S("Mese Axe"),
		inventory_image = "mese_axe.png",
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
			},
			damage_groups = {fleshy=6},
		},
		sound = tools.sound,
		groups = {axe = 1}
	})

	minetest.register_tool("mese:sword", {
		description = S("Mese Sword"),
		inventory_image = "mese_sword.png",
		tool_capabilities = {
			full_punch_interval = 0.7,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
			},
			damage_groups = {fleshy=7},
		},
		sound = tools.sound,
		groups = {sword = 1}
	})
end
