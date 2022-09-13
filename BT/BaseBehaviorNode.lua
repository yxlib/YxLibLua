-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Const = require("LuaScripts.YxLibLua.BT.Const")

---@class BaseBehaviorNode @BaseBehaviorNode class
---@field nodeId number @node id
---@field actionId number @action id
---@field maxStep number @max step
---@field nodeType number @node type
---@field state number @state
---@field step number @step
local BaseBehaviorNode = {
    ---@param nodeId number @node id
    ---@param actionId number @action id
    ---@param maxStep number @max step
    ---@return BaseBehaviorNode @BaseBehaviorNode object
    new = function(nodeId, actionId, maxStep) end
}
class(BaseBehaviorNode, "BaseBehaviorNode", nil)

--- ctor method
function BaseBehaviorNode:_ctor(...)
    local params = {...}
    self.nodeId = params[1]
    if #params > 1 then
        self.actionId = params[2]
        self.maxStep = params[3]
    else
        self.actionId = 0
        self.maxStep = 0
    end
    
    self.nodeType = Const.BNODE_TYPE_ACTION
    self.state = Const.BNODE_STAT_NOT_EXECUTE
    self.step = 0
end

--- get id
---@return number @id
function BaseBehaviorNode:getId()
    return self.nodeId
end

--- get action id
---@return number @action id
function BaseBehaviorNode:getActionId()
    return self.actionId
end

--- get type
---@return number @type
function BaseBehaviorNode:getType()
    return self.nodeType
end

--- update step
function BaseBehaviorNode:updateStep()
    self.step = self.step + 1
end

--- get step
---@return number @step
function BaseBehaviorNode:getStep()
    return self.step
end

--- get max step
---@return number @max step
function BaseBehaviorNode:getMaxStep()
    return self.maxStep
end

--- set state
---@param state number @state
function BaseBehaviorNode:setState(state)
    self.state = state
end

--- get state
---@return number @state
function BaseBehaviorNode:getState()
    return self.state
end

--- is complete
---@return boolean @complete
function BaseBehaviorNode:isCompleted()
    if self.state == Const.BNODE_STAT_SUCC then
        return true
    end

    if self.state == Const.BNODE_STAT_FAIL then
        return true
    end

    return false
end

--- execute
function BaseBehaviorNode:execute() end

--- add child
---@param child BaseBehaviorNode @child
function BaseBehaviorNode:addChild(child) end

--- remove child
---@param child BaseBehaviorNode @child
function BaseBehaviorNode:removeChild(child) end

--- remove child by id
---@param nodeId number @node id of child
function BaseBehaviorNode:removeChildById(nodeId) end

--- get child by id
---@param nodeId number @node id of child
---@return BaseBehaviorNode @child
---@return boolean @ok
function BaseBehaviorNode:getChildById(nodeId)
    return nil, false
end

return BaseBehaviorNode