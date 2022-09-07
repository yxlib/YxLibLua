-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("Assets.YxLibLua.Util.Class")

---@class Array @Array class
local Array = {
    ---@return Array @Array object
    new = function() end
}
class(Array, "Array", nil)

--- clone the array
---@return Array @the clone one
function Array:clone()
    local o = {table.unpack(self)}
    setmetatable(o, Array) -- bind class

    return o
end

--- push item to the back of the array
---@param value any
function Array:pushBack(value)
    assert(value, "value is nil")

    table.insert(self, value)
end

--- pop item at the last index of the array
---@return any @the last item
function Array:popBack()
    assert(#self > 0, "empty array")
    
    local value = self[#self]
    table.remove(self)
    return value
end

--- erase the item at the index idx of the array
---@param idx number
function Array:erase(idx)
    assert((idx > 0 and idx <= #self), "idx out of range")
    table.remove(self, idx)
end

--- get the size of the array
---@return number
function Array:size()
    return #self
end

--- iterate all items of the array
---@param callback function @the callback function(i, v): boolean
function Array:foreach(callback)
    assert(callback, "callback is nil")

    for i, v in ipairs(self) do
        local bContinue = callback(i, v)
        if not bContinue then
            break
        end
    end
end

return Array