-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class IBehaviorNode @IBehaviorNode interface
local IBehaviorNode = interface("IBehaviorNode")

--- get id
---@return number @id
function IBehaviorNode:getId() end

--- get action id
---@return number @action id
function IBehaviorNode:getActionId() end

--- get type
---@return number @type
function IBehaviorNode:getType() end

--- update step
function IBehaviorNode:updateStep() end

--- get step
---@return number @step
function IBehaviorNode:getStep() end

--- get max step
---@return number @max step
function IBehaviorNode:getMaxStep() end

--- get state
---@return number @state
function IBehaviorNode:getState() end

--- is complete
---@return boolean @complete
function IBehaviorNode:isCompleted() end

--- execute
function IBehaviorNode:execute() end

--- add child
---@param child IBehaviorNode @child
function IBehaviorNode:addChild(child) end

--- remove child
---@param child IBehaviorNode @child
function IBehaviorNode:removeChild(child) end

--- remove child by id
---@param nodeId number @node id of child
function IBehaviorNode:removeChildById(nodeId) end

--- get child by id
---@param nodeId number @node id of child
---@return IBehaviorNode @child
---@return boolean @ok
function IBehaviorNode:getChildById(nodeId) end

return IBehaviorNode
