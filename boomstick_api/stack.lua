-- Implementation of a SizedStack
-- Loosely based on http://lua-users.org/wiki/SimpleSizedStack
--
boomstick_api.sized_stack = {}

function boomstick_api.sized_stack.init()
    local stack = {}
    stack.size = 100
    stack.elements = {}

    return stack
end

function boomstick_api.sized_stack.resize(stack, new_size)
    stack.size = new_size

    if #stack.elements > stack.size then
        while #stack.elements ~= stack.size do
            boomstick_api.sized_stack.pop(stack)
        end
    end
end

function boomstick_api.sized_stack.push(stack, ...)
    if ... then
        local targs = {...}
        -- add values
        for _, v in ipairs(targs) do
            if #stack.elements + 1 <= stack.size then
                table.insert(stack.elements, v)
            end
        end
    end
end

function boomstick_api.sized_stack.repeat_push(stack, value, count)
    for i = 1,count do
        boomstick_api.sized_stack.push(stack, value)
    end
end


function boomstick_api.sized_stack.pop(stack, num)
    -- How many items to pop from stack
    local num = num or 1

    -- return table
    local elements = {}

    -- get values into entries
    for i = 1, num do
        -- get last entry
        if #stack.elements ~= 0 then
            table.insert(elements, stack.elements[#stack.elements])
            table.remove(stack.elements)
        else
            break
        end
    end

    if num == 1 then
        return table.unpack(elements)
    else
        return elements
    end
end
