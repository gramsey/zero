
local S = minetest.get_translator("sign");

function sign.register(name, def)

	if def.recipeitem then
		minetest.register_craft({
			output = name .. " 3",
			recipe = {
				{def.recipeitem, def.recipeitem, def.recipeitem},
				{def.recipeitem, def.recipeitem, def.recipeitem},
				{"", "group:stick", ""},
			}
		})
		def.recipeitem = nil
	end


	local sign_def = {
		description = S("Sign"), 
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "opaque",
		node_box = {
			type = "wallmounted",
			wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
			wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
			wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
		},
		legacy_wallmounted = true,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "field[text;;${text}]")
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local player_name = sender:get_player_name()
			if minetest.is_protected(pos, player_name) then
				minetest.record_protection_violation(pos, player_name)
				return
			end
			local text = fields.text
			if not text then
				return
			end
			if string.len(text) > 512 then
				minetest.chat_send_player(player_name, S("Text too long"))
				return
			end
			minetest.log("action", player_name .. " wrote \"" .. text ..
				"\" to the sign at " .. minetest.pos_to_string(pos))
			local meta = minetest.get_meta(pos)
			meta:set_string("text", text)

			if #text > 0 then
				meta:set_string("infotext", S('"@1"', text))
			else
				meta:set_string("infotext", '')
			end
		end,
	}

	for k, v in pairs(def) do sign_def[k] = v end
	sign_def.inventory_image = sign_def.inventory_image or sign_def.wield_image
	sign_def.wield_image = sign_def.wield_image or sign_def.inventory_image
	
	minetest.register_node(name, sign_def)
end
