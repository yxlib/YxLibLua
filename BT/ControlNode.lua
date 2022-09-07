-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Const = require("Assets.YxLibLua.BT.Const")
local BaseBehaviorNode = require("Assets.YxLibLua.BT.BaseBehaviorNode")

---@class ControlNode @ControlNode class
---@field nodeId number @node id
---@field nodeType number @node type
---@field subNodes Array @sub nodes
local ControlNode = {
    ---@param nodeId number @node id
    ---@param nodeType number @node type
    ---@return ControlNode @ControlNode object
    new = function(nodeId, nodeType) end
}
class(ControlNode, "ControlNode", BaseBehaviorNode)

--- ctor method
function ControlNode:_ctor(...)
    local params = {...}
    super(self, params[1])
    self.nodeType = params[2]

    self.subNodes = Util.Array.new()
end

--- add child
---@param child IBehaviorNode @child
function ControlNode:addChild(child)
    assert(child, "child is nil")

    self.subNodes:pushBack(child)
end

--- remove child
---@param child IBehaviorNode @child
function ControlNode:removeChild(child)
    assert(child, "child is nil")

    for i, exist in ipairs(self.subNodes) do
        if exist == child then
            self.subNodes:erase(i)
            break
        end
    end
end

--- remove child by id
---@param nodeId number @node id of child
function ControlNode:removeChildById(nodeId)
    for i, exist in ipairs(self.subNodes) do
        if exist:getId() == nodeId then
            self.subNodes:erase(i)
            break
        end
    end
end

--- get child by id
---@param nodeId number @node id of child
---@return IBehaviorNode @child
---@return boolean @ok
function ControlNode:getChildById(nodeId)
    for i, exist in ipairs(self.subNodes) do
        if exist:getId() == nodeId then
            return exist, true
        end
    end

    return nil, false
end

return ControlNode