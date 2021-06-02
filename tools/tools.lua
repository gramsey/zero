
-- expose sound for other mods
tools.sound = {
	breaks = "tools_breaks",
}

-- PICK
function tools.register_pickaxe(name , o)

	o.tool_capabilities = o.tool_capabilities or {};  

	minetest.register_tool(name, {
		description = o.description or S("Pickaxe"),
		inventory_image = o.inventory_image,
		wield_image = o.wield_image,
		tool_capabilities = {
			full_punch_interval = o.tool_capabilities.full_punch_interval or 1.2,
			max_drop_level= o.tool_capabilities.max_drop_level or 0,
			groupcaps= o.tool_capabilities.groupcaps or {
				cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
			},
			damage_groups = o.tool_capabilities.damage_groups or {fleshy=2},
		},
		sound = o.sound or tools.sound,
		groups = o.groups or {pickaxe = 1}
	})

	if o.recipeitem then
		minetest.register_craft({
			output = name,
			recipe = {
				{o.recipeitem, 	o.recipeitem, 	o.recipeitem},
				{"", 			"group:stick", 	""},
				{"", 			"group:stick", 	""},
			},
		})
	end
end

-- SHOVEL
function tools.register_shovel(name , o)

	o.tool_capabilities = o.tool_capabilities or {};  

	minetest.register_tool(name, {
		description = o.description or S("Shovel"),
		inventory_image = o.inventory_image,
		wield_image = o.wield_image or o.inventory_image .. "^[transformR90",
		tool_capabilities = {
			full_punch_interval = o.tool_capabilities.full_punch_interval or 1.2,
			max_drop_level= o.tool_capabilities.max_drop_level or 0,
			groupcaps= o.tool_capabilities.groupcaps or {
				crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
			},
			damage_groups = o.tool_capabilities.damage_groups or {fleshy=2},
		},
		sound = o.sound or {breaks = tools.sound.breaks},
		groups = o.groups or {shovel = 1}
	})

	if o.recipeitem then
		minetest.register_craft({
			output = name,
			recipe = {
				{o.recipeitem},
				{"group:stick"},
				{"group:stick"},
			},
		})
	end
end

-- AXE
function tools.register_axe(name , o)

	o.tool_capabilities = o.tool_capabilities or {};  

	minetest.register_tool(name, {
		description = o.description or S("Axe"),
		inventory_image = o.inventory_image,
		wield_image = o.wield_image,
		tool_capabilities = {
			full_punch_interval = o.tool_capabilities.full_punch_interval or 1.0,
			max_drop_level= o.tool_capabilities.max_drop_level or 0,
			groupcaps= o.tool_capabilities.groupcaps or {
				choppy = {times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1},
			},
			damage_groups = o.tool_capabilities.damage_groups or {fleshy=2},
		},
		sound = o.sound or {breaks = tools.sound.breaks},
		groups = o.groups or {shovel = 1}
	})

	if o.recipeitem then
		minetest.register_craft({
			output = name,
			recipe = {
				{o.recipeitem, 	o.recipeitem},
				{o.recipeitem, 	"group:stick"},
				{"", 			"group:stick"},
			},
		})
	end
end

-- SWORD
function tools.register_sword(name , o)

	o.tool_capabilities = o.tool_capabilities or {};  

	minetest.register_tool(name, {
		description = o.description or S("Sword"),
		inventory_image = o.inventory_image,
		wield_image = o.wield_image,
		tool_capabilities = {
			full_punch_interval = o.tool_capabilities.full_punch_interval or 1,
			max_drop_level= o.tool_capabilities.max_drop_level or 0,
			groupcaps= o.tool_capabilities.groupcaps or {
				snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
			},
			damage_groups = o.tool_capabilities.damage_groups or {fleshy=2},
		},
		sound = o.sound or tools.sound,
		groups = o.groups or {sword = 1}
	})

	if o.recipeitem then
		minetest.register_craft({
			output = name,
			recipe = {
				{o.recipeitem},
				{o.recipeitem},
				{"group:stick"},
			},
		})
	end
end
