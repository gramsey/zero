
local S = minetest.get_translator("jungle");

-- FENCE
fence.register_fence("jungle:fence", {                                                                       
    description = S("Jungle Wood Fence"),
    texture = "jungle_fence.png",
    material = "jungle:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = wood.sounds,
})
