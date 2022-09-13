-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Const = require("Assets.YxLibLua.BT.Const")
local ControlNode = require("Assets.YxLibLua.BT.ControlNode")

---@class ParallelNode : ControlNode @ParallelNode class
---@field nodeId number @node id
local ParallelNode = {
    ---@param nodeId number @node id
    ---@return ParallelNode @ParallelNode object
    new = function(nodeId) end
}
class(ParallelNode, "ParallelNode", ControlNode)

--- ctor method
function ParallelNode:_ctor(...)
    local params = {...}
    super(self, ControlNode, params[1], Const.BNODE_TYPE_PARALLEL)

    -- self.nodeType = Const.BNODE_TYPE_PARALLEL
end

--- execute
function ParallelNode:execute()
    if self:isCompleted() then
        return
    end

    self.state = Const.BNODE_STAT_EXECUTING

    local bFinish = true
    for i, child in ipairs(self.subNodes) do
        if child:isCompleted() then
            goto continue
        end

        child:execute()
        if not child:isCompleted() then
            bFinish = false
            goto continue
        end

        if child:getState() == Const.BNODE_STAT_FAIL then
            self.state = Const.BNODE_STAT_FAIL
            break
        end

        ::continue::
    end

    if bFinish and self.state == Const.BNODE_STAT_EXECUTING then
        self.state = Const.BNODE_STAT_SUCC
    end
end

return ParallelNode
