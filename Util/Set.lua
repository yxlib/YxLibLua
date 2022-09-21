-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Class")

---@class Set @Set class
local Set = {
    ---@return Set @Set object
    new = function() end
}
class(Set, "Set", nil)

--- ctor method
function Set:_ctor(...)
    self.internal = {}
end

--- add an element
---@param element any
function Set:add(element)
    assert(not self.internal[element], "element is exist")

    self.internal[element] = true
end

--- remove an element
---@param element any
function Set:remove(element)
    assert(self.internal[element], "element is not exist")

    self.internal[element] = false
end

--- is element exist
---@param element any
---@return boolean
function Set:exist(element)
    return self.internal[element]
end

--- get all elements
---@return table @elements array
function Set:elements()
    local elements = {}

    local idx = 1
    for k, v in pairs(self.internal) do
        if v then
            table.insert(elements, idx, k)
            idx = idx + 1
        end
    end

    return elements
end

--- get the size of the set
---@return number
function Set:size()
    local cnt = 0

    for k, v in pairs(self.internal) do
        if v then
            cnt = cnt + 1
        end
    end

    return cnt
end

return Set