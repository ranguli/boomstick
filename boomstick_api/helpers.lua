--- Assorted helper functions
--
--
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

function boomstick_api.create_new_category(name, category, base)
    -- Inherit any default values from a base, if one is provided. (Ensure both are tables)
    if base ~= nil and type(base) == "table" and type(category) == "table" then
        category =
            boomstick_api.table_merge(boomstick_api.data.categories[base], category)
    elseif base ~= nil and type(base) == "table" and type(category) == "string" then
        -- Because category could be before our table let's reverse the calls so we get the right thing
        category =
            boomstick_api.table_merge(boomstick_api.data.categories[category], base)
    end
    -- minetest.log("action", minetest.serialize(category)) -- Used to verify the tables were being merged
    boomstick_api.data.categories[name] = category
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

    return boomstick_api.get_random_entry(table)
end


--- Wrapper for `minetest.log()` with some added conveniences.
-- @param string - A string to log to the Minetest console for debugging purposes, which will be the first argument to `string.format()`
-- @param table - A table containing printf-style arguments to be passed as the second argument to `string.format()`
-- @return table - A [SimpleSoundSpec](https://minetest.gitlab.io/minetest/sounds/#simplesoundspec) with the name set to a random sound.
function boomstick_api.debug(string, table)
    if table == nil then
        minetest.log("verbose", "[Boomstick] " .. string)
    else
        minetest.log("verbose", "[Boomstick] " .. string.format(string, unpack(table)))
    end
end


--- Returns true if a mod exists
-- @tparam string modname - The name of a mod.
-- @return boolean - Whether or not a mod exists.
function boomstick_api.mod_exists(modname)
    if minetest.get_modpath(modname) ~= nil then
        return true
    end
    return false
end


--- Randomly select a sound from a table of sounds, handling the creation of SimpleSoundSpecs, sound parameter tables, and getting player position.
-- @param sounds - A list of tables, each containing a `name` value, with optional `gain`, and `max_hear_distance` values.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). The sound will originate at the players position.
-- @usage
-- local my_sounds = {
--     {name = "my_sound_1"},
--     {name = "my_sound_2", gain = 0.25, max_hear_distance = 5},
-- }
--
-- boomstick_api.play_random_sound_on_player(my_sounds, player)
function boomstick_api.play_random_sound_on_player(sounds, player)
    assert(player and minetest.is_player(player), "Must provide a valid player object")
    local pos = player:get_pos()

    boomstick_api.play_random_sound(sounds, pos)
end


--- Randomly select a sound from a table of sounds, handling the creation of SimpleSoundSpec and sound parameter tables.
-- @param sounds - A list of tables, each containing a `name` value, with optional `gain`, and `max_hear_distance` values.
-- @param pos - A Minetest [vector](https://minetest.gitlab.io/minetest/representations-of-simple-things/#representations-of-simple-things) where the sound should originate from.
-- @usage
-- local my_sounds = {
--     {name = "my_sound_1"},
--     {name = "my_sound_2", gain = 0.25, max_hear_distance = 5},
-- }
--
-- boomstick_api.play_random_sound(empty_weapon_sounds, pos)
function boomstick_api.play_random_sound(sounds, pos)
    if sounds == nil then
        boomstick_api.debug("No sounds provided")
        return
    end

    local sound = boomstick_api.get_random_sound(sounds)
    boomstick_api.play_sound(sound, pos)
end


--- Wrapper for `minetest.sound_play()` that handles the creation of SimpleSoundSpec and sound parameter tables, and getting player position.
-- @param sound - A table containing a `name` value, with optional `gain`, and `max_hear_distance` values.
-- @param player - A player [ObjectRef](https://minetest.gitlab.io/minetest/class-reference/#objectref). The sound will originate at the players position.
-- @usage
-- boomstick_api.play_sound({
--     name = "mysound",
--     gain = 1.0,
--     max_hear_distance = 5
-- },
-- player)
function boomstick_api.play_sound_on_player(sound, player)
    assert(player and minetest.is_player(player), "Must provide a valid player object")
    local pos = player:get_pos()

    boomstick_api.play_sound(sound, pos)
end


--- Wrapper for `minetest.sound_play()` that handles the creation of SimpleSoundSpec and sound parameter tables.
-- @param sound - A table containing a `name` value, with optional `gain`, and `max_hear_distance` values.
-- @param pos - A Minetest [vector](https://minetest.gitlab.io/minetest/representations-of-simple-things/#representations-of-simple-things) where the sound should originate from.
-- @usage
-- boomstick_api.play_sound({
--     name = "mysound",
--     gain = 1.0,
--     max_hear_distance = 5
-- },
-- pos)
function boomstick_api.play_sound(sound, pos)
    if sound == nil then
        minetest.log("error", "Argument #1 to boomstick_api.play_sound() must not be nil.")
        return nil
    elseif not sound.name then
        minetest.log("error",
            "Argument #1 to boomstick_api.play_sound() must not contain a 'name' field.")
        return nil
    end

    local gain = sound.gain or 1.0
    local max_hear_distance = sound.max_hear_distance or 5

    local sound_spec = {name = sound.name, gain = gain}
    local sound_table = {pos = pos, max_hear_distance = max_hear_distance}
    minetest.sound_play(sound_spec, sound_table, false)
end
