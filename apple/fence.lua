
local S = minetest.get_translator("apple");

-- FENCE
fence.register_fence("apple:fence", {                                                                       
    description = S("Apple Wood Fence"),
    texture = "apple_fence.png",
    material = "apple:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
