
local clearance = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

function fence.register_wall(name, def)
	-- RECIPE
	if (def.material ~= nil) then
		minetest.register_craft({
			output = name .. " 6",
			recipe = {
				{ "", "", "" },
				{ def.material, def.material, def.material},
				{ def.material, def.material, def.material},
			}
		})

    	def.material = nil
	end

	-- FORCE REQUIRED VALUES
	def.paramtype = "light"
	def.drawtype = "nodebox"

	-- DEFAULTS
	def.groups = def.groups or {cracky = 3, stone = 2}
	def.groups.wall = 1

	def.node_box = def.node_box or {
		type = "connected",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
		connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
		connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
		connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
		connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
	}
	def.collision_box = def.collision_box or {
		type = "connected",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + clearance, 1/4},
		connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + clearance,-1/4},
		connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + clearance,1/4},
		connect_back = {-1/4,-1/2,1/4,1/4,1/2 + clearance,1/2},
		connect_right = {1/4,-1/2,-1/4,1/2,1/2 + clearance,1/4},
	}
	def.connects_to = def.connects_to or 
		{ "group:wall", "group:stone", "group:fence" }
	def.inventory_image = def.inventory_image --or def.texture
	def.wield_image = def.wield_image or def.inventory_image
	def.tiles = def.tiles or {def.texture}
	def.walkable = def.walkable or true
	def.sunlight_propagates = def.sunlight_propagates or true
	def.is_ground_content = def.is_ground_content or false

	if (def.sounds == nil and minetest.get_modpath("stone") ~= nil) then
		def.sounds = stone.sounds
	end

	def.texture = nil

	-- CREATE WALL
    minetest.register_node(name, def) 
end                      
