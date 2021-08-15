
local S = minetest.get_translator("aspen");

-- FENCE
fence.register_fence("aspen:fence", {                                                                       
    description = S("Aspen Wood Fence"),
    texture = "aspen_fence.png",
    material = "aspen:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
fence.register_fence_rail("aspen:fence_rail", {                                                                       
    description = S("Aspen Wood Fence Rail"),
    texture = "aspen_fence_rail.png",
    material = "aspen:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
