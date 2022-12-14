-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Class")

---@class Queue @Queue class
---@field maxSize number
---@field queSize number
---@field first number
---@field last number
local Queue = {
    ---@param maxSize number @max size
    ---@return Queue @Queue object
    new = function(maxSize) end
}
class(Queue, "Queue", nil)

--- ctor method
function Queue:_ctor(...)
    local params = {...}
    self.maxSize = params[1]
    self.internal = {}
    self.queSize = 0
    self.first = 1
    self.last = 1
end

--- push
---@param value any
function Queue:push(value)
    assert(value, "value is nil")
    assert(self.queSize < self.maxSize, "queue is full")

    local last = self.last
    self.internal[last] = value

    last = last + 1
    if last > self.maxSize then
        last = 1
    end

    self.last = last
    self.queSize = self.queSize + 1
end

--- pop
---@return any
function Queue:pop()
    assert(self.queSize > 0, "Queue is empty")

    local first = self.first
    local value = self.internal[first]
    self.internal[first] = nil

    first = first + 1
    if first > self.maxSize then
        first = 1
    end

    self.first = first
    self.queSize = self.queSize - 1

    return value
end

--- size
---@return number
function Queue:size()
    return self.queSize
end

--- isFull
---@return boolean
function Queue:isFull()
    return (self.queSize == self.maxSize)
end

return Queue
