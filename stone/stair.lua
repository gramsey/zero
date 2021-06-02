
-- stone stairs (only ran if mod stair is included)
local S = minetest.get_translator("stairs")

-- Register default stairs and slabs
stair.register_stair_and_slab(
	"stone",
	"stone:stone",
	{cracky = 3},
	{"stone.png"},
	"Stone Stair",
	"Stone Slab",
	stone.sounds,
	true
)

stair.register_stair_and_slab(
	"cobble",
	"stone:cobble",
	{cracky = 3},
	{"stone_cobble.png"},
	"Cobblestone Stair",
	"Cobblestone Slab",
	stone.sounds,
	true
)

stair.register_stair_and_slab(
	"mossycobble",
	"stone:mossycobble",
	{cracky = 3},
	{"stone_mossycobble.png"},
	"Mossy Cobblestone Stair",
	"Mossy Cobblestone Slab",
	stone.sounds,
	true
)
