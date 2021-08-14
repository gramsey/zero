-- farm/nodes.lua

-- support for MT game translation.
local S = minetest.get_translator("farm")

minetest.override_item("dirt:dirt", {
	soil = {
		base = "dirt:dirt",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.override_item("dirt:dry", {
	soil = {
		base = "dirt:dry",
		dry = "farm:dry_soil",
		wet = "farm:dry_soil_wet"
	}
})


minetest.override_item("dirt:grass", {
	soil = {
		base = "dirt:grass",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.override_item("dirt:grass_dry", {
	soil = {
		base = "dirt:grass_dry",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.override_item("dirt:litter", {
	soil = {
		base = "dirt:litter",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.override_item("dirt:dry_litter", {
	soil = {
		base = "dirt:dry_litter",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.register_node("farm:soil", {
	description = S("Soil"),
	tiles = {"dirt.png^farm_soil.png", "dirt.png"},
	drop = "dirt:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = dirt.sounds,
	soil = {
		base = "dirt:dirt",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.register_node("farm:soil_wet", {
	description = S("Wet Soil"),
	tiles = {"dirt.png^farm_soil_wet.png", "dirt.png^farm_soil_wet_side.png"},
	drop = "dirt:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = dirt.sounds,
	soil = {
		base = "dirt:dirt",
		dry = "farm:soil",
		wet = "farm:soil_wet"
	}
})

minetest.register_node("farm:dry_soil", {
	description = S("Savanna Soil"),
	tiles = {"dirt_dry.png^farm_soil.png", "dirt_dry.png"},
	drop = "dirt:dry",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = dirt.sounds,
	soil = {
		base = "dirt:dry",
		dry = "farm:dry_soil",
		wet = "farm:dry_soil_wet"
	}
})

minetest.register_node("farm:dry_soil_wet", {
	description = S("Wet Savanna Soil"),
	tiles = {"dirt_dry.png^farm_soil_wet.png", "dirt_dry.png^farm_soil_wet_side.png"},
	drop = "dirt:dirt_dry",
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = dirt.sounds,
	soil = {
		base = "dirt:dirt_dry",
		dry = "farm:dry_soil",
		wet = "farm:dry_soil_wet"
	}
})

minetest.register_node("farm:straw", {
	description = S("Straw"),
	tiles = {"farm_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = dirt.grass_sounds,
})

-- Registered before the stairs so the stairs get fuel recipes.
minetest.register_craft({
	type = "fuel",
	recipe = "farm:straw",
	burntime = 3,
})

minetest.register_abm({
	label = "Farming soil",
	nodenames = {"group:field"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		local n_def = minetest.registered_nodes[node.name] or nil
		local wet = n_def.soil.wet or nil
		local base = n_def.soil.base or nil
		local dry = n_def.soil.dry or nil
		if not n_def or not n_def.soil or not wet or not base or not dry then
			return
		end

		pos.y = pos.y + 1
		local nn = minetest.get_node_or_nil(pos)
		if not nn or not nn.name then
			return
		end
		local nn_def = minetest.registered_nodes[nn.name] or nil
		pos.y = pos.y - 1

		if nn_def and nn_def.walkable and minetest.get_item_group(nn.name, "plant") == 0 then
			minetest.set_node(pos, {name = base})
			return
		end
		-- check if there is water nearby
		local wet_lvl = minetest.get_item_group(node.name, "wet")
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil and not base node, turn it into wet soil
			if wet_lvl == 0 then
				minetest.set_node(pos, {name = wet})
			end
		else
			-- only turn back if there are no unloaded blocks (and therefore
			-- possible water sources) nearby
			if not minetest.find_node_near(pos, 3, {"ignore"}) then
				-- turn it back into base if it is already dry
				if wet_lvl == 0 then
					-- only turn it back if there is no plant/seed on top of it
					if minetest.get_item_group(nn.name, "plant") == 0 and minetest.get_item_group(nn.name, "seed") == 0 then
						minetest.set_node(pos, {name = base})
					end

				-- if its wet turn it back into dry soil
				elseif wet_lvl == 1 then
					minetest.set_node(pos, {name = dry})
				end
			end
		end
	end,
})

for i = 1, 5 do
	minetest.override_item("grass:grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {"farm:seed_cotton"}, rarity = 8},
			{items = {"farm:seed_wheat"}, rarity = 5},
			{items = {"grass:grass_1"}},
		}
	}})
end

minetest.register_node("farm:cotton_wild", {
	description = S("Wild Cotton"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"farm_cotton_wild.png"},
	inventory_image = "farm_cotton_wild.png",
	wield_image = "farm_cotton_wild.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, attached_node = 1, flammable = 4, oddly_breakable_by_hand = 3},
	drop = "farm:seed_cotton",
	sounds = dirt.grass_sounds,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})
