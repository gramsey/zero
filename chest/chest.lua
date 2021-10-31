
local S = minetest.get_translator("chest")

-- PUBLIC API functions and properties
chest.open_chests = {}

chest.sounds = wood and wood.sounds or {} 
chest.sounds.open = "chest_open" 
chest.sounds.close = "chest_close" 

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

chest.formspec = 
		"formspec_version[4]" ..
		"size[10.3,11]" ..
		"list[context;main;0.3,0.3;8,4;]" ..
		"list[current_player;main;0.3,6;8,4;]" ..
		"listring[]"

function chest.get_formspec(pos)
	local pos_str = "nodemeta:".. pos.x .. "," .. pos.y .. "," .. pos.z ..";"
	local formspec = chest.formspec:gsub("context;",pos_str)
	return formspec
end

function chest.show_form(pn, pos)
	minetest.show_formspec(pn, "chest:chest_form", chest.get_formspec(pos))
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
	minetest.sound_play(chest.sounds.close, {gain = 0.3, pos = pos,
		max_hear_distance = 10}, true)
end

chest.formspec_callbacks = {}
function chest.on_player_receive_fields(fn)
	table.insert(chest.formspec_callbacks, fn)
end


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

local function is_locked(pos, player)
	return lock and lock.is_locked(pos, player:get_player_name())
end

local def_chest = {
	description = S("Chest"),
	visual = "mesh",
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false,

	tiles = {
		"chest_top.png",
		"chest_top.png",
		"chest_side.png^[transformFX",
		"chest_side.png",
		"chest_side.png",
		"chest_front.png",
	},

	sounds = chest.sounds,

	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	lock_enabled = lock and true,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,

	can_dig = function(pos,player)
		if minetest.is_protected(pos, player:get_player_name()) then return false end

		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, fl,fi,tl,ti, count, player)
		if is_locked(pos, player) then return 0 end
		return count
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if is_locked(pos, player) then return 0 end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_locked(pos, player) then return 0 end
		return stack:get_count()
	end,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if is_locked(pos, clicker) then return end

		local def = minetest.registered_nodes[node.name]

		minetest.sound_play(def.sounds.open, 
			{gain = 0.3, pos = pos, max_hear_distance = 10}, true)

		if not chest.chest_lid_obstructed(pos) then
			minetest.swap_node(pos, {name = node.name.."_open", param2 = node.param2})
		end

		minetest.after(0.2, chest.show_form, clicker:get_player_name(), pos)

		chest.open_chests[clicker:get_player_name()] = { pos = pos,
				sound = def.sound_close, swap = node.name }
	end,

	after_place_node = function(pos, placer) 
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name() or ""
		meta:set_string("owner", owner)

		if old_after_place_node then 
			old_after_place_node(pos, placer)
		end
	end,

	on_blast = function(pos)

		if lock.is_locked(pos) then return end

		local drops = {}
		get_inventory_drops(pos, "main", drops)
		drops[#drops+1] = def.name
		minetest.remove_node(pos)
		return drops
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to chest at " .. minetest.pos_to_string(pos))
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes " .. stack:get_name() ..
			" from chest at " .. minetest.pos_to_string(pos))
	end,
}


local def_opened = {
	drawtype = "mesh",
	mesh = "chest_open.obj",

	tiles = {
		{name = "chest_top.png", backface_culling = true},
		{name = "chest_top.png", backface_culling = true},
		{name = "chest_side.png", backface_culling = true},
		{name = "chest_side.png", backface_culling = true},
		{name = "chest_front.png", backface_culling = true},
		{name = "chest_inside.png", backface_culling = true}
	},

	groups = {not_in_creative_inventory = 1},

	selection_box = {
		type = "fixed",
		fixed = { -1/2, -1/2, -1/2, 1/2, 3/16, 1/2 },
	},

	can_dig = function() return false end,
	on_blast = function() end,
}


function chest.register_chest(prefixed_name, d_chest, d_open)
	d_chest = d_chest or {} -- def properties applied to both open and closed chests
	d_open = d_open or {} -- def properties only applied to open chest (overrides)

	-- set defaults
	local def_cl = table.copy(def_chest)
	local def_op = table.copy(def_cl)
	for k, v in pairs(def_opened) do def_op[k] = v end

	-- apply custom from parameters
	for k, v in pairs(d_chest) do def_cl[k] = v end
	for k, v in pairs(d_chest) do def_op[k] = v end
	for k, v in pairs(d_open) do def_op[k] = v end

	-- register chest
	minetest.register_node(prefixed_name, def_cl)
	minetest.register_node(prefixed_name .. "_open", def_op)
end


minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname ~= "chest:chest_form" then return end
	if not player then return end

	local pn = player:get_player_name()
	if not chest.open_chests[pn] then return end

	local pos = chest.open_chests[pn].pos 

	local callbacks = chest.formspec_callbacks

	for i = 1, #callbacks do
		callbacks[i](player, pos, fields)
	end

	return true
end)

minetest.register_on_leaveplayer(function(player)
	local pn = player:get_player_name()
	if chest.open_chests[pn] then
		chest.chest_lid_close(pn)
	end
end)

-- register default chest
chest.register_chest("chest:chest")

chest.on_player_receive_fields(function(player, pos, fields) 
	if not fields.quit then return end
	local pn = player:get_player_name()
	chest.chest_lid_close(pn)
end)

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
