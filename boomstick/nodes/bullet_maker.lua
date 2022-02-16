local compatible_items = {}

compatible_items["basic_materials:brass_ingot"] = {
    "boomstick:9mm_casing 10",
    "boomstick:556_casing 5",
    "boomstick:762x39_casing 5"
}

compatible_items["technic:lead_ingot"] = {
    "boomstick:musket_ball 5",
    "boomstick:pellets 15",
    "boomstick:9mm_projectile 10",
    "boomstick:556_projectile 5",
    "boomstick:762x39_projectile 5"
}

function get_formspec(name)
    local formspec = {
	   "size[8,7;]list[current_player;main;0,3.25;8,4;]"..
	   "image[3,1;1,1;gui_furnace_arrow_bg.png^[transformR270]",
	   "list[context;input;2,1;1,1;]",
	   "list[context;output;4,0;4,3;]",
       default.gui_bg,
       default.gui_bg_img,
    }

    return table.concat(formspec, "")
end

function get_output(inv, stack)
	local output = compatible_items[stack:get_name()]

    if output then
	    inv:set_list("output", output)
    end
end

function allow_metadata_inventory_take(pos, listname, index, stack, player)
	local inv = minetest.get_meta(pos):get_inventory()

    -- Player is removing the crafting input
    if listname == "input" then
        inv:set_list("output", {})
        return stack:get_count()

    -- Player is removing the crafting output
    elseif listname == "output" then
        -- Subtract one from the input stack size
        local input_item = inv:get_stack("input", 1)
        input_item:set_count(input_item:get_count() - 1)
        inv:set_stack("input", 1, input_item)


        -- Clear all the other options that aren't what the player chose.
        for item_index, item in pairs(inv:get_list(listname)) do
            if item:get_name() ~= stack:get_name() then
                inv:remove_item(listname, item_index)
            end
        end

        return stack:get_count()
    end
end

function allow_metadata_inventory_put(pos, listname, index, stack, player)
	local inv = minetest.get_meta(pos):get_inventory()

    -- Player is placing an input in the input field
	if listname == "input" then
        for k,v in pairs(compatible_items) do
            if k == stack:get_name() and stack:get_count() == 1 then
                get_output(inv, stack)
                return stack:get_count()
            end
        end
        return 0
    end

    -- Don't allow players to put items into the output grid
    if listname == "output" then
        return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
    -- Don't allow the player to move items from the crafting "input" to the crafting "output"
    return 0
end

function after_place_node(pos, placer)
    local meta = minetest.get_meta(pos)
    local formspec = get_formspec()
	local inv = meta:get_inventory(pos)

	inv:set_size("input", 1)
	inv:set_size("output", 4*3)

    meta:set_string("formspec", formspec)
	meta:set_string("infotext", "Work Bench")
end

minetest.register_node("boomstick:bulletmaker", {
	description = "Bullet Maker",
	groups = {cracky=2, choppy=2, oddly_breakable_by_hand=1},
    tiles = {
        "boomstick_bullet_maker_top.png",
        "boomstick_bullet_maker_top.png",
        "boomstick_bullet_maker_sides.png",
        "boomstick_bullet_maker_sides.png",
        "boomstick_bullet_maker_front.png",
        "boomstick_bullet_maker_sides.png"
    },
	after_place_node = after_place_node,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
})

