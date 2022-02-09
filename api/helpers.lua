-- Add the values from table1 to table2, if they don't already exist
function boomstick.table_merge(table1, table2)
    assert(table1 ~= nil and table2 ~= nil, "Can't merge a nil table")

    for k, v in pairs(table1) do
        if table2[k] == nil then
            table2[k] = v
        end
    end

    return table2
end

function boomstick.validate_table(keys, data)
    for _, key in pairs(keys) do
        if data[key] == nil then
            return false
        end
    end
    return true
end

function boomstick.get_random_entry(table)
    if table == nil then
        boomstick.debug("A nil table was passed to boomstick.get_random_sound()")
        return
    end

    return table[math.random(#table)]
end

function boomstick.get_random_sound(table)
    if table == nil then
        boomstick.debug("A nil table was passed to boomstick.get_random_sound()")
        return
    end

    return {name = boomstick.get_random_entry(table)}
end

function boomstick.debug(string)
    if minetest.settings:get_bool("boomstick_debug") then
        minetest.log(string)
    end
end
