-- bronze
local S = minetest.get_translator("bronze");

local bronze_metal = metal.register_metal("bronze", {
	block = {description = S("Bronze Block"), png = "bronze_block.png"},
	ingot = {description = S("Bronze Ingot"), png = "bronze_ingot.png"},
})

minetest.register_craft({
       output = "bronze:ingot 9",
       recipe = {
               {"copper:ingot", "copper:ingot", "copper:ingot"},
               {"copper:ingot", "tin:ingot",    "copper:ingot"},
               {"copper:ingot", "copper:ingot", "copper:ingot"},
       }
})

-- tools 

if(minetest.get_modpath("tools")) ~= nil then

	tools.register_pickaxe("bronze:pick", {
		description = S("Bronze Pickaxe"),
		inventory_image = "bronze_pick.png",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[1]=4.50, [2]=1.80, [3]=0.90}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
		recipeitem = bronze_metal.ingot,
	})
	
	tools.register_shovel("bronze:shovel", {
		description = S("Bronze Shovel"),
		inventory_image = "bronze_shovel.png",
		wield_image = "bronze_shovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.1,
			max_drop_level=1,
			groupcaps={
				crumbly = {times={[1]=1.65, [2]=1.05, [3]=0.45}, uses=25, maxlevel=2},
			},
			damage_groups = {fleshy=3},
		},
		recipeitem = bronze_metal.ingot,
	})

	tools.register_axe("bronze:axe", {
		description = S("Bronze Axe"),
		inventory_image = "bronze_axe.png",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=2.75, [2]=1.70, [3]=1.15}, uses=20, maxlevel=2},
			},
			damage_groups = {fleshy=4},
		},
		recipeitem = bronze_metal.ingot,
	})

	tools.register_sword("bronze:sword", {
		description = S("Bronze Sword"),
		inventory_image = "bronze_sword.png",
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level=1,
			groupcaps={
				snappy={times={[1]=2.75, [2]=1.30, [3]=0.375}, uses=25, maxlevel=2},
			},
			damage_groups = {fleshy=6},
		},
		recipeitem = bronze_metal.ingot,
	})

end
