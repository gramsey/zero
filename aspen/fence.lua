
local S = minetest.get_translator("aspen");

-- FENCE
fence.register_fence("aspen:fence", {                                                                       
    description = S("Aspen Wood Fence"),
    texture = "aspen_fence.png",
    material = "aspen:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
