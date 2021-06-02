local S = minetest.get_translator("bug")

local butter_list = {
	{"white",  S("White Butterfly")},
	{"red",    S("Red Butterfly")},
	{"violet", S("Violet Butterfly")}
}

for i in ipairs (butter_list) do
	local name = butter_list[i][1]
	local desc = butter_list[i][2]

	minetest.register_node("bug:butterfly_"..name, {
		description = desc,
		drawtype = "plantlike",
		tiles = {{
			name = "bug_butterfly_"..name.."_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3
			},
		}},
		inventory_image = "bug_butterfly_"..name..".png",
		wield_image =  "bug_butterfly_"..name..".png",
		waving = 1,
		paramtype = "light",
		sunlight_propagates = true,
		buildable_to = true,
		walkable = false,
		groups = {catchable = 1},
		selection_box = {
			type = "fixed",
			fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		},
		floodable = true,
		on_place = function(itemstack, placer, pointed_thing)
			local player_name = placer:get_player_name()
			local pos = pointed_thing.above

			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pointed_thing.under, player_name) and
					minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name = "bug:butterfly_"..name})
				minetest.get_node_timer(pos):start(1)
				itemstack:take_item()
			end
			return itemstack
		end,
		on_timer = function(pos, elapsed)
			if minetest.get_node_light(pos) < 11 then
				minetest.set_node(pos, {name = "bug:hidden_butterfly_"..name})
			end
			minetest.get_node_timer(pos):start(30)
		end
	})

	minetest.register_node("bug:hidden_butterfly_"..name, {
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		drop = "",
		groups = {not_in_creative_inventory = 1},
		floodable = true,
		on_place = function(itemstack, placer, pointed_thing)
			local player_name = placer:get_player_name()
			local pos = pointed_thing.above

			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pointed_thing.under, player_name) and
					minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name = "bug:hidden_butterfly_"..name})
				minetest.get_node_timer(pos):start(1)
				itemstack:take_item()
			end
			return itemstack
		end,
		on_timer = function(pos, elapsed)
			if minetest.get_node_light(pos) >= 11 then
				minetest.set_node(pos, {name = "bug:butterfly_"..name})
			end
			minetest.get_node_timer(pos):start(30)
		end
	})
end

function bug.add_butterfly_to_biome(name, biome)

	minetest.register_decoration({
		name = name,
		deco_type = "simple",
		place_on = {"grass:dirt"},
		place_offset_y = 2,
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = {biome},
		y_max = 31000,
		y_min = 1,
		decoration = {
			"bug:butterfly_white",
			"bug:butterfly_red",
			"bug:butterfly_violet"
		},
		spawn_by = "group:flower",
		num_spawn_by = 1
	})

	local deco_id = minetest.get_decoration_id(name)
	minetest.set_gen_notify({decoration = true}, {deco_id})

	minetest.debug("deco id", deco_id)

	-- start nodetimers
	minetest.register_on_generated(function(minp, maxp, blockseed)
		local gennotify = minetest.get_mapgen_object("gennotify")
		local poslist = {}

		for _, pos in ipairs(gennotify["decoration#"..deco_id] or {}) do
			local deco_pos = {x = pos.x, y = pos.y + 3, z = pos.z}
			table.insert(poslist, deco_pos)
		end

		if #poslist ~= 0 then
			for i = 1, #poslist do
				local pos = poslist[i]
				minetest.get_node_timer(pos):start(1)
			end
		end
	end)
end

