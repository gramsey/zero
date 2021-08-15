
local clearance = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

function fence.register_fence_rail(name, def)
	-- RECIPE
	if (def.recipe_item ~= nil) then
		minetest.register_craft({
			output = name .. " 16",
			recipe = {
				{ def.recipe_item, def.recipe_item },
				{ "", ""},
				{ def.recipe_item, def.recipe_item },
			}
		})
    	def.recipe_item = nil
	end

	-- FORCE REQUIRED VALUES
	def.paramtype = "light"
	def.drawtype = "nodebox"

	-- DEFAULTS
	def.group = def.groups or {};
	def.groups.fence = 1;

	def.node_box = def.node_box or {
		type = "connected",
			fixed = {
				{-1/16,  3/16, -1/16, 1/16,  5/16, 1/16},
				{-1/16, -3/16, -1/16, 1/16, -5/16, 1/16}
			}, connect_front = {
				{-1/16,  3/16, -1/2,   1/16,  5/16, -1/16},
			    {-1/16, -5/16, -1/2,   1/16, -3/16, -1/16}
			}, connect_left =  {
				{-1/2,   3/16, -1/16, -1/16,  5/16,  1/16},
			    {-1/2,  -5/16, -1/16, -1/16, -3/16,  1/16}
			}, connect_back = {
				{-1/16,  3/16,  1/16,  1/16,  5/16,  1/2 },
			    {-1/16, -5/16,  1/16,  1/16, -3/16,  1/2 }
			}, connect_right = {
				{ 1/16,  3/16, -1/16,  1/2,   5/16,  1/16},
		        { 1/16, -5/16, -1/16,  1/2,  -3/16,  1/16}
			}
	}
	def.collision_box = def.collision_box or {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + clearance, 1/8},
            connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 + clearance, -1/8},
            connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 + clearance,  1/8},
            connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 + clearance,  1/2},
            connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 + clearance,  1/8}
	}
	def.connects_to = def.connects_to or 
		{"group:fence", "group:wood", "group:tree", "group:wall"}
	def.inventory_image = def.inventory_image or 
		"fence_rail_overlay.png^" .. def.texture .. "^fence_rail_overlay.png^[makealpha:255,126,126"
	def.wield_image = def.wield_image or def.inventory_image
	def.tiles = {def.texture}
	def.sunlight_propagates = def.sunlight_propagates or true
	def.is_ground_content = def.is_ground_content or false

	def.texture = nil

	-- HARD CODED
	def.paramtype = "light"

	-- CREATE FENCE
    minetest.register_node(name, def) 
end                      
