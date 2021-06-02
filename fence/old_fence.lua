
local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

function fence.register_fence(name, def)
    minetest.register_craft({
        output = name .. " 4",
        recipe = {
            { def.material, 'group:stick', def.material },
            { def.material, 'group:stick', def.material },
        }
    })


    local fence_texture = "fence_overlay.png^" .. def.texture ..
            "^fence_overlay.png^[makealpha:255,126,126"

    -- Allow almost everything to be overridden
    local default_fields = {
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
            -- connect_top =
            -- connect_bottom =
            connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/8 },
                         {-1/16, -5/16, -1/2,   1/16, -3/16, -1/8 }},
            connect_left =  {{-1/2,   3/16, -1/16, -1/8,   5/16,  1/16},
                         {-1/2,  -5/16, -1/16, -1/8,  -3/16,  1/16}},
            connect_back =  {{-1/16,  3/16,  1/8,   1/16,  5/16,  1/2 },
                         {-1/16, -5/16,  1/8,   1/16, -3/16,  1/2 }},
            connect_right = {{ 1/8,   3/16, -1/16,  1/2,   5/16,  1/16},
                         { 1/8,  -5/16, -1/16,  1/2,  -3/16,  1/16}}
        },
        collision_box = {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fence_collision_extra, 1/8},
            -- connect_top =
            -- connect_bottom =
            connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2 + fence_collision_extra, -1/8},
            connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2 + fence_collision_extra,  1/8},
            connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2 + fence_collision_extra,  1/2},
            connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2 + fence_collision_extra,  1/8}
        },  
        connects_to = {"group:fence", "group:wood", "group:tree", "group:wall"},
        inventory_image = fence_texture,
        wield_image = fence_texture,
        tiles = {def.texture},
        sunlight_propagates = true,
        is_ground_content = false,
        groups = {},
    }   
    for k, v in pairs(default_fields) do
        if def[k] == nil then
            def[k] = v
        end 
    end     
            
    -- Always add to the fence group, even if no group provided
    def.groups.fence = 1 
            
    def.texture = nil    
    def.material = nil
                         
    minetest.register_node(name, def) 
end                      

walls.register = function(wall_name, wall_desc, wall_texture_table, wall_mat, wall_sounds)

	minetest.register_craft({
		output = wall_name .. " 6",
		recipe = {
			{ "", "", "" },
			{ wall_mat, wall_mat, wall_mat},
			{ wall_mat, wall_mat, wall_mat},
		}
	})

	--make wall_texture_table paramenter backwards compatible for mods passing single texture
	if type(wall_texture_table) ~= "table" then
		wall_texture_table = { wall_texture_table }
	end
	-- inventory node, and pole-type wall start item
	minetest.register_node(wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			-- connect_bottom =
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
			-- connect_top =
			-- connect_bottom =
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2 + fence_collision_extra,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2 + fence_collision_extra,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2 + fence_collision_extra,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2 + fence_collision_extra,1/4},
		},
		connects_to = { "group:wall", "group:stone", "group:fence" },
		paramtype = "light",
		is_ground_content = false,
		tiles = wall_texture_table,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2 },
		sounds = wall_sounds,
	})


end

walls.register("walls:cobble", S("Cobblestone Wall"), {"default_cobble.png"},
		"default:cobble", default.node_sound_stone_defaults())

walls.register("walls:mossycobble", S("Mossy Cobblestone Wall"), {"default_mossycobble.png"},
		"default:mossycobble", default.node_sound_stone_defaults())

walls.register("walls:desertcobble", S("Desert Cobblestone Wall"), {"default_desert_cobble.png"},
		"default:desert_cobble", default.node_sound_stone_defaults())

