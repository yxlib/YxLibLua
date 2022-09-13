-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Class")
local Array = require("LuaScripts.YxLibLua.Util.Array")

---@class Set @Set class
local Set = {
    ---@return Set @Set object
    new = function() end
}
class(Set, "Set", nil)

--- add an element
---@param element any
function Set:add(element)
    assert(not self[element], "element is exist")

    self[element] = true
end

--- remove an element
---@param element any
function Set:remove(element)
    assert(self[element], "element is not exist")

    self[element] = false
end

--- is element exist
---@param element any
---@return boolean
function Set:exist(element)
    return self[element]
end

--- get all elements
---@return Array
function Set:elements()
    local arr = Array.new()

    for k, v in pairs(self) do
        if v then
            arr:pushBack(k)
        end
    end

    return arr
end

--- get the size of the set
---@return number
function Set:size()
    local cnt = 0

    for k, v in pairs(self) do
        if v then
            cnt = cnt + 1
        end
    end

    return cnt
end

return Set