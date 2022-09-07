-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Const = require("Assets.YxLibLua.BT.Const")
local SequenceNode = require("Assets.YxLibLua.BT.SequenceNode")

---@class BehaviorTree @BehaviorTree class
---@field treeId number @tree id
---@field rootNode SequenceNode @root node
local BehaviorTree = {
    ---@param treeId number @tree id
    ---@return BehaviorTree @BehaviorTree object
    new = function(treeId) end
}
class(BehaviorTree, "BehaviorTree", nil)

--- ctor method
function BehaviorTree:_ctor(...)
    local params = {...}
    self.treeId = params[1]
    self.rootNode = SequenceNode.new(Const.BTREE_ROOT_NODE_ID)
end

--- get id
---@return number @id
function BehaviorTree:getId()
    return self.treeId
end

--- get root node
---@return IBehaviorNode @root node
function BehaviorTree:getRootNode()
    return self.rootNode
end

--- execute
function BehaviorTree:execute()
    self.rootNode:execute()
end

--- get state
---@return number @state
function BehaviorTree:getState()
    return self.rootNode:getState()
end

--- is complete
---@return boolean @complete
function BehaviorTree:isCompleted()
    return self.rootNode:isCompleted()
end

return BehaviorTree