
local S = minetest.get_translator("door")

door.flip_trapdoor = function(pos, node ) 
	local def = minetest.registered_nodes[node.name]
	local sounds = def and def.sounds or {open = "door_trapdoor_open", close = "door_trapdoor_close"}

	if node.name:find "_open$" then
		minetest.sound_play(sounds.close, sound_settings)
		node.name = node.name:gsub("_open$","")
	else
		minetest.sound_play(sounds.open, sound_settings)
		node.name = node.name .. "_open"
	end

	minetest.swap_node(pos, {name = node.name, param1 = node.param1, param2 = node.param2})
end

local defaults = {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = true,
	is_ground_content = false,
	buildable_to = false,
	connect_sides = {"left", "right"},
	node_box = {type="fixed", fixed={-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}},
	selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -6/16, 0.5}},
	use_texture_alpha = "clip",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if minetest.is_protected(pos, clicker:get_player_name()) then return end
		door.flip_trapdoor(pos,node)
	end,
}

function door.register_trapdoor(name, def) 
	local front = def.tile_front
	local frontTF = front..'^[transform'
	local side = def.tile_front
	local sideTF = side..'^[transform'
	def.tile_front = nil
	def.tile_side = nil

	local trap = table.copy(defaults)

	for k, v in pairs(def) do 
		trap[k] = v 
	end
	trap.groups.door = 1

	trap.tiles = {front, frontTF..'FY', side, side, side, side}

	minetest.register_node(name, trap)

	local trap_open = table.copy(trap)
	trap_open.drop = name			-- drop original fence (not _open)
	trap_open.node_box = {type="fixed", fixed={-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}}
	trap_open.selection_box = {type="fixed", fixed={-0.5, -0.5, 6/16, 0.5, 0.5, 0.5}}
	trap_open.groups.not_in_creative_inventory = 1
	trap_open.tiles = {side, sideTF.."2", sideTF.."3", sideTF.."1", frontTF.."46", frontTF.."6"}

	minetest.register_node(name.."_open", trap_open)
end

