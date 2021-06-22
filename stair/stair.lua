
local S = minetest.get_translator("stair")

function stair.register(prefix, def)
	
	local recipeitem = def.recipeitem
	def.recipeitem = nil

	local defaults = {
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			minetest.debug("rotate and place")
			return minetest.rotate_and_place(itemstack, placer, pointed_thing)
		end,
	}

	def = def or {}
	for k, v in pairs(def) do defaults[k] = v end

	if recipeitem then
		node_def = minetest.registered_nodes[recipeitem]

		defaults.description = defaults.description or node_def.description
		defaults.tiles = defaults.tiles or node_def.tiles
		defaults.groups = defaults.groups or node_def.groups
		defaults.sounds = defaults.sounds or node_def.sounds
	end

	local stair_def = table.copy(defaults)

	stair_def.description = S("@1 Stairs", defaults.description)

	minetest.register_node(prefix.."stair", stair_def)

	-- INNER STAIR
	local inner_def = table.copy(defaults)
	inner_def.node_box.fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
		{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
	}
	inner_def.description = S("Inner @1", stair_def.description)
	minetest.register_node(prefix.."stair_inner", inner_def)

	-- OUTER STAIR
	local outer_def = table.copy(defaults)
	outer_def.node_box.fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
	}
	outer_def.description = S("Outer @1", stair_def.description)
	minetest.register_node(prefix.."stair_outer", outer_def)

	-- SLAB
	local slab_def = table.copy(defaults)

	slab_def.node_box.fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	slab_def.description = S("@1 Slab", defaults.description)
	minetest.register_node(prefix.."slab", slab_def)
end
