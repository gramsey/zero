minetest.override_item("", {
    wield_scale = {x=1,y=1,z=2.5},
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            oddly_breakable_by_hand = {times={[1]=15,[2]=3.00,[3]=1.70,[4] = 0.7}, uses=0}
        },
        damage_groups = {fleshy=1},
    }
})
