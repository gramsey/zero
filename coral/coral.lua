
local S = minetest.get_translator("coral");

coral.rooted_sounds = dirt.grass_sounds
coral.block_sounds = stone.sounds

local function coral_on_place(itemstack, placer, pointed_thing)
	minetest.debug("coral on place")
	if pointed_thing.type ~= "node" or not placer then
		return itemstack
	end

	local player_name = placer:get_player_name()
	local pos_under = pointed_thing.under
	local pos_above = pointed_thing.above
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
		return def_under.on_rightclick(pos_under, node_under,
				placer, itemstack, pointed_thing) or itemstack
	end

	minetest.debug("coral " .. node_under.name .. " below " .. minetest.get_node(pos_above).name)

	if node_under.name ~= "coral:skeleton" or
			minetest.get_node(pos_above).name ~= "water:source" then
		return itemstack
	end

		if minetest.is_protected(pos_under, player_name) or
			minetest.is_protected(pos_above, player_name) then
		minetest.log("action", player_name
			.. " tried to place " .. itemstack:get_name()
			.. " at protected position "
			.. minetest.pos_to_string(pos_under))
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	node_under.name = itemstack:get_name()
	minetest.set_node(pos_under, node_under)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

local default_rooted = {
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"coral_skeleton.png"},
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "coral:skeleton",
	node_placement_prediction = "",
	sounds = coral.rooted_sounds,
	on_place = coral_on_place,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "coral:skeleton"})
	end,
}

function coral.register_rooted(coral_name, def) 
	local new_def = table.copy(default_rooted)
	for k, v in pairs(def) do new_def[k] = v end
	minetest.register_node(coral_name, new_def)
end

coral.register_rooted("coral:green", {
	description = S("Green Coral"),
	special_tiles = {{name = "coral_green.png", tileable_vertical = true}},
	inventory_image = "coral_green.png",
	wield_image = "coral_green.png",
})

coral.register_rooted("coral:pink", {
	description = S("Pink Coral"),
	special_tiles = {{name = "coral_pink.png", tileable_vertical = true}},
	inventory_image = "coral_pink.png",
	wield_image = "coral_pink.png",
})

coral.register_rooted("coral:cyan", {
	description = S("Cyan Coral"),
	special_tiles = {{name = "coral_cyan.png", tileable_vertical = true}},
	inventory_image = "coral_cyan.png",
	wield_image = "coral_cyan.png",
})

minetest.register_node("coral:brown", {
	description = S("Brown Coral"),
	tiles = {"coral_brown.png"},
	groups = {cracky = 3},
	drop = "coral:skeleton",
	sounds = coral.block_sounds,
})

minetest.register_node("coral:orange", {
	description = S("Orange Coral"),
	tiles = {"coral_orange.png"},
	groups = {cracky = 3},
	drop = "coral:skeleton",
	sounds = coral.block_sounds,
})

minetest.register_node("coral:skeleton", {
	description = S("Coral Skeleton"),
	tiles = {"coral_skeleton.png"},
	groups = {cracky = 3},
	sounds = coral.block_sounds,
})


