
local S = minetest.get_translator("flower")

local waterlily_def = {
	description = S("Waterlily"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"flower_waterlily.png", "flower_waterlily_bottom.png"},
	inventory_image = "flower_waterlily.png",
	wield_image = "flower_waterlily.png",
	use_texture_alpha = "clip",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy = 3, flower = 1, flammable = 1},
	sounds = dirt.sounds,
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under)
		local def = minetest.registered_nodes[node.name]

		if def and def.on_rightclick then
			return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
					pointed_thing)
		end

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node.name, "water") > 0 then
			local player_name = placer and placer:get_player_name() or ""
			if not minetest.is_protected(pos, player_name) then
				minetest.set_node(pos, {name = "flower:waterlily" ..
					(def.waving == 3 and "_waving" or ""),
					param2 = math.random(0, 3)})
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
}

function add_waterlily_to_biome(biome)
	minetest.register_decoration({
		name = biome..":waterlily",
		deco_type = "simple",
		place_on = {"dirt:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		biomes = { biome },
		y_max = 0,
		y_min = 0,
		decoration = "flower:waterlily_waving",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})
end

local waterlily_waving_def = table.copy(waterlily_def)
waterlily_waving_def.waving = 3
waterlily_waving_def.drop = "flower:waterlily"
waterlily_waving_def.groups.not_in_creative_inventory = 1

minetest.register_node("flower:waterlily", waterlily_def)
minetest.register_node("flower:waterlily_waving", waterlily_waving_def)

