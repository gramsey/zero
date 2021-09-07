
local S = minetest.get_translator("door")

door.flip = function(pos, node ) 
	if node.name:find "_flip$" then
		node.name = node.name:gsub("_flip$","")
	else
		node.name = node.name .. "_flip"
	end
	minetest.swap_node(pos, {name = node.name, param1 = node.param1, param2 = node.param2})
end

door.toggle = function(pos, node ) 
	if node.name:find "_flip$" then
		node.name = node.name:gsub("_flip$","")
		node.param2 = (node.param2 - 1) % 4
	else
		node.name = node.name .. "_flip"
		node.param2 = (node.param2 + 1) % 4
	end

	local meta = minetest.get_meta(pos)
	local is_open = meta:get_int("is_open") or 0

	local sound_settings = {pos = pos, gain = 0.3, max_hear_distance = 10}
	local def = minetest.registered_nodes[node.name]
	local sounds = def and def.sounds or {open = "door_open", close = "door_close"}

	if is_open == 0 then
		minetest.sound_play(sounds.open, sound_settings)
	else
		minetest.sound_play(sounds.close, sound_settings)
	end

	meta:set_int("is_open", (is_open + 1) % 2)
	minetest.swap_node(pos, {name = node.name, param1 = node.param1, param2 = node.param2})
end

local can_place_door = function(pointed_thing)

	if pointed_thing.type ~= "node" then return false end

	local u_pos = pointed_thing.under
	local a_pos = pointed_thing.above

	local u_node = minetest.get_node(u_pos)
	local a_node = minetest.get_node(a_pos)

	local u_def = minetest.registered_nodes[u_node.name]
	local a_def = minetest.registered_nodes[a_node.name]

	if a_def and u_def then
		if a_def.buildable_to and u_def.buildable_to then
			return true
		elseif a_def.buildable_to and not u_def.buildable_to then
			local one_up = minetest.get_node({x = a_pos.x, y = a_pos.y + 1, z = a_pos.z})
			local top_def = minetest.registered_nodes[one_up.name]
			if top_def and top_def.buildable_to then return true end
		end
	end
	return false
end

local place_door = function(itemstack, placer, pointed_thing, param2)
	local u_pos = pointed_thing.under
	local a_pos = pointed_thing.above
	local u_node = minetest.get_node(u_pos)
	local u_def = minetest.registered_nodes[u_node.name]

	local newstack, placed_at = minetest.item_place(itemstack, placer, pointed_thing, param2) 

	if not placed_at then return itemstack, nil end
	
	local door_node = minetest.get_node(placed_at)
	local one_up = {x = placed_at.x, y = placed_at.y+1, z = placed_at.z}

	minetest.set_node(one_up, {name = "door:hidden", param2 = door_node.param2})

	return newstack, placed_at
end


function door.register(name, def) 
	local def_table = {
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = true,
		is_ground_content = false,
		buildable_to = false,
		selection_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
		collision_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
		use_texture_alpha = "clip",
		groups = {door = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		mesh = "door.obj",

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if minetest.is_protected(pos, clicker:get_player_name()) then return end
			door.toggle(pos,node)
		end,

		on_place = function(itemstack, placer, pointed_thing, param2)
			if can_place_door(pointed_thing) then
				return place_door(itemstack, placer, pointed_thing, param2) 
			end
			local unplaceable = ItemStack("unknown") 
			minetest.item_place(unplaceable, placer, pointed_thing, param2)
			return itemstack, nil
		end,
		
		after_dig_node = function(pos, node, meta, digger)
			minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
			minetest.check_for_falling({x = pos.x, y = pos.y + 1, z = pos.z})
		end,

		on_rotate = function(pos, node, user, mode, new_param2)
			door.flip(pos, node)
			return true
		end,
	}
	
	if def.material then 
		minetest.register_craft({
			output = name,
			recipe = {
				{def.material, def.material},
				{def.material, def.material},
				{def.material, def.material},
			}
		})
		def.material = nil
	end

	for k, v in pairs(def) do def_table[k] = v end

	minetest.register_node(name, def_table)

	local def_flip = table.copy(def_table)
	-- create mirror image for left-hand doors
	local flip_tiles = {}
	for _, t in pairs(def.tiles) do
		if type(t) == "table" then
			local t_flip = table.copy(t)
			t_flip.name = t_flip.name.."^[transformFX"
			table.insert(flip_tiles, t_flip)
		else
			table.insert(flip_tiles, t.."^[transformFX")
		end
	end
	def_flip.tiles = flip_tiles

	minetest.register_node(name .. "_flip", def_flip)
end
