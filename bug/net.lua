local S = minetest.get_translator("bug")

-- bug net
minetest.register_tool("bug:net", {
	description = S("Bug Net"),
	inventory_image = "bug_net.png",
	on_use = function(itemstack, player, pointed_thing)
		local player_name = player and player:get_player_name() or ""
		if not pointed_thing or pointed_thing.type ~= "node" or
				minetest.is_protected(pointed_thing.under, player_name) then
			return
		end
		local node_name = minetest.get_node(pointed_thing.under).name
		local inv = player:get_inventory()
		if minetest.get_item_group(node_name, "catchable") == 1 then
			minetest.set_node(pointed_thing.under, {name = "air"})
			local stack = ItemStack(node_name.." 1")
			local leftover = inv:add_item("main", stack)
			if leftover:get_count() > 0 then
				minetest.add_item(pointed_thing.under, node_name.." 1")
			end
		end
		if not minetest.is_creative_enabled(player_name) then
			itemstack:add_wear(256)
			return itemstack
		end
	end
})

minetest.register_craft( {
	output = "bug:net",
	recipe = {
		{"wool:string", "wool:string"},
		{"wool:string", "wool:string"},
		{"group:stick", ""}
	}
})

