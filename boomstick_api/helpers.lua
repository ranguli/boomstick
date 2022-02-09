--- Add the values from table1 to table2, if they don't already exist.
-- @param table1 - Table containing items
-- @param table2 - Table containing items
-- @return table - Returns table2 with the unique items from table1 inserted.
function boomstick_api.table_merge(table1, table2)
    assert(table1 ~= nil and table2 ~= nil, "Can't merge a nil table")

    for k, v in pairs(table1) do
        if table2[k] == nil then
            table2[k] = v
        end
    end

    return table2
end

--- Given a table and a set of keys, validate that the keys in the table exist.
-- @param keys - Table containing keys
-- @param data - Table to be validated.
-- @return boolean - Whether or not the table has all keys.
function boomstick_api.validate_table(keys, data)
    for _, key in pairs(keys) do
        if data[key] == nil then
            return false
        end
    end
    return true
end

--- Returns a random item from a table.
-- @param table containing items
-- @return item from the table.
function boomstick_api.get_random_entry(table)
    if table == nil then
        boomstick_api.debug("A nil table was passed to boomstick.get_random_sound()")
        return
    end

    return table[math.random(#table)]
end

--- Given a table of sounds, randomly select one and return a [SimpleSoundSpec](https://minetest.gitlab.io/minetest/sounds/#simplesoundspec).
-- This allows weapons (or anything with a sound) to randomly play different
-- sounds to add variety.
-- @param table A table of strings, containing filenames of sounds.
-- @return table - A [SimpleSoundSpec](https://minetest.gitlab.io/minetest/sounds/#simplesoundspec) with the name set to a random sound.
function boomstick_api.get_random_sound(table)
    if table == nil then
        boomstick_api.debug("A nil table was passed to boomstick.get_random_sound()")
        return
    end

    return {name = boomstick_api.get_random_entry(table)}
end

--- Wrapper for `minetest.debug()` that will check if a debug flag is set in the mod settings before logging.
-- This is a work in progress.
-- @param string - A string to log to the Minetest console for debugging purposes.
-- @param table - A table containing printf-style arguments to be passed to `string.format()`
-- @return table - A [SimpleSoundSpec](https://minetest.gitlab.io/minetest/sounds/#simplesoundspec) with the name set to a random sound.
function boomstick_api.debug(string, table)
    if minetest.settings:get_bool("boomstick_debug") then
        minetest.log(string.format(string, unpack(table)))
    end
end
