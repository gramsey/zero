
-- apple stairs (only ran if mod stair is included)
local S = minetest.get_translator("stairs")

-- Register default stairs and slabs
stair.register_stair_and_slab(
	"apple",
	"apple:wood",
	{cracky = 3},
	{"apple_wood.png"},
	S("Wooden Stair"),
	S("Wooden Slab"),
	wood.sounds,
	true
)
