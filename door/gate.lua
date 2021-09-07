
local clearance = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0
local S = minetest.get_translator("door")

door.flip_gate = function(pos, node ) 

	local def = minetest.registered_nodes[node.name]
	local sounds = def and def.sounds or {open = "door_gate_open", close = "door_gate_close"}

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
	drawtype = "mesh",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = true,
	is_ground_content = false,
	buildable_to = false,
	connect_sides = {"left", "right"},
	selection_box = {type = "fixed", fixed = {-1/2, -1/2, -1/4, 1/2, 1/2, 1/4}},
	collision_box = {type = "fixed", fixed = {-1/2, -1/2, -1/8, 1/2, 1/2 + clearance, 1/8}},
	use_texture_alpha = "clip",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	mesh = "door_fencegate_closed.obj",

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if minetest.is_protected(pos, clicker:get_player_name()) then return end
		door.flip_gate(pos,node)
	end,
}

function door.register_gate(name, def) 

	local def_table = table.copy(defaults)

	for k, v in pairs(def) do 
		def_table[k] = v 
	end
	def_table.groups.door = 1
	def_table.tiles = {{name = def.texture, backface_culling = true}}
	def_table.texture = nil

	if def.material then
		minetest.register_craft({
			output = name ,
			recipe = {
				{"group:stick", def.material, "group:stick"},
				{"group:stick", def.material, "group:stick"}
			}
		})
		def_table.material = nil
	end

	minetest.register_node(name, def_table)

	local gate_open = table.copy(def_table)
	gate_open.drop = name			-- drop original fence (not _open)
	gate_open.mesh = "door_fencegate_open.obj"
	gate_open.collision_box = {type = "fixed",
		fixed = {{-1/2, -1/2, -1/8, -3/8, 1/2 + clearance, 1/8},
				 {-1/2, -3/8, -1/2, -3/8, 3/8,             0  }}}
	gate_open.groups.not_in_creative_inventory = 1

	minetest.register_node(name.."_open", gate_open)

end
