
local S = minetest.get_translator("acacia");

-- FENCE
fence.register_fence("acacia:fence", {                                                                       
    description = S("Acacia Wood Fence"),
    texture = "acacia_fence.png",
    material = "acacia:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})

fence.register_fence_rail("acacia:fence_rail", {                                                                       
    description = S("Acacia Wood Fence Rail"),
    texture = "acacia_fence_rail.png",
    material = "acacia:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
