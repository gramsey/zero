
local S = minetest.get_translator("wood")

tools.register_pickaxe("wood:pick", {
    description = S("Wooden Pickaxe"),
    inventory_image = "wood_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
			cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
	groups = {pickaxe = 1, flammable = 2},
	recipeitem = "group:wood",
})

tools.register_axe("wood:axe", {
    description = S("Wooden Axe"),
    inventory_image = "wood_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
			choppy = {times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
	groups = {axe = 1, flammable = 2},
	
	recipeitem = "group:wood"
})

tools.register_shovel("wood:shovel", {
    description = S("Wooden Shovel"),
    inventory_image = "wood_shovel.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level=0,
        groupcaps={
			crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
	groups = {shovel = 1, flammable = 2},
	recipeitem = "group:wood"
})

tools.register_sword("wood:sword", {
    description = S("Wooden Sword"),
    inventory_image = "wood_sword.png",
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level=0,
        groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
	groups = {sword = 1, flammable = 2},
	recipeitem = "group:wood"
})
