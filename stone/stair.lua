
-- stone stairs (only ran if mod stair is included)
local S = minetest.get_translator("stairs")

-- Register default stairs and slabs

stair.register("stone:stone_",{ recipeitem = "stone:stone" }) 
stair.register("stone:cobble_",{ recipeitem = "stone:cobble" }) 
stair.register("stone:mossycobble_",{ recipeitem = "stone:mossycobble" }) 
