
local S = minetest.get_translator("pine");

-- FENCE
fence.register_fence("pine:fence", {                                                                       
    description = S("Pine Wood Fence"),
    texture = "pine_fence.png",
    material = "pine:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})

fence.register_fence_rail("pine:fence_rail", {                                                                       
    description = S("Pine Wood Fence Rail"),
    texture = "pine_fence_rail.png",
    material = "pine:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
