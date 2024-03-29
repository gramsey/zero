-- wool/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("wool")

if (minetest.get_modpath("dye") ~= nil) then
	local dyes = dye.dyes

	for i = 1, #dyes do
		local name, desc = unpack(dyes[i])

		minetest.register_node("wool:" .. name, {
			description = S(desc .. " Wool"),
			tiles = {"wool_" .. name .. ".png"},
			is_ground_content = false,
			groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
					flammable = 3, wool = 1},
			--TODO sounds = default.node_sound_defaults(),
		})

		minetest.register_craft{
			type = "shapeless",
			output = "wool:" .. name,
			recipe = {"group:dye,color_" .. name, "group:wool"},
		}
	end
else
	minetest.register_node("wool:white", {
		description = S("White Wool"),
		tiles = {"wool_white.png"},
		is_ground_content = false,
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		--TODO sounds = default.node_sound_defaults(),
	})
end

minetest.register_craftitem("wool:string", {                                                                      
    description = S("String"),
    inventory_image = "wool_string.png",
    groups = {flammable = 2},
})

minetest.register_craft({
    output = "wool:string 4",
    recipe = {
        {"group:wool"},
    }
})

minetest.register_craft({
    output = "wool:white",
    recipe = {
        {"wool:string", "wool:string"},
        {"wool:string", "wool:string"},
    }
})

-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this run:
-- for _,e in ipairs(dye.dyes) do print(("S(%q)"):format(e[2].." Wool")) end

--[[
S("White Wool")
S("Grey Wool")
S("Dark Grey Wool")
S("Black Wool")
S("Violet Wool")
S("Blue Wool")
S("Cyan Wool")
S("Dark Green Wool")
S("Green Wool")
S("Yellow Wool")
S("Brown Wool")
S("Orange Wool")
S("Red Wool")
S("Magenta Wool")
S("Pink Wool")
--]]
