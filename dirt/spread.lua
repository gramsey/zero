
minetest.register_abm({
	label = "Spread to Dirt",
	nodenames = {"dirt:dirt", "dirt:dry"},
	neighbors = {"group:spread_to_dirt", "group:spread_to_dry_dirt"},
	interval = 6,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end
		
		local pos2 = 
			node.name == "dirt:dirt" and minetest.find_node_near(pos, 1, "group:spread_to_dirt")
			or
			node.name == "dirt:dry" and minetest.find_node_near(pos, 1, "group:spread_to_dry_dirt")

		if pos2 then
			minetest.set_node(pos, {name = minetest.get_node(pos2).name})
		end
	end
})

minetest.register_abm({
	label = "Revert to dirt",
	nodenames = {"group:spread_to_dirt", "group:spread_to_dry_dirt"},
	interval = 8,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		if (name == "air") or (name == "ignore") then return end

		local above_def = minetest.registered_nodes[name]

		if above_def and not ((above_def.sunlight_propagates or above_def.paramtype == "light")
				and above_def.liquidtype == "none") then
				
			local node_def = minetest.registered_nodes[node.name]
			if node_def and node_def.groups then
				if node_def.groups.spread_to_dirt == 1 then
					minetest.set_node(pos, {name = "dirt:dirt"})
				else
					minetest.set_node(pos, {name = "dirt:dry"})
				end
			end
		end
	end
})


minetest.register_abm({
	label = "Spread above dirt",
	nodenames = {"group:spread_above_dirt", "group:spread_above_dry_dirt"},
	interval = 11, 
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		
		local under  = {x = pos.x, y = pos.y - 1, z = pos.z}
		local light = minetest.get_node_light(pos)
		if light < 13 then 
			return 
		end

		local node_def = minetest.registered_nodes[node.name]
		local rand_x = math.random(2)*4 - 6
		local rand_z = math.random(2)*4 - 6

		local p1 = {x = rand_x + pos.x - 1, y = pos.y - 2, z = rand_z + pos.z - 1}
		local p2 = {x = rand_x + pos.x + 1, y = pos.y,     z = rand_z + pos.z + 1}

		local targets
		if node_def.groups.spread_above_dirt == 1 then
			targets = minetest.find_nodes_in_area_under_air(p1, p2, {"group:spread_to_dirt", "dirt:dirt"})
		else
			targets = minetest.find_nodes_in_area_under_air(p1, p2, {"group:spread_to_dry_dirt", "dirt:dry"})
		end
		if #targets < 9 then
			return 
		end

		local new_soil = targets[math.random(#targets)]
		local new_pos = {x = new_soil.x, y = new_soil.y + 1, z = new_soil.z}

		minetest.set_node(new_pos, node)
	end
})
