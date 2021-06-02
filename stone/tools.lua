
local S = minetest.get_translator("stone")

-- Stone tools
tools.register_pickaxe("stone:pick", {
    description = S("Stone Pickaxe"),
    inventory_image = "stone_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.3,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[2]=2.0, [3]=1.00}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
	recipeitem = "stone:cobble"
})

tools.register_axe("stone:axe", {
    description = S("Stone Axe"),
    inventory_image = "stone_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            choppy={times={[1]=3.00, [2]=2.00, [3]=1.30}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
	recipeitem = "stone:cobble"
})

tools.register_shovel("stone:shovel", {
    description = S("Stone Shovel"),
    inventory_image = "stone_shovel.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
			crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},

        },
        damage_groups = {fleshy=3},
    },
	recipeitem = "stone:cobble"
})

tools.register_sword("stone:sword", {
    description = S("Stone Sword"),
    inventory_image = "stone_sword.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
            snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=4},
    },
	recipeitem = "stone:cobble"
})
