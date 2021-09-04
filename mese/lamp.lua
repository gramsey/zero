
local S = minetest.get_translator("mese");

minetest.register_node("mese:lamp", {
	description = S("Mese Lamp"),
	drawtype = "glasslike",
	tiles = {"mese_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = glass.sounds,
	light_source = minetest.LIGHT_MAX,
})

minetest.register_craft({
	output = "mese:lamp",
	recipe = {
		{"glass:glass"},
		{"mese:crystal"},
	}
})

function mese.register_lampost(name, def)
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{'', 'glass:glass', ''},
			{'mese:crystal', 'mese:crystal', 'mese:crystal'},
			{'', def.material, ''},
		}
	})

	local post_texture = def.texture .. "^mese_post_light_side.png^[makealpha:0,0,0"
	local post_texture_dark = def.texture .. "^mese_post_light_side_dark.png^[makealpha:0,0,0"
	-- Allow almost everything to be overridden
	local default_fields = {
		wield_image = post_texture,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-2 / 16, -8 / 16, -2 / 16, 2 / 16, 8 / 16, 2 / 16},
			},
		},
		paramtype = "light",
		tiles = {def.texture, def.texture, post_texture_dark, post_texture_dark, post_texture, post_texture},
		use_texture_alpha = "opaque",
		light_source = minetest.LIGHT_MAX,
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = wood.sounds,
	}
	for k, v in pairs(default_fields) do
		if def[k] == nil then
			def[k] = v
		end
	end

	def.texture = nil
	def.material = nil

	minetest.register_node(name, def)
end
