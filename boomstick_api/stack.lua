-- Implementation of a SizedStack
-- Loosely based on http://lua-users.org/wiki/SimpleSizedStack
boomstick_api.SizedStack = {}

function boomstick_api.SizedStack:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self._entry_table = {}
    self._size = 100
    return o
end

function boomstick_api.SizedStack:set_size(size)
    self._size = size

    if #self._entry_table > self._size then
        while #self._entry_table ~= self._size do
            self:pop()
        end
    end
end

-- get entries
function boomstick_api.SizedStack:count()
    return #self._entry_table
end

function boomstick_api.SizedStack:get_size()
    return self._size
end

function boomstick_api.SizedStack:push(...)
    if ... then
        local targs = {...}
        -- add values
        for _, v in ipairs(targs) do
            if self:count() + 1 <= self:get_size() then
                table.insert(self._entry_table, v)
            end
        end
    end
end

function boomstick_api.SizedStack:repeat_push(value, count)
    for i = 1,count do
        self:push(value)
    end
end


function boomstick_api.SizedStack:list()
    return self._entry_table
end

function boomstick_api.SizedStack:pop(num)
    -- How many items to pop from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
        -- get last entry
        if #self._entry_table ~= 0 then
            table.insert(entries, self._entry_table[#self._entry_table])
            -- remove last value
            table.remove(self._entry_table)
        else
            break
        end
    end

    if num == 1 then
        return table.unpack(entries)
    else
        return entries
    end
end

function boomstick_api.SizedStack:empty()
    self._entry_table = {}
end
