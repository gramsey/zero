
local S = minetest.get_translator("sand")

sand.sounds = {}

sand.sounds = {
    footstep = {name = "sand_footstep", gain = 0.05},
    dig = dirt.sounds.dig,
    dug = {name = "sand_footstep", gain = 0.15},
    place = dirt.sounds.place,
}

-- SAND
minetest.register_node("sand:sand", {
    description = S("Sand"),
    tiles = {"sand.png"},
    groups = {crumbly = 3, falling_node = 1, sand = 1, oddly_breakable_by_hand= 3},
    sounds = sand.sounds,
})
