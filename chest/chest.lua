
local S = minetest.get_translator("chest")

local function get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

function chest.get_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]" ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" 
	return formspec
end

function chest.chest_lid_obstructed(pos)
	local above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local def = minetest.registered_nodes[minetest.get_node(above).name]
	-- allow ladders, signs, wallmounted things and torches to not obstruct
	if def and
			(def.drawtype == "airlike" or
			def.drawtype == "signlike" or
			def.drawtype == "torchlike" or
			(def.drawtype == "nodebox" and def.paramtype2 == "wallmounted")) then
		return false
	end
	return true
end

function chest.chest_lid_close(pn)
	local chest_open_info = chest.open_chests[pn]
	local pos = chest_open_info.pos
	local sound = chest_open_info.sound
	local swap = chest_open_info.swap

	chest.open_chests[pn] = nil
	for k, v in pairs(chest.open_chests) do
		if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
			return true
		end
	end

	local node = minetest.get_node(pos)
	minetest.after(0.2, minetest.swap_node, pos, { name = swap,
			param2 = node.param2 })
	minetest.sound_play(sound, {gain = 0.3, pos = pos,
		max_hear_distance = 10}, true)
end

chest.open_chests = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "chest:chest" then
		return
	end
	if not player or not fields.quit then
		return
	end
	local pn = player:get_player_name()

	if not chest.open_chests[pn] then
		return
	end

	chest.chest_lid_close(pn)
	return true
end)

minetest.register_on_leaveplayer(function(player)
	local pn = player:get_player_name()
	if chest.open_chests[pn] then
		chest.chest_lid_close(pn)
	end
end)

local function is_locked(pos, player)
	return lock and lock.is_locked(pos, player:get_player_name())
end

function chest.register_chest(prefixed_name, d)
	local name = prefixed_name:sub(1,1) == ':' and prefixed_name:sub(2,-1) or prefixed_name
	local def = table.copy(d)
	def.drawtype = "mesh"
	def.visual = "mesh"
	def.paramtype = "light"
	def.paramtype2 = "facedir"
	def.legacy_facedir_simple = true
	def.is_ground_content = false
	def.on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", def.description)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end
	def.can_dig = function(pos,player)
		if minetest.is_protected(pos, player:get_player_name()) then return false end

		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end
	def.allow_metadata_inventory_move = function(pos, fl,fi,tl,ti, count, player)
		if is_locked(pos, player) then return 0 end
		return count
	end
	def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if is_locked(pos, player) then return 0 end
		return stack:get_count()
	end
	def.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_locked(pos, player) then return 0 end
		return stack:get_count()
	end
	def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if is_locked(pos, clicker) then return end

		minetest.sound_play(def.sound_open, 
			{gain = 0.3, pos = pos, max_hear_distance = 10}, true)

		if not chest.chest_lid_obstructed(pos) then
			minetest.swap_node(pos, {name = name.."_open", param2 = node.param2})
		end
		minetest.after(0.2, minetest.show_formspec, clicker:get_player_name(),
				"chest:chest", chest.get_chest_formspec(pos))

		chest.open_chests[clicker:get_player_name()] = { pos = pos,
				sound = def.sound_close, swap = name }
	end

	local old_after_place_node = def.after_place_node

	def.after_place_node = function(pos, placer) 
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name() or ""
		meta:set_string("owner", owner)

		if old_after_place_node then 
			old_after_place_node(pos, placer)
		end
	end
	if not def.on_blast then 
		def.on_blast = function(pos)

			if lock.is_locked(pos) then return end

			local drops = {}
			get_inventory_drops(pos, "main", drops)
			drops[#drops+1] = def.name
			minetest.remove_node(pos)
			return drops
		end
	end
	def.on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end
	def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to chest at " .. minetest.pos_to_string(pos))
	end
	def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes " .. stack:get_name() ..
			" from chest at " .. minetest.pos_to_string(pos))
	end

	local def_opened = table.copy(def)
	local def_closed = table.copy(def)

	def_opened.mesh = "chest_open.obj"
	for i = 1, #def_opened.tiles do
		if type(def_opened.tiles[i]) == "string" then
			def_opened.tiles[i] = {name = def_opened.tiles[i], backface_culling = true}
		elseif def_opened.tiles[i].backface_culling == nil then
			def_opened.tiles[i].backface_culling = true
		end
	end
	def_opened.drop = name
	def_opened.groups.not_in_creative_inventory = 1
	def_opened.selection_box = {
		type = "fixed",
		fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
	}
	def_opened.can_dig = function()
		return false
	end
	def_opened.on_blast = function() end

	def_closed.mesh = nil
	def_closed.drawtype = nil
	def_closed.tiles[6] = def.tiles[5] -- swap textures around for "normal"
	def_closed.tiles[5] = def.tiles[3] -- drawtype to make them match the mesh
	def_closed.tiles[3] = def.tiles[3].."^[transformFX"

	minetest.register_node(prefixed_name, def_closed)
	minetest.register_node(prefixed_name .. "_open", def_opened)
end

-- register chest item
chest.register_chest("chest:chest", {
	description = S("Chest"),
	tiles = {
		"chest_top.png",
		"chest_top.png",
		"chest_side.png",
		"chest_side.png",
		"chest_front.png",
		"chest_inside.png"
	},
	sounds = wood.sounds,
	sound_open = "chest_open",
	sound_close = "chest_close",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	lock_enabled = true,
})


minetest.register_craft({
	output = "chest:chest",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "chest:chest",
	burntime = 30,
})
