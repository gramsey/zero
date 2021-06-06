local S = minetest.get_translator("apple");

minetest.register_node("apple:tree", {
    description = S("Apple Tree"),
    tiles = {
		"apple_tree_end.png", 
		"apple_tree_end.png", 
		"apple_tree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = wood.sounds,
    on_place = minetest.rotate_node
})

minetest.register_node("apple:wood", {
    description = S("Apple Wood Planks"),
    paramtype2 = "facedir",
    place_param2 = 0, 
    tiles = {"apple_wood.png"},
    is_ground_content = false,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
    sounds = wood.sounds,
})

minetest.register_node("apple:leaves", {
    description = S("Apple Tree Leaves"),
    drawtype = "allfaces_optional",
    waving = 1,
    tiles = {"apple_leaves.png"},
    special_tiles = {"apple_leaves.png"},
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, oddly_breakable_by_hand=3},
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get sapling with 1/20 chance
                items = {"apple:sapling"},
                rarity = 20,
            },
            {
                -- player will get leaves only if he get no saplings,
                items = {"apple:leaves"},
            }
        }
    },
    sounds = wood.leaves_sounds,
    after_place_node = wood.after_place_leaves,
})

minetest.register_node("apple:apple", {
    description = S("Apple"),
    drawtype = "plantlike",
    tiles = {"apple.png"},
    inventory_image = "apple.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    is_ground_content = false,
    selection_box = {
        type = "fixed",
        fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
    },
    groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
        leafdecay = 3, leafdecay_drop = 1, food_apple = 1},
    on_use = minetest.item_eat(2),
    sounds = wood.leaves_sounds,
	sound = {  
		eat = {name = "apple_eat", gain = 1.0},
	},

    after_place_node = function(pos, placer, itemstack)
        minetest.set_node(pos, {name = "apple:apple", param2 = 1})
    end,

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        if oldnode.param2 == 0 then
            minetest.set_node(pos, {name = "apple:mark"})
            minetest.get_node_timer(pos):start(math.random(300, 1500))
        end
    end,
})

minetest.register_node("apple:mark", {
    description = S("Apple Marker"),
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drop = "",
    groups = {not_in_creative_inventory = 1},
    on_timer = function(pos, elapsed)
        if not minetest.find_node_near(pos, 1, "apple:leaves") then
            minetest.remove_node(pos)
        elseif minetest.get_node_light(pos) < 11 then
            minetest.get_node_timer(pos):start(200)
        else
            minetest.set_node(pos, {name = "apple:apple"})
        end
    end
})

wood.register_leafdecay({
	trunks = {"apple:tree"},
	leaves = {"apple:apple", "apple:leaves"},
	radius = 2,
})

minetest.register_craft({
    output = "apple:wood 4",
    recipe = {
        {"apple:tree"},
    }
})
