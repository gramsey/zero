
local S = minetest.get_translator("dirt")

gravel.sounds = {
    footstep = {name = "gravel_footstep", gain = 0.1},
    dig = {name = "gravel_dig", gain = 0.35},
    dug = {name = "gravel_dug", gain = 1.0},
    place = {name = "gravel_footstep", gain = 1.0},
}

local drop_items = {
	{items = {"gravel:gravel"}}
}

if (minetest.get_modpath("fire") ~= nil) then
	table.insert(drop_items, 1, {items = {"fire:flint"}, rarity = 16})
end

minetest.register_node("gravel:gravel", {
    description = S("Gravel"),
    tiles = {"gravel.png"},
    groups = {crumbly = 2, falling_node = 1},
    sounds = gravel.sounds,
    drop = {
        max_items = 1,
        items = drop_items,
    }
})
